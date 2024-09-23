function alpha = MLEDiscretePowerLawDensityAprox(x, xmin)
    x = x(x>= xmin);
    n = length(x);
    alpha = 1 + n/sum(log(x/(xmin - 1/2)));
end

