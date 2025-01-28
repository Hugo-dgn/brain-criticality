function plotBranchingRatio(profile, kmax)
    [m, r, lm] = branchingRatio(profile, kmax);
    plotBranchingRatioFit(m, r, lm);
end

