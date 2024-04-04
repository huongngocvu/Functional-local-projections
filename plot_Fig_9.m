% Plot Figure 9: The components of monetary policy shocks

function plot_Fig_9(shocks, period, lambda)

fn=figure; 
plot(shocks(:,3),shocks(:,6),'y',shocks(:,3),shocks(:,5),'b --',shocks(:,3),shocks(:,4),'m','LineWidth',2); 
legend({'\Delta\beta_3_t','\Delta\beta_2_t','\Delta\beta_1_t'},'FontSize',10,'FontWeight','bold','Location','Best'); 
xlabel('Time'); axis tight;
set(gca,'fontsize',12);
% ylim([-0.5 2]);

if lambda == 0.0609
    if period == 1
        saveas(fn,'figuresDATA/ShockBeta_latex_1', 'epsc');
    elseif period == 2
        saveas(fn,'figuresDATA/ShockBeta_latex_2', 'epsc');
    elseif period == 3
        saveas(fn,'figuresDATA/ShockBeta_latex_3', 'epsc');
    elseif period == 4
        saveas(fn,'figuresDATA/ShockBeta_latex_4', 'epsc');
    elseif period == 5
        saveas(fn,'figuresDATA/ShockBeta_latex_5', 'epsc');
    elseif period == 6
        saveas(fn,'figuresDATA/ShockBeta_latex_6', 'epsc');
    end
else
    saveas(fn,'figuresDATA/different_lambda/ShockBeta_latex', 'epsc');
end

end