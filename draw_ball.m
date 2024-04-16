function draw_ball(center, radius, slip_magnitude)
    % Extract x, y, z coordinates from the center
    x_center = center(1);
    y_center = center(2);
    z_center = center(3);

    % Generate grid for the sphere
    [x_sphere, y_sphere, z_sphere] = sphere();
    % Scale the sphere to the desired radius
    x_sphere = x_sphere * radius;
    y_sphere = y_sphere * radius;
    z_sphere = z_sphere * radius;
    % Translate the sphere to the specified center
    x_sphere = x_sphere + x_center;
    y_sphere = y_sphere + y_center;
    z_sphere = z_sphere + z_center;
    % Plot the sphere with color based on slip magnitude
    surf(x_sphere, y_sphere, z_sphere, slip_magnitude * ones(size(x_sphere)), ...
         'EdgeColor', 'g', 'FaceAlpha', 0.01);
    hold on;
    % Plot the center point
    plot3(x_center, y_center, z_center, '.', 'MarkerSize', 1, 'MarkerFaceColor', 'r');
    hold on
    % Set aspect ratio
    axis equal;
end

