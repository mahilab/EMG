#include <MEL/Daq/Quanser/Q8Usb.hpp>
#include <MEL/Communications/MelShare.hpp>
#include <MEL/Core/Timer.hpp>
#include <MEL/Core/Clock.hpp>
#include <MEL/Core/Console.hpp>
#include <MEL/Utility/System.hpp>
#include <MEL/Devices/Windows/Keyboard.hpp>
#include <MEL/Logging/Log.hpp>
#include <EMG/EMG/MesArray.hpp>
#include <EMG/EMG/EmgDataCapture.hpp>

using namespace mel;

int main(int argc, char *argv[]) {

    // handle inputs 
    std::vector<uint32> emg_channel_numbers;
    if (argc > 1) {
        uint32 ch;
        for (int i = 1; i < argc; ++i) {
            std::stringstream ss(argv[i]);
            ss >> ch;
            if (ch >= 0 && ch < 8) {
                emg_channel_numbers.push_back(ch);
            }
        }
    }
    else {
        return 0;
    }

    // enable Windows realtime
    enable_realtime();  

    // construct Q8 USB and configure    
    Q8Usb q8;
	q8.open();
    q8.DO.set_enable_values(std::vector<Logic>(8, High));
    q8.DO.set_disable_values(std::vector<Logic>(8, High));
    q8.DO.set_expire_values(std::vector<Logic>(8, High));
    if (!q8.identify(7)) {
        LOG(Error) << "Incorrect DAQ";
        return 0;
    }
    emg_channel_numbers = q8.AI.get_channel_numbers();
    std::size_t emg_channel_count = q8.AI.get_channel_count();
    
    // construct Myoelectric Signal (MES) Array
    emg::MesArray mes(q8.AI.get_channels(emg_channel_numbers), 300);

    // make MelShares
    MelShare ms_mes_tkeo_env("mes_tkeo_env");
	MelShare ms_mes_tkeo_env_mean("mes_tkeo_env_mean");

    // initialize testing conditions
    bool stop = false;
    Time Ts = milliseconds(1); // sample period
    
    // enable DAQ
    q8.enable();   

    // construct timer in hybrid mode to avoid using 100% CPU
    Timer timer(Ts, Timer::Hybrid);

    // start while loop
    q8.watchdog.start();
   

    while (!stop) {

        // update all DAQ input channels
        q8.update_input();
           
        // emg signal processing
        mes.update_and_buffer();
 
        // write to MelShares
        ms_mes_tkeo_env.write_data(mes.get_tkeo_envelope());
		ms_mes_tkeo_env_mean.write_data(mes.get_tkeo_envelope_mean());

        // check for exit key
        if (Keyboard::is_key_pressed(Key::Escape)) {
            stop = true;
        }

        // kick watchdog
        if (!q8.watchdog.kick())
            stop = true;

        // wait for remainder of sample period
        timer.wait();

    } // end while loop    

    mel::disable_realtime();   
    return 0;
}

