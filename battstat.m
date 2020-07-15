% battstat(stats_sheet,mass)
% Gets the battery cycling statistics: capacity per cycle and Coulombic 
% efficiency per cycle

function battstat(b,m)

    cycnum = b(:,5); % Cycle Number
    Cd = (b(:,9))./m; % Discharge Capacity (mAh/g)
    Cc = (b(:,8))./m; % Charge Capacity (mAh/g)
    Cc = Cc(1:end-1); % Remove last point
    Cd = Cd(1:end-1); % Remove last point
    E = Cd./Cc*100; % Discharge over charge = efficiency

    % For plotting, getting good axis limits
    Esort = sort(E,'descend');
    cycnum1 = cycnum(1:end-1);
    axmax1 = max(Cc)+30;
    axmax2 = Esort(2)+10;
    n = length(cycnum1)+1;

    fig = figure;
    left_color = [0 0 0];
    right_color = [0 0 0];
    set(fig,'defaultAxesColorOrder',[left_color; right_color]);

    yyaxis left

    scatter(cycnum1,Cd,75,'ko')
    hold on
    scatter(cycnum1,Cc,75,'ro')
    %title('Capacity and Coulombic Efficiency','fontsize',18)
    xlabel('Cycle Number')
    ylabel('Capacity (mA h g^{-1})')
    axis([0 n 0 axmax1])
    figure_param

    yyaxis right

    scatter(cycnum1,E,100,'filled')
    %title('Coulombic Efficiency and Cycle Life','fontsize',18)
    xlabel('Cycle Number')
    ylabel('Coulombic Efficiency (%)')
    axis([0 n 0 axmax2])
    legend('Discharge Capacity','Charge Capacity','Coulombic Efficiency','location','southeast')
    figure_param