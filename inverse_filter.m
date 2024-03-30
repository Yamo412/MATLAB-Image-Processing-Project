function output_image = inverse_filter(degraded_image, degradation_function, threshold)
    % Step 1: Convolve the original image with the degradation function
    degraded_image_freq = fftshift(fft2(degraded_image));
    degradation_function_freq = fftshift(fft2(degradation_function, size(degraded_image, 1), size(degraded_image, 2)));
    
    % Step 2: Perform inverse filtering in the frequency domain
    estimated_image_freq = degraded_image_freq ./ degradation_function_freq;
    estimated_image_freq(abs(degradation_function_freq) < threshold) = 0;
    
    % Step 3: Map the estimated image to the spatial domain
    estimated_image = ifft2(ifftshift(estimated_image_freq));
    output_image = real(estimated_image); % Remove any potential imaginary components
    
    % Ensure the output image is within valid intensity range
    output_image = max(0, min(255, output_image));
end