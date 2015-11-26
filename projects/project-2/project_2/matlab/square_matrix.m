function A = square_matrix(M)

A = zeros(M);

for i = 1:M
    for j = 1:M
        A(i,j) = (i-1) + (j-1);
    end
end

end