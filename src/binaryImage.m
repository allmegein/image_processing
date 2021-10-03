clc;
clear;
close all hidden;
close all;

% BINARY IMAGE CONVERSION
% Gray Scale Image Conversion
img = 'apple.jpg';
im = imread(img);
intensities = [0.21, 0.72, 0.07];
gray = intensities(1)*im(:,:,1) + intensities(2)*im(:,:,2) + intensities(3)*im(:,:,3);
figure(1);
subplot(1,3,1), imshow(im), title('Color Image');
subplot(1,3,2), imshow(gray), title('Gray Scale Image');

% Binary Image Conversion
threshold = 256/2;
binary = gray > threshold;
subplot(1,3,3), imshow(binary), title('Binary Image');