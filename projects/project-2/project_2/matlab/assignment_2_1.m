function A = assignment_2_1()

M = 8;
A = zeros(M);

alpha = sqrt(2/M);
alpha = [alpha ones(1,M-1) * sqrt(2/M)];

for i = 1:M
    for k = 1:M
        A(i,k) = alpha(i) * cos ( (2*k+1)*i*pi / (2*M));
    end
end