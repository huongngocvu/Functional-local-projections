% Plot IRFs of the STANDARD local projections

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

saveas(fn,strcat('figuresIRFSsmooth/standardLP/inflation',num2str(shock(tt,2)),num2str(shock(tt,1))),'epsc')


