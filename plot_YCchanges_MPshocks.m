% Plot changes in yield curves and monetary policy shocks

function plot_YCchanges_MPshocks(model, window, mpdates, mptype)

% Inputs: model (chose from different time periods and values of lambda)
%         window (1 for 1-day window; 2 for 2-day window)
%         mpdates (dates of MP announcements)
%         mptype (1 for conventional; 2 for unconventional)

%% Plot changes in yield curves (on and after EVERY monetary policy announcements)
% Plot Figure 6 and Figure 7

betaT=[model.TimeV,model.beta_hat,cumsum(ones(size(model.beta_hat,1),1))];
year = model.TimeV(:,1);
month = model.TimeV(:,2);
day = model.TimeV(:,3);
Yield = model.yield_hat;
maturities = model.maturities;
lambda = model.lambda;
period = model.period;

plotMPshock=[]; jj=1; betamp=[];
for mdays=1:size(mpdates,1)
    a1=find(year==mpdates(mdays,1));
    a2=find(month==mpdates(mdays,2));
    aa1=intersect(a1,a2); 
    a3=find(day==mpdates(mdays,3));
    ttt=intersect(aa1,a3);
    fn=figure('visible','off'); 
    result_before=plot_ttt(betaT,Yield,maturities,lambda,ttt-1); hold on;
    result_after=plot_ttt2(betaT,Yield,maturities,lambda,ttt+window-1); hold off;     

    str=[num2str(day(ttt)),'/',num2str(month(ttt)),'/',num2str(year(ttt))];
    title(str,'FontSize',12); xlabel('Maturity','FontSize',12); 
    lgd=legend('Raw Yield Before','Fitted Yield Before','Raw Yield After','Fitted Yield After','Location','Best'); 
    lgd.FontSize = 12;
    ylabel('Yield (%)','FontSize',12);
    hold off;
    %Save figure
    if mptype == 1
        if period == 1
            saveas(fn,strcat('figuresMPSHOCK/model_1/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 2 
            saveas(fn,strcat('figuresMPSHOCK/model_2/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 3 
            saveas(fn,strcat('figuresMPSHOCK/model_3/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 4 
            saveas(fn,strcat('figuresMPSHOCK/model_4/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 5 
            saveas(fn,strcat('figuresMPSHOCK/model_5/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 6 
            saveas(fn,strcat('figuresMPSHOCK/model_6/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        else 
            saveas(fn,strcat('figuresMPSHOCK/others/conventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        end
    elseif mptype == 2
        if period == 1
            saveas(fn,strcat('figuresMPSHOCK/model_1/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 2
            saveas(fn,strcat('figuresMPSHOCK/model_2/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 3
            saveas(fn,strcat('figuresMPSHOCK/model_3/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 4
            saveas(fn,strcat('figuresMPSHOCK/model_4/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 5
            saveas(fn,strcat('figuresMPSHOCK/model_5/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        elseif period == 6
            saveas(fn,strcat('figuresMPSHOCK/model_6/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        else
            saveas(fn,strcat('figuresMPSHOCK/others/unconventional/TSchangeon',num2str(mpdates(mdays,1)),num2str(mpdates(mdays,2)),num2str(mpdates(mdays,3))), 'epsc')
        end
    end        
    
    %pause;
    %Save data for tables
    plotMPshock=[plotMPshock; jj,mdays,mpdates(mdays,[3,2,1]), result_after.TS-result_before.TS]; 
    betamp=[betamp; mpdates(mdays,[3,2,1]), result_after.beta-result_before.beta];
    jj=jj+1;
end

%%  Plot MP shocks as a function of maturitites (at PARTICULAR days)
% Plot Figure 8a and Figure 8b

tau=1:1:120;  % maturities
if mptype == 1

    if period == 1 || 2 % time starts at 3/1/2012
        fn=figure; plot(tau,plotMPshock(2,6:end),'LineWidth',2); hold on;
        plot(tau,plotMPshock(18,6:end),'r','LineWidth',2);
        plot(tau,plotMPshock(21,6:end),'k','LineWidth',2);
        plot(tau,plotMPshock(29,6:end),'b--','LineWidth',2);
        plot(tau,plotMPshock(34,6:end),'m','LineWidth',2);
        plot(tau,plotMPshock(56,6:end),'r--','LineWidth',2);
        plot(tau,plotMPshock(58,6:end),'k--','LineWidth',2);
        plot(tau,plotMPshock(37,6:end),'m--','LineWidth',2);
        plot(tau,plotMPshock(39,6:end),'c-.','LineWidth',2);
        hold off;
        set(gca,'fontsize',12)
        lgd=legend(num2str(plotMPshock(2,[3,4,5])), ...
            num2str(plotMPshock(18,[3,4,5])), ...
            num2str(plotMPshock(21,[3,4,5])), ...
            num2str(plotMPshock(29,[3,4,5])), ...
            num2str(plotMPshock(34,[3,4,5])), ...
            num2str(plotMPshock(56,[3,4,5])), ...
            num2str(plotMPshock(58,[3,4,5])), ...
            num2str(plotMPshock(37,[3,4,5])), ...
            num2str(plotMPshock(39,[3,4,5])), 'Location','southoutside');
    elseif period == 3 || 4 % time starts at 14/10/2010
        fn=figure; plot(tau,plotMPshock(12,6:end),'LineWidth',2); hold on;
        plot(tau,plotMPshock(28,6:end),'r','LineWidth',2);
        plot(tau,plotMPshock(31,6:end),'k','LineWidth',2);
        plot(tau,plotMPshock(39,6:end),'b--','LineWidth',2);
        plot(tau,plotMPshock(44,6:end),'m','LineWidth',2);
        plot(tau,plotMPshock(66,6:end),'r--','LineWidth',2);
        plot(tau,plotMPshock(68,6:end),'k--','LineWidth',2);
        plot(tau,plotMPshock(72,6:end),'m--','LineWidth',2);
        plot(tau,plotMPshock(73,6:end),'c-.','LineWidth',2);
        hold off;
        set(gca,'fontsize',12)
        lgd=legend(num2str(plotMPshock(12,[3,4,5])), ...
            num2str(plotMPshock(28,[3,4,5])), ...
            num2str(plotMPshock(31,[3,4,5])), ...
            num2str(plotMPshock(39,[3,4,5])), ...
            num2str(plotMPshock(44,[3,4,5])), ...
            num2str(plotMPshock(66,[3,4,5])), ...
            num2str(plotMPshock(68,[3,4,5])), ...
            num2str(plotMPshock(72,[3,4,5])), ...
            num2str(plotMPshock(73,[3,4,5])),'Location','southoutside');
    elseif period == 5 || 6 % time starts at 1/1/1999
        fn=figure; plot(tau,plotMPshock(106,6:end),'LineWidth',2); hold on;
        plot(tau,plotMPshock(122,6:end),'r','LineWidth',2);
        plot(tau,plotMPshock(125,6:end),'k','LineWidth',2);
        plot(tau,plotMPshock(133,6:end),'b--','LineWidth',2);
        plot(tau,plotMPshock(138,6:end),'m','LineWidth',2);
        plot(tau,plotMPshock(160,6:end),'r--','LineWidth',2);
        plot(tau,plotMPshock(162,6:end),'k--','LineWidth',2);
        plot(tau,plotMPshock(166,6:end),'m--','LineWidth',2);
        plot(tau,plotMPshock(167,6:end),'c-.','LineWidth',2);
        hold off;
        set(gca,'fontsize',12)
        lgd=legend(num2str(plotMPshock(106,[3,4,5])), ...
            num2str(plotMPshock(122,[3,4,5])), ...
            num2str(plotMPshock(125,[3,4,5])), ...
            num2str(plotMPshock(133,[3,4,5])), ...
            num2str(plotMPshock(138,[3,4,5])), ...
            num2str(plotMPshock(160,[3,4,5])), ...
            num2str(plotMPshock(162,[3,4,5])), ...
            num2str(plotMPshock(166,[3,4,5])), ...
            num2str(plotMPshock(167,[3,4,5])),'Location','southoutside');

    else % for changing values of lambda (currently plot from 3/1/2012) (might modify to change time period)
        fn=figure; plot(tau,plotMPshock(2,6:end),'LineWidth',2); hold on;
        plot(tau,plotMPshock(18,6:end),'r','LineWidth',2);
        plot(tau,plotMPshock(21,6:end),'k','LineWidth',2);
        plot(tau,plotMPshock(29,6:end),'b--','LineWidth',2);
        plot(tau,plotMPshock(34,6:end),'m','LineWidth',2);
        plot(tau,plotMPshock(56,6:end),'r--','LineWidth',2);
        plot(tau,plotMPshock(58,6:end),'k--','LineWidth',2);
        plot(tau,plotMPshock(37,6:end),'m--','LineWidth',2);
        plot(tau,plotMPshock(39,6:end),'c-.','LineWidth',2);
        hold off;
        set(gca,'fontsize',12)
        lgd=legend(num2str(plotMPshock(2,[3,4,5])), ...
            num2str(plotMPshock(18,[3,4,5])), ...
            num2str(plotMPshock(21,[3,4,5])), ...
            num2str(plotMPshock(29,[3,4,5])), ...
            num2str(plotMPshock(34,[3,4,5])), ...
            num2str(plotMPshock(56,[3,4,5])), ...
            num2str(plotMPshock(58,[3,4,5])), ...
            num2str(plotMPshock(37,[3,4,5])), ...
            num2str(plotMPshock(39,[3,4,5])), 'Location','southoutside');
    end

    lgd.FontSize = 8;
    lgd.NumColumns = 3;
    ylabel('Percent','FontSize',12); xlabel('Maturity','FontSize',12);
    ylim([-0.4 0.3]);
end

if mptype == 2
    fn=figure;
    plot(tau,plotMPshock(1,6:end),'b','LineWidth',2); hold on;
    plot(tau,plotMPshock(2,6:end),'r','LineWidth',2)
    plot(tau,plotMPshock(6,6:end),'b--','LineWidth',2);
    plot(tau,plotMPshock(8,6:end),'k--','LineWidth',2);
    plot(tau,plotMPshock(9,6:end),'m--','LineWidth',2);
    plot(tau,plotMPshock(10,6:end),'c--','LineWidth',2);
    plot(tau,plotMPshock(11,6:end),'b--*','LineWidth',0.5)
    plot(tau,plotMPshock(12,6:end),'m--*','LineWidth',0.5)
    plot(tau,plotMPshock(15,6:end),'g--','LineWidth',2)
    hold off; set(gca,'fontsize',12)
    lgd=legend(num2str(plotMPshock(1,[3,4,5])), ...
        num2str(plotMPshock(2,[3,4,5])), ...
        num2str(plotMPshock(6,[3,4,5])), ...
        num2str(plotMPshock(8,[3,4,5])), ...
        num2str(plotMPshock(9,[3,4,5])), ...
        num2str(plotMPshock(10,[3,4,5])), ...
        num2str(plotMPshock(11,[3,4,5])), ...
        num2str(plotMPshock(12,[3,4,5])), ...
        num2str(plotMPshock(15,[3,4,5])), 'Location','southoutside');
    lgd.FontSize = 8;
    lgd.NumColumns = 3;
    ylabel('Percent','FontSize',12); xlabel('Maturity','FontSize',12);
    ylim([-0.4 0.3]);
end

%Save figure
    if mptype == 1
        if period == 1
            saveas(fn,'figuresMPSHOCK/model_1/conventional/figureSHOCK_conv', 'epsc')
        elseif period == 2 
            saveas(fn,'figuresMPSHOCK/model_2/conventional/figureSHOCK_conv', 'epsc')
        elseif period == 3
            saveas(fn,'figuresMPSHOCK/model_3/conventional/figureSHOCK_conv', 'epsc')
        elseif period == 4 
            saveas(fn,'figuresMPSHOCK/model_4/conventional/figureSHOCK_conv', 'epsc')
        elseif period == 5 
            saveas(fn,'figuresMPSHOCK/model_5/conventional/figureSHOCK_conv', 'epsc')
        elseif period == 6 
            saveas(fn,'figuresMPSHOCK/model_6/conventional/figureSHOCK_conv', 'epsc')
        else 
            saveas(fn,'figuresMPSHOCK/others/conventional/figureSHOCK_conv', 'epsc')
        end
    elseif mptype == 2
        if period == 1
            saveas(fn,'figuresMPSHOCK/model_1/unconventional/figureSHOCK_unconv', 'epsc')
        elseif period == 2
            saveas(fn,'figuresMPSHOCK/model_2/unconventional/figureSHOCK_unconv', 'epsc')
        elseif period == 3
            saveas(fn,'figuresMPSHOCK/model_3/unconventional/figureSHOCK_unconv', 'epsc')
        elseif period == 4
            saveas(fn,'figuresMPSHOCK/model_4/unconventional/figureSHOCK_unconv', 'epsc')
        elseif period == 5
            saveas(fn,'figuresMPSHOCK/model_5/unconventional/figureSHOCK_unconv', 'epsc')
        elseif period == 6
            saveas(fn,'figuresMPSHOCK/model_6/unconventional/figureSHOCK_unconv', 'epsc')
        else
            saveas(fn,'figuresMPSHOCK/others/unconventional/figureSHOCK_unconv', 'epsc')
        end
    end       

%%  TABLES WITH DELTA_BETAS

if mptype == 1
    disp('Table of beta1 beta2 beta3 beta1+beta2 beta3-beta1 for these six dates')

    if period == 1 || 2 % time starts at 3/1/2012
        bb=[betamp(2,4:6); betamp(18,4:6); betamp(21,4:6); betamp(29,4:6); betamp(34,4:6); ...
            betamp(37,4:6); betamp(39,4:6); betamp(56,4:6); betamp(58,4:6)]; % time starts at 3/1/2012 (3m,6m,1-10y)
        bb=[bb,bb(:,1)+bb(:,2),bb(:,3)-bb(:,1)];
        table_bb=[betamp(2,[1,2,3,4,5,6]); betamp(18,[1,2,3,4,5,6]); betamp(21,[1,2,3,4,5,6]); betamp(29,[1,2,3,4,5,6]); betamp(34,[1,2,3,4,5,6]);...
            betamp(37,[1,2,3,4,5,6]); betamp(39,[1,2,3,4,5,6]); betamp(56,[1,2,3,4,5,6]); betamp(58,[1,2,3,4,5,6])];
    elseif period == 3 || 4 % time starts at 14/10/2010
        bb=[betamp(12,4:6); betamp(28,4:6); betamp(31,4:6); betamp(39,4:6); betamp(44,4:6); ...
            betamp(66,4:6); betamp(68,4:6); betamp(72,4:6); betamp(73,4:6)]; % time starts at 14/10/2010 (3m,1-10y)
        bb=[bb,bb(:,1)+bb(:,2),bb(:,3)-bb(:,1)];
        table_bb=[betamp(12,[1,2,3,4,5,6]); betamp(28,[1,2,3,4,5,6]); betamp(31,[1,2,3,4,5,6]); betamp(39,[1,2,3,4,5,6]); betamp(44,[1,2,3,4,5,6]);...
            betamp(66,[1,2,3,4,5,6]); betamp(68,[1,2,3,4,5,6]); betamp(72,[1,2,3,4,5,6]); betamp(73,[1,2,3,4,5,6])];
    elseif period == 5 || 6 % time starts at 1/1/1999
        bb=[betamp(106,4:6); betamp(122,4:6); betamp(125,4:6); betamp(133,4:6); betamp(138,4:6); ...
            betamp(160,4:6); betamp(162,4:6); betamp(166,4:6); betamp(167,4:6)]; % time starts at 1/1/1999 (1-10y)
        bb=[bb,bb(:,1)+bb(:,2),bb(:,3)-bb(:,1)];
        table_bb=[betamp(106,[1,2,3,4,5,6]); betamp(122,[1,2,3,4,5,6]); betamp(125,[1,2,3,4,5,6]); betamp(133,[1,2,3,4,5,6]); betamp(138,[1,2,3,4,5,6]);...
            betamp(160,[1,2,3,4,5,6]); betamp(162,[1,2,3,4,5,6]); betamp(166,[1,2,3,4,5,6]); betamp(167,[1,2,3,4,5,6])];
    else % for changing values of lambda (currently plot from 3/1/2012) (might modify to change time period)
        bb=[betamp(2,4:6); betamp(18,4:6); betamp(21,4:6); betamp(29,4:6); betamp(34,4:6); ...
            betamp(37,4:6); betamp(39,4:6); betamp(56,4:6); betamp(58,4:6)]; % time starts at 3/1/2012 (3m,6m,1-10y)
        bb=[bb,bb(:,1)+bb(:,2),bb(:,3)-bb(:,1)];
        table_bb=[betamp(2,[1,2,3,4,5,6]); betamp(18,[1,2,3,4,5,6]); betamp(21,[1,2,3,4,5,6]); betamp(29,[1,2,3,4,5,6]); betamp(34,[1,2,3,4,5,6]);...
            betamp(37,[1,2,3,4,5,6]); betamp(39,[1,2,3,4,5,6]); betamp(56,[1,2,3,4,5,6]); betamp(58,[1,2,3,4,5,6])];
    end

    table_bb=[table_bb,table_bb(:,4)+table_bb(:,5),table_bb(:,6)-table_bb(:,4)];
    table_bb_all=[betamp(:,[1,2,3]), betamp(:,4:6),betamp(:,4)+betamp(:,5),betamp(:,6)-betamp(:,4)];
    save table_deltabeta_conven table_bb_all -ascii;
elseif mptype == 2
    disp('Table of month day year beta1 beta2 beta3 beta1+beta2 beta3-beta1 for these six dates')
    table_bb=[betamp(:,[1,2,3]), betamp(:,4:6),betamp(:,4)+betamp(:,5),betamp(:,6)-betamp(:,4)];
    disp('Table of beta1 beta2 beta3 beta1+beta2 beta3-beta1 for these six dates')
    save table_deltabeta_unconv table_bb -ascii;
end

%addpath C:\brossi\research\library\formatoTEX
if mptype == 1
    matrix2latex(table_bb, 'TableDeltaBetaConventional.tex');
    matrix2latex(table_bb_all, 'TableDeltaBetaConventionalAllDates.tex');
elseif mptype == 2
    matrix2latex(table_bb, 'TableDeltaBetaUnconventional.tex');
end



function result=plot_ttt(betaT,Yield,maturities,lambda,ttt)
tau=1:1:120;
scatter(maturities,Yield(ttt,:));
linefit2=1.*betaT(ttt,4)+((1-exp(-lambda.*tau))./(lambda.*tau)).*betaT(ttt,5) + ((1-exp(-lambda.*tau))./(lambda.*tau)-exp(-lambda.*tau)).*betaT(ttt,6);
hold on; plot(tau,linefit2,'b','LineWidth',2); 
result.TS=linefit2; result.beta=betaT(ttt,4:6);

function result=plot_ttt2(betaT,Yield,maturities,lambda,ttt)
tau=1:1:120;
scatter(maturities,Yield(ttt,:),'r*');
linefit2=1.*betaT(ttt,4)+((1-exp(-lambda.*tau))./(lambda.*tau)).*betaT(ttt,5) + ((1-exp(-lambda.*tau))./(lambda.*tau)-exp(-lambda.*tau)).*betaT(ttt,6);
hold on; plot(tau,linefit2,'r--','LineWidth',2);
result.TS=linefit2; result.beta=betaT(ttt,4:6);

