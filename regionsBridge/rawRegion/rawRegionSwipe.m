function [g, b, c, d] = rawRegionSwipe(regions, opt)
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