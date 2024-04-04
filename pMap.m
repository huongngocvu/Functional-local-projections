function [A,B,C,D,Mean0,Cov0,StateType] = pMap(p, tau, lambda)
% Parameter mapping function for MATLAB's SSM model

nTau = size(tau,1);

A1 = [p(1) p(4) p(7);...
    p(2) p(5) p(8);...
    p(3) p(6) p(9)];

A2 = diag([p(10) p(11) p(12)]);
A   = [ A1 A2; zeros(3,3) eye(3) ];

B1 = zeros(3,3);
B1(1,1) = p(13); B1(2,1) = p(14); B1(2,2) = p(15);
B1(3,1) = p(16); B1(3,2) = p(17); B1(3,3) = p(18);

B2  = zeros(3,3);
B   = [ B1; B2 ];

C1 = [ones(nTau,1) ...
    (1 - exp(-lambda.* tau)) ./(lambda.* tau) ...
    (1 - exp(-lambda.* tau)) ./(lambda.* tau) - exp(-lambda.* tau)];
C2  = zeros(nTau,3);
C   = [ C1 C2 ];

D   = diag(p(19)*ones(nTau,1));

% ... other assignments
Mean0 = [];
Cov0 = [];
StateType = [0 0 0 1 1 1];

end