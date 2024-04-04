% Functional local projections

function FLP_result = Functional_local_projection(Y, X, horizon, lag, spec, select_beta, lambda, period)

% There are two model specifications to choose:
% spec = 1: X includes shocks; lags of inflation and output
% spec = 2: X includes shocks; lags of inflation and output; macro variables (exchange rates)
% lag: number of lags (either 0, 1, 2, 3, or 4)
% horizon: number of horizons
% select_beta is to select a subset of the betas: for betas use [5,6] to get beta2 and beta3, for yields use [4,6,9] -- important, it has to be a row vector

H = horizon; % h = 1, 2, ..., H
nbeta = size(select_beta,2);

shock = X.shock;
shockhere = shock(:,select_beta);

betabeforeV=X.betabeforeV;
betaafterV =X.betaafterV;

irf_inf = [];
irf_output = [];

% Notations:
% h=1, lag=1: y_(t+1) = a1*x_(t+1) + b1*x_t (from t=1)
% h=2, lag=1: y_(t+2) = a2*x_(t+1) + b2*x_t (from t=2, lose 1 row of data)
% ...
% h=H, lag=1: y_(t+H) = aH*x_(t+1) + bH*x_t (from t=H, lose H-1 rows of data)

% h=1, lag=2: y_(t+1) = a1*x_(t+2) + b1*x_(t+1) + c1*x_t (from t=1)
% h=2, lag=2: y_(t+2) = a1*x_(t+2) + b1*x_(t+1) + c1*x_t (from t=2, lose 1 row of data)
% ...
% h=H, lag=2: y_(t+H) = aH*x_(t+2) + bH*x_(t+1) + cH*x_t (from t=H, lose H-1 rows of data)

for h=2:H       % run from h=2 because effect of MP shocks = 0 at h=1 (no contemporaneous effect)
    if spec == 1
        if lag == 0
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 1
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 2
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 3
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),shockhere(lag-1:end-h-2,:),Y(lag-1:end-h-2,1:2),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 4
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),shockhere(lag-1:end-h-2,:),Y(lag-1:end-h-2,1:2),shockhere(lag-2:end-h-3,:),Y(lag-2:end-h-3,1:2),ones(size(shockhere(h+lag+1:end,:),1),1)];
        end
    elseif spec == 2
        exr = X.exchange_rate(158:253); %31/1/2012 - 31/12/2019
        if lag == 1
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),exr(lag+2:end-h+1),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 2
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),exr(lag+2:end-h+1),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 3
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),shockhere(lag-1:end-h-2,:),Y(lag-1:end-h-2,1:2),exr(lag+2:end-h+1),ones(size(shockhere(h+lag+1:end,:),1),1)];
        elseif lag == 4
            RHS = [shockhere(lag+2:end-h+1,:),Y(lag+2:end-h+1,1:2),shockhere(lag+1:end-h,:),Y(lag+1:end-h,1:2),shockhere(lag:end-h-1,:),Y(lag:end-h-1,1:2),shockhere(lag-1:end-h-2,:),Y(lag-1:end-h-2,1:2),shockhere(lag-2:end-h-3,:),Y(lag-2:end-h-3,1:2),exr(lag+2:end-h+1),ones(size(shockhere(h+lag+1:end,:),1),1)];
        end
    end
    LHS = Y(h+lag+1:end,:);
    IRFinfhere = olsbeta(LHS(:,1), RHS);
    ehat = olsres(LHS(:,1), RHS);
    irf_inf = [irf_inf; IRFinfhere(1:nbeta)];
    qn = 2;
    varbeta_inf = olsvarbetanw(LHS(:,1), RHS, qn);

    IRFoutputhere = olsbeta(LHS(:,2), RHS);
    varbeta_output = olsvarbetanw(LHS(:,2), RHS,qn);
    irf_output = [irf_output; IRFoutputhere(1:nbeta)];
end

% Impose impact = 0: Inf and output are not contemporaneously affected by MP shocks
irf_inf = [irf_inf(1,:).*0; irf_inf(1:end,:)];  % = 0 at h=1
irf_output = [irf_output(1,:).*0; irf_output(1:end,:)];

% Smooth the IRFs by imposing that irf is function of horizon (i.e. fitting a fourth-oder polynomial to irf across horizon)
% irf = b1*horizon + b2*horizon^2 + b3*horion^3 + b4*horizon^4: Estimate this model by OLS and report irf_hat
irf_inf_smooth = smoothT4(irf_inf);
irf_output_smooth = smoothT4(irf_output);

FLP_result.irf_inf_smooth = irf_inf_smooth;
FLP_result.irf_output_smooth = irf_output_smooth;
FLP_result.varbeta_inf = varbeta_inf;
FLP_result.varbeta_output = varbeta_output;

for tt = 1:size(shock,1)
    if sum(abs(shock(tt,4:6)))<eps
        continue
    end

    % Compute the effect of beta2 and beta3 on inflation and output
    irf_inf50    = irf_inf_smooth * shock(tt,select_beta)';
    irf_output50 = irf_output_smooth * shock(tt,select_beta)';

    % Confidence bands
    ta = 1.64;    % 90% (Inoue&Rossi said they report 68% confidence bands)
    % ta = 1;    % 68%

    var_frechet_inf       = shock(tt,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(tt,select_beta)'; %IRF_inf1(floor(0.05*B)+1,:);
    irf_inf16    = [0; irf_inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
    irf_inf84    = [0; irf_inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

    var_frechet_output    = shock(tt,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(tt,select_beta)'; %IRF_inf1(floor(0.05*B)+1,:);
    irf_output16 = [0; irf_output50(2:end,:)-ta*sqrt(var_frechet_output)];
    irf_output84 = [0; irf_output50(2:end,:)+ta*sqrt(var_frechet_output)];

    % Decomposition
    decomp_inf     = bsxfun(@times,irf_inf_smooth,shock(tt,select_beta)); %%max(max(decomp_inf-decomp_inf1)), sdfsdf
    decomp_output  = bsxfun(@times,irf_output_smooth,shock(tt,select_beta)); %%%max(max(decomp_output-decomp_output1)), sdfsdf

    plot_IRFs
   
end
% close all


% % 3M yield unchanged
% % For plotting (Functional LPs vs standard LPs) 10/2012 (tt=10): 10-year yields increased (+0.02%)
% irf_inf50_102012 = irf_inf_smooth*shock(10,select_beta)';
% var_frechet_inf_102012       = shock(10,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(10,select_beta)'; 
% irf_inf16_102012    = [0; irf_inf50_102012(2:end)-ta*sqrt(var_frechet_inf_102012)];
% irf_inf84_102012    = [0; irf_inf50_102012(2:end)+ta*sqrt(var_frechet_inf_102012)];
% FLP_result.irf_inf50_102012 = irf_inf50_102012;    
% FLP_result.irf_inf16_102012 = irf_inf16_102012;
% FLP_result.irf_inf84_102012 = irf_inf84_102012;
% 
% irf_output50_102012 = irf_output_smooth*shock(10,select_beta)';
% var_frechet_output_102012    = shock(10,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(10,select_beta)'; 
% irf_output16_102012 = [0; irf_output50_102012(2:end)-ta*sqrt(var_frechet_output_102012)];
% irf_output84_102012 = [0; irf_output50_102012(2:end)+ta*sqrt(var_frechet_output_102012)];
% FLP_result.irf_output50_102012 = irf_output50_102012;
% FLP_result.irf_output16_102012 = irf_output16_102012;
% FLP_result.irf_output84_102012 = irf_output84_102012;
% 
% % For plotting (Functional LPs vs standard LPs) 10/2015 (tt=46): 10-year yields decreased (-0.01%)
% irf_inf50_102015 = irf_inf_smooth*shock(46,select_beta)';
% var_frechet_inf_102015       = shock(46,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(46,select_beta)'; 
% irf_inf16_102015    = [0; irf_inf50_102015(2:end)-ta*sqrt(var_frechet_inf_102015)];
% irf_inf84_102015    = [0; irf_inf50_102015(2:end)+ta*sqrt(var_frechet_inf_102015)];
% FLP_result.irf_inf50_102015 = irf_inf50_102015;    
% FLP_result.irf_inf16_102015 = irf_inf16_102015;
% FLP_result.irf_inf84_102015 = irf_inf84_102015;
% 
% irf_output50_102015 = irf_output_smooth*shock(46,select_beta)';
% var_frechet_output_102015    = shock(46,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(46,select_beta)'; 
% irf_output16_102015 = [0; irf_output50_102015(2:end)-ta*sqrt(var_frechet_output_102015)];
% irf_output84_102015 = [0; irf_output50_102015(2:end)+ta*sqrt(var_frechet_output_102015)];
% FLP_result.irf_output50_102015 = irf_output50_102015;
% FLP_result.irf_output16_102015 = irf_output16_102015;
% FLP_result.irf_output84_102015 = irf_output84_102015;


% % 10Y yield (almost) unchanged
% % For plotting (Functional LPs vs standard LPs) 9/2013 (tt=21): decrease in 3-month yields (-0.01%), 10-year yields changed little (-0.003%)
% irf_inf50_92013 = irf_inf_smooth*shock(21,select_beta)';
% var_frechet_inf_92013       = shock(21,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(21,select_beta)'; 
% irf_inf16_92013    = [0; irf_inf50_92013(2:end)-ta*sqrt(var_frechet_inf_92013)];
% irf_inf84_92013    = [0; irf_inf50_92013(2:end)+ta*sqrt(var_frechet_inf_92013)];
% FLP_result.irf_inf50_92013 = irf_inf50_92013;    
% FLP_result.irf_inf16_92013 = irf_inf16_92013;
% FLP_result.irf_inf84_92013 = irf_inf84_92013;
% 
% irf_output50_92013 = irf_output_smooth*shock(21,select_beta)';
% var_frechet_output_92013    = shock(21,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(21,select_beta)'; 
% irf_output16_92013 = [0; irf_output50_92013(2:end)-ta*sqrt(var_frechet_output_92013)];
% irf_output84_92013 = [0; irf_output50_92013(2:end)+ta*sqrt(var_frechet_output_92013)];
% FLP_result.irf_output50_92013 = irf_output50_92013;
% FLP_result.irf_output16_92013 = irf_output16_92013;
% FLP_result.irf_output84_92013 = irf_output84_92013;

% For plotting (Functional LPs vs standard LPs) 6/2015 (tt=42): decrease in 3-month yields (-0.08%), 10-year yields changed little (-0.004%)
irf_inf50_62015 = irf_inf_smooth*shock(42,select_beta)';
var_frechet_inf_62015       = shock(42,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(42,select_beta)'; 
irf_inf16_62015    = [0; irf_inf50_62015(2:end)-ta*sqrt(var_frechet_inf_62015)];
irf_inf84_62015    = [0; irf_inf50_62015(2:end)+ta*sqrt(var_frechet_inf_62015)];
FLP_result.irf_inf50_62015 = irf_inf50_62015;    
FLP_result.irf_inf16_62015 = irf_inf16_62015;
FLP_result.irf_inf84_62015 = irf_inf84_62015;

irf_output50_62015 = irf_output_smooth*shock(42,select_beta)';
var_frechet_output_62015    = shock(42,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(42,select_beta)'; 
irf_output16_62015 = [0; irf_output50_62015(2:end)-ta*sqrt(var_frechet_output_62015)];
irf_output84_62015 = [0; irf_output50_62015(2:end)+ta*sqrt(var_frechet_output_62015)];
FLP_result.irf_output50_62015 = irf_output50_62015;
FLP_result.irf_output16_62015 = irf_output16_62015;
FLP_result.irf_output84_62015 = irf_output84_62015;

% % 3M and 10Y yields changed significantly
% % For plotting (Functional LPs vs standard LPs) 3/2016 (tt=51): 3-month yields (-0.1%), 10-year yields (-0.1%)
% irf_inf50_32016 = irf_inf_smooth*shock(51,select_beta)';
% var_frechet_inf_32016       = shock(51,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(51,select_beta)'; 
% irf_inf16_32016    = [0; irf_inf50_32016(2:end)-ta*sqrt(var_frechet_inf_32016)];
% irf_inf84_32016    = [0; irf_inf50_32016(2:end)+ta*sqrt(var_frechet_inf_32016)];
% FLP_result.irf_inf50_32016 = irf_inf50_32016;    
% FLP_result.irf_inf16_32016 = irf_inf16_32016;
% FLP_result.irf_inf84_32016 = irf_inf84_32016;
% 
% irf_output50_32016 = irf_output_smooth*shock(51,select_beta)';
% var_frechet_output_32016    = shock(51,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(51,select_beta)'; 
% irf_output16_32016 = [0; irf_output50_32016(2:end)-ta*sqrt(var_frechet_output_32016)];
% irf_output84_32016 = [0; irf_output50_32016(2:end)+ta*sqrt(var_frechet_output_32016)];
% FLP_result.irf_output50_32016 = irf_output50_32016;
% FLP_result.irf_output16_32016 = irf_output16_32016;
% FLP_result.irf_output84_32016 = irf_output84_32016;
% 
% % For plotting (Functional LPs vs standard LPs) 8/2019 (tt=92): 3-month yields (-0.12%), 10-year yields (-0.14%)
% irf_inf50_82019 = irf_inf_smooth*shock(92,select_beta)';
% var_frechet_inf_82019       = shock(92,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(92,select_beta)'; 
% irf_inf16_82019    = [0; irf_inf50_82019(2:end)-ta*sqrt(var_frechet_inf_82019)];
% irf_inf84_82019    = [0; irf_inf50_82019(2:end)+ta*sqrt(var_frechet_inf_82019)];
% FLP_result.irf_inf50_82019 = irf_inf50_82019;    
% FLP_result.irf_inf16_82019 = irf_inf16_82019;
% FLP_result.irf_inf84_82019 = irf_inf84_82019;
% 
% irf_output50_82019 = irf_output_smooth*shock(92,select_beta)';
% var_frechet_output_82019    = shock(92,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(92,select_beta)'; 
% irf_output16_82019 = [0; irf_output50_82019(2:end)-ta*sqrt(var_frechet_output_82019)];
% irf_output84_82019 = [0; irf_output50_82019(2:end)+ta*sqrt(var_frechet_output_82019)];
% FLP_result.irf_output50_82019 = irf_output50_82019;
% FLP_result.irf_output16_82019 = irf_output16_82019;
% FLP_result.irf_output84_82019 = irf_output84_82019;


% % Last time pick:
% % For plotting (Functional LPs vs standard LPs) 11/12/2014 (tt=36): 3-month zero-coupon yields almost unchanged
% irf_inf50_122014 = irf_inf_smooth * shock(36,select_beta)';
% var_frechet_inf_122014       = shock(36,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(36,select_beta)'; 
% irf_inf16_122014    = [0; irf_inf50_122014(2:end)-ta*sqrt(var_frechet_inf_122014)];
% irf_inf84_122014    = [0; irf_inf50_122014(2:end)+ta*sqrt(var_frechet_inf_122014)];
% FLP_result.irf_inf50_122014 = irf_inf50_122014;    
% FLP_result.irf_inf16_122014 = irf_inf16_122014;
% FLP_result.irf_inf84_122014 = irf_inf84_122014;
% 
% irf_output50_122014 = irf_output_smooth * shock(36,select_beta)';
% var_frechet_output_122014    = shock(36,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(36,select_beta)';
% irf_output16_122014 = [0; irf_output50_122014(2:end)-ta*sqrt(var_frechet_output_122014)];
% irf_output84_122014 = [0; irf_output50_122014(2:end)+ta*sqrt(var_frechet_output_122014)];
% FLP_result.irf_output50_122014 = irf_output50_122014;
% FLP_result.irf_output16_122014 = irf_output16_122014;
% FLP_result.irf_output84_122014 = irf_output84_122014;

% For plotting (Functional LPs vs standard LPs) 13/2/2019 (tt=86): 3-month zero-coupon yields slightly increased
irf_inf50_22019 = irf_inf_smooth * shock(86,select_beta)';
var_frechet_inf_22019       = shock(86,select_beta)*varbeta_inf(1:nbeta,1:nbeta)*shock(86,select_beta)'; 
irf_inf16_22019    = [0; irf_inf50_22019(2:end)-ta*sqrt(var_frechet_inf_22019)];
irf_inf84_22019    = [0; irf_inf50_22019(2:end)+ta*sqrt(var_frechet_inf_22019)];
FLP_result.irf_inf50_22019 = irf_inf50_22019;    
FLP_result.irf_inf16_22019 = irf_inf16_22019;
FLP_result.irf_inf84_22019 = irf_inf84_22019;

irf_output50_22019 = irf_output_smooth * shock(86,select_beta)';
var_frechet_output_22019    = shock(86,select_beta)*varbeta_output(1:nbeta,1:nbeta)*shock(86,select_beta)';
irf_output16_22019 = [0; irf_output50_22019(2:end)-ta*sqrt(var_frechet_output_22019)];
irf_output84_22019 = [0; irf_output50_22019(2:end)+ta*sqrt(var_frechet_output_22019)];
FLP_result.irf_output50_22019 = irf_output50_22019;
FLP_result.irf_output16_22019 = irf_output16_22019;
FLP_result.irf_output84_22019 = irf_output84_22019;


% plot_takeaways

end
