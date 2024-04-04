% Plot Figure 2: NZ yields over time (using data from Reuters)

function plot_Fig_2(model)

% 2D Figure of Reuters yields
fn=figure; 
plot(model.dates,model.Yield);
xlabel('Time'); ylabel('Yield (%)'); 
lgd = legend('3 months','6 months','1 year','2 years','3 years','4 years','5 years','6 years','7 years',...
    '8 years','9 years','10 years','Best');
lgd.FontSize = 9;
lgd.NumColumns = 3;
set(gca,'fontsize',12);

lambda = model.lambda;
if lambda == 0.0609
    saveas(fn,'figuresDATA/latex_yields2D', 'epsc');
else    % different values of lambda
    saveas(fn,'figuresDATA/different_lambda/latex_yields2D', 'epsc');
end


end