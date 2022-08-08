function alpha = rad2ang(alpha)
%RAD2ANG Converts values in radians to values in degrees.
%
% alpha = circ.rad2ang(alpha)
%   converts values in radians to values in degree
%
% Circular Statistics Toolbox for Matlab
%
% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
%
% See also: Contents

alpha = alpha / pi *180;