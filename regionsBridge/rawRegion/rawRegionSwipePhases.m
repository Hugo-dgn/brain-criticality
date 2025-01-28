function [Ids, States, Phases, G] = rawRegionSwipePhases(session, opt)
arguments
  session
  opt.significanceLevel = 0.2
  opt.dicoStep = 10
  opt.min_decade = 1
  opt.base = 1.5
  opt.threshold = 4
end
    phases = loadEvents(session);
    states = ["awake"; "rem"; "sws"];
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