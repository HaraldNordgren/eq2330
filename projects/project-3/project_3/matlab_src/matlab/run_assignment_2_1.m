time_str = datestr(now, 'HH_MM_SS');

frames = 50;
framerate = 30;

exponents = 3:6;
%exponents = 0:12;
Qs = 2 .^ exponents;

bitrates_intra = zeros(size(exponents));
psnr_intra = zeros(size(exponents));

bitrates_rep = zeros(size(exponents));
psnr_rep = zeros(size(exponents));

for i = 1:length(exponents)
    [intra_data, rep_data] = ...
        assignment_2_1(Qs(i), framerate, frames, time_str);
    
    bitrates_intra(i) = intra_data.bitrate;
    psnr_intra(i) = intra_data.psnr;
    
    bitrates_rep(i) = rep_data.bitrate;
    psnr_rep(i) = rep_data.psnr;
end


% PLOT DATA

figure;
hold on;

plot(bitrates_intra, psnr_intra);
plot(bitrates_rep, psnr_rep);

xlabel('Bitrate (kbps)');
ylabel('PSNR');

set(gca, 'xdir','reverse');

mark_q_values(Qs, 'intra ', bitrates_intra, psnr_intra);
mark_q_values(Qs, 'rep ', bitrates_rep, psnr_rep);