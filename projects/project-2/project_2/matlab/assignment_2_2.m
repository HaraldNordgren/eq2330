function A_q = assignment_2_2(A)

[rows, columns] = size(A);
A_q = A;

for i = 1:rows
    for j = 1:columns
        A_q(i,j) = mid_tread_quant(A(i,j));
    end
end

end

function k = mid_tread_quant(x)

delta = 1/256;
k = sign(x) * floor( abs(x)/delta + 1/2 );

end