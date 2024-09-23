function alpha = DiscreteBoundedPowerLawMLE(x, xmin, xmax, alphaStep, alphaMin, alphaMax)
    if nargin < 5
        alphaMin = 1;
    end
    if nargin < 6
        alphaMax = 4;
    end
    alphas = alphaMin:alphaStep:alphaMax;
    L = DiscreteBoundedPowerLawLikelihood(x, xmin, xmax, alphas);
    [~, i] = max(L);
    alpha = alphas(i);
end

