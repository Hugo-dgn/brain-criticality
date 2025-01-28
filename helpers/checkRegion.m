function flag = checkRegion(region, regions)
    if ismember(-1, regions)
        flag = ~(region.id == 0);
    else
        flag = ismember(region.id, regions);
    end
end