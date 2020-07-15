function cyclegroups(a,m)

    si = a(:,4);
    if a(si==2,7)<0
        dn = a(si==2,9)./m; % discharge capacity (mA h/g)
        Vd = a(si==2,6); % discharge voltage
        cn = a(si==4,8)./m; % charge capacity (mA h/g)
        Vc = a(si==4,6); % Charge voltage

        % Cycle Number - Discharge
        Nd = a(si==2,5);
        Gd = findgroups(Nd); % Segregates Cycles
        % Cycle Number - Charge
        Nc = a(si==4,5);
        Gc = findgroups(Nc); % Segregates Cycles
    else
        dn = a(si==4,9)./m; % discharge capacity (mA h/g)
        Vd = a(si==4,6); % discharge voltage
        cn = a(si==2,8)./m; % charge capacity (mA h/g)
        Vc = a(si==2,6); % Charge voltage

        % Cycle Number - Discharge
        Nd = a(si==4,5);
        Gd = findgroups(Nd); % Segregates Cycles
        % Cycle Number - Charge
        Nc = a(si==2,5);
        Gc = findgroups(Nc); % Segregates Cycles

    end

    figure
    gscatter(dn,Vd,Gd);
    hold on
    gscatter(cn,Vc,Gc);
    xlabel('Capacity (mA h g^{-1})');
    ylabel('Voltage (V)');
    % leg = legend('show');
    % title(leg,'Cycle Number');
    % set(legend, 'NumColumns' ,col);
    figure_param
    % set(leg,'fontsize',8,'location','east');