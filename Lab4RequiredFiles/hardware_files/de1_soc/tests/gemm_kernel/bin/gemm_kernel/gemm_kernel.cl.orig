__kernel void gemm_kernel(__global const float *input_tile,
                     __global const float *weights_tile,
                     const int input_tile_size,
                     const int output_neurons_tile_size,
                     __global float *output_tile)
{
    // The Python test uses a 1D global execution size.
    // 'id' represents the specific output neuron this thread is calculating.
    int id = get_global_id(0);

    // Bounds check to ensure we don't write outside the output buffer
    if (id < output_neurons_tile_size) {
        float sum = 0.0f;
        
        // Compute the dot product of the 1D input array and the corresponding column of the weights matrix
        for (int k = 0; k < input_tile_size; ++k) {
            // This assumes the weights matrix is flattened in row-major order 
            // with dimensions [input_tile_size x output_neurons_tile_size]
            sum += input_tile[k] * weights_tile[k * output_neurons_tile_size + id];
        }
        
        output_tile[id] = sum;
    }
}