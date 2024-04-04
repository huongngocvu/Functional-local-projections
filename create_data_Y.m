% Create data for Y (includes inflation and output)

function Y = create_data_Y(period)

% period = 1:   Zero yields include 3M, 6M, 1Y to 10Y from 3/1/2012 - 31/12/2019     (no pandemic)
% period = 2:   Zero yields include 3M, 6M, 1Y to 10Y from 3/1/2012 - 31/12/2021     (pandemic)
% period = 3:   Zero yields include 3M, 1Y to 10Y     from 14/10/2010 - 31/12/2019   (no pandemic)
% period = 4:   Zero yields include 3M, 1Y to 10Y     from 14/10/2010 - 31/12/2021   (pandemic)
% period = 5:   Zero yields include 1Y to 10Y         from 5/1/1999 - 31/12/2019     (no pandemic)
% period = 6:   Zero yields include 1Y to 10Y         from 5/1/1999 - 31/12/2021     (pandemic)

inflation_data = readtable('macro_data.xlsx','Sheet',1);    % CPI
inflation_data = flipud(inflation_data);

output_data = readtable('macro_data.xlsx','Sheet',5);    % NZAC as output, annual percentage change

if period == 1
    Inflation = inflation_data.Inflation(157:252); % CPI, change Y/Y
    Output = output_data.NZAC(100:195);
elseif period == 2
    Inflation = inflation_data.Inflation(157:end);  
    Output = output_data.NZAC(100:end);    
elseif period == 3
    Inflation = inflation_data.Inflation(133:252);
    Output = output_data.NZAC(76:195);
elseif period == 4
    Inflation = inflation_data.Inflation(133:end);
    Output = output_data.NZAC(76:end);
elseif period == 5
    Inflation = inflation_data.Inflation(58:252); % start 31/10/2003 (as NZAC data is available from this time)
    Output = output_data.NZAC(1:195);
elseif period == 6
    Inflation = inflation_data.Inflation(58:end);
    Output = output_data.NZAC(1:end);
end

Y = [Inflation Output];

end