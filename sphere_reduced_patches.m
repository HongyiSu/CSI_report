clear; close all; clc;
%slipmodel_xyzkm_with_m0_and_ampsliprate_per_subfault_Teil_surface_constraint_lowsmooth_07feb2024.txt
%dd = importdata('slipmodel_low.txt'); 
dd = importdata('slipmodel_strong.txt'); 
% define global input parameters for the template
mu_s = false;
mu_d = false;
dc = false;
write_fault_properties_sphere(mu_s, mu_d, dc, dd);