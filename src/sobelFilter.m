% SOBEL FILTER
clear;
close all;
clc;

% read image
im = imread('sudoku.jpg');
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
fv = [-1 0 1; -2 0 2; -1 0 1]; % vertical mask
fh = [-1 -2 -1; 0 0 0; 1 2 1]; % horizontal mask
M = size(fv,1)-1;
N = size(fv,2)-1;
IM = padarray(I, [1 1]); % zero padding

% convolve image with masks.
ov = zeros(size(I));
ima = double(IM);
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fv;
        ov(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(ov, [0 255]);

oh = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fh;
        oh(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(oh, [0 255]);

out = sqrt(ov.^2 + oh.^2);
step = step + 1;
figure(step), imshow(out, []);

% ****************************** End of Code******************************