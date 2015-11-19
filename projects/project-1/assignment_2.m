function assignment_2(image_path)


% ORIGINAL IMAGE

im = imread(image_path);
[rows, columns] = size(im);

im_hist = hist(im(:), 0:255);
normalized_im_hist = im_hist ./ sum(im_hist);

subplot(2,3,1);
bar(normalized_im_hist);
ax1 = gca;

head_title = 'Normalized histogram';
title({head_title, '(Normal contrast)'});

subplot(2,3,4);
imshow(im);

image_title = 'Corresponding image';
title(image_title);


% LOW CONTRAST
% The histogram values are squeezed together,
% while keeping the overall shape of the histogram.

a = 0.2;
b = 50;

im_lc = im;
for i = 1:rows
    for j = 1:columns
        im_lc(i,j) = min(max(round(a*im(i,j) + b), 0), 255);
    end
end

im_lc_hist = hist(im_lc(:), 0:255);
im_lc_hist_normalized = im_lc_hist ./ sum(im_lc_hist);

subplot(2,3,2);
bar(im_lc_hist_normalized);
title({head_title, '(Low contrast)'});
ax2 = gca;

subplot(2,3,5);
imshow(im_lc);
title(image_title);


% HISTOGRAM EQUALIZATION
% The histogram is not flat because we are dealing with
% discretized intensity values.

im_lc_hist_normalized_sum = 255 * cumsum(im_lc_hist_normalized);

im_lc_eq = im_lc;
for i = 1:rows
    for j = 1:columns
        im_lc_eq(i,j) = round(im_lc_hist_normalized_sum(im_lc(i,j)));
        %im_lc_eq(i,j) = im_lc_hist_normalized_sum_rounded(im_lc(i,j));
    end
end

im_lc_eq_hist = hist(im_lc_eq(:), 0:255);
im_lc_eq_hist_normalized = im_lc_eq_hist ./ sum(im_lc_eq_hist);

subplot(2,3,3);
bar(im_lc_eq_hist_normalized);
title({head_title, '(Equalized)'});
ax3 = gca;

subplot(2,3,6);
imshow(im_lc_eq);
title(image_title);


global_max = 1.1 * max( [max(normalized_im_hist) ...
    max(im_lc_hist_normalized) max(im_lc_eq_hist_normalized) ] );

for ax = [ax1 ax2 ax3]
    ax.XLim = [0 255];
    ax.YLim = [0 global_max];
end

end