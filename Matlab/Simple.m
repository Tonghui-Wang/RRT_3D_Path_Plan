function [p_simple] = Simple(p_collect, obstacle)

p_simple=[p_collect(1,:)];
n=size(p_collect,1);

i=1;
j=n;
while true
    p_edge = Edge(p_collect(i,:), p_collect(j,:));
    feasible = Collision(p_edge,obstacle);
    if feasible
        p_simple=[p_simple;p_collect(j,:)];
        i=j;
        j=n;
        if i==n
            break;
        end
    else
        if i+1<j
            j=j-1;
            if i+1==j
                p_simple=[p_simple;p_collect(j,:)];
                i=j;
                j=n;
                if i==n
                    break;
                end
            else
                continue;
            end
        end
    end
end
end
