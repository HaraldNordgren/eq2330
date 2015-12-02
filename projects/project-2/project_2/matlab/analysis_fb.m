function [cA, cD] = analysis_fb(X, psv)

[Lo_D, Hi_D, ~, ~] = orthfilt(psv);

% Direct implementation
[cA, cD] = dwt(X, Lo_D, Hi_D, 'mode', 'per');