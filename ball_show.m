function  [x_rotated, y_rotated_translation, z_trim, slip_trim, radius] = ball_show(x_km,y_km, depth_km, slip_cm, var, var_name, scale_sphere)
    figure('Units', 'centimeters', 'Position', [1, 1, 40, 30]); % [left, bottom, width, height]
    a = find(slip_cm<8 | depth_km > 1.5); %find the element index
    x_trim  = remove(x_km, a');
    y_trim  = remove(y_km, a');
    z_trim  = remove(depth_km, a');
    slip_trim  = remove(slip_cm, a');
    radius = slip_trim * scale_sphere; % Radius of the ball
    var_trim = remove(var, a');
    theta_deg = 47;
    [x_rotated, y_rotated] = rotate_cartesian(x_trim, y_trim, theta_deg);
    %match with the mesh: le-teil_Bertrand.geo
    y_rotated_translation =  y_rotated - 1.05/tand(57);
    for i = 1:length(x_rotated)
        magnitude_color = var_trim(i); % Get magnitude value for the current point
        scatter3(x_rotated(i), y_rotated_translation(i), -z_trim(i), 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'flat', 'CData', magnitude_color, 'SizeData', 100); % Plot the point with a filled circle marker and color based on magnitude
        text(x_rotated(i), y_rotated_translation(i), -z_trim(i)-0.2, [num2str(var_trim(i))], 'FontSize', 12); 
        hold on; % Hold the current plot
        center = [x_rotated(i), y_rotated_translation(i), -z_trim(i)]; % Coordinates of the center
        slip_magnitude = slip_trim(i); % Slip magnitude for color
        draw_ball(center, radius(i), slip_magnitude);
        hold on
    end
    x = [-1.910, -2.840 , 1.550, 2.480]; % X coordinates
    y = [-2.710, -1.720, 2.370, 1.380]; % Y coordinates
    z = [-2.09, 0, 0, -2.09]; % Z coordinates
    [x_r, y_r] = rotate_cartesian(x, y, theta_deg);
    y_r_translation = y_r - 1.05/tand(57);
    % Plot the rectangular plane
    fill3(x_r, y_r_translation, z, 'w', 'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 2); % 'EdgeColor', 'k' makes the edges black
    % Set axis labels
    hold on
    % display hypocenter, a point on the fault plane in mesh.
    plot3(49.723/1000, -648.912/1000, -999.237/1000, 'bp', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    % Set axis labels
    xlabel('Along strike distance (km)');
    ylabel('Northing (km)', Rotation=90);
    zlabel('Depth (km)');
    % Set aspect ratio
    axis equal;
    grid on;
    title(['Visualization of Spherical Patches (scale =', num2str(scale_sphere) ,')'], 'FontSize', 12);
    caxis([min(var_trim(:)), max(var_trim(:))]);
    c = colorbar('southoutside');
    c.Label.String = [var_name, ' (cm)']; % Label the colorbar
    c.Label.set('FontSize', 25);
    view(10, 30); 
    filename = ['/Users/mikesu/Desktop/kinematic/input_template/show_sphere_model_' var_name '.png'];
    saveas(gcf, filename);
    set(gca, 'FontSize', 20)
end