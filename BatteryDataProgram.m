% Head Programme - GUI to input data and choose which figures to get.
% Gives figures with: 3 cycles of your choosing, battery statistics, 
% all cycles, dQ/dV, and capacity retention.
function BatteryDataProgram
% Create figure
h.f = figure('units','pixels','position',[700,400,500,500],...
             'toolbar','none','menu','none');
% Create Text Input Fields
h.c(1) = uicontrol('Style','edit','Units','pixels',...
                'Position',[25,450,450,25],'String','Input Filepath','FontSize',14);
h.c(2) = uicontrol('Style','edit','Units','pixels',...
                'Position',[25,400,450,25],'String','Input Current Density (mA/g)','FontSize',14);
h.c(3) = uicontrol('Style','edit','Units','pixels',...
                'Position',[25,350,140,25],'String','Cycle 1','FontSize',14);
h.c(4) = uicontrol('Style','edit','Units','pixels',...
                'Position',[180,350,140,25],'String','Cycle 2','FontSize',14);
h.c(5) = uicontrol('Style','edit','Units','pixels',...
                'Position',[335,350,140,25],'String','Cycle 3','FontSize',14);
% Create checkboxes
h.c(6) = uicontrol('style','checkbox','units','pixels',...
                'position',[25,300,150,25],'string','Cycling Statistics','FontSize',14);
h.c(7) = uicontrol('style','checkbox','units','pixels',...
                'position',[25,250,150,25],'string','Full Cycling','FontSize',14);  
h.c(8) = uicontrol('style','checkbox','units','pixels',...
                'position',[25,200,150,25],'string','dQ/dV','FontSize',14);
h.c(9) = uicontrol('style','checkbox','units','pixels',...
                'position',[25,150,150,25],'string','Capacity Retention','FontSize',14); 
% Create Continue Pushbutton   
h.p = uicontrol('style','pushbutton','units','pixels',...
                'position',[180,25,140,50],'string','Continue','FontSize',14,...
                'callback',@p_call);
            
    % Pushbutton callback
    function p_call(varargin)
        vals = get(h.c,'Value');
        checked = find([vals{:}]);
        filename = h.c(1).String;
        current_density = h.c(2).String;
        TT1 = filename == "Input Filepath";
        TT2 = current_density == "Input Current Density";
        if TT1+TT2>=1
            if filename == "Input Filepath"
                'Please Enter File Path'
            end
            if current_density == "Input Current Density"
                'Please Enter Current Density'
            end
            return
        else
            current_density_num = str2double(current_density);
            cycles = [str2double(h.c(3).String), str2double(h.c(4).String), str2double(h.c(5).String)];
            [a, b] = battery_data_read(filename);
            avg_C = abs(mean(a(a(:,4)==4,7)));
            m = avg_C./current_density_num;

            cc1 = cycles(1);
            cc2 = cycles(2);
            cc3 = cycles(3);

            cycleplot(a,m,cc1,cc2,cc3)
        end

        if isempty(checked)
            checked = 'none';
            return
        end
        
        if ismember(6,checked)
            battstat(b,m)
        end
        if ismember(7,checked)
            cyclegroups(a,m)
        end
        if ismember(8,checked)
            dqdvwithrests(a,m)
        end
        if ismember(9,checked)
            Capacity_Retention(b,m)
        end
        
        closereq()
    end
end