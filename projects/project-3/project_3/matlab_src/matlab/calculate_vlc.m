function entropies = calculate_vlc(coeff_bins, M)

entropies = zeros(M);

for row = 1:M
    for column = 1:M
        
        i_coeff = coeff_bins(:,:,:,row,column);
        
        [occ, ~] = hist(i_coeff(:), unique(i_coeff(:)));
        p = occ ./ sum(occ);
        
        entropy = -sum(p .* log2(p));
        entropies(row, column) = entropy;
        
    end
end

end