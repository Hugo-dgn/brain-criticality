function [avalArrays, avalArraysSize] = separateAvalSizeTimeDependent(timeDependendentSize)
arguments
    timeDependendentSize
end
    % Separate every avalanche profile, this is useful for the shape
    % collapse. Each avalanche profile is stored in the avalArrays cell and
    % there corresponding length is stored in avalArraysSize

    %this function assume that in the input, each avalanche is separated by
    %a 0 (this is the aval_timeDependendentSize member of region)
    if isempty(timeDependendentSize)
        avalArrays = {};
        return
    end
    if timeDependendentSize(1) ~= 0
        timeDependendentSize = [0;timeDependendentSize];
    end
    if timeDependendentSize(end) ~= 0
        timeDependendentSize = [timeDependendentSize;0];
    end
    zerosPos = find(timeDependendentSize == 0);
    n = length(zerosPos);
    avalArrays = cell(1, n-1);
    avalArraysSize = zeros(1, n-1);
    for i = 2:n
        avalArrays{i - 1} = timeDependendentSize(zerosPos(i-1)+1:zerosPos(i)-1);
        avalArraysSize(i-1) = zerosPos(i)-1 - zerosPos(i-1);
    end
end    