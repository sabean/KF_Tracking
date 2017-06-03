function [m, P]=  kalmanfilter_predict(model, m, u)
 % insitializations 
  R = model.R;
  P = model.P;
 % update step
 [f, E, A] = update(model,m,u);
 % prediction step
 m = f; 
 P = A*P*A' + E*R*E';
 end
