blue_circle_stations = [3, 4, 5, 6, 7, 75, 76, 77, 78, 79, 27, 36, 45, 54, 63, 19, 28, 37, 46, 55, 13, 15, 67, 69, 40, 42]; % Stations to blue circle
red_circle_stations = [23, 32, 41, 50, 59]; % Stations to green circle

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
        scatter(x_want(i)/1e3, y_want(j)/1e3, 80,'k', 'Marker','o'); 
        hold on
        plot([want_x1, want_x2],[want_y1, want_y2],'r', 'LineWidth', 2);
        text((x_want(i) + 100)/1e3, (y_want(j)-200)/1e3, num2str(c));

        % Highlight stations with green circles
        if ismember(c, red_circle_stations)
            scatter(x_want(i)/1e3, y_want(j)/1e3,80, 'r', 'filled'); 
            text((x_want(i) + 100)/1e3, (y_want(j)-200)/1e3, num2str(c), 'Color', 'r', 'FontWeight', 'bold');
            hold on;
        end
        
        % Highlight stations with blue circles
        if ismember(c, blue_circle_stations)
            scatter(x_want(i)/1e3, y_want(j)/1e3,80, 'b', 'filled');
            text((x_want(i) + 100)/1e3, (y_want(j)-200)/1e3, num2str(c), 'Color', 'b', 'FontWeight', 'bold');
            hold on;
        end
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
