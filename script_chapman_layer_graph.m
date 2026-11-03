

%Set plot range
z_range = H*linspace(0,20,1000);


%Generate Chapman Electron Density Profile data
electron_density_profile = electron_density(parameters, z_range);
[max_val, index_of_max] = max(electron_density_profile);
electron_density_maximum = max_val;
altitude_of_density_max = z_range(index_of_max);

%Generate Plasma Frequency Density Profile data

electron_plasma_frequency_profile = electron_plasma_frequency(parameters, z_range);
[maxval, index_of_max] = max(electron_plasma_frequency_profile);
altitude_of_plasma_max_frequency = z_range(index_of_max);
electron_plasma_frequency_max = maxval;

%Generate double-y-axis-layer

dual_fig = figure(2);
yyaxis left
plot(z_range/1000,electron_density_profile, ...
    DisplayName = "Electron density", ...
    Color='black', LineStyle ='-');
ylabel("Electron density (m^{-3})")

ax = gca;
ax.YColor = 'black';

yyaxis right
plot(z_range/1000, electron_plasma_frequency_profile/1e6, ...
    DisplayName = "Plasma frequency", ...
    Color='black', LineStyle =':');
ylabel("Electron plasma frequency (MHz)")
xlabel("Altitude / km")
legend show

ax = gca;
ax.YColor = 'black';

title("Chapman layer")
legend show;
