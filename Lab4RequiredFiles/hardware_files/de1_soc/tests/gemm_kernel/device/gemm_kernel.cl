__kernel void gemm_kernel(__global const float *A,
                          __global const float *B,
                          __global float *C,
                          const int M,
                          const int K,
                          const int N)
{
    // 2D thread mapping matching the host C++ global_work_size
    int row = get_global_id(0);
    int col = get_global_id(1);

    // Bounds check to prevent memory access violations
    if (row < M && col < N) {
        float sum = 0.0f;
        
        // Compute dot product of A's row and B's column
        for (int k = 0; k < K; ++k) {
            sum += A[row * K + k] * B[k * N + col];
        }
        
        // Write the result to the output matrix C
        C[row * N + col] = sum;
    }
}