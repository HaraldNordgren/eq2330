function X = synthesis_fb(cA, cD, psv)

[~, ~, Lo_R, Hi_R] = orthfilt(psv);

X = idwt(cA, cD, Lo_R, Hi_R, 'mode', 'per');