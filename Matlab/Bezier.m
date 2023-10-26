function Bezier(p_collect)

n=size(p_collect,2)-1;
t=0:0.001:1;
x=(1-t).^(n)*p_collect(1,1);
y=(1-t).^(n)*p_collect(2,1);
z=(1-t).^(n)*p_collect(3,1);

for i=1:n
    w=factorial(n)/(factorial(i)*factorial(n-i))*(1-t).^(n-i).*t.^(i);
    x=x+w*p_collect(1,i+1);
    y=y+w*p_collect(2,i+1);
    z=y+w*p_collect(3,i+1);
end
plot3(p_collect(1,:), p_collect(2,:), p_collect(3,:), 'b');
hold on;
grid on;
axis tight;
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(x,y,z,'r');
end
