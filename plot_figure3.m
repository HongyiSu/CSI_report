function plot_figure3(xx, yy, xx_s, yy_s, STA_4, dist2epi, fault_length)

    % Create a figure and define the size
    X_max = 20;
    Y_max = 30;
    figWidth = X_max; % Width in cm
    figHeight = Y_max; % Height in cm
    figure('Units', 'centimeters', 'Position', [0, 0, figWidth, figHeight]);

    % Add Fault
    fault_surface_p1 = [-fault_length/2, 0];
    fault_surface_p2 = [fault_length/2, 0];
    plot([fault_surface_p1(1), fault_surface_p2(1)],[fault_surface_p1(2), fault_surface_p2(2)],'r', 'LineWidth', 2);   
    hold on
    text((fault_length/2+1), (fault_surface_p2(2)),'LRf','FontSize', 15, 'FontWeight','bold');
    
    % Add epicenter, which is the origin (0,0)
    scatter(xx(1)/1000,yy(1)/1000, 150 ,'p', 'filled','MarkerFaceColor','y','MarkerEdgeColor','k');
    hold on
    % ADD NPPs
    scatter(xx_s(end-1)/1000,yy_s(end-1)/1000, 100, 'd', 'MarkerFaceColor', 'g','MarkerEdgeColor', 'r');
    hold on
   % text((xx_s(end-1))/1000-3,yy_s(end-1)/1000+2, strcat(STA_4(length(xx)-1,3), ' (', num2str(round(dist2epi(length(xx)-1)/1000,2,'significant')),'km' ,')'),"FontSize",10,"FontWeight","normal");
    scatter(xx_s(end-2)/1000,yy_s(end-2)/1000, 100, 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'r');
    hold on
   % text((xx_s(end-2))/1000-3,yy_s(end-2)/1000+2, strcat(STA_4(length(xx)-2,3), ' (', num2str(round(dist2epi(length(xx)-2)/1000,2,'significant')),'km' ,')'),"FontSize",10,"FontWeight","normal");

    % Add stations after rotation
    for(i=2:length(xx)-3)
        scatter(xx_s(i)/1000,yy_s(i)/1000, 100, 'v', 'MarkerFaceColor','r','MarkerEdgeColor', 'b');
        if(i==4)
            text((xx_s(i))/1000-4,yy_s(i)/1000-1, strcat(STA_4(i,3), ' (', num2str(round(dist2epi(i)/1000,3,'significant')),'km' ,')'),"FontSize",10,"FontWeight","normal");
        else
           text((xx_s(i))/1000-2,yy_s(i)/1000+1, strcat(STA_4(i,3), ' (', num2str(round(dist2epi(i)/1000,3,'significant')),'km' ,')'),"FontSize",10,"FontWeight","normal");
        end
        hold on
    end

    % ADD CLAU station
    scatter(xx_s(end)/1000,yy_s(end)/1000, 100, 'v', 'MarkerFaceColor', 'r','MarkerEdgeColor', 'b');
    hold on
    text((xx_s(end))/1000-3,yy_s(end)/1000+2, strcat(STA_4(length(xx),3), ' (', num2str(round(dist2epi(length(xx))/1000,2,'significant')),'km' ,')'),"FontSize",20,"FontWeight","normal");

    % Add a box boudary
    x_limits = [-10, 10];
    y_limits = [-10, 10];
    x_corners = [x_limits(1), x_limits(2), x_limits(2), x_limits(1), x_limits(1)];
    y_corners = [y_limits(1), y_limits(1), y_limits(2), y_limits(2), y_limits(1)];
    plot(x_corners, y_corners, 'k-', 'LineWidth', 2);

    %Add label and title
    xlim([-X_max, X_max]);
    ylim([-Y_max, Y_max]);
    xlabel('Easting [km]');
    ylabel('Northing [km]');
    title('Location of the Virtual Nodes');
  
    set(gca, 'FontSize', 20, 'FontWeight','bold');
    ax = gca;
    % Calculate the desired tick length based on the data range
    x_range = X_max*2; %km
    y_range = Y_max*2; %km
    desired_tick_length = 0.0;  % Set your desired tick length here
    % Calculate the tick length for x and y axes
    x_tick_length = desired_tick_length * diff(ax.XLim) / x_range;
    y_tick_length = desired_tick_length * diff(ax.YLim) / y_range;
    % Set the tick lengths for x and y axes
    ax.XRuler.TickLength = [x_tick_length, x_tick_length]; % X-axis tick length
    ax.YRuler.TickLength = [y_tick_length, y_tick_length]; % Y-axis tick length
    % Enable minor grid
    grid on;
    box on;
    % Add a legend
    legend('Fault','Epicentre','Tricastin NPP','Cruas NPP','Virtual Nodes','Location','northwest');
end