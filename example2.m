% Philipp Berens
% CircStat: A Matlab Toolbox for Circular Statistics
% Submitted to Journal of Statistical Software
%
% Example 2
% An Application to Neuroscience
%
%
% In this example, we assess the orientation tuning properties of three
% neurons recorded from the primary visual cortex of awake macaques. the 
% number of action potentials such neurons fire is modulated by the
% orientation of a visual stimulus such as an oriented grating.
%
% We thus consider two variables: The stimulus orientations ori spaced 22.5
% deg apart and the number of spikes w fired in response to each 
% orientation of the stimulus. 
%
% Modified by Max Murphy on 2022-08-08:
%   -> Move this example script to a folder containing the +circ package.


%% part 1: load and plot data
clear
% load neurodata
ori = [0,22.5,45,67.5,90,112.5,135,157.5];
w = [63,66,79,171,101,54,58,51; ...
     25,15,12,2,12,16,67,204;   ...
     10,5,5,0,2,4,22,93];

% orientation of bins -> convert two directions
ori = circ.axial(circ.ang2rad(ori),2);

% spacing of bins
dori = diff(ori(1:2));

% summed spikes per orientation 
w;

% plot the activity of the three neurons
figure
for j = 1:3
  subplot(1,3,j)
  
  % compute and plot mean resultant vector length and direction
  mw = max(w(j,:));
  r = circ.r(ori,w(j,:),dori) * mw;
  phi = circ.mean(ori,w(j,:));
  hold on;
  zm = r*exp(i*phi');
  plot([0 real(zm)], [0, imag(zm)],'r','linewidth',1.5)
  
  % plot the tuning function of the three neurons 
  polar([ori ori(1)], [w(j,:) w(j,1)],'k')
  
  % draw a unit circle
  zz = exp(i*linspace(0, 2*pi, 101)) * mw;
  plot(real(zz),imag(zz),'k:')
  plot([-mw mw], [0 0], 'k:', [0 0], [-mw mw], 'k:')

  circ.formatSubplot(gca,'ax','square','box','off','lim',[-mw mw -mw mw])
  set(gca,'xtick',[])
  set(gca,'ytick',[])

end

%% part 2: descriptive statistics

stats = zeros(3,10);
for i=1:3
  
  spk = w(i,:);
  
  % circular mean angle
  stats(i,1) = circ.mean(ori,spk,2);
  
  % circular variance
  stats(i,2) = circ.var(ori,spk,dori,2);
  
  % circular standard deviation
  [stats(i,3) stats(i,4)] = circ.std(ori,spk,dori,2);
  
  % circular skewness
  [stats(i,5) stats(i,6)] = circ.skewness(ori,spk,2); 
  
  % circular skewness
  [stats(i,7) stats(i,8)] = circ.kurtosis(ori,spk,2);
  
  % confidence limits on mean angle
  t = circ.confmean(ori,[],spk,dori,2);
  stats(i,9) = stats(i,1) + t;
  stats(i,10) = stats(i,1) - t;
end

% stats contains all data reported in table 1

%% part 3: inferential statistics

% A: tests for uniformity of distribution around the circle
% rejecting the null hypothesis allows us to assert that the neurons are
% indeed tuned to the orientation of the stimulus and fire preferentially
% at a particular orientation

uniform = zeros(3,2);
for i=1:3
  
  spk = w(i,:);
  
  % rayleigh test
  uniform(i,1) = circ.rtest(ori,spk,dori);
  
  % omnibus test
  uniform(i,2) = circ.otest(ori,[],spk);
  
  % rao's spacing test is not possible with binned data
end

% B: test for differences in preferred orientation between neurons

% differences between all groups
alpha = [ori ori ori];
idx = [ones(1,length(ori)) 2* ones(1,length(ori)) 3* ones(1,length(ori))];
spk = reshape(w',1,numel(w));

fprintf('TESTING FOR DIFFERENCES BETWEEN ANY CELLS\n')
circ.wwtest(alpha,idx,spk);

% all pairwise differences
for i=1:3
  for j=(i+1):3
    % differences between cells i and cell j
    alpha = [ori ori];
    idx = [i* ones(1,length(ori)) j* ones(1,length(ori))];
    spk = reshape(w([i j],:)',1,numel(w([i j],:)));
    
    fprintf('TESTING FOR DIFFERENCES BETWEEN CELLS %d AND %d\n',i,j)
    watson(i,j) = circ.wwtest(alpha,idx,spk); %#ok<AGROW>
  end
end

























