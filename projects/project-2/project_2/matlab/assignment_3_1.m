function y = assignment_3_1(X, psv)

[Lo_D, Hi_D, Lo_R, Hi_R] = orthfilt(psv);

[cA, cD] = dwt(X, Lo_D, Hi_D);

%{
interval = 0:10;
lambda_1 = -1/2 * (unit_impulse(interval) + ...
    unit_impulse(circshift(interval, [0,1])));
lambda_2 = 1/4 * (unit_impulse(interval) + ...
    unit_impulse(circshift(interval, [0,-1])));
x = 1:10;
%}

h0 = [-1/2 -1/2]; h0_maxdeg = 1;
h1 = [1/4 1/4]; h1_maxdeg = 0;

K0 = sqrt(2);
K1 = 1 / sqrt(2);

LS = {
    'd', h0, h0_maxdeg;
    'p', h1, h1_maxdeg;
    K0, K1, [] };

[y0, y1] = lwt(X,LS);

y = ilwt(y0, y1, LS);