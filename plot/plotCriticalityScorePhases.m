function plotCriticalityScorePhases(Ids, States, Phases, G)
    n = length(Ids);
    figure;
    row = 3;
    column = ceil(n/row);
    for i = 1:n
        subplot(row, column, i);
        ids = Ids{i};
        states = States{i};
        score = 1./var(G{i}, 0, 3);
        plotCriticalityScore(ids, states, score);
        title(sprintf('Criticality score %s', Phases{i}));
    end
end

