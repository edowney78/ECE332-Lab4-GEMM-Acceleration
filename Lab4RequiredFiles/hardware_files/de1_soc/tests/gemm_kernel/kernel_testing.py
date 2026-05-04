#!/usr/bin/env python
# coding: utf-8

# Testing OpenCL (.cl) kernels by loading them into Python within a Jupyter notebook and using pyOpenCL module

# 1. Load .cl File: Read the OpenCL kernel from a .cl file into a Python string using file I/O operations.
# 
# 2. Initialize OpenCL: Use pyopencl to select an OpenCL platform and device, creating a context and command queue.
# 
# 3. Compile Kernel: Compile the kernel code within the notebook environment, addressing any compilation issues.
# 
# 4. Prepare Data: Allocate memory for input and output data on the device using OpenCL buffers and transfer input data to the device.
# 
# 5. Execute Kernel: Enqueue the kernel for execution, specifying the number of work items and groups, and wait for completion.
# 
# 6. Read Results: Retrieve output data from the device to the host and analyze for correctness.
# 
# 7. Cleanup: Release OpenCL resources like buffers and context.

# Install required pyopencl kernel

# In[1]:


get_ipython().system('pip install pyopencl')


# Test environment by printing the environment
# 
# Example output:
# 
# Number of platforms                      2
# Platform Name                            Intel(R) OpenCL HD Graphics
# Platform Vendor                          Intel(R) Corporation
# Platform Version                         OpenCL 2.1

# In[2]:


get_ipython().system('clinfo')


# Import python modules

# In[1]:


import pyopencl as cl
import numpy as np


# In[3]:


import sys
print(sys.executable)


# Initialize OpenCL: Use pyopencl to select an OpenCL platform and device
# 
# Example output:
# 
# [<pyopencl.Device 'Intel(R) Gen9 HD Graphics NEO' on 'Intel(R) OpenCL HD Graphics'

# In[ ]:


platforms = cl.get_platforms()
cpu_devices = [device for device in platforms[0].get_devices(device_type=cl.device_type.GPU)]
cpu_devices


# Creating a context and command queue

# In[ ]:


context = cl.Context(devices=cpu_devices)

# Create a command queue for the target device
queue = cl.CommandQueue(context)


# Load .cl File: Read the OpenCL kernel from a .cl file into a Python string using file I/O operations

# In[ ]:


file_name = "./device/hidden.cl"  # Replace with the name of your uploaded .cl file
with open(file_name, 'r') as file:
    kernel_code = file.read()


# Compile Kernel: Compile the kernel code

# In[ ]:


program = cl.Program(context, kernel_code).build()


# Initialize inputs to test (test for random inputs) and output to zeros

# In[ ]:


input_tile_size = 16
output_neurons_tile_size = 10

# Initialize random data for the input tile and weights
input_tile = np.random.rand(input_tile_size).astype(np.float32)
weights_tile = np.random.rand(input_tile_size * output_neurons_tile_size).astype(np.float32)

output_tile = np.zeros(output_neurons_tile_size).astype(np.float32)


# In[ ]:


# Create memory buffers
input_tile_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=input_tile)
weights_tile_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=weights_tile)
output_tile_buf = cl.Buffer(context, cl.mem_flags.WRITE_ONLY, output_tile.nbytes)

# Build the kernel
program = cl.Program(context, kernel_code).build()

# Execute the kernel
global_size = (output_tile.size,)
local_size = None
program.hidden(queue, global_size, local_size,
               input_tile_buf, weights_tile_buf,
               np.int32(input_tile_size), np.int32(output_neurons_tile_size),
               output_tile_buf)

# Read the output buffer back to the host
cl.enqueue_copy(queue, output_tile, output_tile_buf)

# Output the results
print(output_tile)


# In[ ]:


def matrix_vector_multiply(input_tile, weights_tile, input_tile_size, output_neurons_tile_size):
    # Reshape weights_tile to be a 2D array for matrix multiplication
    weights_matrix = weights_tile.reshape((output_neurons_tile_size, input_tile_size))

    # Perform matrix-vector multiplication
    output_tile = np.dot(weights_matrix, input_tile)

    return output_tile


# In[ ]:


test_output = matrix_vector_multiply(input_tile, weights_tile, input_tile_size, output_neurons_tile_size)


# In[ ]:


test_output

