function plotBranchingRatioFit(m, r, lm)
    %plot the linear regression used to compute the branching ratio : Inferring collective
    %dynamical states from widely, Jens Wilting1 & Viola Priesemann
    %unobserved systems
    % m : is the estimated branching ratio
    % r : list of laged branching ratio
    % lm : fit of r against a power function
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

