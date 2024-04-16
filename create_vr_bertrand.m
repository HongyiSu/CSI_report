% this script is used for write csv file and dat file that can be used in
% simulation

clear; 
clc; 
close all;

x_want = linspace(-8000,8000,9);
y_want = linspace(-8000,8000,9);

% Create a csv file that can be opened in Paraview
% Open a file for writing
filename = 'virtual_receiver_bertrand.dat';
fileID = fopen(filename, 'w'); % 'w' for write mode
% Check if the file is opened successfully
if fileID == -1
    error('Unable to open file');
end
% Write formatted data to the file
%fprintf(fileID, 'X,Y,Z,Station\n');
for(i=1:length(x_want))
    for(j=1:length(y_want))
       fprintf(fileID, '%4f %4f %4f\n', x_want(i), y_want(j), 0);
    end
end
% Close the file
fclose(fileID);
% for paraview

filename = 'virtual_receiver_bertrand_s.csv';
fileID = fopen(filename, 'w'); % 'w' for write mode
% Check if the file is opened successfully
if fileID == -1
    error('Unable to open file');
end
% Write formatted data to the file
fprintf(fileID, 'X,Y,Z\n');
c = 0;
for(i=1:length(x_want))
    for(j=1:length(y_want))
       c = c + 1;
       fprintf(fileID, '%4f, %4f, %4f, %s\n', x_want(i), y_want(j), 0, num2str(c));
    end
end
% Close the file
fclose(fileID);

%%
figure('Position', [0, 0, 1000, 1000]); % Set figure size to 10cm by 10cm

x_want = linspace(-8000, 8000, 9);
y_want = linspace(-8000, 8000, 9);
want_x1 = -3;
want_y1 = 0;
want_x2 = 3;
want_y2 = 0;
p1 = [want_x1, want_y1];
p2 = [want_x2, want_y2];
c = 0;
for i = 1:length(x_want)
    for j = 1:length(y_want)
        c = c + 1;
        scatter(x_want(i)/1e3, y_want(j)/1e3, 'k', 'filled'); % Changed 'v' to 'filled' for better visibility
        hold on
        plot([want_x1, want_x2],[want_y1, want_y2],'r', 'LineWidth', 2);
        text((x_want(i) + 100)/1e3, (y_want(j)-200)/1e3, num2str(c));

        ylabel('Northing (km)', 'FontSize', 14, 'FontWeight', 'bold');
        xlabel('Easting (km)', 'FontSize', 14, 'FontWeight', 'bold');
        hold on;
    end
end

xlim([-10000/1e3, 10000/1e3]);
ylim([-10000/1e3, 10000/1e3]);

% Plot boundaries
bottom_boundary_x = [min(xlim), max(xlim)];
bottom_boundary_y = [min(ylim), min(ylim)];
plot(bottom_boundary_x, bottom_boundary_y, 'k-'); % Bottom boundary

top_boundary_x = [min(xlim), max(xlim)];
top_boundary_y = [max(ylim), max(ylim)];
plot(top_boundary_x, top_boundary_y, 'k-'); % Top boundary

left_boundary_x = [min(xlim), min(xlim)];
left_boundary_y = [min(ylim), max(ylim)];
plot(left_boundary_x, left_boundary_y, 'k-'); % Left boundary

right_boundary_x = [max(xlim), max(xlim)];
right_boundary_y = [min(ylim), max(ylim)];
plot(right_boundary_x, right_boundary_y, 'k-'); % Right boundary
% Title
title('Location of Virtual Receivers on Free Surface', 'FontSize', 20, 'FontWeight', 'bold');
legend('VR Node', 'Fault', 'FontSize', 12, 'FontWeight', 'bold');

% Bold ticks
set(gca, 'FontWeight', 'bold');

saveas(gcf, strcat('O:\ENV\SCAN\BERSSIN\R4\Projet 1.4.4\16 - Rupture Dynamique\2023_Near_Source_GM\CSI_report\location_vr.png'));
