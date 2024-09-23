function p = kolmogorovSmirnovGoodnessFit (x, xmin, xmax, alpha)
    num_terms = 100;
    X = x((x>=xmin) & (x<=xmax));
    t = xmin:xmax;
    C = 1/sum(t.^(-alpha));
    cdf_theoretical = cumsum(C*t.^(-alpha));

    n = length(X);
    cdf_empirical = zeros(1, xmax-xmin+1);
    for i = xmin:xmax
        cdf_empirical(i-xmin+1) = sum((X <= i))/n;
    end
    d = max(abs(cdf_theoretical - cdf_empirical));
    p = 1 - 2 * sum(arrayfun(@(k) (-1)^(k-1) * exp(-2 * k^2 * d^2), 1:num_terms));
end