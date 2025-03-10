function [Ids, States, Phases, G] = rawRegionSwipePhases(session, opt)
%compute the gammas estimation for every phases, states and region. It is
%useful to see in which situation the system is critical

%- `Ids`: The IDs of the regions present in each region.  
%- `States`: States present in each region.  
%- `Phases`: All possible phases.  
%- `G`: The three corresponding gamma estimations.

%Each of these is a `cell` of size (1, n), where `n` is the number of 
% phases. The i-th entry of `G` is a matrix of size 
% `length(Ids(i)) × length(States(i)) × 3`, as it contains all the 
% gamma estimations for each combination of states and regions in the phase
% `Phases(i)`. Note that since the states are no longer separated into
% different `region` objects, the code is unable to differentiate states
% (see `helpers/checkState.m`).  
arguments
  session
  opt.significanceLevel = 0.2
  opt.dicoStep = 10
  opt.min_decade = 1
  opt.base = 1.5
  opt.threshold = 4
end
    phases = loadEvents(session);
    states = ["other"; "rem"; "sws"];
    n = length(phases);
    G = cell(1, n);
    Ids = cell(1, n);
    States = cell(1, n);
    Phases = cell(1, n);


    f = waitbar(0,sprintf('Sending jobs (%d/%d)', 0, n));
    future(1:n) = parallel.FevalFuture;
    for i = 1:n
        phase = phases(i);
        future(i) = parfeval(@loadTask, 1, session, phase, states);
        waitbar(i / n, f, sprintf('Sending jobs (%d/%d)', i, n));
    end
    
    waitbar(0, f, 'Pending...');

    for i = 1:n
        [completedIdx, R] = fetchNext(future);
        gammas = rawRegionSwipe(R, significanceLevel=opt.significanceLevel, dicoStep=opt.dicoStep, min_decade=opt.min_decade, base=opt.base, threshold=opt.threshold);
        G{completedIdx} = gammas;
        Ids{completedIdx} = R.ids;
        States{completedIdx} = R.states;
        Phases{completedIdx} = phases(completedIdx);
        waitbar(i/n, f, sprintf('Computing (%d/%d)', i, n));
    end
    close(f);
end

function R = loadTask(session, phase, states)
    R = regions(session, phases=phase, states=states);
    R = R.loadSpikes();
    R = R.computeAvalanches();
end