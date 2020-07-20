% Head Programme - GUI to input data and choose which figures to get.
% Gives figures with: 3 cycles of your choosing, battery statistics, 
% all cycles, dQ/dV, and capacity retention.
% dQ/dV requires the use of signal processing toolbox.
% Code prepared by Leo W. Gordon.
function BatteryDataProgram
% Create figure
h.f = figure('units','normalized','position',[0.35,0.25,0.3,0.5],...
             'toolbar','none','menu','none');
% Create Text Input Fields
h.c(1) = uicontrol('Style','edit','Units','normalized',...
                'Position',[0.1,0.9,0.8,0.05],'String','Input Filepath','FontSize',14);
h.c(2) = uicontrol('Style','edit','Units','normalized',...
                'Position',[0.1,0.825,0.8,0.05],'String','Input Current Density (mA/g)','FontSize',14);
h.c(3) = uicontrol('Style','edit','Units','normalized',...
                'Position',[0.1,0.75,0.25,0.05],'String','Cycle 1','FontSize',14);
h.c(4) = uicontrol('Style','edit','Units','normalized',...
                'Position',[0.375,0.75,0.25,0.05],'String','Cycle 2','FontSize',14);
h.c(5) = uicontrol('Style','edit','Units','normalized',...
                'Position',[0.65,0.75,0.25,0.05],'String','Cycle 3','FontSize',14);
% Create checkboxes
h.c(6) = uicontrol('style','checkbox','units','normalized',...
                'position',[0.1,0.6,0.3,0.05],'string','Cycling Statistics','FontSize',14);
h.c(7) = uicontrol('style','checkbox','units','normalized',...
                'position',[0.1,0.5,0.3,0.05],'string','Full Cycling','FontSize',14);  
h.c(8) = uicontrol('style','checkbox','units','normalized',...
                'position',[0.1,0.4,0.3,0.05],'string','dQ/dV','FontSize',14);
h.c(9) = uicontrol('style','checkbox','units','normalized',...
                'position',[0.1,0.3,0.3,0.05],'string','Capacity Retention','FontSize',14); 
% Create Continue Pushbutton   
h.p = uicontrol('style','pushbutton','units','normalized',...
                'position',[0.3,0.1,0.4,0.1],'string','Continue','FontSize',14,...
                'callback',@p_call);
        
    % Pushbutton callback
    function p_call(varargin)
        vals = get(h.c,'Value');
        checked = find([vals{:}]);
        filename = h.c(1).String;
        current_density = h.c(2).String;
        c1 = h.c(3).String;
        c2 = h.c(4).String;
        c3 = h.c(5).String;
        TT1 = filename == "Input Filepath";
        TT2 = current_density == "Input Current Density";
        if TT1+TT2>=1
            if filename == "Input Filepath"
                disp('Please Enter File Path')
            end
            if current_density == "Input Current Density"
                disp('Please Enter Current Density')
            end
            return
        elseif c1 == "Cycle 1" || c2 == "Cycle 2" || c3 == "Cycle 3"
            disp("Proceeding without cycling plot")
            disp('Getting data from spreadsheet')
            current_density_num = str2double(current_density);
            [a, b] = battery_data_read(filename);
            avg_C = abs(mean(a(a(:,4)==4,7)));
            m = avg_C./current_density_num;
        else
            disp('Getting data from spreadsheet and plotting cycles')
            current_density_num = str2double(current_density);
            cycles = [str2double(c1), str2double(c2), str2double(c3)];
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
            disp('Plotting battery statistics')
            battstat(b,m)
        end
        if ismember(7,checked)
            disp('Plotting all cycles')
            cyclegroups(a,m)
        end
        if ismember(8,checked)
            disp('Plotting dQ/dV')
            dqdvwithrests(a,m)
        end
        if ismember(9,checked)
            disp('Plotting capacity retention')
            Capacity_Retention(b,m)
        end
        
        closereq()
    end
end
