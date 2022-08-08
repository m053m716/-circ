function alpha = ang2rad(alpha)
%ANG2RAD Convert degrees into radians using expected scale.
%
% alpha = circ.ang2rad(alpha)
%   converts values in degree to radians
%
% Circular Statistics Toolbox for Matlab
%
% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
%
% See also: Contents

alpha = alpha * pi /180;