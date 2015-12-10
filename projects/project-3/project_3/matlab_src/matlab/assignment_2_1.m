function [bitrate_kbps, psnr] = assignment_2_1(delta, framerate)

M = 16;
qcif = [176 144];

%delta = 8;
%framerate = 30;

frames = 50;

input_prefix = '../../foreman_qcif/'; input_title = 'foreman_qcif';
%input_prefix = '../../mother-daughter_qcif/'; input_title = 'mother-daughter_qcif';

input_suffix = '.yuv';
input = [ input_prefix input_title input_suffix ];

video = yuv_import_y(input, qcif, frames);
video_recon = video;

size_blocks = qcif / M;

coeff_bins = zeros(size_blocks(1), size_blocks(2), frames, M, M);
psnr_frames = zeros(1, frames);

for i = 1:frames
    
    frame = video{i};
    frame_recon = frame;
    
    for column = 1:size_blocks(1)
        for row = 1:size_blocks(2)
            
            row_indices = block_indices(row, M);
            column_indices = block_indices(column, M);

            block = frame(row_indices, column_indices);
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
            
            frame_recon(row_indices, column_indices) = block_recon;
            coeff_bins(column,row,i,:,:) = block_dct_q;
            
        end
    end
    
    mse = my_mse(frame_recon, video{i});
    psnr_frames(i) = my_psnr(mse);
    
    video{i} = uint8(video{i});
    video_recon{i} = uint8(frame_recon);
    
end


% CREATE AVI FILES

output_suffix = '.avi';

output_title = [input_prefix input_title '_q' int2str(delta) ...
    '_recon' output_suffix];

%create_video(video, [input_prefix input_title output_suffix], framerate);
create_video(video_recon, output_title, framerate);



% CALCULATE TEST DATA

entropies = calculate_vlc(coeff_bins, M);
bits = sum(entropies(:));

bitrate = bits * framerate / frames;
bitrate_kbps = bitrate / 1000;

psnr = mean(psnr_frames(:));

end