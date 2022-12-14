function r = dist2(x,y)
%DIST2 All pairwise differences x_i-y_j around the circle computed efficiently.
%
% r = circ.dist2(alpha, beta)
%   All pairwise difference x_i-y_j around the circle computed efficiently.
%
%   Input:
%     alpha       sample of linear random variable
%     beta       sample of linear random variable
%
%   Output:
%     r       matrix with pairwise differences
%
% References:
%     Biostatistical Analysis, J. H. Zar, p. 651
%
% PHB 3/19/2009
%
% Circular Statistics Toolbox for Matlab
%
% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
%
% See also: Contents

if nargin < 2
  y = x;
end

if size(x,2)>size(x,1)
  x = x';
end

if size(y,2)>size(y,1)
  y = y';
end

r = angle(repmat(exp(1i*x),1,length(y)) ...
       ./ repmat(exp(1i*y'),length(x),1));