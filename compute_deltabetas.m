function result = compute_deltabetas(model, window_time)
% Constructs a series of delta_betas at the monthly frequency
% window (1 for 1-day window; 2 for 2-day window)

betaT = [model.TimeV,model.beta_hat,cumsum(ones(size(model.beta_hat,1),1))];
year = model.TimeV(:,1);
mpdates = model.MPdates;
period = model.period;

shockV_avg  = [];   shockV_final = []; betabeforeV_avg = []; betaafterV_avg = [];

for ty = year(1):year(end)   % for year
    for tm = 1:12            % for month
        [i_shock] = find(mpdates(:,1)==ty &  mpdates(:,2)==tm);

        if isempty(i_shock) == 1   % No MP announcements: MP shock = 0
            shockV_avg  = [shockV_avg;   ty,tm, ty+(tm-1)/12,zeros(1,size(betaT,2)-4)];
            shockV_final= [shockV_final; ty,tm, ty+(tm-1)/12,zeros(1,size(betaT,2)-4)];
            betabeforeV_avg =[betabeforeV_avg;  ty,tm, ty+(tm-1)/12,zeros(1,size(betaT,2)-4)];
            betaafterV_avg  =[betaafterV_avg;   ty,tm, ty+(tm-1)/12,zeros(1,size(betaT,2)-4)];
        else                       % MP announcements: MP shock = average of shocks in a month
            shockV_ii_avg = []; betabeforeV_ii_avg = []; betaafterV_ii_avg  = [];
            for ii=i_shock'
                [i_beta]=find( betaT(:,1)==mpdates(ii,1) &  betaT(:,2)==mpdates(ii,2) &  betaT(:,3)==mpdates(ii,3) );
                shockV_ii_avg   =[shockV_ii_avg; betaT(i_beta,[1,2]), ty+(tm-1)/12, betaT(i_beta+window_time-1,4:end-1)-betaT(i_beta-1,4:end-1)];
                shockV_ii_final =               [betaT(i_beta,[1,2]), ty+(tm-1)/12, betaT(i_beta+window_time-1,4:end-1)-betaT(i_beta-1,4:end-1)];
                betabeforeV_ii_avg =[betabeforeV_ii_avg;  ty,tm, ty+(tm-1)/12,betaT(i_beta-1,4:end-1)];
                betaafterV_ii_avg  =[betaafterV_ii_avg;   ty,tm, ty+(tm-1)/12,betaT(i_beta+window_time-1,4:end-1)];
            end
            shockV_avg=[shockV_avg; mean(shockV_ii_avg,1)];
            shockV_final=[shockV_final; shockV_ii_final];
            betabeforeV_avg=[betabeforeV_avg; mean(betabeforeV_ii_avg,1)];
            betaafterV_avg =[betaafterV_avg;  mean(betaafterV_ii_avg,1)];
        end
    end
end

result.shock = shockV_avg;
result.betabeforeV = betabeforeV_avg;
result.betaafterV  = betaafterV_avg;

end

