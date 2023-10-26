clc
clear all;
close all;

%% 初始化
% p_start_full=Fkine([0,-5,-30,10,-23,34]);
% p_stop_full=Fkine([12,-23,34,-45,56,-67]);
p_start_full=[200,-400,350,0,0,0];%起点笛卡尔坐标xyzabc
p_stop_full=[1000,800,300,0,0,0];%终点笛卡尔坐标xyzabc

p_start=p_start_full(1:3);%获取起点xyz
p_stop=p_stop_full(1:3);%获取终点xyz
p_list1=[p_start,0,0];%树1节点列表
p_list2=[p_stop,0,0];%树2节点列表
jlimit=[-90, -90, -90, -180, -180, -180; +90, +90, +90, +180, +180, +180];%关节空间限位约束
plimit=[0, -1500, -300, -180, -180, -180; +1500, +1500, +1200, +180, +180, +180];%笛卡尔空间限位约束
loop=1000;%迭代次数
finish=false;

%定义障碍物
obstacle=Obstacle(true);

figure;
hold on;
% grid on;
% Workspace(jlimit);
plot3(p_start(1), p_start(2), p_start(3), 'bo', 'MarkerSize',8, 'MarkerFaceColor','b');
plot3(p_stop(1), p_stop(2), p_stop(3), 'ro', 'MarkerSize',8, 'MarkerFaceColor','r');
PlotObstacle(obstacle);

tic;

for i=1:loop
    treenum=mod(i,2);%每个loop只操作一棵树，两个树轮换操作
    
    %% 采样
    p_rand=SampleJ(jlimit);
    %         p_rand=SampleP1(plimit);
    %     p_rand=SampleP(p_start,p_stop);
    temp=plot3(p_rand(1), p_rand(2), p_rand(3), 'g*', 'MarkerSize',2, 'MarkerFaceColor','g');
    
    if treenum==1
        %% 树1 找到列表中最接近的点
        [p_near, i_near]= Near(p_rand,p_list1);
        
        %% 树1 计算新节点
        p_new = Steer(p_start,p_rand,p_near,p_stop);
        delete(temp);
        temp=plot3(p_new(1), p_new(2), p_new(3), 'b*', 'MarkerSize', 2);
        
        %% 树1 新节点父级
        [p_parent, i_parent] = Parent(p_list1,p_new,i_near);
        
        %% 树1 计算新连线(连线数据离散化)
        p_edge = Edge(p_new, p_parent);
        
        %% 树1 检测新连线(碰撞验证)
        feasible = Collision(p_edge,obstacle);
        if ~feasible
            delete(temp);
            continue;
        end
        p_list1= AddNode(p_list1,p_new,i_parent);

        plot3([p_parent(1),p_new(1)], [p_parent(2),p_new(2)],[p_parent(3),p_new(3)], 'b-');
        
        %% 树1 检测交叉接触
        [finish, i_touch]=Touch(p_new, p_list2);
        if finish
            p_edge = Edge(p_new, p_list2(i_touch,:));
            feasible = Collision(p_edge,obstacle);
            if ~feasible
                finish=false;
                continue;
            end
            plot3([p_list2(i_touch,1),p_new(1)],[p_list2(i_touch,2),p_new(2)],[p_list2(i_touch,3),p_new(3)], 'b-');
        end
    else
        %% 树2 找到列表中最接近的点
        [p_near, i_near]= Near(p_rand,p_list2);
        
        %% 树2 计算新节点
        p_new = Steer(p_stop,p_rand,p_near,p_start);
        delete(temp);
        temp=plot3(p_new(1), p_new(2), p_new(3), 'r*', 'MarkerSize', 3);
        
        %% 树2 新节点父级
        [p_parent, i_parent] = Parent(p_list2,p_new,i_near);
        
        %% 树2 计算新连线(连线数据离散化)
        p_edge = Edge(p_new, p_parent);
        
        %% 树2 检测新连线(碰撞验证)
        feasible = Collision(p_edge,obstacle);
        if ~feasible
            delete(temp);
            continue;
        end
        p_list2= AddNode(p_list2,p_new,i_parent);
        
        plot3([p_parent(1),p_new(1)], [p_parent(2),p_new(2)],[p_parent(3),p_new(3)], 'r-');
        
        %% 树2 检测交叉接触
        [finish, i_touch]=Touch(p_new, p_list1);
        if finish
            p_edge = Edge(p_new, p_list1(i_touch,:));
            feasible = Collision(p_edge,obstacle);
            if ~feasible
                finish=false;
                continue;
            end
            plot3([p_list1(i_touch,1),p_new(1)],[p_list1(i_touch,2),p_new(2)],[p_list1(i_touch,3),p_new(3)], 'r-');
        end
    end
    
    if finish
%         toc;
        
        p_collect = Collect(p_list1,p_list2,i_touch,treenum);
        p_optimize = Optimize(p_collect);
        plot3(p_collect(:,1), p_collect(:,2), p_collect(:,3),'y-', 'Linewidth', 2);
        plot3(p_optimize(:,1), p_optimize(:,2), p_optimize(:,3),'g-', 'Linewidth', 2);
        %       PlotResult(p_collect);
        fprintf('all point-number is %d\nfinish\n',size(p_collect,1));
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
toc;
