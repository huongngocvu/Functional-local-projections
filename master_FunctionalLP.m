clear
close all
clc

% Codes to replicate all results of Kirkby and Vu (2024)

%% Get the data and create Diebold-Li estimates

% There are 6 datasets used in the paper

% period = 1:   Zero yields include 3M, 6M, 1Y to 10Y from 3/1/2012 - 31/12/2019     (no pandemic)  BASELINE FOR IRFS
% period = 2:   Zero yields include 3M, 6M, 1Y to 10Y from 3/1/2012 - 31/12/2021     (pandemic)     BASELINE FOR MP SHOCK
% period = 3:   Zero yields include 3M, 1Y to 10Y     from 14/10/2010 - 31/12/2019   (no pandemic)
% period = 4:   Zero yields include 3M, 1Y to 10Y     from 14/10/2010 - 31/12/2021   (pandemic)
% period = 5:   Zero yields include 1Y to 10Y         from 5/1/1999 - 31/12/2019     (no pandemic)
% period = 6:   Zero yields include 1Y to 10Y         from 5/1/1999 - 31/12/2021     (pandemic)

doYieldCurveEstimation = 0;
period = 1;
lambda = 0.0609;

if doYieldCurveEstimation==1
    model = run_model(period,lambda);   % Dataset from Refinitiv is not provided
else
    load NSmodel_results.mat  % Journal version
end

%% Plotting

plot_Fig_1(model) % Plot the loadings of 3 factors
plot_Fig_2(model) % Plot the NZ yields over time (2D)
plot_Fig_3(model) % Plot the NZ term structure (3D)
plot_Fig_4(model) % Plot NZ yield curves on particular days
plot_Fig_5(model) % Plot the estimated NS factors

%% MP shocks as changes in yield curves

window_time = 1; % 1 for 1-day window; 2 for 2-day window

% Plot Figure 6, 7, and 8
plot_YCchanges_MPshocks(model, window_time, model.conven_dates, 1)   % Conventional MP period

if (period == 2) || (period == 4) || (period == 6)  % pandemic    
    plot_YCchanges_MPshocks(model, window_time, model.unconv_dates, 2)   % Unonventional MP period
end

% Compute the monetary policy shocks
result = compute_deltabetas(model, window_time); 
MPshocks = result.shock;

% Plot Figure 9 and 10
plot_Fig_9(MPshocks, period, lambda)
plot_Fig_10(MPshocks, period, lambda)


%% IRFs

% Model: Y ~ X 
% Y includes inflation and output
% X includes shocks and controls

Y = create_data_Y(period);

X = create_data_X(model, result);

% Plot IRFs
% There are two model specifications to choose:
% spec = 1: X includes shocks; lags of inflation and output
% spec = 2: X includes shocks; lags of inflation and output; macro variables (exchange rates)

horizon = 16;
lag = 2;
spec = 1;
select_beta = [5 6];

doFunctionalLP = 0;

if doFunctionalLP==1
    FLP_result = Functional_local_projection(Y, X, horizon, lag, spec, select_beta, lambda, period);
    close all
    plot_takeaways_simplified
else    % do Standard LP
    yields_change = calculateMPshocks_yieldData(model, window_time);
    X.shock_fitted = yields_change.fitted;
    X.shock_actual = yields_change.actual;
    select_yields = 1; % = 1: compute MP shocks from fitted yields; = 2: compute MP shocks from actual yields (Section 4 uses fitted yields. Appendix reports actual yields)
    
    LP_result = Standard_local_projection(Y, X, horizon, lag, spec, lambda, select_yields);
    close all
    plot_Fig_16
    plot_Fig_18
end
