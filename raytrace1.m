cdt = 10; %meters traveled before updating

N = 50000;

alfa0 = pi/4;
x0 = 0;
z0 = 0;
x = x0;
z = z0;
alfa = alfa0;
k = 1;

x_list = zeros(N,1);
z_list = zeros(N,1);

while k <= N
    current_index_of_refraction = index_of_refraction(parameters, z, 10e6);
    x = x + cdt * cos(alfa)/ current_index_of_refraction;
    z = z + cdt * sin(alfa) / current_index_of_refraction;

    new_index_of_refraction =  index_of_refraction(parameters, z, 10e6);
    disp(k + " "+  new_index_of_refraction)

    %If we new index of refraction is positive then we continue but if
    %not we backtrack and force reflection

    if imag(new_index_of_refraction) == 0 && abs(current_index_of_refraction*cos(alfa)/new_index_of_refraction) < 1
        alfa = asin(current_index_of_refraction * cos(alfa) / new_index_of_refraction);
        k = k + 1;
        x_list(k) = x;
        z_list(k) = z;
    else
        %stay in same place and reflect if complex
        x = x_list(k)
        z = z_list(k)
        alfa = -alfa
    end

    
end

disp(x_list)

f = figure(1);

plot(x_list,z_list);
