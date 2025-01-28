function meanAvalArrays = AvalAverageSizeTimeDependent(avalArrays, avalArraysSizes, opt)
arguments
    avalArrays
    avalArraysSizes
    opt.minSamples = 10
end
    uniqueAvalArraysSizes = unique(avalArraysSizes);
    uniqueAvalArraysSizes = uniqueAvalArraysSizes(uniqueAvalArraysSizes > 0); 
    uniqueAvalArraysSizes = sort(uniqueAvalArraysSizes);
    meanAvalArrays = {};
    for i = 1:length(uniqueAvalArraysSizes)
        sizeGroup = uniqueAvalArraysSizes(i);
        sameSizeSubArrays = avalArrays(avalArraysSizes == sizeGroup);
        sameSizeAvalMatrix = cell2mat(sameSizeSubArrays);
        if size(sameSizeAvalMatrix, 2) > opt.minSamples
            meanAvalArrays{length(meanAvalArrays) + 1} = mean(sameSizeAvalMatrix, 2);
        end
    end
end