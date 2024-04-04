% Plot Figure 5: The estimated Nelson-Siegel factors

function plot_Fig_5(model)

fn = figure;
plot(model.dates, model.beta_hat(:,1));
hold on;
plot(model.dates, model.beta_hat(:,2));
plot(model.dates, model.beta_hat(:,3));
hold off;
datetick('x','mmm-yy');
legend('Level factor','Slope factor','Curvature factor');
xlabel('Time'); ylabel('Factors');
set(gca,'fontsize',12);

lambda = model.lambda;
if lambda == 0.0609
    saveas(fn,'figuresDATA/latex_factors', 'epsc');
else    % different values of lambda
    saveas(fn,'figuresDATA/different_lambda/latex_factors', 'epsc');
end

end