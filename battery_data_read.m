% [main_sheet, stats_sheet] = battery_data_read(filename)
% Reads in Arbin cycling data, stats sheet and main sheet

function [a, b] = battery_data_read(filename)

sheets = sheetnames(filename);

k=0;
kk=0;
count=0;
while kk<1
    count=count+1;
   if contains(sheets(count),'Channel') 
        a = readmatrix(filename,'Sheet',sheets(count));
        kk=1;
    end 
end
count=0;
while k<1
    count=count+1;
    if contains(sheets(count),'Statistics') 
        b = readmatrix(filename,'Sheet',sheets(count));
        k=1;
    end
end
