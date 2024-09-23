function L = DiscreteBoundedPowerLawLikelihood(x, xmin, xmax, alpha)
    X = x((x >= xmin) & (x <= xmax));
    n = length(X);
    L1 = - alpha .* sum(log(X));
    omega = repmat(transpose(xmin:xmax), length(alpha));
    L2 = -n*log(sum(omega .^ (-alpha), 1));
    L =  L2 + L1;
end

