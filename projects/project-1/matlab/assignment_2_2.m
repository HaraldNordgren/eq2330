function assignment_2_2(image_path)


% ORIGINAL

im = imread(image_path);
[rows, columns] = size(im);

hist_head_title = 'Histogram';


% GAUSS NOISE

gauss_noise = mynoisegen('gaussian', rows, columns, 0, 64);
im_gauss = uint8(min(max(round(double(im) + gauss_noise), 0), 255));

figure_with_size;
subplot(2,3,1);
imshow(im_gauss);
title('Gauss noise');

im_gauss_hist = hist(im_gauss(:), 0:255);
normalized_im_gauss_hist = im_gauss_hist ./ sum(im_gauss_hist);

subplot(2,3,4);
bar(normalized_im_gauss_hist);
title(hist_head_title);
ax11 = gca;

% GAUSS NOISE MEAN FILTERED

kernel = ones(3,3) / 9;
im_gauss_mean = uint8(round(conv2(double(im_gauss), kernel, 'same')));

subplot(2,3,2);
imshow(im_gauss_mean);
title({'Gauss noise', 'mean filtered'});

im_gauss_mean_hist = hist(im_gauss_mean(:), 0:255);
im_gauss_mean_hist_normalized = ...
    im_gauss_mean_hist ./ sum(im_gauss_mean_hist);

subplot(2,3,5);
bar(im_gauss_mean_hist_normalized);
title(hist_head_title);
ax12 = gca;

% GAUSS NOISE MEDIAN FILTERED

im_gauss_median = medfilt2(im_gauss);

subplot(2,3,3);
imshow(im_gauss_median);
title({'Gauss noise', 'median filtered'});

im_gauss_median_hist = hist(im_gauss_median(:), 0:255);
im_gauss_median_hist_normalized = ...
    im_gauss_median_hist ./ sum(im_gauss_median_hist);

subplot(2,3,6);
bar(im_gauss_median_hist_normalized);
title(hist_head_title);
ax13 = gca;


global_max_noised = 1.1 * max( [normalized_im_gauss_hist ...
    im_gauss_mean_hist_normalized im_gauss_median_hist_normalized ] );

ylabel(ax11, 'h(r)');
for ax = [ax11 ax12 ax13]
    ax.XLim = [-5 260];
    xlabel(ax, 'r');
    
    ax.YLim = [0 global_max_noised];
end

print('../report/images/2-2_gauss', '-deps');


% SALT-N-PEPA

im_saltp = im;
n = mynoisegen('saltpepper', rows, columns, .05, .05);

im_saltp(n==0) = 0;
im_saltp(n==1) = 255;

figure_with_size;
subplot(2,3,1);
imshow(im_saltp);
title('Salt & pepper noise');

im_saltp_hist = hist(im_saltp(:), 0:255);
normalized_im_saltp_hist = im_saltp_hist ./ sum(im_saltp_hist);

subplot(2,3,4);
bar(normalized_im_saltp_hist);
title(hist_head_title);
ax21 = gca;


% SALT & PEPPER NOISE MEAN FILTERED

im_saltp_mean = uint8(round(conv2(double(im_saltp), kernel, 'same')));

subplot(2,3,2);
imshow(im_saltp_mean);
title({'Salt & pepper noise', 'mean filtered'});

im_saltp_mean_hist = hist(im_saltp_mean(:), 0:255);
im_saltp_mean_hist_normalized = ...
    im_saltp_mean_hist ./ sum(im_saltp_mean_hist);

subplot(2,3,5);
bar(im_saltp_mean_hist_normalized);
title(hist_head_title);
ax22 = gca;


% SALT & PEPPER NOISE MEDIAN FILTERED

im_saltp_median = medfilt2(im_saltp);

subplot(2,3,3);
imshow(im_saltp_median);
title({'Salt & pepper noise', 'median filtered'});

im_saltp_median_hist = hist(im_saltp_median(:), 0:255);
im_saltp_median_hist_normalized = ...
    im_saltp_median_hist ./ sum(im_saltp_median_hist);

subplot(2,3,6);
bar(im_saltp_median_hist_normalized);
title(hist_head_title);
ax23 = gca;


global_max_filtered = 1.1 * max( [ im_saltp_mean_hist_normalized ...
    im_saltp_median_hist_normalized] );

ylabel(ax21, 'h(r)');
for ax = [ax21 ax22 ax23]
    ax.XLim = [-5 260];
    xlabel(ax, 'r');
    
    ax.YLim = [0 global_max_filtered];
end

print('../report/images/2-2_saltp', '-deps');