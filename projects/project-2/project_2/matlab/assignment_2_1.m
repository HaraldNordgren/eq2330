function A = assignment_2_1(delta)

M = 8; m = 10;
%delta = 0.1;

%x = square_matrix(M);

im = double(imread('../images/boats512x512.tif'));
x = im(1+m:M+m, 1+m:M+m);

subplot(1,4,1);
plot_block_matrix(x);


% CALCULATE DCT TRANSFORM MATRIX

A = zeros(M);

alpha = sqrt(2/M) * ones(1,M);
alpha(1) = sqrt(1/M);

for i = 0:M-1
    for k = 0:M-1
        A(i+1,k+1) = alpha(i+1) * cos( (2*k + 1)*i*pi / (2*M) );
    end
end

x_dct = A * x * A';
%x_dct = dct2(x);

subplot(1,4,2);
plot_block_matrix(x_dct);


% QUANTIZATION

x_dct_q = mid_tread_quant(x_dct, delta);

subplot(1,4,3);
plot_block_matrix(x_dct_q);


% INVERSE DCT

x_recon = A' * x_dct_q * A;
%x_recon = idct2(x_dct_q);

subplot(1,4,4);
plot_block_matrix(x_recon);

end