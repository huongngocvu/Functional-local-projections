function [beta, phi_hat, k_hat, b_hat, yield_hat] = DieboldLiEstimation(Yield, Maturity, lambda)

% Using Diebold and Li (2006) (a variation of Nelson-Siegel model) to
% estimate 3 factors (b1-level, b2-slope, b3-curvature) and time-decay
% parameter lambda

% Reference: Nyholm, K. (2020). A Practitioner's Guide to Discrete-time
% Yield Curve Modelling: With Empirical Illustrations and MATLAB Examples.
% Cambridge University Press.

% State-space model: 
% x(t) = k + phi * x(t-1) + sig_x * e(t)     State equation
% y(t) = a + b * x(t) + sig_y * u(t)       Observation equation
% x: yield curve factors; y: yields
% k, a: constants

% SSM toolbox:
% x(t) = A * x(t-1) + B * e(t)
% y(t) = C * x(t) + D * u(t)

nTau = size(Maturity,1);

% Initial values
k0 = zeros(3,1);                                % 3-by-1
A0 = [0.95 0.05 0.05;...
      0.05 0.95 0.05;...
      0.05 0.05 0.95];                          % 3-by-3
B0 = [0.2; 0.01; 0.2; 0.01; 0.01; 0.2];         % 6-by-1

D0 = 0.08;                                      
% D0 = 0.06;                                      

p0 = [A0(:); k0; B0(:); D0]; % 19 parameters to estimate

% nP = size(p0,1);    % nP = 19

% Upper and lower parameter bounds
lb_        = [ -2*ones(9,1); -inf*ones(3,1); -10*ones(6,1); -10 ];
ub_        = [  2*ones(9,1);  inf*ones(3,1);  10*ones(6,1); 10 ];

Mdl_ = ssm (@(p) pMap (p, Maturity, lambda));
options = optimoptions ( @fmincon ,'Algorithm','interior-point' ,'MaxIterations' ,1e6,...
    'MaxFunctionEvaluations' ,1e6 , 'TolFun', 1e-6 , 'TolX', 1e-6);

[EstMdl_ , p_hat] = estimate(Mdl_ ,Yield ,p0 ,'Display','iter',...
    'lb',lb_ ,'ub',ub_ ,'univariate',true ,'options',options);

% [EstMdl_ , p_hat] = estimate(Mdl_ ,Yield ,p0, 'Display','iter',...
%     'lb', lb_, 'ub', ub_, 'Univariate', true, 'CovMethod', 'sandwich');

x_filter = filter(EstMdl_ , Yield); % extract filtered state variables

beta = x_filter(:,1:3);            %Estimated factors
phi_hat = EstMdl_.A(1:3,1:3);       %Estimated phi matrix
k_hat = diag(EstMdl_.A(1:3,4:6));   %Estimated constant k
b_hat = EstMdl_.C(1:nTau,1:3);        %Estimated b matrix
yield_hat = (b_hat *beta')';   %Estimated yields





