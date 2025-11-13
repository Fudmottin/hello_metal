#import <Metal/Metal.h>
#import <Foundation/Foundation.h>
#include <vector>
#include <iostream>

int main() {
    @autoreleasepool {
        id<MTLDevice> device = MTLCreateSystemDefaultDevice();
        if (!device) {
            std::cerr << "Metal not supported on this device\n";
            return 1;
        }

        NSError* error = nil;
        NSURL* url = [NSURL fileURLWithPath:@"kernel.metallib"];
        id<MTLLibrary> library = [device newLibraryWithURL:url error:&error];
        if (!library) {
            std::cerr << "Failed to load library: " << [[error localizedDescription] UTF8String] << "\n";
            return 1;
        }

        id<MTLFunction> kernelFunction = [library newFunctionWithName:@"hello_kernel"];
        id<MTLCommandQueue> queue = [device newCommandQueue];
        id<MTLComputePipelineState> pipeline = [device newComputePipelineStateWithFunction:kernelFunction error:&error];

        const int count = 16;
        std::vector<uint32_t> data(count, 0);
        id<MTLBuffer> buffer = [device newBufferWithBytes:data.data()
                                                   length:sizeof(uint32_t) * count
                                                  options:MTLResourceStorageModeShared];

        id<MTLCommandBuffer> commandBuffer = [queue commandBuffer];
        id<MTLComputeCommandEncoder> encoder = [commandBuffer computeCommandEncoder];
        [encoder setComputePipelineState:pipeline];
        [encoder setBuffer:buffer offset:0 atIndex:0];

        MTLSize gridSize = MTLSizeMake(count, 1, 1);
        NSUInteger threadGroupSize = pipeline.maxTotalThreadsPerThreadgroup;
        MTLSize threadgroupSize = MTLSizeMake(threadGroupSize, 1, 1);

        [encoder dispatchThreads:gridSize threadsPerThreadgroup:threadgroupSize];
        [encoder endEncoding];
        [commandBuffer commit];
        [commandBuffer waitUntilCompleted];

        uint32_t* results = (uint32_t*)[buffer contents];
        for (int i = 0; i < count; ++i) {
            std::cout << results[i] << " ";
        }
        std::cout << "\n";
    }
    return 0;
}

