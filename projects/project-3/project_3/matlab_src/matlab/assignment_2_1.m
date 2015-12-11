function [intra_data, rep_data] = ...
    assignment_2_1(Q, framerate, frames, time_str)

M = 16;
qcif = [176 144];
size_blocks = qcif / M;

%Q = 16;
%framerate = 30;
%frames = 50;

%lambda = 0.02 * Q^2;
lambda = 0.001 * Q^2;

input_prefix = '../../foreman_qcif/'; input_title = 'foreman_qcif';
%input_prefix = '../../mother-daughter_qcif/'; input_title = 'mother-daughter_qcif';
input = [ input_prefix input_title '.yuv' ];

output_dir = [input_prefix time_str '/'];
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end


% INTRA CODING

video = yuv_import_y(input, qcif, frames);
video_recon_intra = video;

coeff_bins = zeros(size_blocks(1), size_blocks(2), frames, M, M);
intra_psnr_frames = zeros(1, frames);

for i = 1:frames
    
    frame = video{i};
    frame_recon = frame;
    
    for column = 1:size_blocks(1)
        for row = 1:size_blocks(2)
            
            row_indices = block_indices(row, M);
            column_indices = block_indices(column, M);

            block = frame(row_indices, column_indices);
            [intra_block, block_dct_q] = intra_code_block(block, Q, M);
            
            frame_recon(row_indices, column_indices) = intra_block;
            coeff_bins(column,row,i,:,:) = block_dct_q;
            
        end
    end
    
    mse = my_mse(frame_recon, video{i});
    intra_psnr_frames(i) = my_psnr(mse);
    
    video_recon_intra{i} = frame_recon;
    
end


% CALCULATE TEST DATA FOR INTRA CODING

intra_data = video_data;
intra_data.psnr = mean(intra_psnr_frames(:));

bits_per_coeff = calculate_vlc(coeff_bins, M, false);
bits_per_coeff_all_frames_and_blocks = ...
    size_blocks(1) * size_blocks(2) * frames * bits_per_coeff;

intra_data.bitrate = ...
    calculate_bitrate(bits_per_coeff_all_frames_and_blocks, ...
    framerate, frames);


% CONDITIONAL REPLENISHMENT CODING

% For the dimensions and for the first frame
video_recon_rep = video_recon_intra;

rep_psnr_frames = zeros(1, frames);
total_copy_bits = 0;

for i = 2:frames
    
    frame = video{i};
    last_frame = video_recon_rep{i-1};
    
    frame_recon = frame;
    
    for column = 1:size_blocks(1)
        for row = 1:size_blocks(2)
            
            row_indices = block_indices(row, M);
            column_indices = block_indices(column, M);

            block = frame(row_indices, column_indices);
            [intra_block, ~] = intra_code_block(block, Q, M);
            
            % INTRA MODE
            D_intra = my_mse(intra_block, block);
            R_intra = sum(bits_per_coeff(:)) + 1;
            J_intra = D_intra + lambda * R_intra;
            
            % COPY MODE
            copy_block = last_frame(row_indices, column_indices);
            D_copy = my_mse(copy_block, block);
            R_copy = 1;
            J_copy = D_copy + lambda * R_copy;
            
            if J_copy <= J_intra
                total_copy_bits = total_copy_bits + R_copy;
                frame_recon(row_indices, column_indices) = copy_block;
            else
                total_copy_bits = total_copy_bits + R_intra;
                frame_recon(row_indices, column_indices) = intra_block;
            end
            
        end
    end
    
    mse = my_mse(frame_recon, frame);
    rep_psnr_frames(i) = my_psnr(mse);
    
    video_recon_rep{i} = frame_recon;
    
end


% CALCULATE TEST DATA FOR CONDITIONAL REPLENISHMENT CODING

rep_data = video_data;

rep_data.psnr = mean(rep_psnr_frames(:));
rep_data.bitrate = calculate_bitrate(total_copy_bits, framerate, frames);


% CREATE AVI FILES

for i = 1:frames
    %video{i} = uint8(video{i});
    video_recon_intra{i} = uint8(video_recon_intra{i});
    video_recon_rep{i} = uint8(video_recon_rep{i});
end

output_suffix = '.avi';

intra_title = [output_dir input_title '_q' int2str(Q) ...
    '_intra' output_suffix];
create_video(video_recon_intra, intra_title, framerate);

rep_title = [output_dir input_title '_q' int2str(Q) ...
    '_rep' output_suffix];
create_video(video_recon_rep, rep_title, framerate);