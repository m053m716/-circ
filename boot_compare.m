function [ci95, rejectNull, diffMeans, pValue, asterisks, fig] = boot_compare(data1, data2, alpha)
% Bootstrap-based comparison of circular means

if nargin < 3
    alpha = 0.05;
end

B = 10000;
mu1 = circ.mean(data1(:));
mu2 = circ.mean(data2(:));
diffMeans = circ.dist(mu1, mu2);

bootDiffs = zeros(B,1);
n1 = length(data1);
n2 = length(data2);

for b = 1:B
    samp1 = data1(randi(n1, n1, 1));
    samp2 = data2(randi(n2, n2, 1));
    mu1b = circ.mean(samp1);
    mu2b = circ.mean(samp2);
    bootDiffs(b) = circ.mean(circ.dist(mu1b, mu2b)');
end

ci95 = quantile(bootDiffs, [alpha/2, 1 - alpha/2]);

rejectNull = ~(ci95(1) <= 0 && ci95(2) >= 0);
pValue = mean(abs(bootDiffs) >= abs(diffMeans));

% asterisks
if pValue < 0.001
    asterisks = "***";
elseif pValue < 0.01
    asterisks ="**";
elseif pValue < 0.05
    asterisks = "*";
else
    asterisks = "NS";
end

fig = figure('Color','w','Name','Bootstrap Mean Angle Comparison');
histogram(bootDiffs, 100); hold on;
xline(ci95, 'r'); xline(diffMeans, 'k');
title('Bootstrapped Difference of Circular Means');
xlabel('Angle difference (rad)');
ylabel('Frequency');
end
