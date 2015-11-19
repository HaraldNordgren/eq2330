function assignment_2_2(image_path)


% ORIGINAL

im = imread(image_path);
[rows, columns] = size(im);

subplot(2,3,1);
imshow(im);
title('No added noise');

im_hist = hist(im(:), 0:255);
normalized_im_hist = im_hist ./ sum(im_hist);

subplot(2,3,4);
bar(normalized_im_hist);
ax11 = gca;

hist_head_title = 'Histogram';
title(hist_head_title);


% GAUSSIAN

gauss_noise = mynoisegen('gaussian', rows, columns, 0, 64);
im_gauss = uint8(min(max(round(double(im) + gauss_noise), 0), 255));

subplot(2,3,2);
imshow(im_gauss);
title('Gauss noise');

im_gauss_hist = hist(im_gauss(:), 0:255);
normalized_im_gauss_hist = im_gauss_hist ./ sum(im_gauss_hist);

subplot(2,3,5);
bar(normalized_im_gauss_hist);
title(hist_head_title);
ax12 = gca;


% SALT-N-PEPA

im_saltp = im;
n = mynoisegen('saltpepper', rows, columns, .05, .05);

im_saltp(n==0) = 0;
im_saltp(n==1) = 255;

subplot(2,3,3);
imshow(im_saltp);
title('Salt & pepper noise');

im_saltp_hist = hist(im_saltp(:), 0:255);
normalized_im_saltp_hist = im_saltp_hist ./ sum(im_saltp_hist);

subplot(2,3,6);
bar(normalized_im_saltp_hist);
title(hist_head_title);
ax13 = gca;

global_max_noised = 1.1 * max( [max(normalized_im_hist) ...
    max(normalized_im_gauss_hist) max(normalized_im_saltp_hist) ] );

for ax = [ax11 ax12 ax13]
    ax.XLim = [-5 260];
    ax.YLim = [0 global_max_noised];
end


% FILTERS

kernel = ones(3,3) / 9;
figure;


% GAUSS NOISE MEAN FILTERED

im_gauss_mean = uint8(round(conv2(double(im_gauss), kernel, 'same')));

subplot(2,4,1);
imshow(im_gauss_mean);
title({'Gauss noise', 'mean filtered'});

im_gauss_mean_hist = hist(im_gauss_mean(:), 0:255);
im_gauss_mean_hist_normalized = ...
    im_gauss_mean_hist ./ sum(im_gauss_mean_hist);

subplot(2,4,5);
bar(im_gauss_mean_hist_normalized);
title(hist_head_title);
ax21 = gca;

% GAUSS NOISE MEDIAN FILTERED

im_gauss_median = medfilt2(im_gauss);

subplot(2,4,2);
imshow(im_gauss_median);
title({'Gauss noise', 'median filtered'});

im_gauss_median_hist = hist(im_gauss_median(:), 0:255);
im_gauss_median_hist_normalized = ...
    im_gauss_median_hist ./ sum(im_gauss_median_hist);

subplot(2,4,6);
bar(im_gauss_median_hist_normalized);
title(hist_head_title);
ax22 = gca;


% SALT & PEPPER NOISE MEAN FILTERED

im_saltp_mean = uint8(round(conv2(double(im_saltp), kernel, 'same')));

subplot(2,4,3);
imshow(im_saltp_mean);
title({'Salt & pepper noise', 'mean filtered'});

im_saltp_mean_hist = hist(im_saltp_mean(:), 0:255);
im_saltp_mean_hist_normalized = ...
    im_saltp_mean_hist ./ sum(im_saltp_mean_hist);

subplot(2,4,7);
bar(im_saltp_mean_hist_normalized);
title(hist_head_title);
ax23 = gca;


% SALT & PEPPER NOISE MEDIAN FILTERED

im_saltp_median = medfilt2(im_saltp);

subplot(2,4,4);
imshow(im_saltp_median);
title({'Salt & pepper noise', 'median filtered'});

im_saltp_median_hist = hist(im_saltp_median(:), 0:255);
im_saltp_median_hist_normalized = ...
    im_saltp_median_hist ./ sum(im_saltp_median_hist);

subplot(2,4,8);
bar(im_saltp_median_hist_normalized);
title(hist_head_title);
ax24 = gca;


global_max_filtered = 1.1 * max( [max(im_gauss_mean_hist_normalized) ...
    max(im_gauss_median_hist_normalized) ...
    max(im_saltp_mean_hist_normalized) ...
    im_saltp_median_hist_normalized] );

for ax = [ax21 ax22 ax23 ax24]
    ax.XLim = [-5 260];
    ax.YLim = [0 global_max_filtered];
end

% The mean filter replaces each value with the mean of the surrounding
% values. The median replaces it with the median (that is, sorting the
% values by size and choosing the middle one). The mean filter is quicker
% to calculate -- no sorting is needed -- but the median filter is likely
% to give slightly better results when dealing with outlier noise, which is
% why it gives such a good performance for the salt and pepper noise.