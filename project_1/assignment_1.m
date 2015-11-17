function y = assignment_1

im = imread('images/lena512.bmp');
hist(im(:), 0:255);

low_contrast_im = im;

a = 0.2;
b = 50;

[rows,columns] = size(im);
for i = 1:rows
    for j = 1:columns
        low_contrast_im(i,j) = min(max(round(a*im(i,j) + b), 0), 255);
    end
end

figure
hist(low_contrast_im(:), 0:255)
% The values are squeezed together, while keeping the overall shape.

y = low_contrast_im;