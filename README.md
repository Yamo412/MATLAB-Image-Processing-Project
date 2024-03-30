# MATLAB-Image-Processing-Project

This MATLAB project showcases the implementation of various image processing techniques, including piecewise linear transformation, adaptive local noise reduction, inverse filtering, and edge detection. Designed to demonstrate the application of these methods on different images, the project provides a practical insight into image preprocessing and enhancement in MATLAB.

**Project Components**

- Part 1: Piecewise Linear Transformation
  - Function: piecewise_linear_transform.m
  - Purpose: Enhances image contrast through specified input-output intensity mappings.
  - Usage: piecewise_linear_transform('airplane.png', [0, 100, 130, 255], [0, 70, 200, 255]);
 
- Part 2: Adaptive Local Noise Reduction
  - Function: adaptive_local_noise_reduction.m
  - Purpose: Reduces noise in an image based on local statistics within a sliding window.
  - Usage: adaptive_local_noise_reduction('camera.png', 0.02, 7);
 
- Part 3: Inverse Filtering
  - Function: inverse_filter.m
  - Purpose: Attempts to restore an image degraded by a known distortion, given a degradation function and a threshold for regularization.
  - Usage: ```degradation_function = [3, 7, 7, 7, 8, 9, 5; 4, 6, 2, 5, 8, 8, 3; ...] / 239;
original_image = imread('yard.png');
original_image = rgb2gray(original_image);
degraded_image = conv2(double(original_image), degradation_function, 'same');
threshold = 0.01;
restored_image = inverse_filter(degraded_image, degradation_function, threshold);```

- Part 4: Edge Detection
  - Function: edge_detection.m
  - Purpose: Detects edges in an image using gradient magnitude and applies non-maximal suppression.
  - Usage: ```input_image = imread('house.png');
[gradient_magnitude, gradient_angle, gradient_suppressed] = edge_detection(input_image);```

**Installation**

Ensure MATLAB is installed on your system. Clone this repository or download the files to a local directory. Open MATLAB and navigate to the project directory before running any scripts.

**Running the Project**

Each part of the project can be executed independently by running the corresponding script in the MATLAB command window as shown in the usage sections above. Ensure the image files referenced in the commands are present in the project directory or adjust the paths accordingly.

**Authors**

Yaman Salman
Sama Khraim

