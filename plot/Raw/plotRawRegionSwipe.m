function plotRawRegionSwipe(regions, opt)
arguments
  regions
  opt.significanceLevel = 0.05
  opt.dicoStep = 20
  opt.min_decade = 1
  opt.base = 2
  opt.threshold = 4
  opt.percentile = 60;
end
    [gammas, branchings, chis, decades] = rawRegionSwipe(regions, significanceLevel=opt.significanceLevel, dicoStep=opt.dicoStep, min_decade=opt.min_decade, base=opt.base, threshold=opt.threshold);
    v = var(gammas, 0, 3);
    precision = 1./v;
    h = figure();
    set(h, 'Name', 'Criticality score');
    subplot(2, 2, 1);
    plotCriticalityScore(regions.ids, regions.states, precision, logscale=true);
    title('Gamma precision');
    subplot(2, 2, 2);
    plotCriticalityScore(regions.ids, regions.states, branchings);
    title('Branching ratio');
    subplot(2, 2, 3);
    decay = 1./chis;
    plotCriticalityScore(regions.ids, regions.states, decay);
    title('Autocorrelation decay');
    subplot(2, 2, 4);
    plotCriticalityScore(regions.ids, regions.states, decades);
    title('Size decade fit');
end