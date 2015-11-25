function assignment_2_1(image_path)


% ORIGINAL IMAGE

im = imread(image_path);
[rows, columns] = size(im);

figure_with_size;
subplot(2,3,1);
imshow(im);

image_title = 'Original';
title(image_title);

im_hist = hist(im(:), 0:255);
normalized_im_hist = im_hist ./ sum(im_hist);

subplot(2,3,4);
bar(normalized_im_hist);
ax1 = gca;

head_title = 'Histogram';
title(head_title);


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

subplot(2,3,2);
imshow(im_lc);
title('Low contrast');

im_lc_hist = hist(im_lc(:), 0:255);
im_lc_hist_normalized = im_lc_hist ./ sum(im_lc_hist);

subplot(2,3,5);
bar(im_lc_hist_normalized);
title(head_title);
ax2 = gca;


% HISTOGRAM EQUALIZATION

im_lc_hist_normalized_sum = 255 * cumsum(im_lc_hist_normalized);

im_lc_eq = im_lc;
for i = 1:rows
    for j = 1:columns
        im_lc_eq(i,j) = round(im_lc_hist_normalized_sum(im_lc(i,j)));
        %im_lc_eq(i,j) = im_lc_hist_normalized_sum_rounded(im_lc(i,j));
    end
end

subplot(2,3,3);
imshow(im_lc_eq);
title('Equalized');

im_lc_eq_hist = hist(im_lc_eq(:), 0:255);
im_lc_eq_hist_normalized = im_lc_eq_hist ./ sum(im_lc_eq_hist);

subplot(2,3,6);
bar(im_lc_eq_hist_normalized);
title(head_title);
ax3 = gca;


global_max = 1.1 * max( [max(normalized_im_hist) ...
    max(im_lc_hist_normalized) max(im_lc_eq_hist_normalized) ] );

ylabel(ax1, 'h(r)');
for ax = [ax1 ax2 ax3]
    ax.XLim = [-5 260];
    xlabel(ax, 'r');
    
    ax.YLim = [0 global_max];
end

print('../report/images/2-1', '-deps');

end