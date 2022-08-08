% Philipp Berens
% CircStat: A Matlab Toolbox for Circular Statistics
% Submitted to Journal of Statistical Software
%
% Example 1
%
% Demonstrate functionality of all functions of the CircStat toolbox using
% artifical data.
%
% Modified by Max Murphy on 2022-08-08:
%   -> Move this example script to a folder containing the +circ package.

%% part1: generate data

alpha_deg = [13 15 21 26 28 30 35 36 41 60 92 103 165 199 210 ...
        250 301 320 343 359]';

alpha_rad = circ.ang2rad(alpha_deg);       % convert to radians

beta_deg = [1 13 41 56 67 71 81 85 99 110 119 131 145 177 199 220 ...
      291 320 340 355]';
beta_rad = circ.ang2rad(beta_deg);         % convert to radians

fprintf('\nTHE CIRCSTAT TOOLBOX EXAMPLE\n\nDescriptive Statistics\n')

%% part2: plot data (generate figure 1)

figure(1)
subplot(2,2,1)
circ.plot(alpha_rad,'pretty','bo',true,'linewidth',2,'color','r'),

subplot(2,2,3)
circ.plot(alpha_rad,'hist',[],20,true,true,'linewidth',2,'color','r')

subplot(2,2,2)
circ.plot(beta_rad,'pretty','bo',true,'linewidth',2,'color','r'),

subplot(2,2,4)
circ.plot(beta_rad,'hist',[],20,true,true,'linewidth',2,'color','r')

%% part 3: descriptive statistics

fprintf('\t\t\t\t\t\tALPHA\tBETA\n')

alpha_bar = circ.mean(alpha_rad);
beta_bar = circ.mean(beta_rad);

fprintf('Mean resultant vector:\t%.2f \t%.2f\n', circ.rad2ang([alpha_bar beta_bar]))

alpha_hat = circ.median(alpha_rad);
beta_hat = circ.median(beta_rad);

fprintf('Median:\t\t\t\t\t%.2f \t%.2f\n', circ.rad2ang([alpha_hat beta_hat]))

R_alpha = circ.r(alpha_rad);
R_beta = circ.r(beta_rad);

fprintf('R Length:\t\t\t\t\t%.2f \t%.2f\n',[R_alpha R_beta])

S_alpha = circ.var(alpha_rad);
S_beta = circ.var(beta_rad);

fprintf('Variance:\t\t\t\t%.2f \t%.2f\n',[S_alpha S_beta])

[s_alpha, s0_alpha] = circ.std(alpha_rad);
[s_beta, s0_beta] = circ.std(beta_rad);

fprintf('Standard deviation:\t\t%.2f \t%.2f\n',[s_alpha s_beta])
fprintf('Standard deviation 0:\t%.2f \t%.2f\n',[s0_alpha s0_beta])

b_alpha = circ.skewness(alpha_rad);
b_beta = circ.skewness(beta_rad);

fprintf('Skewness:\t\t\t\t%.2f \t%.2f\n',[b_alpha b_beta])

k_alpha = circ.kurtosis(alpha_rad);
k_beta = circ.kurtosis(beta_rad);

fprintf('Kurtosis:\t\t\t\t%.2f \t%.2f\n',[k_alpha k_beta])

fprintf('\n\n')

%% part 4: inferential statistics

fprintf('Inferential Statistics\n\nTests for Uniformity\n')

% Rayleigh test
p_alpha = circ.rtest(alpha_rad);
p_beta = circ.rtest(beta_rad);
fprintf('Rayleigh Test, \t\t P = %.2f \t%.2f\n',[p_alpha p_beta])

% Omnibus test
p_alpha = circ.otest(alpha_rad);
p_beta = circ.otest(beta_rad);
fprintf('Omnibus Test, \t\t P = %.2f \t%.2f\n',[p_alpha p_beta])

% Rao's spacing test
p_alpha = circ.raotest(alpha_rad);
p_beta = circ.raotest(beta_rad);
fprintf('Rao Spacing Test, \t P = %.2f \t%.2f\n',[p_alpha p_beta])

% V test
p_alpha = circ.vtest(alpha_rad,circ.ang2rad(0));
p_beta = circ.vtest(beta_rad,circ.ang2rad(0));
fprintf('V Test (r = 0), \t P = %.2f \t%.2f\n',[p_alpha p_beta])


fprintf('\nTests concerning Mean and Median angle\n')

% 95 percent confidence intervals for mean direction
t_alpha = circ.confmean(alpha_rad,0.05);
t_beta = circ.confmean(beta_rad,0.05);

fprintf('Mean, up 95 perc. CI:\t\t\t%.2f \t%.2f\n', circ.rad2ang([alpha_bar+t_alpha beta_bar+t_beta]))
fprintf('Mean, low 95 perc. CI:\t\t\t%.2f \t%.2f\n', circ.rad2ang([2*pi+alpha_bar-t_alpha beta_bar-t_beta]))

h1 = circ.mtest(alpha_rad,0);
h2 = circ.mtest(alpha_rad,circ.ang2rad(90));

fprintf('Mean Test (alpha), mean = 0 deg:\t\t%d\n',h1)
fprintf('Mean Test (alpha), mean = 90 deg:\t\t%d\n',h2)


h1 = circ.medtest(alpha_rad,circ.ang2rad(25));
h2 = circ.medtest(alpha_rad,circ.ang2rad(105));

fprintf('Median Test (alpha), median = 25 deg:\t%.2f\n',h1)
fprintf('Median Test (alpha), median = 105 deg:\t%.2f\n',h2)

h1 = circ.symtest(alpha_rad);
h2 = circ.symtest(beta_rad);

fprintf('Symmetry around median (alpha/beta):\t\t\t%.2f\t %.2f\n',h1,h2)


%% part 4: association
fprintf('Measures of Association\n\nCircular-Circular Association\n')

figure
subplot(121)
plot(alpha_rad,beta_rad,'ok')
circ.formatSubplot(gca,'xl','\alpha_i','yl','\beta_i', 'ax','square','box','off', 'lim',[0 2*pi 0 2*pi ])

subplot(122)
plot(1:20,alpha_rad,'or',1:20,beta_rad,'ok')
circ.formatSubplot(gca,'xl','x','yl','\alpha_i (red) / \beta_i (black)', 'ax','square','box','off', 'lim',[0 21 0 2*pi ])


% compute circular - circular correlation of alpha and beta
[c, p] = circ.corrcc(alpha_rad,beta_rad);
fprintf('Circ-circ corr coeff/pval:\t%.2f\t %.3f\n',c,p)


% cmpute circular - linear correlation of alpha/beta with 1:20
[ca, pa] = circ.corrcl(alpha_rad,1:20);
[cb, pb] = circ.corrcl(beta_rad,1:20);

fprintf('Circ-lin corr coeff:\t\t%.2f\t %.2f\n',ca,cb)
fprintf('Circ-lin corr pval:\t\t\t%.3f\t %.3f\n',pa,pb)


%% part 5: multi-sample tests
% the dataset we use here consists of three samples from von mises
% distributions with common parameter kappa = 10 and means equal to pi,
% pi+.25 and pi+.5.

% load data
idx = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3;3];
theta = [-2.35333882539270;2.45272754601313;-2.78290741744120;2.82971567867312;-3.13744615847557;-2.70450159734912;2.98102109921849;3.05120024680588;2.42344832951971;-2.78488566332663;2.73288781771674;2.75193515887027;2.99247939172725;-3.05880011718106;-3.04299609458884;-2.88466801907042;3.09178977515758;2.96627595313463;-2.67049733208495;2.83581644089597;3.11962186194240;2.43537046924551;-3.00181939032689;-2.90734428097007;2.91809852212895;-2.88066419590832;2.67878953897533;2.81350653009853;2.88999695108791;3.13193544830555;-2.96664474417714;-2.75622020669069;-3.07528965762258;3.11564464980910;-2.75875345567137;-2.93566008083461;-2.65326093757725;-2.93870749918101;2.55298759285896;-3.07727511710405;-2.65314923365076;3.11393682395874;-2.44774063233257;-2.59174465414917;-3.01277983557777;-2.54552957373932;-2.89297267054962;-3.08291419253901;-2.75372630446263;2.81161835694472;-3.11534300887151;-2.55917644216381;-2.67254925867059;-3.05710403401661;-2.69995357919187;-2.52487130109313;-2.93212058610970;-2.38924441759146;-3.01009362024597;-2.28944409746607;-2.59735525164386;-2.81467518744682;-2.19834370545488;-2.46896988704204;-2.21511243733845;-2.62932352830152;-2.45901995019929;-2.82959708601379;-2.76958098054839;-2.61568945349516;-2.76414807305320;-2.49157296820624;-2.53565299867506;-2.68681659790754;-2.41336210652730;-1.90251893770016;-2.21210320718755;-2.94330079969732;-3.06552627157403;-2.06669799413457;-2.71678703440491;-2.19414698998753;-2.60367558377318;-3.08929593737276;-2.53006997272571;-2.07790107944959;-2.85268131794381;-2.46926587318788;-2.10026850728550;-2.26337206209848];
theta1 = [-2.35333882539270;2.45272754601313;-2.78290741744120;2.82971567867312;-3.13744615847557;-2.70450159734912;2.98102109921849;3.05120024680588;2.42344832951971;-2.78488566332663;2.73288781771674;2.75193515887027;2.99247939172725;-3.05880011718106;-3.04299609458884;-2.88466801907042;3.09178977515758;2.96627595313463;-2.67049733208495;2.83581644089597;3.11962186194240;2.43537046924551;-3.00181939032689;-2.90734428097007;2.91809852212895;-2.88066419590832;2.67878953897533;2.81350653009853;2.88999695108791;3.13193544830555];
theta2 = [-2.96664474417714;-2.75622020669069;-3.07528965762258;3.11564464980910;-2.75875345567137;-2.93566008083461;-2.65326093757725;-2.93870749918101;2.55298759285896;-3.07727511710405;-2.65314923365076;3.11393682395874;-2.44774063233257;-2.59174465414917;-3.01277983557777;-2.54552957373932;-2.89297267054962;-3.08291419253901;-2.75372630446263;2.81161835694472;-3.11534300887151;-2.55917644216381;-2.67254925867059;-3.05710403401661;-2.69995357919187;-2.52487130109313;-2.93212058610970;-2.38924441759146;-3.01009362024597;-2.28944409746607];
theta3 = [-2.59735525164386;-2.81467518744682;-2.19834370545488;-2.46896988704204;-2.21511243733845;-2.62932352830152;-2.45901995019929;-2.82959708601379;-2.76958098054839;-2.61568945349516;-2.76414807305320;-2.49157296820624;-2.53565299867506;-2.68681659790754;-2.41336210652730;-1.90251893770016;-2.21210320718755;-2.94330079969732;-3.06552627157403;-2.06669799413457;-2.71678703440491;-2.19414698998753;-2.60367558377318;-3.08929593737276;-2.53006997272571;-2.07790107944959;-2.85268131794381;-2.46926587318788;-2.10026850728550;-2.26337206209848];

p = nan(1,4);
fprintf('\nMulti-Sample tests\n')
p(1) = circ.wwtest(theta1,theta2);
fprintf('\nTEST 1: ONE FACTOR ANOVA, theta1 vs theta2\n\t->\t<strong>p=%.4f</strong>\n\n', p(1));
p(2) = circ.wwtest(theta,idx);
fprintf('\nTEST 2: ONE FACTOR ANOVA, theta1 vs theta2 vs theta3\n\t->\t<strong>p=%.4f</strong>\n\n', p(2))
p(3) = circ.cmtest(theta1,theta2);
fprintf('TEST 3: NON PARAMETRIC ONE FACTOR ANOVA, theta1 vs. theta2\n\t->\t<strong>p=%.4f</strong>\n\n',p(3))
idp = idx(1:60);    % factor 1: two original groups
idq = idp(randperm(length(idp))); % factor 2: random assignment to groups
p(4) = circ.hktest([theta1; theta2], idp,idq,true);
fprintf('\nTEST 4: TWO FACTOR ANOVA, theta1 vs theta2\n\t->\t<strong>p=%.4f</strong>\n\n',p(4));
















