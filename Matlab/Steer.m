function p_new = Steer(p_start,p_rand,p_near,p_stop)

radius=30.00;
k=1;

% ori_rand=(p_rand-p_near)/norm(p_rand-p_near);
% ori_search=(p_stop-p_start)/norm(p_stop-p_start);
ori_rand=p_rand - p_near;
ori_search=p_stop - p_start;
ori=ori_rand + k*ori_search;
p_new=p_near+radius*ori/norm(ori);
end
