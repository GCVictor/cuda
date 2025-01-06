#include <cuda_runtime.h>
#include <nccl.h>

#include <iostream>

#define NCCL_CHECK(cmd)                                                    \
  do {                                                                     \
    ncclResult_t res = cmd;                                                \
    if (res != ncclSuccess) {                                              \
      std::cerr << "NCCL error: " << ncclGetErrorString(res) << std::endl; \
      exit(EXIT_FAILURE);                                                  \
    }                                                                      \
  } while (0)

#define CUDA_CHECK(call)                                               \
  do {                                                                 \
    cudaError_t err = call;                                            \
    if (err != cudaSuccess) {                                          \
      std::cerr << "CUDA error: " << cudaGetErrorString(err) << " at " \
                << __FILE__ << ":" << __LINE__ << std::endl;           \
      exit(EXIT_FAILURE);                                              \
    }                                                                  \
  } while (0)

int main() {
  int size = 2;  // GPU数量
  int rank = 0;  // 当前GPU的rank

  ncclComm_t comm;
  ncclUniqueId id;
  ncclGetUniqueId(&id);
  ncclCommInitRank(&comm, size, id, rank);

  const int N = 1024;
  float* send_buff;
  float* recv_buff;

  CUDA_CHECK(cudaMalloc(&send_buff, N * sizeof(float)));
  CUDA_CHECK(cudaMalloc(&recv_buff, N * sizeof(float)));

  float value = rank + 1;
}