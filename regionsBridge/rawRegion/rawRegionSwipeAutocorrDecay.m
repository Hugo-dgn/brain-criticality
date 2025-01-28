function chi = rawRegionSwipeAutocorrDecay(regions, opt)
arguments
    regions
    opt.step = 10
    opt.rSquaredMin = 0.9
    opt.interpn = 1000
    opt.states = {'all'}
    opt.regions = [-1]
end
    timeDependendentSize = getRawRegionSizeTimeDependent(regions, states=opt.states, regions=opt.regions);
    ST = separateAvalSizeTimeDependent(timeDependendentSize);
    chi = swipeAutocorrelationDecay(ST, step=opt.step, interpn=opt.interpn, rSquaredMin=opt.rSquaredMin);
end

