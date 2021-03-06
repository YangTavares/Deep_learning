function finalRad= ExampleControlProgram(serPort)

    
    % Set constants for this program
    maxDuration= 1200;  % Max time to allow the program to run (s)
    maxFwdVel= 0.5;     % Max allowable forward velocity with no angular 
                        % velocity at the time (m/s)   
    
    % Initialize loop variables
    tStart= tic;        % Time limit marker
    
    % Load trained RBF parameters to move the robot
    load('weights')
    
    % Enter main loop
    while toc(tStart) < maxDuration
        % Check for and react to bump sensor readings
        % 1 - right, 2 - front, 3 - left, 4 - back
        front = ReadSonarMultiple(serPort,2);
        right = ReadSonarMultiple(serPort,1);
        left = ReadSonarMultiple(serPort,3);
        
        % Check for bugs on sensors reading
        if length([right; front; left])==3
            [status,term_out] = system('swipl -s plscript.pl 0 0 0')
            wheels_speeds =  str2num(term_out);
            % If the sensors bug, rotate the robot
            SetDriveWheelsCreate(serPort,wheels_speeds(1),wheels_speeds(2));
        else
            % If the sensors bug, rotate the robot
            SetDriveWheelsCreate(serPort,-0.5,0.5);
        end
        % Get robot position
        [x y th]= OverheadLocalizationCreate(serPort);
        
        % Print a red star on the robot position
        plot(x,y,'r*');
        %end
        pause(0.1)
    end
    
    % Specify output parameter
    finalRad= 0;
    
    % Stop the robot
    SetFwdVelAngVelCreate(serPort,0,0)
end