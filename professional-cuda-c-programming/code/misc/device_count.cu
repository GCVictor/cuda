#include <cuda_runtime.h>

#include <iostream>

using namespace std;

int main(int argc, char **argv) {
  int ngpus;
  cudaGetDeviceCount(&ngpus);

  for (int i = 0; i < ngpus; ++i) {
    cudaDeviceProp devProp;

    cudaGetDeviceProperties(&devProp, i);
    printf("Device %d has compute capability %d.%d.\n", i, devProp.major,
           devProp.minor);
  }

  return 0;
}