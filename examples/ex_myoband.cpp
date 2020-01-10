// MIT License
//
// MEL - Mechatronics Engine & Library
// Copyright (c) 2019 Mechatronics and Haptic Interfaces Lab - Rice University
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Author(s): Evan Pezent (epezent@rice.edu)

#include <MEL/Devices/Myo/MyoBand.hpp>
#include <MEL/Utility/System.hpp>
#include <MEL/Logging/Log.hpp>
#include <MEL/Core/Console.hpp>
#include <MEL/Communications/MelShare.hpp>
#include <MEL/Devices/Windows/Keyboard.hpp>
#include <MEL/Core/Clock.hpp>
#include <MEL/Core/Timer.hpp>
#include <EMG/Core/MesArray.hpp>
#include <MEL/Math/Butterworth.hpp>

using namespace mel;
using namespace emg;

int main() {

    // handle inputs
    std::vector<uint32> emg_channel_numbers = { 0,1,2,3,4,5,6,7 };
    std::size_t emg_channel_count = emg_channel_numbers.size();

    // construct myoband
    MyoBand myo("my_myo");

    // construct Myoelectric Signal (MES) Array
	MesArray mes(myo.get_channels(emg_channel_numbers), 300);

	// make MelShares
	MelShare ms_mes("mes"); // myoelectric signal

    double cutoff = 0.005;

    // initialize testing conditions
    Time Ts = milliseconds(1); // sample period

    Butterworth buttfilt(4,cutoff,Butterworth::Lowpass);

    // construct timer in hybrid mode to avoid using 100% CPU
    Timer timer(Ts, Timer::Hybrid);
	bool stop = false;

	// prompt the user for input
	print("Open MelScope with MelShare \"mes\" to view Myo signals.");
	print("Press 'Escape' to exit.");

    // enable hardware
    myo.enable();

    while (!stop) {

        // update hardware
        myo.update();

        // update EMG signal processing
        mes.update_and_buffer();

        // write to MelShares
        // ms_mes.write_data(mes.get_tkeo_envelope());

        double sum = 0;
        for (auto& v : mes.get_envelope())
            sum += v;

        ms_mes.write_data({sum,buttfilt.update(sum)});


        // check for exit key
        if (Keyboard::is_key_pressed(Key::Escape)) {
            stop = true;
        }

        // wait for remainder of sample period
        timer.wait();

    } // end control loop

    return 0;
}

