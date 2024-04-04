function fV=smoothT4(irf_output); 
n=size(irf_output,1); m=size(irf_output,2); 
ttrend=[0:1:n-1]'; 
fV=[];

for j=1:m; 
%kk=olsbeta(irf_output(:,j),[ttrend,ttrend.^2,ttrend.^3]); f1=[ttrend,ttrend.^2,ttrend.^3]*kk';
kk=olsbeta(irf_output(:,j),[ttrend,ttrend.^2,ttrend.^3,ttrend.^4]); f1=[ttrend,ttrend.^2,ttrend.^3,ttrend.^4]*kk';
%figure; plot(irf_output(:,j)); hold on; plot(f1,'r');
fV=[fV,f1];
end

% for j=1:m; 
% kk=olsbeta(irf_output(:,j),[ttrend,ttrend.^2]); f1=[ttrend,ttrend.^2]*kk';
% %figure; plot(irf_output(:,j)); hold on; plot(f1,'r');
% fV=[fV,f1];
% end;

