clc;
clear;
close all hidden;
close all;

% GRAY SCALE IMAGE CONVERSION
img = 'apple.jpg';
im = imread(img);
intensities = [0.21, 0.72, 0.07];
gray = intensities(1)*im(:,:,1) + intensities(2)*im(:,:,2) + intensities(3)*im(:,:,3);
figure(1);
subplot(1,2,1), imshow(im), title('Color Image');
subplot(1,2,2), imshow(gray), title('Gray Scale Image');