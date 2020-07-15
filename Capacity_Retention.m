% Cd = discharge cap
% Cc = charge cap
% cycnum1 = cycle number

% Code to find the capacity loss per cycle
function Capacity_Retention(b,m)

    cycnum1 = b(:,5); % Cycle Number
%     cycnum1 = cycnum(1:end-1);
    Cd = (b(:,9))./m;

    maxcap = maxk(Cd,5);

    vec = 2:1:length(Cd);

        for i = vec
            y1(i) = (Cd(i)-maxcap(5))*100/maxcap(5); % gives loss versus max
            y2(i) = (Cd(i)-Cd(i-1))*100/Cd(i-1); % gives loss versus previous
        end

    figure
    plot(cycnum1,y1,'-b','LineWidth',2)
    xlim([0 max(cycnum1)])
    ylabel('Capacity Loss vs. Maximum (%)')
    xlabel('Cycle Number')
    figure_param
    legend off

    figure
    plot(cycnum1,y2,'-r','LineWidth',2)
    xlim([0 max(cycnum1)])
    ylabel('Capacity Loss Per Cycle (%)')
    xlabel('Cycle Number')
    figure_param
    legend off