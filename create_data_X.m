% Create data for X (includes shocks and controls)

function X = create_data_X(model, shocks_result)

% shocks_result: results from compute_deltabetas

X.shock = shocks_result.shock;
X.betabeforeV = shocks_result.betabeforeV;
X.betaafterV = shocks_result.betaafterV;  

period = model.period;
MPdates = model.MPdates;

if period == 5
    X.conven_dates = MPdates(39:end,:);   % time starts at 1/10/2003 (as NZAC starts at 2003)
    X.shock = X.shock(58:end,:);
elseif period == 6
    MPdates = MPdates(39:end,:);
    X.conven_dates = MPdates(1:127,:); % time starts at 1/10/2003 (1-10y) (sample 1 for IRFs)
    X.unconv_dates = MPdates(128:end,:);
    X.shock = X.shock(58:end,:);
end

% Exchange rate data
data = readtable('hb1-monthly.xlsx','Sheet',1);
X.exchange_rate = data.Exchange_rates;

end

