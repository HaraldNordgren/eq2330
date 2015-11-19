function assignment_2_2(image_path)


% ORIGINAL

im = imread(image_path);
[rows, columns] = size(im);

im_hist = hist(im(:), 0:255);
normalized_im_hist = im_hist ./ sum(im_hist);

subplot(2,3,1);
bar(normalized_im_hist);
ax1 = gca;

head_title = 'Normalized histogram';
title({head_title, '(No added noise)'});

subplot(2,3,4);
imshow(im);


% GAUSSIAN

gauss_noise = mynoisegen('gaussian', rows, columns, 0, 64);
im_gauss = uint8(min(max(round(double(im) + gauss_noise), 0), 255));

im_gauss_hist = hist(im_gauss(:), 0:255);
normalized_im_gauss_hist = im_gauss_hist ./ sum(im_gauss_hist);

subplot(2,3,2);
bar(normalized_im_gauss_hist);
ax2 = gca;

title({head_title, '(Gauss noise)'});

subplot(2,3,5);
imshow(im_gauss);

% SALT-N-PEPA

im_saltp = im;
n = mynoisegen('saltpepper', rows, columns, .05, .05);

im_saltp(n==0) = 0;
im_saltp(n==1) = 255;

im_saltp_hist = hist(im_saltp(:), 0:255);
normalized_im_saltp_hist = im_saltp_hist ./ sum(im_saltp_hist);

subplot(2,3,3);
bar(normalized_im_saltp_hist);
ax3 = gca;

title({head_title, '(Salt & pepper noise)'});

subplot(2,3,6);
imshow(im_saltp);

%max(normalized_im_hist)
%max(normalized_im_gauss_hist)
%max(normalized_im_saltp_hist)

global_max = 1.1 * max( [max(normalized_im_hist) ...
    max(normalized_im_gauss_hist) max(normalized_im_saltp_hist) ] );

for ax = [ax1 ax2 ax3]
    ax.XLim = [-5 260];
    ax.YLim = [0 global_max];
end