function [g, b, c, d] = rawRegionSwipe(regions, opt)
% computes the gammas, branching ratio and slow decay of autocorelation 
% estimations over all combinations of  `states`, and `region`. It is useful to see in which condition criticality arise.

% g : 3 gamma estimations
% b : branching ratio estimations
% c : chis estimations
% d : range of the fit over which the above estimation were made

% thise list are of shape (num_regions, num_states) to cover every
% possibilities
arguments
  regions
  opt.significanceLevel = 0.05
  opt.dicoStep = 10
  opt.min_decade = 1
  opt.base = 2
  opt.threshold = 4
  opt.verbose = true
end
    [g, b, c, d] = regionsSwipeAnalysis(regions, @getRawRegionSize, @getRawRegionLifetime, @getRawRegionArea, @getRawRegionSizeTimeDependent, @getRawRegionProfile, significanceLevel=opt.significanceLevel, dicoStep=opt.dicoStep, min_decade=opt.min_decade, base=opt.base, threshold=opt.threshold, verbose=opt.verbose);
end