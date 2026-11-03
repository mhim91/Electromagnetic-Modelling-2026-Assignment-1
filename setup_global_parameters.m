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


set(groot, 'DefaultFigureUnits', 'centimeters');
set(groot, 'DefaultFigurePosition', [10, 10, 8,10]); % [left, bottom, width, height]
set(groot, 'DefaultAxesFontName', 'Computer Modern'); %default LaTeX font
set(groot, 'DefaultAxesFontSize', 10); %default LaTeX fontsize
set(groot, 'DefaultLineLineWidth', 1.5);
set(groot, 'DefaultAxesXGrid', 'on');
set(groot, 'DefaultAxesYGrid', 'on');
set(groot, 'DefaultAxesZGrid', 'on');