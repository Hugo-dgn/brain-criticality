function plotBranchingRatioFit(m, r, lm)
    b = exp(lm.Coefficients.Estimate(1));
    kmax = length(r);
    x = 1:kmax;
    y = b*m.^x;
    semilogy(x, r, 'bo', 'HandleVisibility', 'off');
    hold on;
    semilogy(x, y, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Estimated branching ratio : r = %.5f', m));
    xlabel('lags')
    ylabel('branching ratio')
    legend show;
end

