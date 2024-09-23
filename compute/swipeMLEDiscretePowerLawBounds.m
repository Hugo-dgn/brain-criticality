function [alpha, xmin, xmax, p] = swipeMLEDiscretePowerLawBounds(x, significanceLevel, alphaStep)
    n = length(x);
    xminBound = min(x);
    xmaxBound = max(x);
    boundStep = floor((xmaxBound - xminBound)/10);
    
    current_p = 1;
    current_alpha = 0;
    current_xmin = 0;
    current_xmax = 0;
    
    f = waitbar(0,'Please wait...');
    total_iterations = floor((xmaxBound - xminBound)^2/2) ;
    for xmin = xminBound:boundStep:(xmaxBound-1)
        for xmax = (xmin+boundStep):boundStep:xmaxBound
        iter = (xmin - xminBound) * (xmaxBound - xminBound - (xmin - xminBound)/2) + xmax - xmin;
        waitbar((iter-1)/total_iterations, f, 'computing');
        alpha = DiscreteBoundedPowerLawMLE(x, xmin, xmax, alphaStep);
        p = kolmogorovSmirnovGoodnessFit(x, xmin, xmax, alpha);
        if (p < significanceLevel) & (p < current_p)
            if xmax - xmin > current_xmax - current_xmin
                current_p = p;
                current_alpha = alpha;
                current_xmin = xmin;
                current_xmax = xmax;
            end
        end
    end
    alpha = current_alpha;
    xmin = current_xmin;
    xmax = current_xmax;
    p = current_p;
end

