function write_fault_properties_sphere(mu_s_hetero, mu_d_hetero, dc_hetero, dd)
    x_km = dd.data(:,1);
    y_km = dd.data(:,2);
    depth_km = dd.data(:,3);
    strike = dd.data(:,4);
    dip = dd.data(:,5);
    rake = dd.data(:,6);
    ontime_s = dd.data(:,7);
    slip_cm = dd.data(:,8);
    ampsliprate1 = dd.data(:,9); %cm/s
    ampsliprate2 = dd.data(:,10); %cm/s
    ampsliprate3 = dd.data(:,11); %cm/s
    M0_subfault = dd.data(:,12); %dyn.cm
    if(mu_s_hetero == true)
        mu_s = 0.6*(1-slip_cm/100);
        var = mu_s;
        var_name = 'mus';
    else
        mu_s = 0.6*ones(length(slip_cm),1);
    end
    if(mu_d_hetero == true)
        mu_d = 0.2*(1-slip_cm/100);
        var = mu_d;
        var_name = 'mud';
    else
        mu_d = 0.2*ones(length(slip_cm),1);
    end
    if(dc_hetero == true)
        d_c = 0.05*(1-slip_cm/100);
        var = d_c;
        var_name = 'dc';
    else
        d_c = 0.05*ones(length(slip_cm),1);
    end
    if((mu_s_hetero || mu_d_hetero || dc_hetero) == false)
        var = slip_cm;
        var_name = 'slip';
    end
    
    scale_sphere = 0.02;
    [x_rotated, y_rotated_translation, z_trim, slip_trim, radius_trim] = ball_show(x_km,y_km, depth_km, slip_cm, var, var_name, scale_sphere);
    %fault properties inside nucleation
    if(mu_s_hetero == true)
        mu_s_t = 0.6*(1-slip_trim/100);
    else
        mu_s_t = 0.6*ones(length(slip_trim),1);
    end
    if(mu_d_hetero == true)
        mu_d_t = 0.2*(1-slip_trim/100);
    else
        mu_d_t = 0.2*ones(length(slip_trim),1);
    end
    if(dc_hetero == true)
        d_c_t = 0.05*(1-slip_trim/100);
    else
        d_c_t = 0.05*ones(length(slip_trim),1);
    end
    mu_s_in = mu_s_t;
    mu_d_in = mu_d_t;
    d_c_in = d_c_t;
    %fault properties outside nucleation
    mu_s_out = 0.6;
    mu_d_out = 0.2;
    dc_out = 0.05;
    %define nuclation
    xc = 49.723; %m_
    yc = -648.912;
    zc = -999.237;
    r_crit = 500; 
    Vs = 300; %forced initial nucleation speed m/s
    write_sphere_template_constant(['/Users/mikesu/Desktop/kinematic/input_template/sphere_low_' var_name '.yaml'], ...
    x_rotated, y_rotated_translation, -z_trim, ...
    radius_trim, mu_s_in, mu_d_in, d_c_in, mu_s_out, ...
    mu_d_out, dc_out, xc, yc, zc, r_crit, Vs)
end
