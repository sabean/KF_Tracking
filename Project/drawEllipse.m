function drawEllipse(mu, a, b, theta, str)
% mu is a 2-vector of the ellipse center.
% a and b are the half widths.
% The ellipse is inclined at angleRadians w.r.t the x_1 axis.
% str is a string of drawing specifications like 'b:' of 'r'
% circle = rsmak('circle');
% ellipse = fncmb(circle,diag([a,b]));
% st = sin(angleRadians);
% ct= cos(angleRadians);
% rtellipse = fncmb(fncmb(ellipse, [ct, st;-st, ct]), [mu(1);mu(2)]);
% hold on, fnplt(rtellipse,str);
t=-pi:0.01:pi;
vx= a*cos(t);
vy= b*sin(t);
x= mu(1) + vx.*cos(theta) - vy*sin(theta);
y= mu(2) + vx.*sin(theta) + vy*cos(theta);
plot(x,y, str); %, 'LineWidth', 2);
hold on;