function assignment_3(image_path)


% ORIGINAL

im = double(imread(image_path));

figure_with_size;
subplot(2,3,1);
imshow(im, [0 255]);
title('Original');

subplot(2,3,4);
im_fft = fft2(im);
im_fft_abs_log = log(abs(fftshift(im_fft)) + 1);
imshow(mat2gray(im_fft_abs_log));

hist_fft_title = 'Fourier spectrum';
title(hist_fft_title);


% GAUSS BLURRED AND 8-BIT QUANTIZED

h = myblurgen('gaussian', 8);

im_conv = conv2(im, h, 'same');
im_conv_q = min(max(round(im_conv), 0), 255);

subplot(2,3,2);
imshow(im_conv_q, [0 255]);
title('Gauss blur');

subplot(2,3,5);
im_conv_q_fft = fft2(im_conv_q);
im_conv_q_fft_abs_log = log(abs(fftshift(im_conv_q_fft)) + 1);
imshow(mat2gray(im_conv_q_fft_abs_log));
title(hist_fft_title);


% DEBLURRED IMAGE

diff_q = im_conv - im_conv_q;
var_q = var(diff_q(:));

im_deblurred = deblur(im_conv_q, h, var_q);

subplot(2,3,3);
imshow(im_deblurred, [0 255]);
title('Wiener filtered');

subplot(2,3,6);
im_deblurred_fft = fft2(im_deblurred);
deblurred_fft_abs_log = log(abs(fftshift(im_deblurred_fft)) + 1);
imshow(mat2gray(deblurred_fft_abs_log));
title(hist_fft_title);

print('../report/images/3', '-deps');