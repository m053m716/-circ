function [ci, bootSamples] = bootci(data, nBoot, circStatFunc, alpha)
%BOOTCI Bootstrapped confidence interval for circular statistics
%
%   ci = circ.bootci(data, nBoot, circStatFunc)
%   ci = circ.bootci(data, nBoot, circStatFunc, alpha)
%
% Inputs:
%   data          - vector of angular data in radians
%   nBoot         - number of bootstrap samples (e.g. 10000)
%   circStatFunc  - function handle, e.g. @circ_mean or @circ_median
%   alpha         - significance level (default = 0.05)
%
% Output:
%   ci            - 2-element vector with lower and upper bounds

arguments
    data
    nBoot (1,1) double {mustBePositive, mustBeInteger} = 10000;
    circStatFunc = @circ.mean
    alpha (1,1) double {mustBeInRange(alpha,0,1)} = 0.05;
end

data = data(:);
n = length(data);
bootSamples = zeros(nBoot, 1);

for i = 1:nBoot
    sample = data(randi(n, n, 1));
    bootSamples(i) = circStatFunc(sample);
end

% Wrap into [-pi, pi)
bootSamples = mod(bootSamples + pi, 2*pi) - pi;

% Sort and take percentiles — careful with wrapping!
% Convert to unit vectors, compute circular mean/CI from angles
[x, y] = pol2cart(bootSamples, ones(size(bootSamples)));
angles = atan2(y, x);

% Sort angles for quantile approximation
angles = sort(mod(angles + 2*pi, 2*pi));

ci_lo = angles(round(alpha/2 * nBoot));
ci_hi = angles(round((1 - alpha/2) * nBoot));

ci = [ci_lo, ci_hi];
end
