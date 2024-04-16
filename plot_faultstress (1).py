#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 30 10:01:10 2023

@author: Hongyi Su, M.Sc., B.Sc., B.ENG., PhD candidate
Institut de radioprotection et de sûreté nucléaire
hongyi.su@irsn.fr
"""
import matplotlib.pyplot as plt
import numpy as np
import seissolxdmf
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.ticker as ticker


# %%
# define fig size in cm
# Convert centimeters to inches for figsize
width_cm = 16  # Width in centimeters
height_cm = 5  # Height in centimeters
# Convert centimeters to inches
width_inches = width_cm * 0.393701
height_inches = height_cm * 0.393701

foldername = 'O:\\ENV\\SCAN\\BERSSIN\\R4\\Projet 1.4.4\\16 - Rupture Dynamique\\2023_Near_Source_GM\\Seissol_result\\output_dc_S02_15s_6\\'
modelname = 'dcS02_6'
sx = seissolxdmf.seissolxdmf(foldername + modelname + '-fault.xdmf')
# Assuming `sx` is a module providing functions for geometry operations

# Read geometry data
surfxyz = sx.ReadGeometry()
connect = sx.ReadConnect()
# Extract x, y, z coordinates from the geometry data
x = surfxyz[:, 0]
y = surfxyz[:, 1]
z = surfxyz[:, 2]
#ndt = sx.ReadNdt()-1
ndt = 0
td = sx.ReadData('Td0',ndt)
pn = sx.ReadData('Pn0',ndt)
ts = sx.ReadData('Ts0',ndt)
#read timesteps
dt = sx.ReadTimeStep()
#%%
# Create a figure with subplots for td, pn, and ts values combined
fig, axes = plt.subplots(nrows=1, ncols=3, figsize=(width_cm, height_cm), subplot_kw={'projection': '3d'})

# Plot td values in the first subplot (index 0)
trisurf_td = axes[0].plot_trisurf(x, y, z, triangles=connect, cmap='cividis')
trisurf_td.set_array(td/1e6)  # Setting color data
cbar = fig.colorbar(trisurf_td, ax=axes[0], shrink=0.6, aspect=20, pad=0.2)
cbar.set_label('Stress (MPa)', fontweight='bold')  # Label for the colorbar
# Set the tick frequency on the colorbar
tick_locator = ticker.MaxNLocator(nbins=10)  # Adjust the number of ticks as needed
cbar.locator = tick_locator
cbar.update_ticks()
# Set the font properties for colorbar ticks
cbar.ax.tick_params(labelsize=12)  # Adjust the font size as needed
# Set the fontweight to bold for colorbar ticks
for tick in cbar.ax.yaxis.get_majorticklabels():
    tick.set_fontweight('bold')
axes[0].set_title('Along-Dip Shear Stress (MPa)\n at time ' + str(dt*ndt) +' seconds', fontsize=14, fontweight='bold')
axes[0].set_xlabel('X (km)', fontweight='bold')
axes[0].set_ylabel('Y (km)', fontweight='bold')
axes[0].set_zlabel('Z (km)', fontweight='bold')


# Plot pn values in the second subplot (index 1)
trisurf_pn = axes[1].plot_trisurf(x, y, z, triangles=connect, cmap='plasma')
trisurf_pn.set_array(pn/1e6)  # Setting color data
cbar2 = fig.colorbar(trisurf_pn, ax=axes[1], shrink=0.6, aspect=20, pad=0.2)
cbar2.set_label('Stress (MPa)', fontweight='bold')  # Label for the colorbar
# Set the tick frequency on the colorbar
tick_locator2 = ticker.MaxNLocator(nbins=10)  # Adjust the number of ticks as needed
cbar2.locator = tick_locator2
cbar2.update_ticks()
# Set the font properties for colorbar ticks
cbar2.ax.tick_params(labelsize=12)  # Adjust the font size as needed
# Set the fontweight to bold for colorbar ticks
for tick in cbar2.ax.yaxis.get_majorticklabels():
    tick.set_fontweight('bold')
axes[1].set_title('Effective Normal Stress (MPa)\n at time ' + str(dt*ndt) +' seconds', fontsize=14, fontweight='bold')
axes[1].set_xlabel('X (km)', fontweight='bold')
axes[1].set_ylabel('Y (km)', fontweight='bold')
axes[1].set_zlabel('Z (km)', fontweight='bold')


# Plot ts values in the third subplot (index 2)
trisurf_ts = axes[2].plot_trisurf(x, y, z, triangles=connect, cmap='inferno')
trisurf_ts.set_array(ts/1e6)  # Setting color data
cbar3 = fig.colorbar(trisurf_ts, ax=axes[2], shrink=0.6, aspect=20,pad=0.2)
cbar3.set_label('Stress (MPa)', fontweight='bold')  # Label for the colorbar
# Set the tick frequency on the colorbar
tick_locator3 = ticker.MaxNLocator(nbins=5)  # Adjust the number of ticks as needed
cbar3.locator = tick_locator3
cbar3.update_ticks()
# Set the font properties for colorbar ticks
cbar3.ax.tick_params(labelsize=12)  # Adjust the font size as needed
# Set the fontweight to bold for colorbar ticks
for tick in cbar3.ax.yaxis.get_majorticklabels():
    tick.set_fontweight('bold')
axes[2].set_title('Along-strike Shear Stress (MPa)\n at time ' + str(dt*ndt) +' seconds', fontsize=14, fontweight='bold')
axes[2].set_xlabel('X (km)', fontweight='bold')
axes[2].set_ylabel('Y (km)', fontweight='bold')
axes[2].set_zlabel('Z (km)', fontweight='bold')

# Customize x, y, z ticks
for ax in axes:
    custom_ticks_x = [-2000, 0, 2000]
    custom_ticklabels_x = ['-2', '0', '2']
    ax.set_xticks(custom_ticks_x)
    ax.set_xticklabels(custom_ticklabels_x, fontsize=14, fontweight='bold')
    custom_ticks_y = [-1000, 0]
    custom_ticklabels_y = ['-1', '0']
    ax.set_yticks(custom_ticks_y)
    ax.set_yticklabels(custom_ticklabels_y, fontsize=14, fontweight='bold')
    custom_ticks_z = [-2000,-1000,0]
    custom_ticklabels_z = ['-2', '-1', '0']
    ax.set_zticks(custom_ticks_z)
    ax.set_zticklabels(custom_ticklabels_z, fontsize=14, fontweight='bold')


figure_d = 'O:\\ENV\\SCAN\\BERSSIN\\R4\\Projet 1.4.4\\16 - Rupture Dynamique\\2023_Near_Source_GM\\PPT\\'
plt.savefig(figure_d + modelname + '-stress_on_fault-' + str(dt*ndt) + 's.png', dpi=150)
plt.show()

