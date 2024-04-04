clear
close all
clc

%% Plot takeaway points
Hv = 0:1:15;
tau_new = 1:10:120;
lambda = 0.0609;
ta = 1.64;  % 90% confidence level
spec = 1;
period = 1;

load FLP.mat

F_output = FLP_result.irf_output_smooth(1:Hv(end)+1,:);
F_inf = FLP_result.irf_inf_smooth(1:Hv(end)+1,:);
F_var_output = FLP_result.varbeta_output(1:2,1:2);
F_var_inf = FLP_result.varbeta_inf(1:2,1:2);

%% Varying beta2

d = [0.04   0.00];
TS_diff2 = d(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + d(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * d';
F_var_frechet_inf    = d*F_var_inf*d'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

F_output50 = F_output * d';
F_var_frechet_output    = d*F_var_output*d'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([inf1 inf3],'Functional LPs','Functional LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b2_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b2_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b2_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b2_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b2_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b2_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b2_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b2_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b2_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b2_simp', 'epsc');
end


fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([output1 output3],'Functional LPs','Functional LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b2_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b2_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b2_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b2_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b2_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b2_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b2_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b2_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b2_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b2_simp', 'epsc');
end


%% FIGURE 5: varying b3
d = [0.00   0.04];
TS_diff2 = d(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + d(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * d';
F_var_frechet_inf    = d*F_var_inf*d'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

F_output50 = F_output * d';
F_var_frechet_output    = d*F_var_output*d'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([inf1 inf3],'Functional LPs','Functional LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b3_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b3_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b3_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b3_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b3_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b3_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b3_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b3_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b3_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b3_simp', 'epsc');
end


fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([output1 output3],'Functional LPs','Functional LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b3_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b3_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b3_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b3_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b3_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b3_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b3_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b3_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b3_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b3_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b3_simp', 'epsc');
end


%% FIGURE 6.1: varying b2 and b3
d= [0.02  0.04];
TS_diff2 = d(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + d(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * d';
F_var_frechet_inf    = d*F_var_inf*d'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

F_output50 = F_output * d';
F_var_frechet_output    = d*F_var_output*d'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([inf1 inf3],'Functional LPs','Functional LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b23_2_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b23_2_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b23_2_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b23_2_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b23_2_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b23_2_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b23_2_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b23_2_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b23_2_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b23_2_simp', 'epsc');
end

fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([output1 output3],'Functional LPs','Functional LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b23_2_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b23_2_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b23_2_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b23_2_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b23_2_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b23_2_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b23_2_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b23_2_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b23_2_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b23_2_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b23_2_simp', 'epsc');
end



%% FIGURE 6.2: varying b2 and b3
d= [0.0200   -0.0400];
TS_diff2 = d(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + d(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * d';
F_var_frechet_inf    = d*F_var_inf*d'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

F_output50 = F_output * d';
F_var_frechet_output    = d*F_var_output*d'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([inf1 inf3],'Functional LPs','Functional LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/inf_b23_1_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/inf_b23_1_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/inf_b23_1_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/inf_b23_1_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/inf_b23_1_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/inf_b23_1_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b23_1_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/inf_b23_1_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b23_1_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/inf_b23_1_simp', 'epsc');
end


fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
legend([output1 output3],'Functional LPs','Functional LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,TS_diff2,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(TS_diff2)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
hold off

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_1/takeaway/y_b23_1_simp', 'epsc');
        elseif period == 2
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_2/takeaway/y_b23_1_simp', 'epsc');
        elseif period == 3
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_3/takeaway/y_b23_1_simp', 'epsc');
        elseif period == 4
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_4/takeaway/y_b23_1_simp', 'epsc');
        elseif period == 5
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_5/takeaway/y_b23_1_simp', 'epsc');
        elseif period == 6
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b23_1_simp', 'jpg');
            saveas(fn,'figuresIRFSsmooth/model_6/takeaway/y_b23_1_simp', 'epsc');
        end
    else
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b23_1_simp', 'jpg');
        saveas(fn,'figuresIRFSsmooth/different_lambda/takeaway/y_b23_1_simp', 'epsc');
    end
elseif spec == 2
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b23_1_simp', 'jpg');
    saveas(fn,'figuresIRFSsmooth/exchange_rate/takeaway/y_b23_1_simp', 'epsc');
end



