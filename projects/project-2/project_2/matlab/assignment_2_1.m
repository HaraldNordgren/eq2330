function x_dct_q = assignment_2_1(x, delta)

M = 8;
%delta = 0.1;

if ~isequal(size(x), [M M])
    error('Matrix size must be 8x8!')
end

subplot(1,4,1);
plot_block_matrix(x);


% CALCULATE DCT

A = zeros(M);

alpha = sqrt(1/M);
alpha = [alpha ones(1,M-1) * sqrt(2/M)];

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


% MSE

mse_x = my_mse(x_recon, x);
mse_coeffs = my_mse(x_dct, x_dct_q);
mse_ratio = mse_coeffs / mse_x;

psnr = my_psnr(mse_x);


% VLC


[occ, symbols] = hist(x_dct_q(:), unique(x_dct_q(:)));
p = occ ./ sum(occ);

dict = huffmandict(symbols,p);
hcode = huffmanenco(x_dct_q(:),dict);

dhsig = huffmandeco(hcode,dict);
%reshape(dhsig, [M M])

length(dhsig)

end