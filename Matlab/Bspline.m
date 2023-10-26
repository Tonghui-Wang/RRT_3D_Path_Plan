function [p_spline]=Bspline(p_simple)

k=3;%三次B样条
p_spline=[];
N=length(p_simple);

A1=eye(N+2,N+2)*4;
A1(1,1)=6;
A1(1,2)=-6;
A1(N+2,N+1)=6;
A1(N+2,N+2)=-6;
for i=2:N+1
    A1(i,i-1)=1;
    A1(i,i+1)=1;
end

%先求x、y、z坐标
b1=[0;p_simple(:,1);0]*6;%注意系数
px=Chase_method(A1,b1);%用追赶法求得所有控制点
b2=[0;p_simple(:,2);0]*6;
py=Chase_method(A1,b2);
b3=[0;p_simple(:,3);0]*6;
pz=Chase_method(A1,b3);

%确定节点矢量
u=zeros(1,N+1+k+2);%0:1/(N+1+k+2-1):1;
for i=1:k+1
    u(length(u)-i+1)=1;
end

%控制多边形各边长
l=zeros(1,N+1);
for i=1:N+1
    l(i)=norm([px(i),py(i),pz(i)]-[px(i+1),py(i+1),pz(i+1)]);
end

%用哈德利-贾德方法决定节点矢量
sum1=0;
for g=k+1:N+1+1
    for j=g-k:g-1
        sum1=sum1+l(j);
    end
end
for i=k+2:N+2
    u(i)=sum(l(i-k:i-1))/sum1+u(i-1);
end

%用基函数求值
for uTest=0:0.01:1
    score=find(uTest>=u,1,'last');%确定该参数方程的参数值所属的分段
    if uTest==1 score=find(u==1,1)-1;end
    score=score-k;%表示第score段样条曲线
    A2=[-1 3 -3 1;
        3 -6 3 0;
        -3 0 3 0;
        1 4 1 0];
    QControlx=[];
    QControly=[];
    QControlz=[];
    for i=1:k+1
        QControlx=[QControlx px(score+i-1)];%由段数得知控制点
        QControly=[QControly py(score+i-1)];
        QControlz=[QControlz pz(score+i-1)];
    end
    uNode=1;%上面的uTest是整体参数，用来确定是哪段曲线，要将整体参数转化为局部参数t
    t=(uTest-u(score+k))/(u(score+1+k)-u(score+k));
    for i=1:k
        uNode=[t^i uNode];
    end
    Qx=1/6*uNode*A2*QControlx';
    Qy=1/6*uNode*A2*QControly';
    Qz=1/6*uNode*A2*QControlz';
    p_spline=[p_spline; Qx,Qy,Qz];
end
end

function [ x ] = Chase_method( A, b )

%   Chase追赶法求三对角矩阵的解
%   A为三对角矩阵的系数，b为等式右端的常数项，返回值x即为最终的解
%   注：A尽量为方阵，b一定要为列向量

%求追赶法所需L及U
T = A;
for i = 2 : size(T,1)
    T(i,i-1) = T(i,i-1)/T(i-1,i-1);
    T(i,i) = T(i,i) - T(i-1,i) * T(i,i-1);
end

L = zeros(size(T));
L(logical(eye(size(T)))) = 1;%对角线赋值1
for i = 2:size(T,1)
    for j = i-1:size(T,1)
        L(i,j) = T(i,j);
        break;
    end
end

U = zeros(size(T));
U(logical(eye(size(T)))) = T(logical(eye(size(T))));
for i = 1:size(T,1)
    for j = i+1:size(T,1)
        U(i,j) = T(i,j);
        break;
    end
end

%利用matlab解矩阵方程的遍历直接求解
y = L\b;
x = U\y;
end
