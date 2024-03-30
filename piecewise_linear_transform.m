function piecewise_linear_transform(input_image, input_intensities, output_intensities)
    % Read and preprocess the image
    origin_Image = imread(input_image);
    origin_Image = im2double(origin_Image);

    [row, col] = size(origin_Image);
    num_segments = numel(input_intensities) - 1;
    image_stretch = zeros(row, col); % Initialize the stretched image

    for i = 1:num_segments
        lower_threshold = input_intensities(i);
        upper_threshold = input_intensities(i + 1);

        slope = (output_intensities(i + 1) - output_intensities(i)) / (upper_threshold - lower_threshold);

        % Apply the appropriate transformation based on the slope
        image_stretch(origin_Image >= lower_threshold & origin_Image <= upper_threshold) = slope * (origin_Image(origin_Image >= lower_threshold & origin_Image <= upper_threshold) - lower_threshold) + output_intensities(i);
    end

    % Display the original and stretched images
    figure;
    subplot(1, 2, 1), imshow(origin_Image), title('Original Image');
    subplot(1, 2, 2), imshow(image_stretch), title('Transformed Image');

    % Plotting the piecewise linear function
    input_range = linspace(0, 1, 256);
    output_range = zeros(size(input_range));

    for i = 1:num_segments
        input_mask = (input_range >= input_intensities(i)/255) & (input_range <= input_intensities(i+1)/255);
        output_range(input_mask) = (input_range(input_mask) - input_intensities(i)/255) * (output_intensities(i+1)/255 - output_intensities(i)/255) / (input_intensities(i+1)/255 - input_intensities(i)/255) + output_intensities(i)/255;
    end

    % Plotting the piecewise linear transformation function
    figure;
    subplot(1, 2, 1), plot(input_range, output_range);
    title('Piecewise Linear Transformation Function');
    xlabel('Input Intensity');
    ylabel('Output Intensity');

    % Plotting the input-output intensities
    subplot(1, 2, 2), plot(input_intensities, output_intensities, 'o-');
    title('Input-Output Intensities');
    xlabel('Input Intensity');
    ylabel('Output Intensity');
end
