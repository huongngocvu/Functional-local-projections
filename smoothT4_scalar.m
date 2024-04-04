function fV=smoothT4_scalar(irf_output); 
n=size(irf_output,1);  
ttrend=[0:1:n-1]'; 
fV=[];

kk=olsbeta(irf_output,[ttrend,ttrend.^2,ttrend.^3,ttrend.^4]); f1=[ttrend,ttrend.^2,ttrend.^3,ttrend.^4]*kk';
%figure; plot(irf_output(:,j)); hold on; plot(f1,'r');
fV=[fV,f1];


