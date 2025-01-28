function T = getLifetime(aval_indeces)
    T = aval_indeces(:,2) - aval_indeces(:,1) + 1;
end

