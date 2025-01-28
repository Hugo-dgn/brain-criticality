function [vars, scores, bestVars] = rawRegionSwipePC(R, opt)
arguments
    R
    opt.start = 0.05
    opt.end = 0.6
    opt.step = 10
end
    vars = linspace(opt.start, opt.end, opt.step);
    scores = zeros(opt.step, numel(R.ids), numel(R.states));

    f = waitbar(0, 'Wait...');
    for i = 1:opt.step
        v = vars(i);
        r = R.computeAvalanches(dopc=true, var=v, verbose=false);
        [gammas, ~, ~, ~] = rawRegionSwipe(r, verbose=false);
        score = 1./(abs(gammas(:, :, 1) - gammas(:,:,2)));
        scores(i, :, :) = score;
        waitbar(i / opt.step, f, sprintf('Computing (%d/%d)', i, opt.step));
    end
    close(f);
    [~, i] = max(scores);
    bestVars = vars(i);
end