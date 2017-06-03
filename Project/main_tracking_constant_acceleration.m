% Sabin bhandari
% Ashish Khanal

clear all;
draw_covs= 1;

model.T= 0.1; % Sample-time for prediction
model.L = 10;

% Initial state covariance
model.P = [3^2, 0, 0;...
	   0, 3^2, 0;...
	   0, 0, (pi/60)^2];
   
% Only x,y are observed.
model.H = [1, 0, 0; ...
           0, 1, 0];
       
% Observation Noise Covariance
model.Q = [5^2, 0; ...
             0, 5^2];
         
model.R= [0.2^2, 0; ...
          0, (pi/30)^2];
 
% Get first sample from the sensor
ground_truth= [0; 0];

% Initial state
heading = 0;
m = [0, 0, heading]'; 
v = 1; A = pi/4; w = 2*pi/100; s = A*(sin(w*0)); % nominal applied inputs : forward velocity, amplitude and steering 
u = [v; s];   % time-trajectory of nominal applied inputs


% intial update stage 
[model.f, model.E, model.A] = update(model, m, u);

% ground truth for the sensor used to initialize initial position
mg = [ground_truth; 0];
K = 50;

for t= 0: model.T: 200
    % Ground truth implementation to calculate mg = (xg; yg)
    sample_ground_input= create_normal_sample(u, model.R);   
    mg = update(model, mg, sample_ground_input);
    plot(mg(1), mg(2), 'k.'); hold on;
    
    % calculation of the predicted position m = (x; y)
    [m, model.P]=  kalmanfilter_predict(model, m, u);
    plot(m(1), m(2), 'r.'); hold on;
 
    % Show covariance only every few second
    if (mod(t, K*model.T) == 0)&&(draw_covs == 1)
        P_xy= model.P(1:2, 1:2); % Pick out only the x-y uncertainty.
        [evec1,eval1]= eig(P_xy);
        theta1= acos([1,0]*evec1(:,1));
        drawEllipse(m, 2*sqrt(eval1(1,1)), 2*sqrt(eval1(2,2)), theta1, 'k');
    end
    
    % Apply correction only every k*T second
    if(mod(t, K*model.T) == 0)
        ground_truth = [mg(1); mg(2)];
        z= create_normal_sample(ground_truth, model.Q);
        plot(z(1), z(2), 'bx'); hold on;
        % correction step of our position
        [m, model.P]=  kalmanfilter_correct(model, m, z);
        if (draw_covs == 1)
            P_xy= model.P(1:2, 1:2); % Pick out only the x-y uncertainty.
            [evec1,eval1]= eig(P_xy);
            theta1= acos([1,0]*evec1(:,1));
            drawEllipse(m, 2*sqrt(eval1(1,1)), 2*sqrt(eval1(2,2)), theta1, 'b');
        end;
    end
    % non linear sinusoid path dependent on the time
    u(2) = A*(sin(w*t));
end
axis equal;  

     
 
     
