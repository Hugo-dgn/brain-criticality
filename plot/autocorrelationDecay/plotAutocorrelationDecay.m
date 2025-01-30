 function plotAutocorrelationDecay(autocorr, mean_autocorr, lm, T_ref)
    n = length(autocorr);
    
    
    for i =1:n
        y = autocorr{i};
        y = y(y>0);
        if ~isempty(y)
            x = linspace(0, 1, length(y));
            semilogy(x, y, 'LineWidth', 1, 'Color', [0.8 0.8 0.8], 'HandleVisibility', 'off');
            hold on;
        end
    end
    z = linspace(0, 1, length(mean_autocorr));
    semilogy(z, mean_autocorr, 'LineWidth', 1.5, 'HandleVisibility', 'off');

    chi = -lm.Coefficients.Estimate(2);
    r = lm.Coefficients.Estimate(1);

    fitindices = (z > T_ref);

    xfit = z(fitindices) - T_ref;
    yfit = xfit.^(-chi)*exp(r);
    semilogy(xfit + T_ref, yfit, 'LineWidth', 2, 'DisplayName', sprintf('\\chi = %.3f', chi));

    ylim([min(mean_autocorr)/2, max(mean_autocorr)*2])
    xline(T_ref, 'k--', 'LineWidth', 1.5, 'DisplayName', sprintf('reference : %.2f', T_ref));
    xlabel('t/T');
    ylabel('cross correlation')
    legend show;
    hold off;
end