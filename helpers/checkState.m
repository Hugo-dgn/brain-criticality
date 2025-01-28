function flag = checkState(region, states)
    if ismember('all', states)
        flag = true;
    else
        flag = ismember(region.state, states);
    end
end