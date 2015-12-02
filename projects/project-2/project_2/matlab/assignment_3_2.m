function [A, D] = assignment_3_2(x, scale)

load coeffs

[cA, cD] = analysis_fb(x, db8);

[A, D] = fwt(cA, cD, scale-1, db8);