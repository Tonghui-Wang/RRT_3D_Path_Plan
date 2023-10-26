function [obstacle] = Obstacle(flag)

obstacle.cube=[];
obstacle.cylinder=[];
obstacle.sphere=[];

if ~flag
    return;
end

obstacle.cube(1).exist=true;
obstacle.cube(1).lwh=[500,100,500];
obstacle.cube(1).xyz=[700,400,0];
obstacle.cube(2).exist=true;
obstacle.cube(2).lwh=[100,700,500];
obstacle.cube(2).xyz=[1150,-400,0];

obstacle.cylinder(1).exist=true;
obstacle.cylinder(1).xyz=[600, 0,0];
obstacle.cylinder(1).radius=150;
obstacle.cylinder(1).height=600;
obstacle.cylinder(2).exist=false;
obstacle.cylinder(2).xyz=[300,300,100];
obstacle.cylinder(2).radius=20;
obstacle.cylinder(2).height=100;

obstacle.sphere(1).exist = false;
obstacle.sphere(1).xyz = [700,700,700];
obstacle.sphere(1).radius=50;
obstacle.sphere(2).exist = false;
obstacle.sphere(2).xyz = [800,800,800];
obstacle.sphere(2).radius=80;

end
