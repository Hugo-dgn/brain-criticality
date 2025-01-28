function [m, r, lm] = branchingRatio(profile, kmax)
    r = zeros(1, kmax);

    for i = 1:kmax
        past = profile(1:end-i);
        future = profile(i+1:end);
        p = polyfit(past, future, 1);
        r(i) = p(1);
    end
    x = 1:kmax;
    nonNegative = r > 0;
    x = x(nonNegative);
    y = r(nonNegative);
    lm = fitlm(x, y);
    m = exp(lm.Coefficients.Estimate(2));
end