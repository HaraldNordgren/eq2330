function assignment_3(image_path)


% ORIGINAL

im = double(imread(image_path));
%[rows, columns] = size(im);

subplot(2,3,1);
imshow(im, [0 255]);

subplot(2,3,4);
im_fft = fft2(im);
im_fft_abs_log = log(abs(fftshift(im_fft)) + 1);
imshow(mat2gray(im_fft_abs_log));


% GAUSS BLURRED

h = myblurgen('gaussian', 8);

im_conv = conv2(im, h, 'same');
subplot(2,3,2);
imshow(im_conv, [0 255]);

subplot(2,3,5);
im_conv_fft = fft2(im_conv);
im_conv_fft_abs_log = log(abs(fftshift(im_conv_fft)) + 1);
imshow(mat2gray(im_conv_fft_abs_log));


% QUANTIZATION ERROR OF BLURRED IMAGES

im_conv_q = min(max(round(im_conv), 0), 255);

diff_q = im_conv - im_conv_q;
var_q = var(diff_q(:));


% REMOVING NOISE AND DEBLURRING

im_noise_removed = im_conv_q - (0);

im_noise_removed_fft = fft2(im_noise_removed);

h_fft = fft2(h);

% h is singular! Weiner component in denom is probably needed.
%h_fft_inv = inv(h_fft);

%{
top_padding = ceil((size(im_conv_fft) - size(h_fft_inv)) / 2);
h_fft_inv_padded = padarray(h_fft_inv, top_padding, 0, 'pre');

bottom_padding = floor((size(im_conv_fft) - size(h_fft_inv)) / 2);
h_fft_inv_padded = padarray(h_fft_inv_padded, bottom_padding, 0, 'post');
%}

deblurred_fft = im_noise_removed_fft; %* h_fft_inv_padded
im_deblurred = ifft2(deblurred_fft);

subplot(2,3,3);
imshow(im_deblurred, [0 255]);

subplot(2,3,6);
deblurred_fft_abs_log = log(abs(fftshift(deblurred_fft)) + 1);
imshow(mat2gray(deblurred_fft_abs_log));