function feasible = Collision(p_edge,obstacle)

feasible = incube(p_edge, obstacle.cube);   %长方体碰撞检测函数
if ~feasible
    return;
end

feasible = incylinder(p_edge, obstacle.cylinder);  %圆柱体碰撞检测函数
if ~feasible
    return;
end

feasible = insphere(p_edge, obstacle.sphere);   %球形障碍物碰撞检测函数
end

function feasible = incube(p_edge, cube)

feasible = true;

n=length(cube);
for i=1:n
    if ~cube(i).exist
        continue;
    end
    
    m=size(p_edge,1);
    for j=1:m
        if p_edge(j,1)>=cube(i).xyz(1) && p_edge(j,1)<=cube(i).xyz(1)+cube(i).lwh(1)
            ;
        else
            continue;
        end
        
        if p_edge(j,2)>=cube(i).xyz(2) && p_edge(j,2)<=cube(i).xyz(2)+cube(i).lwh(2)
            ;
        else
            continue;
        end
        
        if p_edge(j,3)>=cube(i).xyz(3) && p_edge(j,3)<=cube(i).xyz(3)+cube(i).lwh(3)
            feasible=false;
            return;
        end
    end
end
end

function feasible = incylinder(p_edge, cylinder)
 
feasible = true;

n=length(cylinder);
for i=1:n
    if ~cylinder(i).exist
        continue;
    end
    
    m=size(p_edge,1);
    for j=1:m
        if norm(p_edge(j,1:2)-cylinder(i).xyz(1:2))<=cylinder(i).radius
            ;
        else
            continue;
        end
        
        if p_edge(j,3)>=cylinder(i).xyz(3) && p_edge(j,3)<=cylinder(i).xyz(3)+cylinder(i).height
            feasible=false;
            return;
        end
    end
end
end
 
function feasible = insphere(p_edge, sphere)

feasible = true;

n=length(sphere);
for i=1:n
    if ~sphere(i).exist
        continue;
    end
    
    m=size(p_edge,1);
    for j=1:m
        if norm(p_edge(j,:)-sphere(i).xyz)<=sphere(i).radius
            feasible = false;
            return;
        end
    end
end
end
