function [A, D] = fwt2(cA, cD, scale, psv)

if scale >= 2
    
    [cAA, cAD] = analysis_fb(cA, psv);
    [cDA, cDD] = analysis_fb(cD, psv);

    A = [cAA; cAD];
    D = [cDA; cDD];
    
else
    
    A = cA;
    D = cD;
    
end