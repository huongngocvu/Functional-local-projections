% Plot Figure 4: NZ yield curves on particular days

function plot_Fig_4(model)

fn=figure; 
plot(model.maturities',model.yield_hat(551,:),'b');
hold on
plot(model.maturities',model.Yield(551,:),'b*');
plot(model.maturities',model.yield_hat(1904,:),'r');
plot(model.maturities',model.Yield(1904,:),'r*');
% plot(model.maturities',model.yield_hat(2478,:),'k');
% plot(model.maturities',model.Yield(2478,:),'k*');

xlabel('Maturities (months)'); ylabel('Yield (%)'); 
% lgd = legend('13/3/2014 fitted','13/3/2014 actual','7/8/2019 fitted','7/8/2019 actual','24/11/2021 fitted','24/11/2021 actual','Location','southoutside');
lgd = legend('13/3/2014 fitted','13/3/2014 actual','7/8/2019 fitted','7/8/2019 actual','Location','southoutside');
lgd.FontSize = 9;
lgd.NumColumns = 2;
set(gca,'fontsize',12);

lambda = model.lambda;
if lambda == 0.0609
    saveas(fn,'figuresDATA/latex_yieldcurve', 'epsc');
else    % different values of lambda
    saveas(fn,'figuresDATA/different_lambda/latex_yieldcurve', 'epsc');
end

end
