function [p_rand] = SampleP1(plimit)

n=size(plimit,2);
p=zeros(1,n);
for i=1:n
    p(i)=plimit(1,i)+diff(plimit(:,i))*rand;%在正负限位范围内进行均匀分布采样
end

p_rand=p(1:3);
end

