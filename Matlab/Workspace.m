function Workspace(jlimit)

loop=10000;
q=zeros(loop,6);
p=zeros(loop,6);

for i=1:loop
    for j=1:6
        q(i,j)=jlimit(1,j)+diff(jlimit(:,j))*rand;
    end
    p(i,:)=Fkine(q(i,:));

end
    plot3(p(:,1),p(:,2),p(:,3),'y.');
% scatter3(p(:,1),p(:,2),p(:,3));
% [X,Y,Z]=griddata(p(:,1),p(:,2),p(:,3),linspace(min(p(:,1)),max(p(:,1)))',linspace(min(p(:,2)),max(p(:,2))),'v4');
% surf(X,Y,Z);
end
