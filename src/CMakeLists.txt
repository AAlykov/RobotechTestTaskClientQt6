file(GLOB SOURCES ${CMAKE_CURRENT_LIST_DIR}/*.cpp)
file(GLOB HEADERS ${CMAKE_CURRENT_LIST_DIR}/*.h)

target_sources(
    ${PROJECT_NAME}
    PRIVATE
    ${SOURCES}
    ${HEADERS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
)
