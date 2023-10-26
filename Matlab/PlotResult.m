function PlotResult(p_collect)

x=linspace(min(p_collect(:,1)),max(p_collect(:,1)),100);
y=spline(p_collect(:,1),p_collect(:,2),x);
z=spline(p_collect(:,1),p_collect(:,3),x);
plot3(x, y, z, 'm-', 'Linewidth', 3);
end
