function [block_recon, block_dct_q] = ...
    intra_code_block(block, delta, M)

block_recon = block;
block_dct_q = zeros(M,M);

for subcol = 1:2
    for subrow = 1:2

        subrow_indices = block_indices(subrow, M/2);
        subcol_indices = block_indices(subcol, M/2);

        subblock = block(subrow_indices, subcol_indices);

        subblock_dct = dct2(subblock);

        subblock_dct_q = mid_tread_quant(subblock_dct, delta);
        block_dct_q(subrow_indices, subcol_indices) = ...
            subblock_dct_q;

        subblock_recon = idct2(subblock_dct_q);
        block_recon(subrow_indices, subcol_indices) = ...
            subblock_recon;

    end
end