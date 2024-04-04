% Plot IRFs of the functional local projections and takeaway points

Hv = 0:1:horizon-1;

%% Plot IRFs
fn=figure;
subplot(2,2,1);
plot(Hv,irf_inf16','--r','LineWidth',2); hold on;
plot(Hv,irf_inf84','--r','LineWidth',2);
Hv2=[Hv,fliplr(Hv)]; inbetween=[irf_inf16',fliplr(irf_inf84')]; fill(Hv2, inbetween,[1 0.6 0.3]);
plot(Hv,irf_inf50','r','LineWidth',3);
hold off;
ylabel('Percent','FontSize',14); xlabel('Horizon','FontSize',14);
str1=['title(''Inflation IRF on ',num2str(shock(tt,2)),'/',num2str(shock(tt,1)),''',''FontSize'',14',');'];
eval(str1);

subplot(2,2,2);
plot(Hv,irf_output16','--r','LineWidth',2); hold on;
plot(Hv,irf_output84','--r','LineWidth',2);
Hv2=[Hv,fliplr(Hv)]; inbetween=[irf_output16',fliplr(irf_output84')]; fill(Hv2, inbetween,[1 0.6 0.3]);
plot(Hv,irf_output50','r','LineWidth',3); hold off;
ylabel('Percent','FontSize',14); xlabel('Horizon','FontSize',14);
str1=['title(''Output IRF on ',num2str(shock(tt,2)),'/',num2str(shock(tt,1)),''',''FontSize'',14',');'];
eval(str1);

subplot(2,2,3);
betabefore=betabeforeV(tt,:);
betaafter=betaafterV(tt,:);
% betadiff=betaafter-betabefore;
tau=1:1:120;
TS_before=betabefore(1,4)+betabefore(1,5)*(1-exp(-lambda*tau))./(lambda*tau)+betabefore(1,6)*((1-exp(-lambda*tau))./(lambda*tau)-exp(-lambda*tau));
TS_after=betaafter(1,4)+betaafter(1,5)*(1-exp(-lambda*tau))./(lambda*tau)+betaafter(1,6)*((1-exp(-lambda*tau))./(lambda*tau)-exp(-lambda*tau));
plot(tau,TS_before,'b','LineWidth',2); hold on; plot(tau,TS_after,'r-*');
str2=['title(''',num2str(betabefore(2)),'/',num2str(betabefore(1)),''',''FontSize'',14',');'];
eval(str2);
legend('Yield Curve Before','Yield Curve After','Location','Best');
xlabel('Maturity','FontSize',14); ylabel('Yield (%)','FontSize',14); hold off;

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,strcat('figuresIRFSsmooth/model_1/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 2
            saveas(fn,strcat('figuresIRFSsmooth/model_2/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 3
            saveas(fn,strcat('figuresIRFSsmooth/model_3/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 4
            saveas(fn,strcat('figuresIRFSsmooth/model_4/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 5
            saveas(fn,strcat('figuresIRFSsmooth/model_5/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 6
            saveas(fn,strcat('figuresIRFSsmooth/model_6/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        end
    else
        saveas(fn,strcat('figuresIRFSsmooth/different_lambda/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
    end
elseif spec == 2
    saveas(fn,strcat('figuresIRFSsmooth/exchange_rate/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
end


% deltabetaV = [deltabetaV; betabefore(2), betabefore(1), betadiff(1,4), betadiff(1,5), betadiff(1,6), betadiff(1,4)+betadiff(1,5), betadiff(1,6)-betadiff(1,4) ];
% irfinfV = [irfinfV; irf_inf50];

fn=figure('visible','off');
subplot(1,2,1);
plot(decomp_inf(:,1),'o:'); hold on;
plot(decomp_inf(:,2)); hold off;
ylabel('Percent','FontSize',14); xlabel('Horizon','FontSize',14);
lgd=legend('Contribution of \Delta\beta_2_t','Contribution of \Delta\beta_3_t','Location','best'); lgd.FontSize = 10;
str3=['title(''Inflation on ',num2str(shock(tt,2)),'/',num2str(shock(tt,1)),''',''FontSize'',10',');'];
eval(str3);
subplot(1,2,2);
plot(decomp_output(:,1),'o:'); hold on;
plot(decomp_output(:,2)); hold off;
ylabel('Percent','FontSize',14); xlabel('Horizon','FontSize',14);
lgd=legend('Contribution of \Delta\beta_2_t','Contribution of \Delta\beta_3_t','Location','best'); lgd.FontSize = 10;
str3=['title(''Output on ',num2str(shock(tt,2)),'/',num2str(shock(tt,1)),''',''FontSize'',10',');'];
eval(str3);

if spec == 1
    if lambda == 0.0609
        if period == 1
            saveas(fn,strcat('figuresIRFSsmooth/model_1/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 2
            saveas(fn,strcat('figuresIRFSsmooth/model_2/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 3
            saveas(fn,strcat('figuresIRFSsmooth/model_3/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 4
            saveas(fn,strcat('figuresIRFSsmooth/model_4/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 5
            saveas(fn,strcat('figuresIRFSsmooth/model_5/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        elseif period == 6
            saveas(fn,strcat('figuresIRFSsmooth/model_6/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
        end
    else
        saveas(fn,strcat('figuresIRFSsmooth/different_lambda/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
    end
elseif spec == 2
    saveas(fn,strcat('figuresIRFSsmooth/exchange_rate/inflation_decomp',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')
end

