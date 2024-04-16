function [x_rotated, y_rotated] = rotate_cartesian(x, y, theta_deg)
    % Convert angle from degrees to radians
    theta_rad = deg2rad(theta_deg);
    
    % Define the rotation matrix
    R = [cosd(theta_deg), -sind(theta_deg);
         sind(theta_deg), cosd(theta_deg)];
    
    % Stack the coordinates into a matrix
    coordinates = [x(:), y(:)]';
    
    % Apply the rotation
    rotated_coordinates = R * coordinates;
    
    % Extract the rotated coordinates
    y_rotated = -rotated_coordinates(1, :);
    x_rotated = rotated_coordinates(2, :);
end
