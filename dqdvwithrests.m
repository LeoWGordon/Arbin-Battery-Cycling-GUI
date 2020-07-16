function dqdvwithrests(a,mass)
% mass in g
    ccc = a(:,5); % cycle index column

    n = max(ccc); % number of cycles

    thresmin = 1;
    thresmax = n;
    clevels = 6;
    thresvec=nan(1,clevels);
    figure
    for ii=1:clevels
        thresvec(ii)=round(thresmin*((thresmax/thresmin)^(1/clevels))^ii)-1;
    end

    cnt = 0;
    ymaxall = nan(size(thresvec));
    % j = [1:1:n];
        for i = thresvec % Finds data for every 50th cycle, change 50 to change the step size
            cnt = cnt+1;
            cn = a(ccc==i,:); % Redefines the table according to the cycle corresponding to i
            si = cn(:,4); % finds the step indices

            if cn(si==2,7)<0
                dischargecap = cn(si==2,9)/mass;
                dischargevoltage = cn(si==2,6);
                chargecap = cn(si==4,8)/mass;
                chargevoltage = cn(si==4,6);

                drestcap = cn(si==3,9)/mass;
                drestvolt = cn(si==3,6);
                crestcap = cn(si==5,8)/mass;
                crestvolt = cn(si==5,6);

            else
                dischargecap = cn(si==4,9)/mass;
                dischargevoltage = cn(si==4,6);
                chargecap = cn(si==2,8)/mass;
                chargevoltage = cn(si==2,6);

                drestcap = cn(si==5,9)/mass;
                drestvolt = cn(si==5,6);
                crestcap = cn(si==3,8)/mass;
                crestvolt = cn(si==3,6);

            end

            cap = [dischargecap; drestcap; chargecap; crestcap];
            volt = [dischargevoltage; drestvolt; chargevoltage; crestvolt];

            dydx = gradient(cap(:))./gradient(volt(:)); % dQ/dV = mAh/g/V == A.s/V

            % Savitzky-Golay filter to smooth the data
            % Increase 3rd entry to smooth more, or vice versa
            sgf0 = sgolayfilt(dydx,1,51); 
            ymaxall(i) = max(sgf0);
            yminall(i) = min(sgf0);
            % Plot figure
            txt = ['Cycle ',num2str(i)];
            c = jet(n);

            p1 = plot(volt,sgf0,'color',c(cnt*(floor(n/clevels)),:),'displayname',txt,'linewidth',2);
            xlim([min(volt)-0.1 max(volt)+0.1])
            ylim([min(yminall)-50 max(ymaxall)+50])
            xlabel('Voltage (V)');
            ylabel('^{dQ}/_{dV} (mA h g^{-1} V^{-1})');
            hold on
            legend location 'northwest'
            figure_param

        end
