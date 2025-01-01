#include <iostream>
#include <cuda_runtime.h>

void shared_memory_per_block() {
    int device_id = 0;
    int shared_mem_size;

    cudaDeviceGetAttribute(&shared_mem_size, cudaDevAttrMaxSharedMemoryPerBlock, device_id);
    std::cout << "Shared Memory Size per Block: " << shared_mem_size << " bytes" << std::endl;
}

__global__ void total_shared_memory() {
    extern __shared__ int shared_memory[];
    printf("Shared Memory Size per Block: %lu bytes\n", sizeof(shared_memory));
}

int main() {
    shared_memory_per_block();
    total_shared_memory<<<1, 1, 1024>>>();

    return 0;
}

// Output: 49152 bytes (48KB)