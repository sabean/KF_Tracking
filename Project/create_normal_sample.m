function [y]=  create_normal_sample(m, C)
% m is the mean
% C is the covariance

[U,S,V]= svd(C); % U and V will be the same.
Ssqrt= sqrt(S); % Element by element sqrt
D= U*Ssqrt*U';
x= random('Normal', 0, 1, size(m, 1), 1);
y= m + D*x;