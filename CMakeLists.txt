cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

option(GENERATE_TRANSLATION "Enable generation of Qt linguis files." ON)

set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_SOURCE_DIR}/deploy/
)

project(RobotechTestTaskClientQt6
	VERSION 1.0.0
    	LANGUAGES CXX
)

set(OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")

add_executable(${PROJECT_NAME}
    ${CMAKE_SOURCE_DIR}/resources/qml.qrc    
)

list(APPEND QML_IMPORT_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/resources/qml)

set(QML_IMPORT_PATH ${QML_IMPORT_PATHS}
    CACHE STRING "Qt Creator 5.15.2 extra qml import paths"
    FORCE
)

find_package(Qt6
    COMPONENTS REQUIRED
    Core
    Quick
)

if (MSVC)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /MANIFEST:NO")
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Quick
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED YES
    CXX_EXTENSIONS NO
    AUTOUIC ON
    AUTOMOC ON
    AUTORCC ON
    WIN32_EXECUTABLE TRUE
    RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_DIRECTORY}"
)

list(APPEND QML_IMPORT_PATHS
    ${CMAKE_CURRENT_SOURCE_DIR}/resources/qml
)

#include(deploy)
#deploy(${PROJECT_NAME} ${OUTPUT_DIRECTORY} QML_PATH ${CMAKE_CURRENT_LIST_DIR}/resources/qml)

add_subdirectory("src")
