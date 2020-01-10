# This file groups all EMG header and source files 

#===============================================================================
# HEADER FILES
#===============================================================================

# headers directory
set(EMG_HEADERS_DIR "${CMAKE_SOURCE_DIR}/include/EMG")

# collections of common subdirectory headers
set(EMG_CORE_HEADERS "")
set(EMG_SIGNAL_PROCESSING_HEADERS "")

# EMG Core
set(EMG_CORE_HEADERS_DIR "${EMG_HEADERS_DIR}/EMG")
list(APPEND EMG_CORE_HEADERS
    "${EMG_CORE_HEADERS_DIR}/MesArray.hpp"
    "${EMG_CORE_HEADERS_DIR}/MyoelectricSignal.hpp"
)

# EMG Signal Processing
set(EMG_SIGNAL_PROCESSING_HEADERS_DIR "${EMG_HEADERS_DIR}/Signal_Processing")
list(APPEND EMG_SIGNAL_PROCESSING_HEADERS
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/Rectifier.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/SignalProcessingFunctions.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/SignalProcessor.hpp"
    "${EMG_SIGNAL_PROCESSING_HEADERS_DIR}/TeagerKaiserEnergyOperator.hpp"
)

# EMG Classification
set(EMG_CLASSIFICATION_HEADERS_DIR "${EMG_HEADERS_DIR}/Classification")
list(APPEND EMG_CLASSIFICATION_HEADERS
    "${EMG_CLASSIFICATION_HEADERS}/LinearDiscriminantAnalysis.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/RealTimeClassifier.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/RealTimeMultiClassifier.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/EmgActiveClassifier.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/EmgDirClassifier.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/EnsembleRTClassifier.hpp"
    "${EMG_CLASSIFICATION_HEADERS}/EmgActiveEnsClassifier.hpp"
)

# EMG Utility
set(EMG_UTILITY_HEADERS_DIR "${EMG_HEADERS_DIR}/Utility")
list(APPEND EMG_UTILITY_HEADERS
    "${EMG_UTILITY_HEADERS}/EigenConversions.hpp"
    "${EMG_UTILITY_HEADERS}/VirtualInput.hpp"
    "${EMG_UTILITY_HEADERS}/Matrix.hpp"
    "${EMG_UTILITY_HEADERS}/EmgFeatures.hpp"
    "${EMG_UTILITY_HEADERS}/EmgDataCapture.hpp"
)


# collect common header files
set(EMG_COMMON_HEADERS
    ${EMG_CORE_HEADERS}
    ${EMG_SIGNAL_PROCESSING_HEADERS}
    ${EMG_CLASSIFICATION_HEADERS}
    ${EMG_UTILITY_HEADERS}
)

#===============================================================================
# SOURCE FILES
#===============================================================================

# source directory
set(EMG_SRC_DIR "${CMAKE_SOURCE_DIR}/src/EMG")

# collections of subdirectory sources
set(EMG_CORE_SRC "")
set(EMG_SIGNAL_PROCESSING_SRC "")

# EMG Core
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

# EMG Classification
set(EMG_CLASSIFICATION_DIR "${EMG_SRC_DIR}/Classification")
list(APPEND EMG_CLASSIFICATION_SRC
    "${EMG_CLASSIFICATION_DIR}/LinearDiscriminantAnalysis.cpp"
    "${EMG_CLASSIFICATION_DIR}/RealTimeClassifier.cpp"
    "${EMG_CLASSIFICATION_DIR}/RealTimeMultiClassifier.cpp"
    "${EMG_CLASSIFICATION_DIR}/EmgActiveClassifier.cpp"
    "${EMG_CLASSIFICATION_DIR}/EmgDirClassifier.cpp"
    "${EMG_CLASSIFICATION_DIR}/EnsembleRTClassifier.cpp"
    "${EMG_CLASSIFICATION_DIR}/EmgActiveEnsClassifier.cpp"
)

# EMG Utility
set(EMG_UTILITY_SRC_DIR "${EMG_SRC_DIR}/Utility")
list(APPEND EMG_UTILITY_SRC
    "${EMG_UTILITY_SRC_DIR}/EigenConversions.cpp"
    "${EMG_UTILITY_SRC_DIR}/VirtualInput.cpp"
    "${EMG_UTILITY_SRC_DIR}/Matrix.cpp"
    "${EMG_UTILITY_SRC_DIR}/EmgFeatures.cpp"
    "${EMG_UTILITY_SRC_DIR}/EmgDataCapture.cpp"
)

# collect common source files
set(EMG_COMMON_SRC
    ${EMG_CORE_SRC}
    ${EMG_SIGNAL_PROCESSING_SRC}
    ${EMG_CLASSIFICATION_SRC}
    ${EMG_UTILITY_SRC}
)