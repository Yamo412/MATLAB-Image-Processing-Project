function adaptive_local_noise_reduction(input_image_path, noise_variance, window_size)
    % Load the original image
    original_image = imread(input_image_path);
    original_image = im2double(original_image);

    % Add Gaussian noise to the original image
    noisy_image = imnoise(original_image, 'gaussian', 0, noise_variance);

    % Get image dimensions
    [m, n] = size(noisy_image);

    % Initialize restored image
    restored_image = zeros(m, n);

    % Calculate window half size
    window_half = floor(window_size / 2);

    % Create a figure for plotting
    figure;

    % Display the original image
    subplot(1, 3, 1);
    imshow(original_image);
    title('Original Image');

    % Display the noisy image with added Gaussian noise
    subplot(1, 3, 2);
    imshow(noisy_image);
    title('Noisy Image with Gaussian Noise');

    % Process each pixel
    for i = 1:m
        for j = 1:n
            % Define the limits of the filter window
            x_min = max(i - window_half, 1);
            x_max = min(i + window_half, m);
            y_min = max(j - window_half, 1);
            y_max = min(j + window_half, n);

            % Extract the local window from the noisy image
            local_window = noisy_image(x_min:x_max, y_min:y_max);

            % Calculate the local mean and local variance
            local_mean = mean(local_window(:));
            local_var = var(local_window(:));

            % Calculate the adaptive expression
            alpha = max(0, 1 - noise_variance / local_var);

            % Calculate the restored pixel value
            restored_pixel = local_mean + alpha * (noisy_image(i, j) - local_mean);

            restored_image(i, j) = restored_pixel;
        end
    end
    % Display the restored image
    subplot(1, 3, 3);
    imshow(restored_image);
    title('Restored Image');

    sgtitle('Adaptive Local Noise Reduction');
end