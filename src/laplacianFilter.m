% LAPLACIAN FILTER
clear;
close all;
clc;

% read image
im = imread('tesla.jpg');
im = imresize(im,.5);
step = 1;
figure(step), imshow(im), title('Color Image');

% convert color image to grayscale
if length(size(im)) == 3
    I = rgb2gray(im);
else
    I = im;
end
step = step + 1;
figure(step), imshow(I), title('Gray Scale Image');

% create filter
fl = [
    0 1 0;
    1 -4 1;
    0 1 0
    ];
% fl = [
%     0 0 1 0 0;
%     0 1 2 1 0;
%     1 2 -16 2 1;
%     0 1 2 1 0;
%     0 0 1 0 0
%     ];
M = size(fl,1)-1;
N = size(fl,2)-1;
IM = padarray(I, [1 1]); % zero padding

% convolve image with masks.
ol = zeros(size(I));
ima = double(IM);
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fl;
        ol(i,j) = sum(temp(:));
    end
end

sharpened = double(I) - ol;
step = step + 1;
figure(step), imshow(ol, [0 255]), title('Edge of Image');
step = step + 1;
figure(step);
subplot(1,2,1), imshow(I), title('Original Image');
subplot(1,2,2), imshow(sharpened, [0 255]), title('Sharpened Image');

% ****************************** End of Code******************************