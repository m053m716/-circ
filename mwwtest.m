function p = mwwtest(alpha1, alpha2)
% Non-parametric Mardia-Watson-Wheeler test for equal distributions
% Input: alpha1, alpha2 - angles in radians
% Output: p - p-value of test

alpha = [alpha1(:); alpha2(:)];
groups = [ones(size(alpha1)); 2 * ones(size(alpha2))];
n1 = numel(alpha1);
n2 = numel(alpha2);
n = n1 + n2;

% Rank the angles
[~, sortIdx] = sort(mod(alpha, 2*pi));
ranks = 1:n;
ranks(sortIdx) = ranks;

% Compute test statistic
r1 = sum(ranks(groups == 1));
r2 = sum(ranks(groups == 2));

U = (12 / (n * (n + 1))) * (r1^2 / n1 + r2^2 / n2) - 3 * (n + 1);

% Use chi-squared approximation with 2 degrees of freedom
p = 1 - chi2cdf(U, 2);
end
