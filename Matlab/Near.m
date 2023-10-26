function [p_near, i_near] = Near(p_rand,p_list)

l_max=inf;
n=size(p_list,1);
for i=1:n
    l=norm(p_rand(1:3)-p_list(i,1:3));
    if l<l_max
        l_max=l;
        p_near=p_list(i,1:3);
        i_near=i;
    end
end
end
