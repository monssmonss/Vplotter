function P = plot_arc(Initial_angle,End_angle,x_center,y_center,radius,LineStyle)

t = linspace(Initial_angle*pi/180,End_angle*pi/180,150);
x = radius*cos(t) + x_center;
y = radius*sin(t) + y_center;
P = plot(x,y,'k','LineStyle',LineStyle);
end