function write_sphere_template_constant(filename, x_km_rotated, y_km_rotated, depth_km_rotated, radius_want, mu_s_in, mu_d_in, d_c_in, mu_s_out, mu_d_out, dc_out, xc, yc, zc, r_crit, Vs)
    fileID = fopen(filename, 'w');
    if fileID == -1
        error('Unable to open file for writing.');
    end
    fprintf(fileID, '!Switch\n');
    fprintf(fileID, '[mu_s, mu_d, d_c, cohesion]: !IdentityMap\n');
    fprintf(fileID, '  components:\n');
    for i = 1:length(x_km_rotated)
        fprintf(fileID, '    - !SphericalDomainFilter #%f,%f,%f\n', x_km_rotated(i)*1000, y_km_rotated(i)*1000, depth_km_rotated(i)*1000);
        fprintf(fileID, '      radius: %f\n', radius_want(i)*1000);
        fprintf(fileID, '      centre:\n');
        fprintf(fileID, '        x: %f\n', x_km_rotated(i)*1000);
        fprintf(fileID, '        y: %f\n', y_km_rotated(i)*1000);
        fprintf(fileID, '        z: %f\n', depth_km_rotated(i)*1000);
        fprintf(fileID, '      components: !ConstantMap\n');
        fprintf(fileID, '        map:\n');
        fprintf(fileID, '          mu_s:        %f\n', mu_s_in(i));
        fprintf(fileID, '          mu_d:        %f\n', mu_d_in(i));
        fprintf(fileID, '          d_c:         %f\n', d_c_in(i));
        if(-depth_km_rotated(i)*1000 <= 212)
            fprintf(fileID, '          cohesion: -2000000.0\n');
        else
            fprintf(fileID, '          cohesion: 0.0\n');
        end
    end
    fprintf(fileID, '    - !ConstantMap\n');
    fprintf(fileID, '      map:\n');
    fprintf(fileID, '        mu_s:        %f\n', mu_s_out);
    fprintf(fileID, '        mu_d:        %f\n', mu_d_out);
    fprintf(fileID, '        d_c:         %f\n', dc_out);
    fprintf(fileID, '        cohesion: -10000000.0\n');
    fprintf(fileID, '[forced_rupture_time]: !FunctionMap\n');
    fprintf(fileID, '  map:\n');
    fprintf(fileID, '    forced_rupture_time: |\n');
    fprintf(fileID, '      xc = %f;\n', xc);
    fprintf(fileID, '      yc = %f;\n', yc);
    fprintf(fileID, '      zc = %f;\n', zc);
    fprintf(fileID, '      r = sqrt(pow(x - xc, 2.0) + pow(y - yc, 2.0) + pow(z - zc, 2.0));\n');
    fprintf(fileID, '      r_crit = %f;\n', r_crit);
    fprintf(fileID, '      Vs = %f;\n', Vs);
    fprintf(fileID, '      if (r <= r_crit) {\n');
    fprintf(fileID, '        return r/(0.7*Vs)+(0.081*r_crit/(0.7*Vs))*(1.0/(1.0-pow(r/r_crit, 2.0))-1.0);\n');
    fprintf(fileID, '      }\n');
    fprintf(fileID, '      return 1000000000.0;\n');
    fprintf(fileID, '[s_xx, s_yy, s_zz, s_xy, s_yz, s_xz]: !Include stress_field_aochi_S_0.2.yaml\n');
    % Close the file
    fclose(fileID);
    disp(['Data has been written to file: ', filename]);
end
