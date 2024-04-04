% Plot Figure 10: Linear combinations of the components of MP shocks

function plot_Fig_10(shocks, period, lambda)

fn=figure;  
plot(shocks(:,3),shocks(:,6)-shocks(:,4),'b:','LineWidth',2); hold on;
plot(shocks(:,3),shocks(:,5)+shocks(:,4),'m','LineWidth',2); 
xlabel('Time'); axis tight; hold off; 
% ylim([-0.5 2]);
set(gca,'fontsize',12);
legend({'\Delta(\beta_3_t-\beta_1_t)','\Delta(\beta_1_t+\beta_2_t)'},'FontSize',10,'FontWeight','bold','Location','Best'); 

if lambda == 0.0609
    if period == 1
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_1', 'epsc');
    elseif period == 2
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_2', 'epsc');
    elseif period == 3
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_3', 'epsc');
    elseif period == 4
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_4', 'epsc');
    elseif period == 5
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_5', 'epsc');
    elseif period == 6
        saveas(fn,'figuresDATA/ShockBetaLinComb_latex_6', 'epsc');
    end
else
    saveas(fn,'figuresDATA/different_lambda/ShockBetaLinComb_latex', 'epsc');
end

end