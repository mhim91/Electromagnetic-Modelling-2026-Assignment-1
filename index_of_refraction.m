function n = index_of_refraction(parameters, z, frequency)
    n = sqrt(1 - electron_plasma_frequency(parameters, z).^2 ./ frequency.^2);
    return;