function x_dct = assignment_2_1(x, delta)

M = 8;
%delta = 0.1;

if ~isequal(size(x), [M M])
    error('Matrix size must be 8x8!')
end

subplot(1,3,1);
plot_block_matrix(x);


% CALCULATE DCT

A = zeros(M);

alpha = sqrt(2/M);
alpha = [alpha ones(1,M-1) * sqrt(2/M)];

for i = 1:M
    for k = 1:M
        A(i,k) = alpha(i) * cos( (2*k+1)*i*pi / (2*M) );
    end
end

x_dct = A * x * A';

subplot(1,3,2);
plot_block_matrix(x_dct);


% QUANTIZATION

x_dct_q = mid_tread_quant(x_dct, delta);

subplot(1,3,3);
plot_block_matrix(x_dct_q);

end