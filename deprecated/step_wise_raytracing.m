clc
alpha0 = pi/3;
x0 = 0;
z0 = 0;
sinalpha0 = sin(alpha0)
freq = 10e6
    
f = @(x) index_of_refraction(parameters,x, freq)^2 - sinalpha0^2;
z_max = fzero(f, 0)
    
N = 10000
z = linspace(0,z_max,N);
sinalfa = [sinalpha0, zeros(0,N-1)];
x = [x0, zeros(0,N-1)];
    
for k = 2:N
    sinalfa(k) = sinalpha0 / index_of_refraction(parameters, (z(k) + z(k-1))/2, freq);
    x(k) = x(k-1) + (z(k) - z(k-1)) * sinalfa(k-1) / sqrt(1 - sinalfa(k)^2);
end
    
figure(8)
    
plot(x,z,   Color = 'black')
axis equal