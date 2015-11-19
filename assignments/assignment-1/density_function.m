function y = density_function(a)

if mod(a,2) == 0
    error('Argument cannot be 0 or a multiple of 2!')
end

b_abs = (1 - cos(a*pi)) / (a*pi);

f = @(x) (1 / abs(b_abs) * sin(a*pi*x));

t=0:0.01:1;
plot(t, f(t))

y = integral(f,0,1);