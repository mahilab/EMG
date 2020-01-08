cmake_minimum_required(VERSION 3.13.0)

#===============================================================================
# USER OPTIONS
#===============================================================================
option(QUANSER     "Turn ON if compiling for Quanser hardware"                                 ON)
option(MYO         "Turn ON to build Thalmic Labs Myo Armband."                                ON)
option(EXAMPLES    "Turn ON to build example executable(s)."                                   OFF)
option(TESTS       "Turn ON to build test executable(s)"                                       OFF)

set(EIGEN_ROOT   "C:/dev/eigen"                 CACHE FILEPATH "Absolute path to Eigen installation.")



# enable C/C++
enable_language(C)
enable_language(CXX)

# enable C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CONFIGURATION_TYPES Release)

# create project
project(EMG VERSION 0.1.0 LANGUAGES CXX)

# tell user they can't have shared version of EMG if they try
if (BUILD_SHARED_LIBS)
    message(FATAL_ERROR "EMG does not yet support shared libaries")
endif()

# add ./cmake to CMake module path so our .cmake files can be found
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_SOURCE_DIR}/cmake)

include(EMGSources)     # lists of EMG source and header files
include(GNUInstallDirs) # defines conventional GNU isntallation directories

# Enable IDE folders and set them for predefined CMake projects
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake")

#===============================================================================
# CREATE EMG LIBRARY
#===============================================================================

# create EMG library (EMG::EMG)
add_library(EMG STATIC "")
target_compile_definitions(EMG PUBLIC)

# add alias so that find_package(EMG) and add_subdirectory(EMG) provide the same targets and namespaces
add_library(EMG::EMG ALIAS EMG)

# add sources
target_sources(EMG PRIVATE ${EMG_COMMON_SRC})

# add <project>/include as public include directory
target_include_directories(EMG
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    PRIVATE
        ${PROJECT_SOURCE_DIR}/src                
)

# add compile features
# complete listing:
# https://cmake.org/cmake/help/v3.14/prop_gbl/CMAKE_CXX_KNOWN_FEATURES.html
target_compile_features(EMG
    PUBLIC
        cxx_std_11
    PRIVATE
)

if(WIN32)
    target_compile_definitions(EMG
        PUBLIC
            -D_CRT_SECURE_NO_WARNINGS          # remove secure warnings (e.g sprinft_s)
            -DNOMINMAX                         # remove min/max macros
            -D_WINSOCK_DEPRECATED_NO_WARNINGS  # remove winsock deprecated warnings
    )

    # the following only compile under MSVC
    if(MSVC)
        if (MYO)
            target_link_libraries(EMG MEL::myo)
        endif()
        if (QUANSER)
            target_link_libraries(EMG MEL::quanser)
        endif()
    endif(MSVC)
endif(WIN32)


#===============================================================================
# LINK EXTERNAL LIBS
#===============================================================================


find_package(MEL REQUIRED)

# Eigen Lib
set(INCLUDE_DIRS include ${EIGEN_ROOT})

# include directories
include_directories(${INCLUDE_DIRS})


#===============================================================================
# Install
#===============================================================================

# install the library
set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/EMG)
install(TARGETS EMG
	EXPORT EMG-targets
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

set_target_properties(EMG PROPERTIES EXPORT_NAME EMG)
set_target_properties(EMG PROPERTIES FOLDER "EMG")

# install headers
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# set where we want to install our config
set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/EMG)

# export the targets to a script
install(EXPORT EMG-targets
	FILE
		EMGTargets.cmake
	# NAMESPACE
	# 	EMG::
	DESTINATION
		${INSTALL_CONFIGDIR}
)

# include helper functions for creating config files that can be included by other projects to find and use a package
include(CMakePackageConfigHelpers)

# generate a package configuration file and a package version file
configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/EMGConfig.cmake.in
	${CMAKE_CURRENT_BINARY_DIR}/EMGConfig.cmake
	INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
)
write_basic_package_version_file(
	${CMAKE_CURRENT_BINARY_DIR}/EMGConfigVersion.cmake
	VERSION ${PROJECT_VERSION}
	COMPATIBILITY AnyNewerVersion
)

# install the config and configversion modules
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/EMGConfig.cmake
	${CMAKE_CURRENT_BINARY_DIR}/EMGConfigVersion.cmake
	DESTINATION ${INSTALL_CONFIGDIR}
)

# export from the build tree
export(EXPORT EMG-targets
	#    NAMESPACE syntacts::
	   FILE ${CMAKE_CURRENT_BINARY_DIR}/EMGTargets.cmake)



#===============================================================================
# CREATE EXECUTABLES
#===============================================================================

add_executable(ex_myoband examples/ex_myoband.cpp)
target_link_libraries(ex_myoband EMG)