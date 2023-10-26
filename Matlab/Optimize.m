function [p_optimize]=Optimize(p_collect)

k=4;%滑动滤波连续k个点输出1次
n=size(p_collect,1)-1;
vector=zeros(n,3);
p_optimize=p_collect;

for i=1:n
    vector(i,:)=p_collect(i+1,:)-p_collect(i,:);
end

i=1;
j=n;
while true
    vector(i,:)=mean(vector(i:i+(k-1),:));
    vector(j,:)=mean(vector(j-(k-1):j,:));
    if mod(n,2)==0
        if (i-j==1)
            break;
        end
    else
        if (i==j)
            break;
        end
    end
    i=i+1;
    j=j-1;
end

n=size(p_optimize,1);
i=1;
j=n;
if mod(n,2)==0
    while true
        p_temp1=p_optimize(i,:)+vector(i,:);
        p_temp2=p_optimize(j,:)-vector(j-1,:);
        if (i+1==j)%首尾相背1
            p_optimize(i+1,:)=mean([p_optimize(i+1,:); p_temp1]);
            p_optimize(j-1,:)=mean([p_optimize(j-1,:); p_temp2]);
        elseif (i-1==j)%首尾相背2
            p_optimize(i+1,:)=mean([p_optimize(i+1,:); p_temp1]);
            p_optimize(j-1,:)=mean([p_optimize(j-1,:); p_temp2]);
            break;
        else%首尾相向
            p_optimize(i+1,:)=p_temp1;
            p_optimize(j-1,:)=p_temp2;
        end
        i=i+1;
        j=j-1;
    end
else
    while true
        p_temp1=p_optimize(i,:)+vector(i,:);
        p_temp2=p_optimize(j,:)-vector(j-1,:);
        if (i+1==j-1)%首尾相遇
            p_optimize(i+1,:)=mean([p_temp1; p_temp2]);
        elseif (i==j)%首尾相背
            p_optimize(i+1,:)=mean([p_optimize(i+1,:); p_temp1]);
            p_optimize(j-1,:)=mean([p_optimize(j-1,:); p_temp2]);
            break;
        else%首尾相向
            p_optimize(i+1,:)=p_temp1;
            p_optimize(j-1,:)=p_temp2;
        end
        i=i+1;
        j=j-1;
    end
end

% figure(1);
% hold on;
% plot3(p_collect(:,1), p_collect(:,2), p_collect(:,3),'y-', 'Linewidth', 2);
% plot3(p_optimize(:,1), p_optimize(:,2), p_optimize(:,3),'g-', 'Linewidth', 2);
end
