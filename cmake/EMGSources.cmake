# This file groups all EMG header and source files 

#===============================================================================
# HEADER FILES
#===============================================================================

# headers directory
set(EMG_HEADERS_DIR "${CMAKE_SOURCE_DIR}/include/EMG")

# collections of common subdirectory headers
set(EMG_CORE_HEADERS "")
set(EMG_SIGNAL_PROCESSING_HEADERS "")

# EMG EMG
set(EMG_CORE_HEADERS_DIR "${EMG_HEADERS_DIR}/EMG")
list(APPEND EMG_CORE_HEADERS
    "${EMG_CORE_HEADERS_DIR}/MesArray.hpp"
    "${EMG_CORE_HEADERS_DIR}/MyoelectricSignal.hpp"
)

# EMG SIGNAL_PROCESSING
set(EMG_SIGNAL_PROCESSING_HEADERS_DIR "${EMG_HEADERS_DIR}/Signal_Processing")
list(APPEND EMG_SIGNAL_PROCESSING_HEADERS
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/Rectifier.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/SignalProcessingFunctions.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/SignalProcessor.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/TeagerKaiserEnergyOperator.hpp"
)


# collect common header files
set(EMG_COMMON_HEADERS
    ${EMG_CORE_HEADERS}
    ${EMG_SIGNAL_PROCESSING_HEADERS}
)

#===============================================================================
# SOURCE FILES
#===============================================================================

# source directory
set(EMG_SRC_DIR "${CMAKE_SOURCE_DIR}/src/EMG")

# collections of subdirectory sources
set(EMG_CORE_SRC "")
set(EMG_SIGNAL_PROCESSING_SRC "")

# EMG SRC
set(EMG_CORE_SRC_DIR "${EMG_SRC_DIR}/Core")
list(APPEND EMG_CORE_SRC
    "${EMG_CORE_SRC_DIR}/MesArray.cpp"
    "${EMG_CORE_SRC_DIR}/MyoelectricSignal.cpp"
)

# EMG Signal Processing
set(EMG_SIGNAL_PROCESSING_SRC_DIR "${EMG_SRC_DIR}/SignalProcessing")
list(APPEND EMG_SIGNAL_PROCESSING_SRC
    "${EMG_SIGNAL_PROCESSING_SRC_DIR}/Rectifier.cpp"
    "${EMG_SIGNAL_PROCESSING_SRC_DIR}/TeagerKaiserEnergyOperator.cpp"
)

# collect common source files
set(EMG_COMMON_SRC
    ${EMG_CORE_SRC}
    ${EMG_SIGNAL_PROCESSING_SRC}
)