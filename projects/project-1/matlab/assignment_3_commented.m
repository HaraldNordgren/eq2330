% F^ estimate

%{
p = [0 -1 0; -1 4 -1; 0 -1 0];

top_padding_h = ceil((size(im) - size(h)) / 2);
bottom_padding_h = floor((size(im) - size(h)) / 2);

h_padded = padarray(h, top_padding_h, 0, 'pre');
h_padded = padarray(h_padded, bottom_padding_h, 0, 'pre');

top_padding_p = ceil((size(im) - size(p)) / 2);
bottom_padding_p = floor((size(im) - size(p)) / 2);

p_padded = padarray(p, top_padding_p, 0, 'pre');
p_padded = padarray(p_padded, bottom_padding_p, 0, 'pre');
%}

%{
deblurring_function_padded = ...
    padarray(deblurring_function, top_padding, 0, 'pre');
deblurring_function_padded = ...
    padarray(deblurring_function_padded, bottom_padding, 0, 'post');
%}

%p_padded = padarray(p, (size(h_fft) - size(p)) / 2);

%{
h_fft = fft2(h_padded);
p_fft = fft2(p_padded);

gamma = 10;

deblurring_function = conj(h_fft) / (norm(h_fft)^2 + gamma*norm(p_fft)^2);


%im_noise_removed = im_conv_q - (0);
%im_noise_removed_fft = fft2(im_noise_removed);


deblurred_fft = deblurring_function * im_conv_q;
%deblurred_fft = im_noise_removed_fft; %* h_fft_inv_padded
return

im_deblurred = ifft2(deblurred_fft);
%}