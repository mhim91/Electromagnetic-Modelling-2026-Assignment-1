

alfa0 = pi/4;

x0 = 0;
z0 = 0;
sinalfa0 = sin(alfa0);
dz = 100;
freq = 10e6;

x = x0;
z = z0;
sinalfa = sinalfa0;

N = 100000;
x_list = zeros(N,1);
z_list = zeros(N,1);
sinalfa_list = zeros(N,1);

k = 1;
x_list(k) = x;
z_list(k) = z;
sinalfa_list(k) = sinalfa0;
while sinalfa <0.9999 && k < N
    z_new = z + dz;
    x_new = x + dz * tan(asin(sinalfa))
    sinalfa_new =  sinalfa0 / index_of_refraction(parameters, z_new, freq);


    x = x_new;
    z = z_new;
    sinalfa = sinalfa_new;

    k = k + 1
    x_list(k) = x_new;
    z_list(k) = z_new;
    sinalfa_list(k) = sinalfa_new;
end

x_list = x_list(1:k);
x_offset = x_list(end);
x_list = [x_list, -x_list+x_offset];

z_list = z_list(1:k);
z_list = [z_list, z_list];

sinalfa_list = sinalfa_list(1:k);

plot(x_list, z_list)

hold on;
profile = index_of_refraction(parameters, z_list, freq);
plot(max(x_list)*profile, z_list)
hold off;
axis equal





