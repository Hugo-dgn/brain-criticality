function plotDiscretePowerLawDensityFit(x, xmin, xmax, alpha, fitVariable)
    if nargin < 3
        fitVariable = 'alpha';
    end

    if strcmp(fitVariable, 'alpha')
        variableName = '\alpha';
    elseif strcmp(fitVariable, 'beta')
        variableName = '\beta';
    else
        error('fitVariable must be either "alpha" or "beta"');
    end
    
    X = x((x >= xmin) & (x <= xmax));
    [counts, bin_edges] = histcounts(X, 'Normalization', 'pdf');
    bin_centers = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;
    loglog(bin_centers, counts, 'bo', 'DisplayName', 'Empirical PDF');
    hold on;
    
    x_vals = linspace(xmin, xmax, 100);
    C = 1/sum((xmin:xmax).^(-alpha));
    power_law_pdf = C*x_vals.^(-alpha);
    loglog(x_vals, power_law_pdf, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Estimated Power Law PDF (%s = %.4f)', variableName, alpha));
    legend show;
end

