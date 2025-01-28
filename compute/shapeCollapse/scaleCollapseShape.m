function scale_shape = scaleCollapseShape(shape, T, gam)
    T = reshape(T, 1, []);
    scale_shape = shape.*T.^(1-gam);
end

