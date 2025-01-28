function y = preprocess(x)
    uniqueVals = unique(x);
    [counts, ~] = histcounts(x, [uniqueVals; max(uniqueVals) + 1]);
    moreThanOnce = uniqueVals(counts > 1);
    y = x(ismember(x, moreThanOnce));
end

