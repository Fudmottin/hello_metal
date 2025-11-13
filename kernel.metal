#include <metal_stdlib>
using namespace metal;

kernel void hello_kernel(device uint* data [[buffer(0)]],
                         uint id [[thread_position_in_grid]]) {
    data[id] = id;
}

