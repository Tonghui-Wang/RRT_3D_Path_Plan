function p_edge = Edge(p_new,p_parent)

n=ceil(norm(p_new(1:3)-p_parent(1:3))/10);
m=length(p_new);
p_edge=zeros(n,m);

for i=1:m
    p_edge(:,i)=linspace(p_parent(i), p_new(i), n);
end
    
end
