function pval = symtest(alpha)
%SYMTEST Tests for symmetry about the median.
%
% pval = circ.symtest(alpha)
%   Tests for symmetry about the median.
%   H0: the population is symmetrical around the median
%   HA: the population is not symmetrical around the median
%
%
%   Input:
%     alpha	sample of angles in radians
%
%   Output:
%     pval  p-value
%
% PHB 3/19/2009
%
% References:
%   Biostatistical Analysis, J. H. Zar, 27.4
%
% Circular Statistics Toolbox for Matlab
%
% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
%
% See also: Contents

if size(alpha,2) > size(alpha,1)
	alpha = alpha';
end

% compute median
md = circ.median(alpha);

% compute deviations from median
d = circ.dist(alpha,md);

% compute wilcoxon sign rank test
pval = signrank(d);




