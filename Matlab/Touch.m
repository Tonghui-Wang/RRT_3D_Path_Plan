function [finish,i_touch] = Touch(p_new, p_list)

finish=false;
radius=100.00;
i_touch=1;
n=size(p_list,1);

for i=1:n
    l=norm(p_new(1:3)-p_list(i,1:3));
    if l<=radius
        finish=true;
        i_touch=i;
        return;
    end
end
end
