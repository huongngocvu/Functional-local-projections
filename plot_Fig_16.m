%% Compare functional LPs and standard LPs
clear
close all

% Functional LPs: changes in the entire yield curves around MP announcements
% Standard LPs: changes in 3-month yields around MP announcements only

load FLP.mat
load LP.mat

Hv = 0:1:15;

% %% 3M yield unchanged
% % 10/2012
% F_inf16_1 = FLP_result.irf_inf16_102012;
% F_inf50_1 = FLP_result.irf_inf50_102012;
% F_inf84_1 = FLP_result.irf_inf84_102012;
% 
% F_output16_1 = FLP_result.irf_output16_102012;
% F_output50_1 = FLP_result.irf_output50_102012;
% F_output84_1 = FLP_result.irf_output84_102012;
% 
% inf16_1 = LP_result.irf_inf16_102012;
% inf50_1 = LP_result.irf_inf50_102012;
% inf84_1 = LP_result.irf_inf84_102012;
% 
% output16_1 = LP_result.irf_output16_102012;
% output50_1 = LP_result.irf_output50_102012;
% output84_1 = LP_result.irf_output84_102012;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_1','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_1', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_1' fliplr(F_inf84_1')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_1' fliplr(inf84_1')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_102012','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_1','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_1', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_1' fliplr(F_output84_1')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_1' fliplr(output84_1')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_102012','epsc')
% 
% 
% % 10/2015
% F_inf16_2 = FLP_result.irf_inf16_102015;
% F_inf50_2 = FLP_result.irf_inf50_102015;
% F_inf84_2 = FLP_result.irf_inf84_102015;
% 
% F_output16_2 = FLP_result.irf_output16_102015;
% F_output50_2 = FLP_result.irf_output50_102015;
% F_output84_2 = FLP_result.irf_output84_102015;
% 
% 
% inf16_2 = LP_result.irf_inf16_102015;
% inf50_2 = LP_result.irf_inf50_102015;
% inf84_2 = LP_result.irf_inf84_102015;
% 
% output16_2 = LP_result.irf_output16_102015;
% output50_2 = LP_result.irf_output50_102015;
% output84_2 = LP_result.irf_output84_102015;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_2','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_2', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_2' fliplr(F_inf84_2')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_2' fliplr(inf84_2')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_102015','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_2','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_2', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_2' fliplr(F_output84_2')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_2' fliplr(output84_2')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_102015','epsc')


%% 10Y yield (almost) unchanged
% % 9/2013
% F_inf16_3 = FLP_result.irf_inf16_92013;
% F_inf50_3 = FLP_result.irf_inf50_92013;
% F_inf84_3 = FLP_result.irf_inf84_92013;
% 
% F_output16_3 = FLP_result.irf_output16_92013;
% F_output50_3 = FLP_result.irf_output50_92013;
% F_output84_3 = FLP_result.irf_output84_92013;
% 
% 
% inf16_3 = LP_result.irf_inf16_92013;
% inf50_3 = LP_result.irf_inf50_92013;
% inf84_3 = LP_result.irf_inf84_92013;
% 
% output16_3 = LP_result.irf_output16_92013;
% output50_3 = LP_result.irf_output50_92013;
% output84_3 = LP_result.irf_output84_92013;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_3','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_3', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_3' fliplr(F_inf84_3')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_3' fliplr(inf84_3')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_92013','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_3','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_3', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_3' fliplr(F_output84_3')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_3' fliplr(output84_3')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_92013','epsc')

% 6/2015
F_inf16_4 = FLP_result.irf_inf16_62015;
F_inf50_4 = FLP_result.irf_inf50_62015;
F_inf84_4 = FLP_result.irf_inf84_62015;

F_output16_4 = FLP_result.irf_output16_62015;
F_output50_4 = FLP_result.irf_output50_62015;
F_output84_4 = FLP_result.irf_output84_62015;


inf16_4 = LP_result.irf_inf16_62015;
inf50_4 = LP_result.irf_inf50_62015;
inf84_4 = LP_result.irf_inf84_62015;

output16_4 = LP_result.irf_output16_62015;
output50_4 = LP_result.irf_output50_62015;
output84_4 = LP_result.irf_output84_62015;

fn = figure();
hold on
%grid on
inf1 = plot(Hv ,F_inf50_4','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50_4', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [F_inf16_4' fliplr(F_inf84_4')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16_4' fliplr(inf84_4')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);

% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_62015','epsc')


fn = figure();
hold on
%grid on
output1 = plot(Hv ,F_output50_4','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50_4', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [F_output16_4' fliplr(F_output84_4')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16_4' fliplr(output84_4')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);

% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
saveas(fn,'figuresIRFSsmooth/compareIRFs_output_62015','epsc')


% %% 3M and 10Y yields changed significantly
% % 3/2016
% F_inf16_5 = FLP_result.irf_inf16_32016;
% F_inf50_5 = FLP_result.irf_inf50_32016;
% F_inf84_5 = FLP_result.irf_inf84_32016;
% 
% F_output16_5 = FLP_result.irf_output16_32016;
% F_output50_5 = FLP_result.irf_output50_32016;
% F_output84_5 = FLP_result.irf_output84_32016;
% 
% 
% inf16_5 = LP_result.irf_inf16_32016;
% inf50_5 = LP_result.irf_inf50_32016;
% inf84_5 = LP_result.irf_inf84_32016;
% 
% output16_5 = LP_result.irf_output16_32016;
% output50_5 = LP_result.irf_output50_32016;
% output84_5 = LP_result.irf_output84_32016;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_5','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_5', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_5' fliplr(F_inf84_5')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_5' fliplr(inf84_5')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_32016','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_5','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_5', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_5' fliplr(F_output84_5')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_5' fliplr(output84_5')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_32016','epsc')
% 
% % 8/2019
% F_inf16_6 = FLP_result.irf_inf16_82019;
% F_inf50_6 = FLP_result.irf_inf50_82019;
% F_inf84_6 = FLP_result.irf_inf84_82019;
% 
% F_output16_6 = FLP_result.irf_output16_82019;
% F_output50_6 = FLP_result.irf_output50_82019;
% F_output84_6 = FLP_result.irf_output84_82019;
% 
% 
% inf16_6 = LP_result.irf_inf16_82019;
% inf50_6 = LP_result.irf_inf50_82019;
% inf84_6 = LP_result.irf_inf84_82019;
% 
% output16_6 = LP_result.irf_output16_82019;
% output50_6 = LP_result.irf_output50_82019;
% output84_6 = LP_result.irf_output84_82019;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_6','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_6', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_6' fliplr(F_inf84_6')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_6' fliplr(inf84_6')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_82019','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_6','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_6', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_6' fliplr(F_output84_6')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_6' fliplr(output84_6')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_82019','epsc')

%% Last time pick:
% % 12/2014
% F_inf16_7 = FLP_result.irf_inf16_122014;
% F_inf50_7 = FLP_result.irf_inf50_122014;
% F_inf84_7 = FLP_result.irf_inf84_122014;
% 
% F_output16_7 = FLP_result.irf_output16_122014;
% F_output50_7 = FLP_result.irf_output50_122014;
% F_output84_7 = FLP_result.irf_output84_122014;
% 
% 
% inf16_7 = LP_result.irf_inf16_122014;
% inf50_7 = LP_result.irf_inf50_122014;
% inf84_7 = LP_result.irf_inf84_122014;
% 
% output16_7 = LP_result.irf_output16_122014;
% output50_7 = LP_result.irf_output50_122014;
% output84_7 = LP_result.irf_output84_122014;
% 
% fn = figure();
% hold on
% %grid on
% inf1 = plot(Hv ,F_inf50_7','-r', 'LineWidth' , 2)
% inf2 = plot(Hv, inf50_7', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_inf16_7' fliplr(F_inf84_7')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [inf16_7' fliplr(inf84_7')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Inflation','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_122014','epsc')
% 
% 
% fn = figure();
% hold on
% %grid on
% output1 = plot(Hv ,F_output50_7','-r', 'LineWidth' , 2)
% output2 = plot(Hv, output50_7', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% % fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [F_output16_7' fliplr(F_output84_7')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
% fill([Hv fliplr(Hv)], [output16_7' fliplr(output84_7')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
% title('Output','FontWeight','bold')
% xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% 
% % Add legends for the fill functions
% output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
% output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
% legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','southeast','Box', 'off')
% saveas(fn,'figuresIRFSsmooth/compareIRFs_output_122014','epsc')

% 2/2019
F_inf16_8 = FLP_result.irf_inf16_22019;
F_inf50_8 = FLP_result.irf_inf50_22019;
F_inf84_8 = FLP_result.irf_inf84_22019;

F_output16_8 = FLP_result.irf_output16_22019;
F_output50_8 = FLP_result.irf_output50_22019;
F_output84_8 = FLP_result.irf_output84_22019;


inf16_8 = LP_result.irf_inf16_22019;
inf50_8 = LP_result.irf_inf50_22019;
inf84_8 = LP_result.irf_inf84_22019;

output16_8 = LP_result.irf_output16_22019;
output50_8 = LP_result.irf_output50_22019;
output84_8 = LP_result.irf_output84_22019;

fn = figure();
hold on
%grid on
inf1 = plot(Hv ,F_inf50_8','-r', 'LineWidth' , 2)
inf2 = plot(Hv, inf50_8', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [F_inf16_8' fliplr(F_inf84_8')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [inf16_8' fliplr(inf84_8')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Inflation','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);
% Add legends for the fill functions
inf3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
inf4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([inf1 inf3 inf2 inf4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','best','Box', 'off')
saveas(fn,'figuresIRFSsmooth/compareIRFs_inflation_22019','epsc')


fn = figure();
hold on
%grid on
output1 = plot(Hv ,F_output50_8','-r', 'LineWidth' , 2)
output2 = plot(Hv, output50_8', '-g', 'LineWidth', 2, 'Color', [0 0.8 0])
% fill([Hv fliplr(Hv)], [F_inf16' fliplr(F_inf84')], [0.6 0.6 0.6], 'FaceAlpha', 0.3, 'LineStyle', '--', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [F_output16_8' fliplr(F_output84_8')], [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');%, 'LineStyle', '-.', 'LineWidth', .8);
fill([Hv fliplr(Hv)], [output16_8' fliplr(output84_8')], [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
plot(Hv ,zeros(Hv(end)+1,1), '-k' , 'LineWidth' , 1 )
title('Output','FontWeight','bold')
xlabel('Horizon','FontSize',12); ylabel('Percent (%)','FontSize',12);

% Add legends for the fill functions
output3 = fill(NaN, NaN, [0.8 0.2 0.2], 'FaceAlpha', 0.3,'EdgeColor', 'none');% 'LineStyle', '-.', 'LineWidth', .8);
output4 = fill(NaN, NaN, [0.6 0.9 0.6], 'FaceAlpha', 0.3, 'LineStyle', ':', 'LineWidth', 1.2);
legend([output1 output3 output2 output4],'Functional LPs','Functional LPs 90% C.I.','Standard LPs', 'Standard LPs 90% C.I.', 'Location','northwest','Box', 'off')
saveas(fn,'figuresIRFSsmooth/compareIRFs_output_22019','epsc')