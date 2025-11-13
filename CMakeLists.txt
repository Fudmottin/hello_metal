cmake_minimum_required(VERSION 3.20)
project(hello_metal LANGUAGES CXX OBJCXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --- Build Metal shaders ---
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/kernel.metallib
    COMMAND xcrun -sdk macosx metal -c
            -target air64-apple-macosx15.0
            ${CMAKE_SOURCE_DIR}/kernel.metal
            -o ${CMAKE_BINARY_DIR}/kernel.air
    COMMAND xcrun -sdk macosx metallib
            ${CMAKE_BINARY_DIR}/kernel.air
            -o ${CMAKE_BINARY_DIR}/kernel.metallib
    DEPENDS ${CMAKE_SOURCE_DIR}/kernel.metal
    COMMENT "Building Metal shaders"
)

add_custom_target(metal_shaders ALL
    DEPENDS ${CMAKE_BINARY_DIR}/kernel.metallib
)

# --- Main executable ---
add_executable(hello_metal main.mm)

target_link_libraries(hello_metal
    "-framework Metal"
    "-framework Foundation"
)

add_dependencies(hello_metal metal_shaders)

