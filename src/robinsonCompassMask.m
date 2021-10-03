% ROBINSON COMPASS MASK
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
fn = [-1 0 1; -2 0 2; -1 0 1]; % north direction
fnw = [0 1 2; -1 0 1; -2 -1 0]; % north - west direction
fw = [1 2 1; 0 0 0; -1 -2 -1]; % west direction
fsw = [2 1 0; 1 0 -1; 0 -1 -2]; % south - west direction
fs = [1 0 -1; 2 0 -2; 1 0 -1]; % south direction
fse = [0 -1 -2; 1 0 -1; 2 1 0]; % south - east direction
fe = [-1 -2 -1; 0 0 0; 1 2 1]; % east direction
fne = [-2 -1 0; -1 0 1; 0 1 2]; % north - east direction

M = size(fn,1)-1;
N = size(fn,2)-1;
IM = padarray(I, [1 1]); % zero padding

% convolve image with masks.
on = zeros(size(I));
ima = double(IM);
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fn;
        on(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(on, [0 255]);

onw = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fnw;
        onw(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(onw, [0 255]);

ow = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fw;
        ow(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(ow, [0 255]);

osw = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fsw;
        osw(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(osw, [0 255]);

os = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fs;
        os(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(os, [0 255]);

ose = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fse;
        ose(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(ose, [0 255]);

oe = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fe;
        oe(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(oe, [0 255]);

one = zeros(size(I));
for i = 1:size(ima,1)-M
    for j = 1:size(ima,2)-N
        temp = ima(i:i+M , j:j+N) .* fne;
        one(i,j) = sum(temp(:));
    end
end

step = step + 1;
figure(step), imshow(one, [0 255]);

out = sqrt(oe.^2 + on.^2 + one.^2 + onw.^2 + os.^2 + ose.^2 + osw.^2 + ow.^2);
step = step + 1;
figure(step), imshow(out, []);

% ****************************** End of Code******************************