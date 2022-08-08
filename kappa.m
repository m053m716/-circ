function kappa_ = kappa(alpha,w)
%KAPPA Computes an approximation to the ML estimate of the concentration parameter kappa of the von Mises distribution.
%
% kappa = circ.kappa(alpha,[w])
%   Computes an approximation to the ML estimate of the concentration 
%   parameter kappa of the von Mises distribution.
%
%   Input:
%     alpha   angles in radians OR alpha is length resultant
%     [w      number of incidences in case of binned angle data]
%
%   Output:
%     kappa_   estimated value of kappa
%
%   References:
%     Statistical analysis of circular data, Fisher, equation p. 88
%
% Circular Statistics Toolbox for Matlab
%
% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
%
% See also: Contents


alpha = alpha(:);

if nargin<2
  % if no specific weighting has been specified
  % assume no binning has taken place
	w = ones(size(alpha));
else
  if size(w,2) > size(w,1)
    w = w';
  end 
end

N = length(alpha);

if N>1
  R = circ.r(alpha,w);
else
  R = alpha;
end

if R < 0.53
  kappa_ = 2*R + R^3 + 5*R^5/6;
elseif R>=0.53 && R<0.85
  kappa_ = -.4 + 1.39*R + 0.43/(1-R);
else
  kappa_ = 1/(R^3 - 4*R^2 + 3*R);
end

if N<15 && N>1
  if kappa_ < 2
    kappa_ = max(kappa_-2*(N*kappa_)^-1,0);    
  else
    kappa_ = (N-1)^3*kappa_/(N^3+N);
  end
end
