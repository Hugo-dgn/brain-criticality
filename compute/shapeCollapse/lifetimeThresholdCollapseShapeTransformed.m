function [threshold_T, threshold_shape] = lifetimeThresholdCollapseShapeTransformed(T, shape, threshold)
    indices = T >= threshold;
    threshold_T = T(indices);
    threshold_shape = shape(:, indices);
end

