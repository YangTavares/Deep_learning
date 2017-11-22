function finalRad= ExampleControlProgram(serPort)

    
    % Set constants for this program
    maxDuration= 1200;  % Max time to allow the program to run (s)
    maxFwdVel= 0.5;     % Max allowable forward velocity with no angular 
                        % velocity at the time (m/s)   
    i=0;
    % Initialize loop variables
    tStart= tic;        % Time limit marker
    
    % Enter main loop
        
    load('last_generation');
    [out i] = min(fitness);
    plot(population{i}(:,1),population{i}(:,2),'O');
    hold on
    plot(population{i}(:,1),population{i}(:,2));
    pop_size = size(population{1});
    pop_size = pop_size(1);
    % Check for bugs on sensors reading
    for j = 1:pop_size
            
        [x y th]= OverheadLocalizationCreate(serPort);
        %th
        
        [population{i}(j,1,:) population{i}(j,2,:)];
        [x y]
        
        qy = sign(y-population{i}(j,2,:))
        qx = sign(x-population{i}(j,1,:))
        %Third cartesian plan
        if qx == -1 && qy == -1
            angle = (atan((y-population{i}(j,2,:))/(x-population{i}(j,1,:)))) - (pi/2);
            angle = (pi/2) + angle;
        %Fourth cartesian plan
        elseif qx == 1 && qy == -1
            angle = (atan((y-population{i}(j,2,:))/(x-population{i}(j,1,:))));
            angle = angle + pi;
        %Second cartesian plan0
        elseif qx == -1 && qy == 1
            angle = (pi/2) - (atan((y-population{i}(j,2,:))/(x-population{i}(j,1,:))));
            angle = (pi/2) - angle;
        %First cartesian plan
        elseif qx == 1 && qy == 1
            angle = (atan((y-population{i}(j,2,:))/(x-population{i}(j,1,:))));
            angle = angle - pi;
        else
            angle = 0;
        end
        if angle > 3.14
            angle = 3.14;
        elseif angle < -3.14
            angle = -3.14;
        end
        %turn_angle = (360/(2*pi))*(angle-th);
        %turnAngle(serPort,5,turn_angle);

        while (abs(angle-th)) > 0.1
            [x y th]= OverheadLocalizationCreate(serPort);
            angle
            th
            SetDriveWheelsCreate(serPort,0.04,-0.04);
            pause(0.2);
        end
        %SetDriveWheelsCreate(serPort,0.0,0.0);
        distance = sqrt(sum(([x y] - population{i}(j,:)) .^ 2));
        travelDist(serPort,0.5,distance);
    end
    % Specify output parameter
    finalRad= 0;
    
    % Stop the robot
    SetFwdVelAngVelCreate(serPort,0,0)
end