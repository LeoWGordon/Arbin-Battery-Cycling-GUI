% cycleplot(filepath,current_density,cycle1,cycle2,...,cyclex)
% Function to plot x cycles from one dataset.
% Requires inputs of filepath and current density, along with the cycle
% numbers of desired cycles to plot.
% Requires external scripts of colourmapfigure and figure_param.
% Made for the GUI programme.

function cycleplot(M,m,varargin)

si=M(:,4);
ccc = M(:,5);
TT=M(si==2,7)<0; 

% Boolean to determine order of charge and discharge, true if discharge first

figure
n=nan(nargin-2,1);
for i=1:size(n)
    
    n(i)=varargin{i};
    cn=M(ccc==n(i),:);
    si=cn(:,4);

        if TT==1
            dC=cn(si==2,9)./m;
            dV=cn(si==2,6);
            cC=cn(si==4,8)./m;
            cV=cn(si==4,6);
        else
            dC=cn(si==4,9)./m;
            dV=cn(si==4,6);
            cC=cn(si==2,8)./m;
            cV=cn(si==2,6);
        end
        
    colourmapfigure;
    txt = strcat('Cycle',{' '},string(varargin{i}));
    p1 = plot(dC,dV,'color',cmapfig(i,:),'LineWidth',2,'DisplayName',txt);
    hold on
    p2 = plot(cC,cV,'color',cmapfig(i,:),'LineWidth',2);
    xlabel('Specific Capacity (mA h g^{-1})');
    ylabel('Cell Voltage (V)');
    
    set(get(get(p2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); % Omits the legend entries for the charge cycle
    legend('-DynamicLegend','Location','east')
    figure_param

end
hold off


