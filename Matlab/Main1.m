clc
clear all;
close all;

%% 初始化
p_start_full=Fkine([0,0,-40,0,0,0]);
% p_stop_full=Fkine([-12,-23,34,-45,56,-67]);
% p_start_full=[200,-400,350,0,0,0];
p_stop_full=[1000,650,300,0,0,0];

p_start=p_start_full(1:3);
p_stop=p_stop_full(1:3);
p_list=[p_start,0,0];
jlimit=[-90, -90, -90, -180, -180, -180; +90, +90, +90, +180, +180, +180]; 
plimit=[0, -1500, -300, -180, -180, -180; +1500, +1500, +1200, +180, +180, +180]; 
loop=1000;
finish=false;

%定义障碍物
obstacle=Obstacle(true);

figure;
hold on;
% grid on;
% Workspace(jlimit);
plot3(p_start(1), p_start(2), p_start(3), 'ro', 'MarkerSize',5, 'MarkerFaceColor','r');
plot3(p_stop(1), p_stop(2), p_stop(3), 'ro', 'MarkerSize',5, 'MarkerFaceColor','r');
PlotObstacle(obstacle);

tic;

for i=1:loop
    %% 采样
        p_rand=SampleJ(jlimit);
%         p_rand=SampleP1(plimit);
%     p_rand=SampleP(p_start,p_stop);
    temp=plot3(p_rand(1), p_rand(2), p_rand(3), 'g*', 'MarkerSize',2, 'MarkerFaceColor','g');
    
    %% 找到列表中最接近的点
    [p_near, i_near]= Near(p_rand,p_list);
    
    %% 计算新节点
    p_new = Steer(p_start,p_rand,p_near,p_stop);
    delete(temp);
    temp=plot3(p_new(1), p_new(2), p_new(3), 'b*', 'MarkerSize', 2);
    
    %% 新节点父级
    [p_parent, i_parent] = Parent(p_list,p_new,i_near);
    
    %% 计算新连线(连线数据离散化)
    p_edge = Edge(p_new, p_parent);
    
    %% 检测新连线(碰撞验证)
    feasible = Collision(p_edge,obstacle);
    if ~feasible
        continue;
    end
    
    p_list= AddNode(p_list,p_new,i_parent);
    plot3([p_parent(1),p_new(1)], [p_parent(2),p_new(2)],[p_parent(3),p_new(3)], 'b-');
    
    %% 检测终点到达
    finish=Goal(p_new, p_stop);
    if finish
        p_edge = Edge(p_new, p_stop);
        feasible = Collision(p_edge,obstacle);
        if ~feasible
            finish=false;
            continue;
        end
        
        toc;
        p_parent=p_new;
        p_new=p_stop;
        p_list= AddNode(p_list,p_new,size(p_list,1));
        plot3([p_parent(1),p_new(1)],[p_parent(2),p_new(2)],[p_parent(3),p_new(3)], 'b-');
        
        p_collect=Extract(p_list);
        plot3(p_collect(:,1), p_collect(:,2), p_collect(:,3),'m-', 'Linewidth', 3)
%         PlotResult(p_collect);
        fprintf('all point-number is %d\nall path-cost is %.2f\n',size(p_collect,1), p_list(end,4));
        fprintf('finish\n');
        break;
    end
    
%     pause(0.01); %暂停一会，使得rrt扩展容易观察
    
    %% 生成gif动图
    frame=getframe(gcf);
    imind=frame2im(frame);
    [imind,cm] = rgb2ind(imind,256);
    if i==1
         imwrite(imind,cm,'rrt.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
    else
         imwrite(imind,cm,'rrt.gif','gif','WriteMode','append','DelayTime',1e-4);
    end
end
