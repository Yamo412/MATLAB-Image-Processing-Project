function [gradient_magnitude, gradient_angle, gradient_suppressed] = edge_detection(image)
    % Normalize the image to [0, 1] range
    normalized_image = double(image) / 255.0;

    % Create a Gaussian kernel for smoothing
    sigma = 0.5;
    kernel_size = 5;
    half_size = (kernel_size - 1) / 2;
    [x, y] = meshgrid(-half_size:half_size, -half_size:half_size);
    gaussian_kernel = exp(-(x.^2 + y.^2) / (2 * sigma^2));
    gaussian_kernel = gaussian_kernel / sum(gaussian_kernel(:));

    % Apply Gaussian smoothing using convolution
    smoothed_image = conv2(normalized_image, gaussian_kernel, 'same');

    % Compute the gradient magnitude and angle images
    [gradient_x, gradient_y] = gradient(smoothed_image);
    gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);
    gradient_angle = atan2(gradient_y, gradient_x);

    % Discretize angles into 8 directions (8 bins)
    angle_bins = [-22.5, 22.5, 67.5, 112.5, 157.5, -157.5, -112.5, -67.5];

    % Apply nonmaximal suppression to the gradient magnitude image
    gradient_suppressed = zeros(size(gradient_magnitude));
    for i = 1:numel(angle_bins)
        angle_bin = angle_bins(i);
        mask = (gradient_angle >= (angle_bin - 22.5) * pi / 180) & (gradient_angle < (angle_bin + 22.5) * pi / 180);
        gradient_suppressed = max(gradient_suppressed, gradient_magnitude .* mask);
    end
end
