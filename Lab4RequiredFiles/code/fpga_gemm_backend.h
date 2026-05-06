#ifndef FPGA_GEMM_BACKEND_H
#define FPGA_GEMM_BACKEND_H

#include <vector>
#include <string>

struct GemmCompareInfo {
    std::string tag;
    int M;
    int K;
    int N;

    bool cpu_success;
    bool fpga_success;

    double cpu_time_ms;
    double fpga_time_ms;

    float max_abs_diff;
    float avg_abs_diff;

    bool outputs_match;
    bool returned_fpga;
};

bool gemm_backend_init(const char* bitstream_path);
void gemm_backend_cleanup();
bool gemm_backend_is_fpga_ready();

void gemm_backend_run_cpu(const std::vector<float>& A,
                          const std::vector<float>& B,
                          std::vector<float>& C,
                          int M,
                          int K,
                          int N);

bool gemm_backend_run_fpga(const std::vector<float>& A,
                           const std::vector<float>& B,
                           std::vector<float>& C,
                           int M,
                           int K,
                           int N);

bool gemm_backend_run_both_compare(const std::vector<float>& A,
                                   const std::vector<float>& B,
                                   std::vector<float>& C_out,
                                   int M,
                                   int K,
                                   int N,
                                   const char* tag,
                                   GemmCompareInfo* info);

void gemm_backend_print_stats();

#endif