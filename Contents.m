% CircStat Toolbox
%   Toolbox for circular statistics with Matlab
%
% This code has been modified from its original form by Max Murphy
% (mdmurphy@andrew.cmu.edu) on 2022-08-08. 
%   Please refer to and be sure to cite the original versions:
%
% Reference:
%   P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software,Vol. 31, Issue 10, 2009
%	http://www.jstatsoft.org/v31/i10
%
% Author:
%   Philipp Berens & Marc J. Velasco, 2009
%
% All modifications presented here are for syntactical convenience, and do
% not change the underlying calculations performed by these code, to the
% best of this author's knowledge.
%
% Descriptive Statistics.
%   circ.mean     - Mean direction of a sample of circular data
%   circ.median   -	Median direction of a sample of circular data
%   circ.r        - Resultant vector length
%   circ.var      - Circular variance
%   circ.std      - Circular standard deviation
%   circ.moment   - Circular p-th moment 
%   circ.skewness -	Circular skewness
%   circ.kurtosis -	Circular kurtosis
%
% Inferential Statistics.
%  Testing for Circular Uniformity.
%   circ.rtest    - Rayleigh's test for nonuniformity
%   circ.otest    - Hodges-Ajne test (omnibus test) for nonuniformity
%   circ.raotest  - Rao's spacing test for nonuniformity
%   circ.vtest    - V-Test for nonuniformity with known mean direction
%
%  Tests Concerning Mean and Median.
%   circ.confmean - Confidence intervals for mean direction
%   circ.mtest    -	One-sample test for specified mean direction
%   circ.medtest  -	Test for median angle
%   circ.symtest  -	Test for symmetry around median angle
%
%  Paired and Multisample Tests.
%   circ.wwtest   - Two and multi-sample test for equal means; 
%                   one-factor ANOVA
%   circ.hktest   -	Two-factor ANOVA
%   circ.cmtest   - Non-parametric multi-sample test for equal medians
%   circ.ktest    - Test for equal concentration parameter
%   circ.kuipertest - Test for equality of distributions (KS-test)
%
% Measures of Association.
%   circ.corrcc   - Circular-circular correlation coefficient
%   circ.corrcl   -	Circular-linear correlation coefficient
%
% The Von Mises Distribution
%   circ.vmpdf    - Probability density function of the von Mises
%                   distribution
%   circ.vmpar    - Parameter estimation
%   circ.vmrnd    - Random number generation
%
% Others.
%   circ.axial    -	Convert axial data to common scale
%   circ.dist     - Distances around a circle
%   circ.dist2    - Pairwise distances around a circle
%   circ.stats    -	Summary statistics
%   circ.kappa    -	Compute concentration parameter of a VM distribution
%   circ.plot     - Visualization for circular data
%   circ.clust    - Simple clustering
%   circ.rad2ang  - Convert radian to angular values
%   circ.ang2rad  -	Convert angular to radian values
%   circ.samplecdf - Evaluate CDF of a sample
%
% Reference:
%   P. Berens, CircStat: A Matlab Toolbox for Circular Statistics, Journal of Statistical Software,Vol. 31, Issue 10, 2009
%	http://www.jstatsoft.org/v31/i10
%
% Author:
%   Philipp Berens & Marc J. Velasco, 2009

