function [ar, dr] = conv_test(X, psv)

[Lo_D, Hi_D, ~, ~] = orthfilt(psv);

lx = length(X);
lf = length(Lo_D);

ex = wextend(1, 'ppd', X, lf);

la = floor((lx+lf-1)/2);

ar = wkeep(dyaddown(conv(ex,Lo_D)),la);
dr = wkeep(dyaddown(conv(ex,Hi_D)),la);