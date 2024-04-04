%% Compare functional LPs and standard LPs
clear
close all

% Functional LPs: changes in the entire yield curves around MP announcements
% Standard LPs: changes in 3-month yields around MP announcements only

load FLP.mat
load LP.mat

Hv = 0:1:15;
tau_new = 1:10:120;
lambda = 0.0609;
ta = 1.64;  % 90% confidence level

F_output = FLP_result.irf_output_smooth(1:Hv(end)+1,:);
F_inf = FLP_result.irf_inf_smooth(1:Hv(end)+1,:);
F_var_output = FLP_result.varbeta_output(1:2,1:2);
F_var_inf = FLP_result.varbeta_inf(1:2,1:2);

output = LP_result.irf_output_smooth(1:Hv(end)+1,:);
inf = LP_result.irf_inf_smooth(1:Hv(end)+1,:);
var_output = LP_result.varbeta_output(1,1);
var_inf = LP_result.varbeta_inf(1,1);

%% 1-std MP shock
shock = std(LP_result.MPshock);

inf50 = inf * shock;
var_frechet_inf    = shock*var_inf*shock; 
inf16 = [0; inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
inf84 = [0; inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

output50 = output * shock;
var_frechet_output    = shock*var_output*shock; 
output16 = [0; output50(2:end,:)-ta*sqrt(var_frechet_output)];
output84 = [0; output50(2:end,:)+ta*sqrt(var_frechet_output)];

fn = figure();
hold on
inf2 = plot(Hv, inf50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [inf16' fliplr(inf84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf2 inf4],'Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/inf_fitted_1std','epsc')

fn = figure();
hold on
output2 = plot(Hv, output50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [output16' fliplr(output84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output2 output4],'Standard LPs', 'Standard LPs 90% C.I.', 'Location','northwest','Box', 'off')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/output_fitted_1std','epsc')


%% Varying beta2
shock = [0.04   0.00];
YC_diff = shock(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + shock(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * shock';
F_var_frechet_inf    = shock*F_var_inf*shock'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

inf50 = inf * YC_diff(1);
var_frechet_inf    = YC_diff(1)*var_inf*YC_diff(1); 
inf16 = [0; inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
inf84 = [0; inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

F_output50 = F_output * shock';
F_var_frechet_output    = shock*F_var_output*shock'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

output50 = output * YC_diff(1);
var_frechet_output    = YC_diff(1)*var_output*YC_diff(1); 
output16 = [0; output50(2:end,:)-ta*sqrt(var_frechet_output)];
output84 = [0; output50(2:end,:)+ta*sqrt(var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16' fliplr(inf84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_inf_b2','epsc')

fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16' fliplr(output84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_y_b2','epsc')


%% Varying beta3
shock = [0.00   0.04];
YC_diff = shock(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + shock(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * shock';
F_var_frechet_inf    = shock*F_var_inf*shock'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

inf50 = inf * YC_diff(1);
var_frechet_inf    = YC_diff(1)*var_inf*YC_diff(1); 
inf16 = [0; inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
inf84 = [0; inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

F_output50 = F_output * shock';
F_var_frechet_output    = shock*F_var_output*shock'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

output50 = output * YC_diff(1);
var_frechet_output    = YC_diff(1)*var_output*YC_diff(1); 
output16 = [0; output50(2:end,:)-ta*sqrt(var_frechet_output)];
output84 = [0; output50(2:end,:)+ta*sqrt(var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16' fliplr(inf84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_inf_b3','epsc')

fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16' fliplr(output84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_y_b3','epsc')


%% Varying beta2 and beta3: same sign
shock = [0.02   0.04];
YC_diff = shock(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + shock(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * shock';
F_var_frechet_inf    = shock*F_var_inf*shock'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

inf50 = inf * YC_diff(1);
var_frechet_inf    = YC_diff(1)*var_inf*YC_diff(1); 
inf16 = [0; inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
inf84 = [0; inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

F_output50 = F_output * shock';
F_var_frechet_output    = shock*F_var_output*shock'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

output50 = output * YC_diff(1);
var_frechet_output    = YC_diff(1)*var_output*YC_diff(1); 
output16 = [0; output50(2:end,:)-ta*sqrt(var_frechet_output)];
output84 = [0; output50(2:end,:)+ta*sqrt(var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16' fliplr(inf84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_inf_b23_2','epsc')

fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16' fliplr(output84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_y_b23_2','epsc')


%% Varying beta2 and beta3: different sign
shock = [0.02   -0.04];
YC_diff = shock(1)*(1-exp(-lambda*tau_new))./(lambda*tau_new) + shock(2)*((1-exp(-lambda*tau_new))./(lambda*tau_new)-exp(-lambda*tau_new));

F_inf50 = F_inf * shock';
F_var_frechet_inf    = shock*F_var_inf*shock'; 
F_inf16 = [0; F_inf50(2:end,:)-ta*sqrt(F_var_frechet_inf)];
F_inf84 = [0; F_inf50(2:end,:)+ta*sqrt(F_var_frechet_inf)];

inf50 = inf * YC_diff(1);
var_frechet_inf    = YC_diff(1)*var_inf*YC_diff(1); 
inf16 = [0; inf50(2:end,:)-ta*sqrt(var_frechet_inf)];
inf84 = [0; inf50(2:end,:)+ta*sqrt(var_frechet_inf)];

F_output50 = F_output * shock';
F_var_frechet_output    = shock*F_var_output*shock'; 
F_output16 = [0; F_output50(2:end,:)-ta*sqrt(F_var_frechet_output)];
F_output84 = [0; F_output50(2:end,:)+ta*sqrt(F_var_frechet_output)];

output50 = output * YC_diff(1);
var_frechet_output    = YC_diff(1)*var_output*YC_diff(1); 
output16 = [0; output50(2:end,:)-ta*sqrt(var_frechet_output)];
output84 = [0; output50(2:end,:)+ta*sqrt(var_frechet_output)];

fn = figure();
subplot(1,2,1);
hold on
inf1 = plot(Hv ,F_inf50','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16' fliplr(inf84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_inf_b23_1','epsc')

fn = figure();
subplot(1,2,1);
hold on
output1 = plot(Hv ,F_output50','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
fill([Hv fliplr(Hv)], [F_output16' fliplr(F_output84')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16' fliplr(output84')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
ylim([-0.5 0.5])
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')

subplot(1,2,2); 
plot(tau_new,YC_diff,':r','LineWidth',3); axis tight; hold on; 
plot(tau_new ,zeros(size(YC_diff)), '-k' , 'LineWidth' , 1 )
legend('Changes in yield curve','Location','southeast')
xlabel('Maturity','FontSize',12); ylabel('Percent','FontSize',12);
ylim([-0.05 0.05])
title('Yield curve','FontWeight','bold')
saveas(fn,'figuresIRFSsmooth/standardLP/takeaway/S_y_b23_1','epsc')
