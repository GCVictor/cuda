#include <cuda_runtime.h>

#include <iostream>

int main(int argc, char** argv) {
  int deviceCount;
  cudaGetDeviceCount(&deviceCount);

  for (int i = 0; i < deviceCount; i++) {
    for (int j = 0; j < deviceCount; j++) {
      if (i == j) continue;

      int canAccessPeer;
      cudaDeviceCanAccessPeer(&canAccessPeer, i, j);

      if (canAccessPeer) {
        cudaSetDevice(i);
        cudaDeviceEnablePeerAccess(j, 0);  // 启用 P2P 访问
        printf("GPU %d can access GPU %d directly\n", i, j);
      } else {
        printf("GPU %d cannot access GPU %d directly\n", i, j);
      }
    }
  }
}