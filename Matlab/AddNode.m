function  p_list= AddNode(p_list,p_new,i_parent)


l=norm(p_new(1:3)-p_list(i_parent,1:3))+p_list(i_parent,end-1);
p_list=[p_list;
        p_new, l, i_parent];

end
