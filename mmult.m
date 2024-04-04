function result=mmult(x,y);

%Multiplies a vector x by each of the columns of y
%INPUT:  x, an nx1 vector
%        y, an nxk matrix

result=[];
for k=1:size(y,2);
    result=[result,x.*y(:,k)];
end;
    