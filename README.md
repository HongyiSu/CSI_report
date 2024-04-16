# CSI_report

This archive stores the Matlab / Python scripts that created the figures in the CSI report. 

# To create input YAML fault properties file: 

sphere_reduced_patches.m as driver:
  depend on -> write_fault_properties_sphere.m 
                depend on -> ball_show.m (create spherical patches figure)
                                  depend on -> remove.m (filter point source based on certain criteria)
                                            -> rotate_cartesian.m (rotate source coordinates by strike angle to match the fault geometry in the mesh)
                                            -> draw_ball.m (plot a ball, centered at each point source)
                                  
                          -> write_sphere_template_constant.m (write the YAML input)
      
