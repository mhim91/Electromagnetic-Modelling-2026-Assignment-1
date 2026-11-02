%------------- STEP 1 (Set up parameters) ----------

[aa, ai, ar, I0, n0, T, f, alpha] = get_parameters(19910522)
g = 9.81;            %Surface gravity
kB = 1.38e-23;       %Boltzmann constant
q = 1.60e-19;        %Elementary charge
epsilon0 = 8.85e-12; %Vacuum Permittivity
me = 9.1e-31;        %Electron mass
mp = 1.67e-27;       %Proton mass
mO = 16*mp;          %Oxygen atomic mass
p = 1e5;             %Surface pressure
H = kB*T/(mO*g);     %Scale height in Barometric law

parameters = struct(); %Define a parameters struct for all parameters
parameters.aa = aa;
parameters.ai = ai;
parameters.ar = ar;
parameters.I0 = I0;
parameters.g = g;
parameters.n0 = n0;
parameters.T = T;
parameters.f = f;
parameters.alpha = alpha;
parameters.kB = kB;
parameters.q = q;
parameters.epsilon0 = epsilon0;
parameters.me = me;
parameters.mp = mp;
parameters.mO = mO;
parameters.p = p;
parameters.H = H;

%-------------------------------------------------------------------------
%------------- STEP 2 (Plot Chapman layer and Frequency curve ) ----------
%-------------------------------------------------------------------------

%Set plot range
z_range = H*linspace(0,20,1000);
f = figure(1)

%Generate Chapman curve
electron_density_profile = electron_density(parameters, z_range);
electron_density_maximum = max(electron_density_profile);
electron_density_profile_label = "Electron density / " + sprintf('%.2e',electron_density_maximum) + "/m^-3"

plot(electron_density_profile / electron_density_maximum, ...
    z_range / parameters.H,  ...
    DisplayName = electron_density_profile_label);


%Check code

theoretical_z_div_H_at_nmax = log(parameters.aa * parameters.n0 * parameters.H);
theoretical_electron_density_maximum = sqrt(parameters.ai*parameters.I0 / (exp(1)*parameters.ar*parameters.aa*parameters.H));

disp("Layer peak at " + theoretical_z_div_H_at_nmax*H/1000 + " km with value " + electron_density_maximum)

%Generate plasma frequency graph

electron_plasma_frequency_profile = electron_plasma_frequency(parameters, z_range);
[maxval, index_of_max] = max(electron_plasma_frequency_profile);
altitude_of_plasma_max_frequency = z_range(index_of_max);
electron_plasma_frequency_max = maxval;

hold on;
plot(electron_plasma_frequency_profile / electron_plasma_frequency_max, ...
    z_range / parameters.H, ...
    DisplayName = "Plasma Frequency / " + round(electron_plasma_frequency_max / 10^6, 2) + " MHz");

title("Chapman layer")
ylabel('Altitude in H-units')
xlabel("Magnitude relative to maximum")
legend show;

hold off

ax = gca;
ax.FontName = 'Computer Modern'; % or 'CMU Serif' depending on your system
ax.FontSize = 10;
grid on;


%------------- STEP 3 (Simplified model on paper) ----------

%------------- STEP 4 (Simplified model on paper) ----------
