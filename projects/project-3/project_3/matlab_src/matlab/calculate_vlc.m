function bits = calculate_vlc(coeff_bins, M, mode_bit)

sz = size(coeff_bins);

bits = zeros(M);

for row = 1:M
    for column = 1:M
        
        i_coeff = coeff_bins(:,:,:,row,column);
        
        [occ, ~] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = -sum(p .* log2(p));
        bits(row, column) = entropy;
        
    end
end

%{
if mode_bit
    % Add one bit per block per frame
    bits = bits + sz(3);
end
%}

%bits = bits * sz(1) * sz(2) * sz(3);

end