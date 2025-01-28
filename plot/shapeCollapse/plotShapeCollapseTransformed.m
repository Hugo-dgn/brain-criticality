function plotShapeCollapseTransformed(x, shape)
    hold on
    n = size(shape, 2);
    for i = 1:n
        plot(x, shape(:, i));
    end
end

