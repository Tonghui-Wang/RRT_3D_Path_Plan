function [p_collect] = Collect(p_list1,p_list2,i_touch,treenum)

p_collect=[];

if treenum==1
    p_temp=Extract(p_list1, size(p_list1,1));
    p_collect=p_temp(end:-1:1,:);
    p_temp=Extract(p_list2, i_touch);
    p_collect=[p_collect; p_temp];
else
    p_temp=Extract(p_list2, size(p_list2,1));
    p_collect=p_temp(end:-1:1,:);
    p_temp=Extract(p_list1, i_touch);
    p_collect=[p_collect; p_temp];
end
end

function [p_temp] = Extract(p_list, i)
p_temp=[];
j=1;

while true
    p_temp(j,1:3)=p_list(i,1:3);
    i=p_list(i,end);
    j=j+1;
    if i==0
        break;
    end
end
end
