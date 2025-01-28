function profile = getRawRegionProfile(R,opt)
arguments
    R
    opt.states = {'all'}
    opt.regions = [-1]
end
    if opt.regions == -1 | length(opt.regions) > 1
        opt.regions = 0;
    end

    regionArray = R.regions_array(:);
    n = length(regionArray);
    for i = 1:n
        r = regionArray(i);
        if checkState(r, opt.states) && checkRegion(r, opt.regions)
            profile = r.aval_profile;
            break;
        end
    end
end

