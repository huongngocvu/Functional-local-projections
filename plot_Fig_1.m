% Plot Figure 1: Factor loadings with lambda = 0.0609

function plot_Fig_1(model)

lambda = model.lambda;
maturities = model.maturities;
X = [ones(size(maturities)) (1 - exp(-lambda*maturities))./(lambda*maturities) ...
    ((1 - exp(-lambda*maturities))./(lambda*maturities) - exp(-lambda*maturities))];

fn = figure;
plot(maturities, X(:,1), 'b');
hold on;
plot(maturities, X(:,2), 'r-*');
plot(maturities, X(:,3), 'k--');
hold off;
% title('Factor Loadings for Diebold Li Model with time factor of .0609')
xlabel('Maturity (months)');
ylabel('Loadings');
ylim([0 1.1]);
legend({'Loading 1','Loading 2','Loading 3'},'location','east');

if lambda == 0.0609
    saveas(fn,'figuresDATA/latex_loadings', 'epsc');
else    % different values of lambda
    saveas(fn,'figuresDATA/different_lambda/latex_loadings', 'epsc');
end

end