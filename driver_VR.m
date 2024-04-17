% Author: Hongyi Su (hongyi.su@irsn.fr)
% Last update: 17/4/2024
% Description: plot a figure which shows the location of virtual nodes
% Usage: matlab driver_VR.m

clear; clc; close all;

file = 'lat_long_revisee_cut.xlsx';
[LAT LON dist2epi STA_4 xx yy] = read_mydata(file);
fault_length = 6; %km
fault_width = 2.5; %km
strike = 47;
dip = 58;
hypo_depth = 1.0; %km
[xx_s yy_s]= rotate_sta(xx, yy, strike);

plot_figure3(xx, yy, xx_s, yy_s, STA_4, dist2epi, fault_length);

function [LAT LON dist2epi STA_4 xx yy] = read_mydata(file)
    % Read the Excel file into a table
    data2 = readtable(file);
    sncf_lat = data2.Latitude;
    sncf_lon = data2.Longitude;
    sncf_sta = string(data2.Station);
    Lat = [44.521, 44.374, 44.636, 44.307, 44.356];
    Lon = [4.669, 4.770, 4.759, 4.689, 4.857];
    Npp_lat = [44.331, 44.632];
    Npp_lon = [4.731, 4.755];
    %apprend 14 SNCF stations + NPP
    LAT = [Lat sncf_lat' Npp_lat 44.5263]; 
    LON = [Lon sncf_lon' Npp_lon 4.6661];
    [x,y,utmzone] = deg2utm(LAT,LON); % call function deg2utm to convert lat/lon to XY
    xx = x - x(1);
    yy = y - y(1);
    dist2epi = sqrt(xx.^2 + yy.^2);
    sta = ["Epicenter"; "ADHE";"CRU1";"OGLP";"TRI2"];
    sta_name = [sta; sncf_sta; "Tricastin"; "Cruas"; "CLAU"];
    STA_4 = [xx, yy, sta_name, dist2epi];
end

function [xx_s yy_s] = rotate_sta(xx, yy, strike)
    strike_radians = deg2rad(strike);
    R = [cos(strike_radians) sin(strike_radians);
        -sin(strike_radians) cos(strike_radians)];
    coordinates = [xx'; yy'];
    rotated_coordinates = R * coordinates;
    xx_s = rotated_coordinates(1, :)';
    yy_s = rotated_coordinates(2, :)';
end

