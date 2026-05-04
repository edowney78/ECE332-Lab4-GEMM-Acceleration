# =========================================================
# DE1-SoC board host Makefile for digit CNN + FPGA GEMM
# =========================================================

CXX := g++
TARGET := bin/cnn_infer_board

# ---------------------------------------------------------
# Paths
# ---------------------------------------------------------
ALTERAOCLSDKROOT ?= /home/root/OpenCL/opencl_arm32_rte
AOCL_UTILS_INC := /home/root/OpenCL/Labs/common/inc
AOCL_UTILS_SRC := /home/root/OpenCL/Labs/common/src/AOCLUtils/opencl.cpp

# ---------------------------------------------------------
# Compiler flags
# ---------------------------------------------------------
CXXFLAGS := -O2 -std=c++0x \
	-I$(ALTERAOCLSDKROOT)/host/include \
	-I$(AOCL_UTILS_INC)

# ---------------------------------------------------------
# Linker flags
# Match the working OpenCL command exactly
# ---------------------------------------------------------
LDFLAGS := \
	-L$(ALTERAOCLSDKROOT)/board/c5soc/arm32/lib \
	-L$(ALTERAOCLSDKROOT)/host/arm32/lib \
	-Wl,--no-as-needed \
	-lalteracl \
	-lalterammdpcie \
	-lelf \
	-lstdc++ \
	-lrt \
	-lpthread \
	-lm

# ---------------------------------------------------------
# Source files
# ---------------------------------------------------------
SRCS := \
	main_loop.cpp \
	digit_cnn.cpp \
	fpga_gemm_backend.cpp \
	preprocess_digit.cpp \
	capture_digit.cpp \
	$(AOCL_UTILS_SRC)

# ---------------------------------------------------------
# Default target
# ---------------------------------------------------------
all: $(TARGET)

# ---------------------------------------------------------
# Build target
# ---------------------------------------------------------
$(TARGET): $(SRCS)
	mkdir -p bin
	@echo "[CXX] $@"
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# ---------------------------------------------------------
# Clean
# ---------------------------------------------------------
clean:
	rm -rf bin

.PHONY: all clean