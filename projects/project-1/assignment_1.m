function y = assignment_1

global im low_contrast_im

im = imread('images/lena512.bmp');
[rows, columns] = size(im);

subplot(1,2,1);
ax1 = gca;

im_hist = hist(im(:), 0:255);
normalized_im_hist = im_hist ./ sum(im_hist);
bar(normalized_im_hist);

head_title = 'Lena512 Normalized Histogram';
title({head_title, '(Normal contrast)'});

a = 0.2;
b = 50;

low_contrast_im = im;
for i = 1:rows
    for j = 1:columns
        low_contrast_im(i,j) = min(max(round(a*im(i,j) + b), 0), 255);
    end
end

%figure;
subplot(1,2,2);
ax2 = gca;

low_contrast_im_hist = hist(low_contrast_im(:), 0:255);
normalized_low_contrast_im_hist = ...
    low_contrast_im_hist ./ sum(low_contrast_im_hist);
bar(normalized_low_contrast_im_hist);
title({head_title, '(Low contrast)'});

global_max = 1.1 * ...
    max( max(normalized_im_hist), max(normalized_low_contrast_im_hist) );

ax1.YLim = [0 global_max];
ax2.YLim = [0 global_max];

% The values are squeezed together, while keeping the overall shape.

y = low_contrast_im;