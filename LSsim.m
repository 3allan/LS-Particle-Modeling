% 
% Matt Werner (m.werner@vt.edu) - June 18, 2021
% 
% 

% Test an LS run
clear, clc
makeStation
for particles = 1:100
    clear k x y z t up vp wp T
    k = 1;
    t(1) = 0;
    x(1) = 0;
    y(1) = 0;
    z(1) = 1;
    up(1) = interp1([station.z;0], [station.up;0], z, 'spline');
    vp(1) = interp1([station.z;0], [station.vp;0], z, 'spline');
    wp(1) = interp1([station.z;0], [station.wp;0], z, 'spline');
    T(1) = station.Tsurface;
    while (t(k) < 200)
        [t(k+1), x(k+1), y(k+1), z(k+1), up(k+1), vp(k+1), wp(k+1), T(k+1)] = LSstep(t(k), x(k), y(k), z(k), up, vp, wp, T, station);
        if (z(k+1) <= 0)
            break
        end
        k = k + 1;
    end
    plot3(x, y, z), hold on
    grid on%, grid minor
    xlabel("Downwind $x$ [m]", 'Interpreter', 'latex')
    ylabel("Crosswind $y$ [m]", 'Interpreter', 'latex')
    zlabel("Vertical $z$ [m]", 'Interpreter', 'latex')
    pause(0.005)
end
% xlim([0,5]), ylim([-2.5,2.5]), zlim([0.75,1.25])