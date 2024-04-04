function VV = olsvarbetanw(y,x,qn); 
%VV = olsvarbetanw(y,x,qn); 

%Estimates t-tests for significance of regressors for an unrestricted VAR(p)
%y must have different variables as columns
%variance is corrected for small samples (n-k) (18-3-03)
%ta=1.96 if 95% or 1.64 if 90%
%This works with conditional heteroskedasticity

[n k]=size(y); [nx,kx]=size(x);
phi=zeros(k,1); res=zeros(n,1);
% coeff=((inv(x'*x))*(x'*y))';
coeff=((x'*x)\(x'*y))';
res=y-x*coeff';
sigma2=nw(res,qn);
 
ee=mmult(res,x); 
S=nw(ee,qn); Sxx=(x'*x)/n; 
% VV=inv(Sxx'*inv(S)*Sxx)/n;
VV=inv(Sxx'/S*Sxx)/n;


function result = nw(y,qn);
%input: y is a T*k vector and qn is the truncation lag
%output: the newey west HAC covariance estimator 
%Formulas are from Hayashi

[T,k]=size(y); ybar=ones(T,1)*((sum(y))/T);
dy=y-ybar;
G0=dy'*dy/T;
for j=1:qn-1;
   gamma=(dy(j+1:T,:)'*dy(1:T-j,:))./(T-1);
   G0=G0+(gamma+gamma').*(1-abs(j/qn));
end;
result=G0;
