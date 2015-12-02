exponents = 0:9;

bitrates = exponents;
psnrs = exponents;

for i = exponents
    [bits, psnr_im] = ...
        assignment_2_3(2^i);
    
    bitrates(i+1) = bits;
    psnrs(i+1) = psnr_im;
end

figure;
plot(bitrates, psnrs);
xlabel('Bitrate');
ylabel('PSNR');
set(gca, 'xdir','reverse')