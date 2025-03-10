function [g, b, c, decades] = regionsSwipeAnalysis(regions, getSize, getLifetime, getArea, getSizeTimeDependent, getProfile,  opt)
arguments
  regions
  getSize
  getLifetime
  getArea
  getSizeTimeDependent
  getProfile
  opt.significanceLevel = 0.2
  opt.dicoStep = 10
  opt.min_decade = 1
  opt.base = 1.5
  opt.threshold = 4
  opt.verbose = true
end

    % this function gives the gamma estimation for each combinason of state and
    % region. This is deprecated as the program is not able to
    % differenciate states with the new version of regions. The result will
    % be the same for each state, only the region parameter will have an
    % impact (before states were separated into different region object and
    % state was a memeber of region, it is not the case anymore)

    %output:
    % - g : the gammas estimations
    % - b : branching ratio estimations
    % - c : chis estimations (for slow decay of autocorelation)
    % - d : number of decades for each estimation (somewhat useless)

    opt.regions = regions.ids;
    opt.states = regions.states;

    opt.regions = opt.regions(:);
    opt.states = opt.states(:);

    num_states = length(opt.states);
    num_regions = length(opt.regions);
    
    iterations_states = repmat(opt.states, 1, num_regions);
    iterations_states = reshape(iterations_states', [], 1);
    iterations_regions = repmat(opt.regions, num_states, 1);
    
    gammas = zeros(num_states*num_regions, 3);
    branchings = zeros(num_states*num_regions, 1);
    chis = zeros(num_states*num_regions, 1);
    decades = zeros(num_states*num_regions, 1);
    if opt.verbose
        f = waitbar(0, sprintf('Sending jobs (%d/%d)', 0, num_states*num_regions));
    end
    future(1:num_states*num_regions) = parallel.FevalFuture;

    for i = 1:num_states*num_regions
        r = iterations_regions(i);
        s = iterations_states(i);
        S = getSize(regions, states=s, regions=r);
        T = getLifetime(regions, states=s, regions=r);
        A = getArea(regions, states=s, regions=r);
        profile = getProfile(regions, states=s, regions=r);
        
        timeDependendentSize = getSizeTimeDependent(regions, states=s, regions=r);
        [ST, lengthST] = separateAvalSizeTimeDependent(timeDependendentSize);
        
    
        future(i) = parfeval(@analysisTask, 6, S, T, A, ST, lengthST, profile, opt);
        if opt.verbose
            waitbar(i / num_states/num_regions, f, sprintf('Sending jobs (%d/%d)', i, num_states*num_regions));
        end
    end
    
    if opt.verbose
        waitbar(0, f, 'Pending...');
    end

    for i = 1:num_states*num_regions
        [completedIdx, gam1, gam2, gam3, branching, chi, d] = fetchNext(future);
        gammas(completedIdx, :) = [gam1, gam2, gam3];
        branchings(completedIdx) = branching;
        chis(completedIdx) = chi;
        decades(completedIdx) = d;
        if opt.verbose
            waitbar(i / num_states/num_regions, f, sprintf('Computing (%d/%d)', i, num_states*num_regions));
        end
    end


    g = reshape(gammas, num_regions, num_states, 3);
    b = reshape(branchings, num_regions, num_states);
    c = reshape(chis, num_regions, num_states);
    decades  = reshape(decades, num_regions, num_states);
    if opt.verbose
        close(f);
    end
end

function [gam1, gam2, gam3, branching, chi, d] = analysisTask(S, T, A, ST, lengthST, profile, opt)
    [~, ~, ~, ~, ~, Sxmin, Sxmax, ~, Alm, gam2, ~, ~, ~, gam3, branching, ~, ~, ~, ~, autocorrlm] = analysis(S, T, A, ST, lengthST, profile, significanceLevel=opt.significanceLevel, dicoStep=opt.dicoStep, min_decade=opt.min_decade, base=opt.base, threshold=opt.threshold, verbose=false);
    if isa(Alm, 'LinearModel')
        gam1 = Alm.Coefficients.Estimate(2);
    else
        gam1 = NaN;
    end
    if isstruct(autocorrlm)
        chi = -autocorrlm.Coefficients.Estimate(2);
    else
        chi = NaN;
    end
    d = log10(Sxmax/Sxmin);
end
