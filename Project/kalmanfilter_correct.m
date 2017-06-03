 function [m, P]=  kalmanfilter_correct(model, m, z)
   % initializations
   H = model.H;
   Q = model.Q;
   P = model.P;
 
   % correction
   K = P*H'*inv(H*P*H' + Q);
   m = m + K*(z - H*m);
   P = (eye(size(m, 1)) - K*H)*P;
 end
