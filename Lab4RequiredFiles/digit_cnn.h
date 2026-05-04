#ifndef DIGIT_CNN_H
#define DIGIT_CNN_H

#include <string>
#include <vector>
#include "preprocess_digit.h"

struct Tensor3D {
    int C;
    int H;
    int W;
    std::vector<float> data;

    Tensor3D();
    Tensor3D(int c, int h, int w, float val = 0.0f);

    float& at(int c, int y, int x);
    const float& at(int c, int y, int x) const;
};

struct Vector1D {
    int N;
    std::vector<float> data;

    Vector1D();
    Vector1D(int n, float val = 0.0f);

    float& at(int i);
    const float& at(int i) const;
};

struct ConvLayer {
    int out_channels;
    int in_channels;
    int kernel_h;
    int kernel_w;
    int padding;
    std::vector<float> weight;
    std::vector<float> bias;

    ConvLayer();
    float& w(int oc, int ic, int ky, int kx);
    const float& w(int oc, int ic, int ky, int kx) const;
};

struct LinearLayer {
    int out_features;
    int in_features;
    std::vector<float> weight;
    std::vector<float> bias;

    LinearLayer();
    float& w(int o, int i);
    const float& w(int o, int i) const;
};

struct SimpleCNN64 {
    ConvLayer conv1;
    ConvLayer conv2;
    ConvLayer conv3;
    LinearLayer fc1;
    LinearLayer fc2;
};

struct DigitPrediction {
    int pred;
    Vector1D log_probs;
    GrayImage canvas64;
};

SimpleCNN64 create_model_structure();
SimpleCNN64 load_model_from_bin_dir(const std::string& dir_path);

Tensor3D grayimage_to_normalized_tensor(const GrayImage& img);
Vector1D forward(const SimpleCNN64& model, const Tensor3D& input);
int argmax(const Vector1D& v);
void print_vector(const Vector1D& v, const std::string& name);

DigitPrediction predict_digit_from_gray(
    const SimpleCNN64& model,
    const GrayImage& gray,
    int pad = 5,
    int target_box_size = 48,
    int tight_eps = 5,
    bool verbose_preprocess = false,
    bool save_debug_canvas = false,
    const std::string& debug_canvas_path = "final_canvas.pgm"
);

#endif
