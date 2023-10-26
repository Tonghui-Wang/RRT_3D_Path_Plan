% 正解函数
% 输入：各关节位移
%	   旋转轴位移值单位为°,移动轴位移值单位为mm
% 输出：TCP位姿描述(XYZABC)
%	   XYZ输出值单位为mm,ABC输出值单位为°
function [p]=Fkine(q)

%{
|_i_|_theta_|_d_|_a_|_alpha_|__q__|
| 1 |   0   |d1 | 0 |   0   | q1  |
| 2 |   90  | 0 |a2 |   90  | q2  |
| 3 |   0   | 0 |a3 |   0   | q3  |
| 4 |   0   |d4 |a4 |   90  | q4  |
| 5 |  -90  | 0 | 0 |  -90  | q5  |
| 6 |   0   |d6 | 0 |   90  | q6  |
%}

% 连杆参数
a2=150;
a3=750;
a4=155;
d1=253;
d4=800;
d6=154;

% DH参数表
theta=[0, pi/2, 0, 0, -pi/2, 0];
d=[d1, 0, 0, d4, 0, d6];
a=[0, a2, a3, a4, 0, 0];
alpha=[0, pi/2, 0, pi/2, -pi/2, pi/2];

q(3)=q(3)-q(2);
q=deg2rad(q);

% 计算T矩阵
T=eye(4);
for i=1:6
    A=mdh_matrix(a(i),alpha(i),d(i),theta(i)+q(i));
    T=T*A;
end

% 等效变换
p=[T(1:3,4)',rad2deg(tform2eul(T,'ZYX'))];

if p(4)>180
    p(4)=p(4)-360;
elseif p(4)<-180
    p(4)=p(4)+360;
end

if p(5)>180
    p(5)=p(5)-360;
elseif p(5)<-180
    p(5)=p(5)+360;
end

if p(6)>180
    p(6)=p(6)-360;
elseif p(6)<-180
    p(6)=p(6)+360;
end

end

% A矩阵的计算函数(MDH方法)
function [A]=mdh_matrix(a,alpha,d,theta)
A=eye(4);
A(1,1)=cos(theta);
A(1,2)=-sin(theta);
A(1,3)=0;
A(1,4)=a;

A(2,1)=sin(theta)*cos(alpha);
A(2,2)=cos(theta)*cos(alpha);
A(2,3)=-sin(alpha);
A(2,4)=-sin(alpha)*d;

A(3,1)=sin(theta)*sin(alpha);
A(3,2)=cos(theta)*sin(alpha);
A(3,3)=cos(alpha);
A(3,4)=cos(alpha)*d;

A(4,1)=0;
A(4,2)=0;
A(4,3)=0;
A(4,4)=1;
end
