function [p_rand] = SampleJ(jlimit)

n=size(jlimit,2);
q=zeros(1,n);
for i=1:n
    q(i)=jlimit(1,i)+diff(jlimit(:,i))*rand;%在正负限位范围内进行均匀分布采样
end

p=Fkine(q);
p_rand=p(1:3);
end
