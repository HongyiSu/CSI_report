# CSI_report

This archive stores the Matlab / Python scripts that created the figures in the CSI report. 

## Generating Input YAML Fault Properties File

To create the input YAML fault properties file, follow these steps:

### Using `sphere_reduced_patches.m` as Driver:

1. **Dependencies:**
   - `write_fault_properties_sphere.m`
     - Dependencies:
       - `ball_show.m` (creates spherical patches figure)
         - Dependencies:
           - `remove.m` (filters point source based on certain criteria)
           - `rotate_cartesian.m` (rotates source coordinates by strike angle to match the fault geometry in the mesh)
           - `draw_ball.m` (plots a ball, centered at each point source)
       - `write_sphere_template_constant.m` (writes the YAML input)

2. Run `sphere_reduced_patches.m` to initiate the process of generating the input YAML fault properties file.

3. This script relies on various dependencies to create and manipulate data before writing it to the YAML file.

4. Ensure that all dependencies are properly installed and configured before executing `sphere_reduced_patches.m`.

## Create Figure 12

### Using `driver_VR.m` as Driver:
1. **Dependencies:**
     - `deg2utm.m` (coordinates conversion)
     - `plot_figure3.m` (for plotting)

## Note:

- Adjust parameters and configurations in the scripts as needed to suit your specific requirements.
- For any issues or questions, please refer to the documentation or contact the repository owner via his professional (hongyi.su@irsn.fr) or personal (mikesu240@gmail.com) email.

