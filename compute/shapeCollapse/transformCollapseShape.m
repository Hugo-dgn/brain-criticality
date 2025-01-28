function [x, S, T] = transformCollapseShape(shape)
    n = numel(shape);
    m = 100;
    x = linspace(0, 1, m);
    S = zeros(m, n-1);
    T = zeros(1, n-1);
    for i = 1:n-1
        s = shape{i+1};
        t = length(s);
        z = linspace(0, t, t);
        s = interp1(z, s, x*t);
        S(:, i) = s;
        T(i) = t;
    end
end

