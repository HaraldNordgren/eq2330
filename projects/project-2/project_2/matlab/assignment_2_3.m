function [total_bits, psnr_im] = assignment_2_3(delta)

%figure;

M = 8;
%delta = 0.1;
%x = square_matrix(8);

image_paths = {'boats', 'harbour', 'peppers'};
path_prefix = '../images/';
path_suffix = '512x512.tif';

size_im = [512 512];
size_blocks = size_im / M;

coeff_bins = ...
    zeros(size_blocks(1), size_blocks(2), length(image_paths), M, M);
mse_im = zeros(1,length(image_paths));

for i = 1:length(image_paths)
    image_shortpath = image_paths(i);
    image_path = [path_prefix image_shortpath{1} path_suffix];
    im = double(imread(image_path));


    % LOOP OVER IMAGE IN 8x8 BLOCKS

    im_recon = zeros(size(im));

    for row = 1:size_blocks(1)
        for column = 1:size_blocks(2)

            % EXTRACT 8x8 BLOCK FROM IMAGE

            row_indices = block_indices(row, M);
            column_indices = block_indices(column, M);

            x = im(row_indices, column_indices);

            %DCT TRANSFORM
            x_dct = dct2(x);

            % QUANTIZATION
            x_dct_q = mid_tread_quant(x_dct, delta);
            coeff_bins(row,column,i,:,:) = x_dct_q;

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
    
    mse_im(i) = my_mse(im_recon, im);
    
    %{
    subplot(1, length(image_paths), i);
    imagesc(im_recon);
    axis off;
    axis square;
    colormap(gray);
    %}
end

d = mean(mse_im);
psnr_im = my_psnr(d);


% VLC

entropies = zeros(M);

for row = 1:M
    for column = 1:M
        i_coeff = coeff_bins(:,:,:,row,column);
        
        [occ, symbols] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = -sum(p .* log2(p));
        entropies(row, column) = entropy;

        %dict = huffmandict(symbols,p);
        %hcode = huffmanenco(x_dct_q(:),dict);

        %dhsig = huffmandeco(hcode,dict);
        %reshape(dhsig, [M M])

        %length(dhsig);
        
    end
end

total_bits = sum(entropies(:));

end

function indices = block_indices(start_index, M)
indices = (start_index-1)*M+1:start_index*M;
end