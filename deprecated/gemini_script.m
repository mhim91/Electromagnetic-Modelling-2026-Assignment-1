%This version turns out not to work
%presumably because the time-step-centering
%is inconsistent with snells law
%we have to use fixed z-steps

cdt = 1; % meters traveled before updating
N = 500000;
alfa0 = pi/4;
x0 = 0;
z0 = 0;
x = x0;
z = z0;
alfa = alfa0;
k = 1;

freq = 5e6;

x_list = zeros(N,1);
z_list = zeros(N,1);
alpha_list = zeros(N,1)

while k <= N
    % 1. Record current valid position
    x_list(k) = x;
    z_list(k) = z;
    alpha_list(k) = alpha;

    % 2. Compute current index of refraction
    current_n = index_of_refraction(parameters, z, freq);

    % 3. Propose next step
    dx = cdt * cos(alfa) / current_n;
    dz = cdt * sin(alfa) / current_n;
    z_trial = z + dz;

    % 4. Evaluate index of refraction at the trial position
    new_n = index_of_refraction(parameters, z_trial, freq);

    % 5. Check if the step is physically valid (real n, positive n, valid Snell's argument)
    snell_arg = current_n * cos(alfa) / new_n;
    is_valid_step = (imag(new_n) == 0) && (new_n > 0) && (abs(snell_arg) <= 1);

    if is_valid_step
        % Valid step: update position and refraction angle
        x = x + dx;
        z = z_trial;
        alfa = sign(alfa)*asin(snell_arg);
        k = k + 1;
    else
        % Reflection point reached: stay put, flip vertical angle to point downward,
        % and advance k so the next iteration propagates the ray back down.
        alfa = -alfa;
        k = k + 1;
    end

    if z < 0
        break;
    end
end

% Trim unused preallocated elements if the ray loop finishes early
valid_indices = find(x_list ~= 0 | z_list ~= 0);
x_list = x_list(valid_indices);
z_list = z_list(valid_indices);

disp('Simulation finished.');
f = figure(1);
plot(x_list, z_list, 'LineWidth', 1.5);
xlabel('Distance x (m)');
ylabel('Height z (m)');
title('Chapman Layer Ray Trace');
grid on;

hold on;
profile = index_of_refraction(parameters, z_list, freq);
plot(max(x_list)*profile, z_list)
hold off;