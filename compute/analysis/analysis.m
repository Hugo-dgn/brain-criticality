function [alpha, Txmin, Txmax, Tp, beta, Sxmin, Sxmax, Sp, Alm, gam, x_shape, T_shape, shape, shape_gam, branching, crossCorr, branchingRatiolm, autocorrDecay, mean_autocorr, autocorrlm] = analysis(S, T, A, ST, lengthST, profile, opt)
arguments
  S
  T
  A
  ST
  lengthST
  profile
  opt.significanceLevel = 0.95
  opt.dicoStep = 10
  opt.min_decade = 1
  opt.base = 1.5
  opt.threshold = 4
  opt.maxLag = 5
  opt.T_ref = 1/3;
  opt.verbose = true
end
    if isempty(T)
        [alpha, Txmin, Txmax, Tp, beta, Sxmin, Sxmax, Sp, Alm, gam, x_shape, T_shape, shape, shape_gam, branching, crossCorr, branchingRatiolm, autocorrDecay, mean_autocorr, autocorrlm] = deal(NaN);
        return
    end
    [alpha, Txmin, Txmax, Tp] = swipeMLEDiscretePowerLawBounds(T, opt.significanceLevel, opt.dicoStep, opt.min_decade, opt.base, opt.verbose);
    [beta, Sxmin, Sxmax, Sp] = swipeMLEDiscretePowerLawBounds(S, opt.significanceLevel, opt.dicoStep, opt.min_decade, opt.base, opt.verbose);
    Alm = fitPowerFunction(A);
    gam = (alpha - 1)/(beta - 1);
    
    ST_AVG = AvalAverageSizeTimeDependent(ST, lengthST);
    [x_shape, shape, T_shape] = transformCollapseShape(ST_AVG);
    [T_shape, shape] = lifetimeThresholdCollapseShapeTransformed(T_shape, shape, opt.threshold);
    shape_gam = fitCollapseShape(T_shape, shape, opt.dicoStep);
  
    [branching, crossCorr, branchingRatiolm] = branchingRatio(profile, opt.maxLag);
    [~, autocorrDecay, mean_autocorr, autocorrlm] = autocorrelationDecay(ST, lengthST, opt.T_ref);
end