% Turns legend box off, axis box on (linewidth 2), sets font sizes to 28 and makes bold

legend box 'off'
box on
set(gca,'FontName','Helvetica','FontWeight', 'bold')
% set(gca,'fontsize',28)
ax = gca;
ax.FontSize = 28;
weight = ax.FontWeight;
ax.FontWeight = 'bold';
ax.LineWidth = 2;
lgd=legend;
% lgd.FontSize = 16;
lgd.FontWeight = 'normal';