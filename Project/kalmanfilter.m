function [m, P, mu_pred, P_pred]=  kalmanfilter(model, m, P, u, z)
 % prediction
 [m, P]=  kalmanfilter_predict(model, m, P, u);
 
 if (nargout > 2)
     mu_pred= m;
     P_pred= P;
 end;

 [m, P]=  kalmanfilter_correct(model, m, P, z);
 