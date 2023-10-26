function [p_parent, i_parent] = Parent(p_list,p_new,i_near)

radius=30.00;
p_list_near=[];
n=size(p_list,1);
for i=1:n
    l=norm(p_new(1:3)-p_list(i,1:3));
    if l<=radius
        p_list_near=[p_list_near; p_list(i,1:3),i];
    end
end

l_max=inf;
n=size(p_list_near, 1);
if n==0
    p_parent=p_list(i_near,1:3);
    i_parent=i_near;
    return;
end

for i=1:n
    l=norm(p_new(1:3)-p_list_near(i,1:3));
    if l<=l_max
        l_max=l;
        p_parent=p_list_near(i,1:3);
        i_parent=p_list_near(i,end);
    end
end
end
