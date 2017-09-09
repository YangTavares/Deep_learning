X = [3 3 1 3 3 1 3 1 0.1 3 2 3 3 3 2 2 2 3 3 3 1 2 2 2;%f
     1 0.5 3 2 2 1 0 3 0.1 3 3 2 3 3 2 3 3 2 2 3 2 1 2 2;%d
     0.5 2 1 2 2 3 0 1 0.1 3 3 3 2 3 3 2 3 2 3 2 2 2 1 2;%e
     0.3 1 0 0 3 1 0 1 3 3 3 3 3 2 3 3 2 3 2 2 2 2 2 1];%t

 
 D = [0.5 0.5 0.5 0.5 0.5 -0.3 0.5 0.5 -0.5 0.5 -0.5 -0.5 0.4 0.5 0.4 -0.5 -0.5 0.5 -0.4 0.5 0.5 -0.5 -0.5 0.2;%e
     0.5 0.5 0.3 0.5 0.5 0.5 0.5 -0.3 -0.5 0.5 0.4 0.3 -0.5 0.5 -0.5 0.4 0.4 0.5 0.5 -0.4 0.5 0.4 0.4 -0.5];%d
 
t_size = 24;   % training set size
out_size = 2;  % output size
in_size = 4;   % input size
z_size = 120;  % Number of RBF functions
Cs_rand_factor = 1; % Cs discrepancy

% Initializing random Centers
Cs = Cs_rand_factor.*rand(z_size,in_size); 

% Calculating maximum euclidian distance
% Between centers
dmax = max(pdist(Cs,'euclidean'));

% Calculating sigma square for the RBF function
sigma_sqr = (dmax.^2)/(2*out_size); 

% Initialize random weights for 
W = rand(out_size,z_size+1); 

% Variable to implement momentum factor
WAnt = zeros(out_size,z_size+1);

%Resulting Perceptron inputs after RBF function
RBF_ins = zeros(z_size,t_size);

%Variable to store RBF results for each loop iteration
Z = zeros(1,z_size);

%Get a Matrix with all RBF results for batch training mode
for i=1:t_size
    for j=1:z_size
        % RBF function
        Z(j)=exp((-1/(2*sigma_sqr))*sqrt(sum((X(:,i)'-Cs(j,:)).^2)));
    end
    RBF_ins(:,i)= Z;
end

step_size = 1; % step parameter
momentum = 0.00000001; % Momentum parameter
D = D+0.5; % Mapping training set to sigmoid range (0-1)
epoch = 1000000;

MSE = zeros(1,epoch); % Error vector to analyze results

RBF_ins = [-1*ones(1,t_size) ; RBF_ins]; % Insert bias

% Train output layer (perceptrons with sigmoid activation function)
% batch mode
for i=1:epoch
    % Random permutation for batch algorithm to 
    % better train the neural network
    k = randperm(t_size);
    % Perceptron result before the activation function
    V = W*RBF_ins(:,k);
    % Applying the sigmoid function
    Y = 1./(1+exp(-V));
    % Calculating the error
    E = D(:,k) - Y;
    
    % Mean square error calculation
    mse_t = mean(mean(E.^2))
    MSE(i) = mse_t;
    T = W;
    
    % Gradient descent calculation based on Sigmoid derivative
    % and the error
    dGf = Y.*(1-Y).*E;
    
    % Weight update based on a step factor and the inputs
    g_step = step_size.*dGf*RBF_ins(:,k)';
    
    % Weight update with momentum
    W = W + g_step + WAnt.*momentum;
    WAnt = T;
   
end
% Print error 
semilogy(MSE);

% Save the trained RBF neural network to be used on the iRobot toolbox
save('weights','W','t_size','out_size','in_size','z_size','Cs');

%% 

X = [3 3 1 3 3 1 3 1 0.1 3 2 3 3 3 2 2 2 3 3 3 1 2 2 2;%f
     1 0.5 3 2 2 1 0 3 0.1 3 3 2 3 3 2 3 3 2 2 3 2 1 2 2;%d
     0.5 2 1 2 2 3 0 1 0.1 3 3 3 2 3 3 2 3 2 3 2 2 2 1 2;%e
     0.3 1 0 0 3 1 0 1 3 3 3 3 3 2 3 3 2 3 2 2 2 2 2 1];%t

 RBF_ins = zeros(z_size,t_size);
 
for i=1:t_size
    for j=1:z_size
        Z(j)=exp(-1*sqrt(sum((X(:,i)'-Cs(j,:)).^2)));
    end
    RBF_ins(:,i)= Z;
end
RBF_ins = [-1*ones(1,t_size) ; RBF_ins];
V = W*RBF_ins;
Y = 1./(1+exp(-V));
Y = Y-0.5
D = D-0.5

%Frontcords = zeros(1,3);
%Leftcords = zeros(1,3);
%Rightcords = zeros(1,3);
%figure;
%hold on;
%for right=[0 0.1 0.2 0.4 0.8 1.6 3]
%    for front=[0 0.1 0.2 0.4 0.8 1.6 3] 
%        for left=[0 0.1 0.2 0.4 0.8 1.6 3]
%            X = [right;front;left];
%            Z = zeros(1,z_size);
%            for j=1:z_size
%                Z(j)=exp(-1*sqrt(sum((X'-Cs(j,:)).^2)));
%            end
%            Z = [-1 Z];

%            V = W*Z';
%            Y = 1./(1+exp(-V));
%            Y = (Y-0.5);
%            if (abs(Y(1,1,:)-Y(2,1,:)))< 0.05
%                Frontcords = [Frontcords;right front left];
%            elseif Y(1,1,:) > Y(2,1,:)
%                Leftcords = [Leftcords;right front left];
%            else
%                Rightcords = [Rightcords;right front left];
%            end
%        end
%    end
%end
%stem3(Frontcords(:,1),Frontcords(:,2),Frontcords(:,3),'filled','Color','g');
%stem3(Leftcords(:,1),Leftcords(:,2),Leftcords(:,3),'filled','Color','r');
%stem3(Rightcords(:,1),Rightcords(:,2),Rightcords(:,3),'filled','Color','b');
%xlabel('Right')                                                      
%ylabel('Front') 
%zlabel('Left') 
%legend('Foward', 'Left', 'Right')
%hold off;


