clear; close all; clc;

%slipmodel_xyzkm_with_m0_and_ampsliprate_per_subfault_Teil_surface_constraint_lowsmooth_07feb2024.txt

%dd = importdata('slipmodel_low.txt'); 
dd = importdata('slipmodel_strong.txt'); 

x_km = dd.data(:,1);
y_km = dd.data(:,2);
depth_km = dd.data(:,3);
strike = dd.data(:,4);
dip = dd.data(:,5);
rake = dd.data(:,6);
ontime_s = dd.data(:,7);
slip_cm = dd.data(:,8);
ampsliprate1 = dd.data(:,9); %cm/s
ampsliprate2 = dd.data(:,10); %cm/s
ampsliprate3 = dd.data(:,11); %cm/s
M0_subfault = dd.data(:,12); %dyn.cm


%%
figure('Units', 'centimeters', 'Position', [1, 1, 40, 30]); % [left, bottom, width, height]

% Given data points in 3D
x = x_km; % x coordinates of data points
y = y_km; % y coordinates of data points
z = -depth_km; % z coordinates of data points
values = slip_cm; % values associated with each data point

% Calculate end point for vectors
scale_factor = 0.3; % Define the scale factor for visualizing vectors
max_slip_cm = max(slip_cm);
for i = 1:length(strike)
    azimuth_deg = strike(i); % The original coordinates taken strike into account
    radial_deg = rake(i);
    radial_mag = slip_cm(i); 
    dip_deg = dip(i);
    [x_end(i), y_end(i), z_end(i)] = sphericalToCartesian1(x_km(i), y_km(i), depth_km(i), azimuth_deg, radial_deg, dip_deg, scale_factor, radial_mag, max_slip_cm);
end
xc = [-1.910, -2.840 , 1.550, 2.480]; % X coordinates
yc = [-2.710, -1.720, 2.370, 1.380]; % Y coordinates
zc = [-2.09, 0, 0, -2.09]; % Z coordinates
%     -1.910    -2.710 : corner 1
%     -2.840    -1.720 : corner 2
%      1.550     2.370 : corner 3
%      2.480     1.380 : corner 4
% Create a grid for surface plotting
[X, Y] = meshgrid(linspace(min(x), max(x), 200), linspace(min(y), max(y), 200));
Z = griddata(x, y, z, X, Y, 'cubic'); % Interpolate z values for the grid
ValuesGrid = griddata(x, y, values, X, Y); % Interpolate values for the grid

% Plot the surface
surf(X, Y, Z, ValuesGrid, 'EdgeColor', 'none');
hold on
% Plot the quiver vectors
for i = 1:length(x)
    h_quiver = quiver3(x_km(i) + 0.07*sind(47), y_km(i) - 0.07*cosd(47), -depth_km(i), x_end(i) - x_km(i), y_end(i) - y_km(i), z_end(i) + depth_km(i), 0, 'Color', 'k', 'LineWidth', 2);
    h_quiver.MaxHeadSize = 1.0; % Adjust the size of the arrowhead
    h_quiver.Marker = 'v'; % Change the arrowhead marker to a circle
    h_quiver.MarkerFaceColor = 'w'; % Set the color of the arrowhead marker
    h_quiver.MarkerSize = 10; % Adjust the size of the marker
    hold on
  %  scatter3(x(i)+200/1000*sind(47), y(i)-200/1000*cosd(47), z(i), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'SizeData', 100);
  %  hold on
end

% for i = 1:length(x)
% text(x(i), y(i), z(i), 'o');hold on
% hold on
% end

% for i = 1:length(x)
%    % Compute the vector components
%     magnitude = slip_cm(i) * scale_factor / max_slip_cm; % Normalize magnitude by max_slip_cm
%     % Plot the vector
%     h = quiver3(x_km(i), y_km(i), -depth_km(i), x_end(i) - x_km(i), y_end(i) - y_km(i), z_end(i) + depth_km(i), 0, 'Color', 'r', 'LineWidth', 2);
%     hold on; % Hold the current plot
%     % Change the arrowhead style
%     h.MaxHeadSize = 1.0; % Adjust the size of the arrowhead
%     h.Marker = 'o'; % Change the arrowhead marker to a circle
%     h.MarkerFaceColor = 'b'; % Set the color of the arrowhead marker
%     h.MarkerSize = 2; % Adjust the size of the marker
%     scatter3(x(i), y(i), z(i), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'SizeData', 100);
%     hold on
% end

% Set colorbar properties
cbar = colorbar;
cbar.Label.String = 'Slip (cm)';
cbar.Label.FontSize = 20;
cbar.FontSize = 20;

%h4 = fill3(xc, yc, zc, 'w', 'FaceColor', 'none', 'EdgeColor', 'k'); % 'EdgeColor', 'k' makes the edges black
h5 = plot3((200*sind(47))/1000, (-200*cosd(47))/1000, -1050/1000, 'bp', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
legend([h5, h_quiver],[{'Hypocenter'}, {'Point Source'}], 'Location', 'northeast', 'FontSize', 16); % Include 'Hypocenter' in the legend


% Set axis labels
xlabel('Easting (km)', 'FontSize', 24);
ylabel('Northing (km)', 'FontSize', 24);
zlabel('Depth (km)', 'FontSize', 24);

% Set tick font size for x, y, and z axes
set(gca, 'FontSize', 25);

% Set aspect ratio
axis equal;
grid on;

% Set title
title('Slip Distribution across Fault Plane', 'FontSize', 45, 'FontWeight','bold');

% Rotate the axis
view(45, 35);
%filename = ['/Users/mikesu/Desktop/kinematic/input_template/slip_surf.png'];
%saveas(gcf, filename);


function [x_new, y_new, z_new] = sphericalToCartesian1(x, y, depth, azimuth_deg, radial_deg, dip_deg, scale, slip, max_slip)
    radial_mag = slip * scale / max_slip; % Normalize magnitude by max_slip_cm
    
    % Calculate new coordinates using spherical coordinates
    x_tmp = radial_mag * cosd(radial_deg) * sind(dip_deg);; 
    y_tmp = radial_mag * sind(radial_deg) * sind(dip_deg);
    
    % Define the rotation matrix
    R = [cosd(azimuth_deg) -sind(azimuth_deg); 
         sind(azimuth_deg) cosd(azimuth_deg)];
    
    % Apply rotation
    rotated_point = R * [x_tmp; y_tmp];
    
    % Extract rotated coordinates
    x_rotated = rotated_point(1);
    y_rotated = rotated_point(2);
    
    % Calculate final coordinates
    x_new = x + x_rotated;
    y_new = y + y_rotated;
    z_new = -depth + 1*(radial_mag * sind(dip_deg) * sind(radial_deg));

end




