function [theta_grid, density] = kde(theta, n, kappa, options)
%KDE Circular kernel density estimation using von Mises kernels
% 
% Syntax:
%   [theta_grid, density] = circ.kde(theta, n, kappa, 'Name', value, ...)
% 
% Inputs:
%   theta   - angles in radians (column or row vector)
%   nGrid   - number of bins (default = 64)
%   kappa   - larger = more smoothing (default = 10)
%
% Outputs:
%   theta_grid - angular positions (radians)
%   density    - estimated PDF values at those positions

arguments
    theta (:,1) double
    n (1,1) {mustBePositive, mustBeInteger} = 64;
    kappa (1,1) double = 10;
    options.Normalize (1,1) logical = false;
end

theta = wrapToPi(theta(:)); % ensure column

% Define grid
theta_grid = linspace(-pi, pi, n + 1);
theta_grid(end) = []; % remove duplicate endpoint

% Von Mises kernel density estimate
density = zeros(size(theta_grid));
for i = 1:length(theta_grid)
    density(i) = sum(exp(kappa * cos(theta - theta_grid(i))));
end
density = density / (2 * pi * besseli(0, kappa));
if options.Normalize
    density = density / numel(theta); % normalize
end
density(density < 1e-12) = 0; % Clamp for numeric precision issues producing small negative values

end
