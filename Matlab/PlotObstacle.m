function PlotObstacle(obstacle)

n=length(obstacle.cube);
for i = 1:n
    if obstacle.cube(i).exist
        plotcube(obstacle.cube(i).lwh, obstacle.cube(i).xyz,...
                0.5, [0.5 0.5 0.5]);
    end
end

n=length(obstacle.cylinder);
for i = 1:n
    if obstacle.cylinder(i).exist
        plotcylinder(obstacle.cylinder(i).xyz, obstacle.cylinder(i).radius,...
                    obstacle.cylinder(i).height, 0.5, [0.5 0.5 0.5]);
    end
end

n=length(obstacle.sphere);
for i = 1:n
    if obstacle.sphere(i).exist
        plotsphere(obstacle.sphere(i).xyz, obstacle.sphere(i).radius,...
                   0.5, [0.5 0.5 0.5]);
    end
end
end

function plotcube(varargin)

% Default input arguments
inArgs = { ...
  [10 56 100] , ... % Default edge sizes (x,y and z)
  [10 10  10] , ... % Default coordinates of the origin point of the cube
  .7          , ... % Default alpha value for the cube's faces
  [1 0 0]       ... % Default Color for the cube
  };
% Replace default input arguments by input values
inArgs(1:nargin) = varargin;
% Create all variables
[edges,origin,alpha,clr] = deal(inArgs{:});
XYZ = { ...
  [0 0 0 0]  [0 0 1 1]  [0 1 1 0] ; ...
  [1 1 1 1]  [0 0 1 1]  [0 1 1 0] ; ...
  [0 1 1 0]  [0 0 0 0]  [0 0 1 1] ; ...
  [0 1 1 0]  [1 1 1 1]  [0 0 1 1] ; ...
  [0 1 1 0]  [0 0 1 1]  [0 0 0 0] ; ...
  [0 1 1 0]  [0 0 1 1]  [1 1 1 1]   ...
  };
XYZ = mat2cell(...
  cellfun( @(x,y,z) x*y+z , ...
    XYZ , ...
    repmat(mat2cell(edges,1,[1 1 1]),6,1) , ...
    repmat(mat2cell(origin,1,[1 1 1]),6,1) , ...
    'UniformOutput',false), ...
  6,[1 1 1]);
cellfun(@patch,XYZ{1},XYZ{2},XYZ{3},...
  repmat({clr},6,1),...
  repmat({'FaceAlpha'},6,1),...
  repmat({alpha},6,1)...
  );
view(3);
end

function plotcylinder(coor,radius,height,facealpha,color)
 
%% plot_cylinder(dat_xia(k2,1:3),dat_xia(k2,4),dat_xia(k2,5),1,rand(1,3));
%  第一个参数是圆柱体的底部圆心坐标值，第二个参数是圆柱体半径，第三个参数是圆柱高度
%  第四个参数是透明度，第五个参数是颜色矩阵
 
%% 函数解释：把这个函数当做黑箱处理，只需要记住函数的输入就可以，知道是干什么的，内部实现过于复杂，很难解释清楚
 
% coor:         中心坐标
% radius:       半径
% height:       高度
% facealpha:    透明度
% color:        颜色
 
r = radius;
theta = 0:0.3:pi*2;
hold on
 
for k1 = 1:length(theta)-1
    X=[coor(1)+r*cos(theta(k1)) coor(1)+r*cos(theta(k1+1)) coor(1)+r*cos(theta(k1+1)) coor(1)+r*cos(theta(k1))];
    Y=[coor(2)+r*sin(theta(k1)) coor(2)+r*sin(theta(k1+1)) coor(2)+r*sin(theta(k1+1)) coor(2)+r*sin(theta(k1))];
    Z=[coor(3),coor(3),coor(3)+height,coor(3)+height];
    h=fill3(X,Y,Z,color);
    set(h,'edgealpha',0,'facealpha',facealpha)  
end
 
X=[coor(1)+r*cos(theta(end)) coor(1)+r*cos(theta(1)) coor(1)+r*cos(theta(1)) coor(1)+r*cos(theta(end))];
Y=[coor(2)+r*sin(theta(end)) coor(2)+r*sin(theta(1)) coor(2)+r*sin(theta(1)) coor(2)+r*sin(theta(end))];
Z=[coor(3),coor(3),coor(3)+height,coor(3)+height];
h=fill3(X,Y,Z,color);
set(h,'edgealpha',0,'facealpha',facealpha)
 
fill3(coor(1)+r*cos(theta),coor(2)+r*sin(theta),coor(3)*ones(1,size(theta,2)),color)
fill3(coor(1)+r*cos(theta),coor(2)+r*sin(theta),height+coor(3)*ones(1,size(theta,2)),color)
view(3)
end

function plotsphere(xyz, radius, pellucidity, color)

[orix,oriy,oriz] = sphere(50);
orix=orix*radius+xyz(1);
oriy=oriy*radius+xyz(2);
oriz=oriz*radius+xyz(3);
mesh(orix,oriy,oriz,'FaceColor',color,'EdgeColor','none','FaceAlpha',pellucidity);
end
