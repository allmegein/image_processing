clear;
close all;
close all hidden;
clc;

% CANNY EDGE DETECTION
% 1. GRAY SCALE CONVERSION
img = 'lenna.jpg';
im = imread(img);
intensities = [0.21, 0.72, 0.07];
gray = intensities(1)*im(:,:,1) + intensities(2)*im(:,:,2) + intensities(3)*im(:,:,3);
A = imnoise(gray, 'Gaussian', 0.04, 0.008); % add gaussian noise
I = double(A);
figure(1),subplot(1,2,2), imshow(uint8(I)), title('after noise is added');
subplot(1,2,1), imshow(gray), title('original gray scale image');

% 2. GAUSSIAN BLUR
sigma = 0.6; % standard deviation
sz = 1; % kernel size towards one direction
[x,y] = meshgrid(-sz:sz , -sz:sz);
M = size(x,1)-1;
N = size(y,1)-1;
expo = -(x.^2 + y.^2)/(2*pow2(sigma));
kernel = (1/2*pow2(sigma))*exp(expo); % kernel

% Convolve with Image
output = zeros(size(I));
I = padarray(I, [sz sz]); % zero padding

for i = 1:size(I,1)-M
    for j = 1:size(I,2)-N
        temp = I(i:i+M , j:j+N) .* kernel;
        output(i,j) = sum(temp(:));
    end
end
output = output/10;
outputui = uint8(output);
figure(2), imshow(outputui, [0 255]);

% 3. DETERMINE INTENSITY GRADIENTS
% Sobel Filter
Gx = [1 0 -1;2 0 -2;1 0 -1];
Gy = [1 2 1;0 0 0;-1 -2 -1];

imgradient_x = conv2(outputui, Gx);
imgradient_y = conv2(outputui, Gy);

figure(3);
subplot(1,2,1), imshow(imgradient_x, [0 255]), title('X Gradient');
subplot(1,2,2), imshow(imgradient_y, [0 255]), title('Y Gradient');

n_direction = atan2(imgradient_y, imgradient_x);
n_direction = n_direction * 180 /pi;
img_magnitude = sqrt(imgradient_x.^2 + imgradient_y.^2);
img_magnitude = uint8(img_magnitude);
figure(4), imshow(img_magnitude), title('Gradient Magnitude');

% 4. NON MAXIMUM SUPPRESSION
% Direction Calculation
n_direction_dis = zeros(size(n_direction));
for i = 1:size(n_direction_dis,1)
    for j = 1:size(n_direction_dis,2)
        if (( n_direction(i,j)>0) && (n_direction(i,j)<22.5) || (n_direction(i,j)>157.5) && (n_direction(i,j)<-157.5))
            n_direction_dis(i,j) = 0;
        end
        if ((n_direction(i,j)>22.5) && (n_direction(i,j)<67.5) || (n_direction(i,j)>-112.5) && (n_direction(i,j)>-157.5))
            n_direction_dis(i,j) = 45;
        end
        if ((n_direction(i,j)>67.5) && (n_direction(i,j)<112.5) || (n_direction(i,j)<-67.5) && (n_direction(i,j)>112.5))
            n_direction_dis(i,j) = 90;
        end
        if ((n_direction(i,j)>112.5) && (n_direction(i,j)<=157.5) || (n_direction(i,j)>-22.5) && (n_direction(i,j)<-67.5))
            n_direction_dis(i,j) = 135;
        end
    end
end

% Non max suppression
img_sup = zeros(size(n_direction_dis));
for i = 2:size(n_direction_dis,1)-1
    for j = 2:size(n_direction_dis,2)-1
        
        if (n_direction_dis(i,j) == 0)
            if (img_magnitude(i,j)>img_magnitude(i,j-1) && img_magnitude(i,j)>img_magnitude(i,j+1))
                img_sup(i,j) = img_magnitude(i,j);
            else
                img_sup(i,j) = 0;
            end
        end
        
        if (n_direction_dis(i,j) == 45)
            if (img_magnitude(i,j)>img_magnitude(i+1,j-1) && img_magnitude(i,j)>img_magnitude(i-1,j+1))
                img_sup(i,j) = img_magnitude(i,j);
            else
                img_sup(i,j) = 0;
            end
        end
        
        if (n_direction_dis(i,j) == 90)
            if (img_magnitude(i,j)>img_magnitude(i-1,j) && img_magnitude(i,j)>img_magnitude(i+1,j))
                img_sup(i,j) = img_magnitude(i,j);
            else
                img_sup(i,j) = 0;
            end
        end
        
        if (n_direction_dis(i,j) == 135)
            if (img_magnitude(i,j)>img_magnitude(i-1,j-1) && img_magnitude(i,j)>img_magnitude(i+1,j+1))
                img_sup(i,j) = img_magnitude(i,j);
            else
                img_sup(i,j) = 0;
            end
        end
    end
end

figure(5);
imshow(img_sup, []), title('Suppresed Image');

% 5. DOUBLE THRESHOLDING
coefL = 0.1;
coefH = 0.3;
lowThreshold = coefL * max(img_sup(:));
highThreshold = coefH * max(img_sup(:));
img_thresh = zeros(size(img_sup));
for i = 1:size(img_thresh,1)
    for j = 1:size(img_thresh,2)
        if (img_sup(i,j)<lowThreshold)
            img_thresh(i,j) = 0;
        elseif (img_sup(i,j)>highThreshold)
            img_thresh(i,j) = 1;
        else
            if (img_sup(i+1,j)>highThreshold) || (img_sup(i-1,j)>highThreshold) || (img_sup(i,j+1)>highThreshold) || (img_sup(i,j-1)>highThreshold)
            img_thresh(i,j) = 1;
            end
        end
    end
end

figure(6);
imshow(img_thresh, []), title('Hysteresis Threshold');