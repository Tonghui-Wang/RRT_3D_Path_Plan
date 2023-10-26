function finish = Goal(p_new,p_stop)

radius=100.00;
l=norm(p_new(1:3)-p_stop(1:3));
if l<=radius
    finish=true;
else
    finish=false;
end
end
