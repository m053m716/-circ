function formatSubplot(handle,varargin)
%FORMATSUBPLOT  Format subplot handles
%
% Syntax:
%   circ.formatSubplot(handle, 'Name', value, ...);
%
% Inputs:
%   handle - Subplot (individual) handle.
%   varargin - 'Name', value pairs.
%  
% See also: Contents

args.fs = 7;
args.xl = [];
args.yl = [];
args.box = [];
args.ax = [];
args.lim = [];
args.tt = [];
args.xt = [];
args.yt =[];
args = circ.parseVarArgs(args,varargin{:});

set(handle,'fontsize',args.fs)
if ~isempty(args.xl)
  xlabel(handle,args.xl)
end
if ~isempty(args.yl)
  ylabel(handle,args.yl)
end
if ~isempty(args.tt)
  title(handle,args.tt)
end
if ~isempty(args.box)
  set(handle,'box',args.box)
end
if ~isempty(args.ax)
  axis(handle,args.ax)
end
if ~isempty(args.lim)
  axis(handle,args.lim)
end
if ~isempty(args.yt)
  set(handle,'ytick',args.yt)
end
if ~isempty(args.xt)
  set(handle,'xtick',args.xt)
end