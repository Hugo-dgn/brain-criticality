function alpha = MLEDiscretePowerLawDensityAprox(x, xmin)
    %Computational efficient way to compute the MLE of the power law exponent, it does not work with xmax
    %This function is not used. See Aaron Clauset, Cosma Rohilla Shalizi and M. E. J. Newman, Power-Law Distributions in
    %Empirical Data*
    x = x(x>= xmin);
    n = length(x);
    alpha = 1 + n/sum(log(x/(xmin - 1/2)));
end

