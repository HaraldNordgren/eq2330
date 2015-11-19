function assignment_3(image_path)


% ORIGINAL

im = double(imread(image_path));
%[rows, columns] = size(im);

subplot(2,2,1);
imshow(im, [0 255]);

subplot(2,2,3);
im_fft = fft2(im);
im_fft_abs_log = log(abs(fftshift(im_fft)) + 1);
imshow(mat2gray(im_fft_abs_log));


% GAUSS BLURRED

h = myblurgen('gaussian', 8);

im_conv = conv2(im, h, 'same');
subplot(2,2,2);
imshow(im_conv, [0 255]);

subplot(2,2,4);
im_conv_fft = fft2(im_conv);
im_conv_fft_abs_log = log(abs(fftshift(im_conv_fft)) + 1);
imshow(mat2gray(im_conv_fft_abs_log));

%figure
%imshow(mat2gray(im_conv_fft_abs_log));

%{
im_conv_q = uint8(min(max(round(im_conv), 0), 255));
subplot(1,3,3);
imshow(im_conv_q, [0 255]);
%}
