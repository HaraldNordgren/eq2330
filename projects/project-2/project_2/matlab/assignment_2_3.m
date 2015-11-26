function [total_bits, psnr_im] = assignment_2_3(image_path, delta)

M = 8;
%delta = 0.1;
%x = square_matrix(8);

%image_paths = ['boats', 'habour', 'peppers'];
%path_prefix = '../images/'
%path_suffix = '512x512.tif'

im = double(imread(image_path));

if ~isequal(mod(size(im), M), [0 0])
    error('Image dimensions must be divisible by 8!')
end


% LOOP OVER IMAGES IN 8x8 BLOCKS

size_blocks = size(im) / M;
coeff_bins = zeros(size_blocks(1), size_blocks(2), M, M);

im_recon = zeros(size(im));

for row = 1:size_blocks(1)
    for column = 1:size_blocks(2)
        
        % EXTRACT 8x8 BLOCK FROM IMAGE
        
        %row_indices = (row-1)*M+1:row*M;
        %column_indices = (column-1)*M+1:column*M;
        row_indices = block_indices(row, M);
        column_indices = block_indices(column, M);
        
        x = im(row_indices, column_indices);
        
        %DCT TRANSFORM
        x_dct = dct2(x);

        % QUANTIZATION
        x_dct_q = mid_tread_quant(x_dct, delta);
        coeff_bins(row, column,:,:) = x_dct_q;

        % INVERSE DCT TRANSFORM
        x_recon = idct2(x_dct_q);

        im_recon(row_indices, column_indices) = x_recon;

        %{
        % MSE

        mse_coeffs = my_mse(x_dct, x_dct_q);
        mse_ratio = mse_coeffs / mse_x;
        %}

    end
end


% VLC

entropies = zeros(M);

for row = 1:M
    for column = 1:M
        i_coeff = coeff_bins(:,:,row,column);
        
        [occ, symbols] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = sum(p .* log(1 ./ p));
        entropies(row, column) = entropy;

        %dict = huffmandict(symbols,p);
        %hcode = huffmanenco(x_dct_q(:),dict);

        %dhsig = huffmandeco(hcode,dict);
        %reshape(dhsig, [M M])

        %length(dhsig);
        
    end
end

total_bits = sum(entropies(:));

mse_im = my_mse(im_recon, im);
psnr_im = my_psnr(mse_im);

%{
imagesc(im_recon);
axis off;
axis square;
colormap(gray);
%}

end

function indices = block_indices(start_index, M)
indices = (start_index-1)*M+1:start_index*M;
end