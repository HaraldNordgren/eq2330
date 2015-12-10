exponents = 3:6;
%exponents = 0:12;
deltas = 2 .^ exponents;

bitrates = zeros(size(exponents));
psnrs = zeros(size(exponents));

for i = 1:length(exponents)
    [bitrate_kbps, psnr] = assignment_2_1(deltas(i), 30);
    
    bitrates(i) = bitrate_kbps;
    psnrs(i) = psnr;
end


% PLOT DATA

figure;
plot(bitrates, psnrs);

xlabel('Bitrate (kbps)');
ylabel('PSNR');

set(gca, 'xdir','reverse')