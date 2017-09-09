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
            t_size=1;
            % RBF inputs
            X = [right;front;left];
            
            % Store RBF outputs for each iteration
            Z = zeros(1,z_size);
            for j=1:z_size
                
                %RBF function
                Z(j)=exp(-1*sqrt(sum((X'-Cs(j,:)).^2)));
            end
            % Insert bias
            Z = [-1 Z];
            
            % Calculate percetron results before activation function
            V = W*Z';
            
            % Sigmoid activation function for the Perceptron
            Y = 1./(1+exp(-V));
            % Map Sigmoid range (0|1) to the wheels range (-0.5|0.5)
            Y = (Y-0.5)
            
            % Set the robot wheels speed based on the RBF 
            % neural network output
            SetDriveWheelsCreate(serPort,Y(1,1,:),Y(2,1,:));
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