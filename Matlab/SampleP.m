function [p_rand] = SampleP(p_start,p_stop)

if p_stop(1)-p_start(1)==0
    x=p_start(1)*rand;
    y=p_start(2)+(p_stop(2)-p_start(2))*rand;
    z=p_start(3)+(p_stop(3)-p_start(3))*rand;
else
    ky=(p_stop(2)-p_start(2))/(p_stop(1)-p_start(1));
    kz=(p_stop(3)-p_start(3))/(p_stop(1)-p_start(1));
    
    x=p_start(1)+(p_stop(1)-p_start(1))*rand;
    y=ky*(x-p_start(1))+p_start(2)+0.5*(-1+2*randn);
    z=kz*(x-p_start(1))+p_start(3)+0.5*(-1+2*randn);
end

p_rand=[x,y,z];
end
