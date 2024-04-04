function yields_change = calculateMPshocks_yieldData(model, window_time)

% Calculate MP shocks as one-day change in yields using yields data

year = model.TimeV(:,1);
mpdates = model.MPdates;

Yields_fitted = [model.TimeV,model.yield_hat];
shockV_avg_fitted  = [];   

for ty = year(1):year(end)   % for year
    for tm = 1:12            % for month
        [i_shock] = find(mpdates(:,1)==ty &  mpdates(:,2)==tm);

        if isempty(i_shock) == 1   % No MP announcements: MP shock = 0
            shockV_avg_fitted  = [shockV_avg_fitted;   ty,tm, ty+(tm-1)/12,zeros(1,size(Yields_fitted,2)-3)];
        else                       % MP announcements: MP shock = average of shocks in a month
            shockV_ii_avg = []; 
            for ii=i_shock'
                [i_beta]=find( Yields_fitted(:,1)==mpdates(ii,1) &  Yields_fitted(:,2)==mpdates(ii,2) &  Yields_fitted(:,3)==mpdates(ii,3) );
                shockV_ii_avg   =[shockV_ii_avg; Yields_fitted(i_beta,[1,2]), ty+(tm-1)/12, Yields_fitted(i_beta+window_time-1,4:end)-Yields_fitted(i_beta-1,4:end)];
            end
            shockV_avg_fitted=[shockV_avg_fitted; mean(shockV_ii_avg,1)];
        end
    end
end

Yields_actual = [model.TimeV,model.Yield];
shockV_avg_actual  = [];   

for ty = year(1):year(end)   % for year
    for tm = 1:12            % for month
        [i_shock] = find(mpdates(:,1)==ty &  mpdates(:,2)==tm);

        if isempty(i_shock) == 1   % No MP announcements: MP shock = 0
            shockV_avg_actual  = [shockV_avg_actual;   ty,tm, ty+(tm-1)/12,zeros(1,size(Yields_actual,2)-3)];
        else                       % MP announcements: MP shock = average of shocks in a month
            shockV_ii_avg = []; 
            for ii=i_shock'
                [i_beta]=find( Yields_actual(:,1)==mpdates(ii,1) &  Yields_actual(:,2)==mpdates(ii,2) &  Yields_actual(:,3)==mpdates(ii,3) );
                shockV_ii_avg   =[shockV_ii_avg; Yields_actual(i_beta,[1,2]), ty+(tm-1)/12, Yields_actual(i_beta+window_time-1,4:end)-Yields_actual(i_beta-1,4:end)];
            end
            shockV_avg_actual=[shockV_avg_actual; mean(shockV_ii_avg,1)];
        end
    end
end

yields_change.fitted = shockV_avg_fitted;
yields_change.actual = shockV_avg_actual;