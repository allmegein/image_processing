clc;
clear;
close all hidden;
close all;

% EROSION
img = 'writing.jpg';
im = imread(img);
intensities = [0.21, 0.72, 0.07];
gray = intensities(1)*im(:,:,1) + intensities(2)*im(:,:,2) + intensities(3)*im(:,:,3);

threshold = 256/2;
binary = gray > threshold;
subplot(1,3,3), imshow(binary), title('Binary Image');

se = strel('disk', 1, 4); % structuring element
f = se.Neighborhood;
[R, C] = size(f);

erosed = zeros(size(binary,1), size(binary,2));
for i = ceil(R/2):size(binary,1) - floor(R/2)
    for j = ceil(C/2):size(binary,2) - floor(C/2)
        on = binary(i - floor(R/2):i + floor(R/2), j - floor(C/2): j + floor(C/2));
        nh = on(logical(f));
        erosed(i,j) = min(nh(:));
    end
end

figure(1);
subplot(1,2,1), imshow(binary);
subplot(1,2,2), imshow(erosed);
title('Erosed');

dilated = zeros(size(erosed,1), size(erosed,2));
for i = ceil(R/2):size(erosed,1) - floor(R/2)
    for j = ceil(C/2):size(erosed,2) - floor(C/2)
        on = erosed(i - floor(R/2):i + floor(R/2), j - floor(C/2): j + floor(C/2));
        nh = on(logical(f));
        dilated(i,j) = max(nh(:));
    end
end

figure(2);
subplot(1,2,1), imshow(erosed);
subplot(1,2,2), imshow(dilated);
title('Dilated');