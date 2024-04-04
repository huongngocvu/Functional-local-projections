% Run Diebold-Li estimation using a data set

function output = run_model(period, lambda)

output.period = period;
output.lambda = lambda;

dataOutput = create_data(period);
data = dataOutput.data;
output.dates = dataOutput.dates;
output.maturities = dataOutput.maturities;

output.Yield = data(:,4:end);
output.TimeV = data(:,1:3);

[output.beta_hat, ~, ~, output.b_hat, output.yield_hat] = DieboldLiEstimation(output.Yield, output.maturities, output.lambda);

output.R2 = compute_R2(output.Yield, output.yield_hat);

output.MPdates = dataOutput.MPdates;
output.conven_dates = dataOutput.conven_dates;
output.unconv_dates = dataOutput.unconv_dates;

end