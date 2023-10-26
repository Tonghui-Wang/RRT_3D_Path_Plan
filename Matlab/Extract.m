function [p_collect] = Extract(p_list)

% p_collect=zeros(p_list(end,end)+1,3);
p_collect=[];
i=size(p_list,1);
j=1;

while true
    p_collect(j,1:3)=p_list(i,1:3);
    i=p_list(i,end);
    j=j+1;
    if i==0
        break;
    end
end
end
