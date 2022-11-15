function [K,Kc]=calculate_LQR2(param,Q1,R1)
R=param.R;
L =param.L;  %摆杆重心到驱动轮轴距离
L_M =param.LM; %摆杆重心到机体转轴距离
l =param.l;  %机体重心到机体转轴距离
m_w =param.mw;   %转子质量
m_p =param.mp;   %摆杆质量
M=param.M;    %机体质量
I_w =param.Iw;%转子惯量
I_p =param.Ip;%摆杆惯量
I_M =param.IM;%机体惯量
g =9.8;



A=[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   0, 1, 0, 0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0, 0;
    (g*(L*m_p + L*M + L_M*M)*(I_M*I_w + I_M*M*R^2 - I_w*M*l^2 + I_M*R^2*m_p + I_M*R^2*m_w - M*R^2*l^2*m_p - M*R^2*l^2*m_w))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w), 0, 0, 0,                                                                                                                                       -(M^2*g*l^2*(I_w*L + I_w*L_M + L*R^2*m_w + L_M*R^2*m_p + L_M*R^2*m_w))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w), 0;
    0, 0, 0, 1,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0, 0;
    -(R^2*g*(L*m_p + L*M + L_M*M)*(L*M*m_p*l^2 + I_M*L*M + I_M*L_M*M + I_M*L*m_p))/(I_M*I_p*I_w + I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M + I_w*L^2*M*l^2*m_p + I_p*M*R^2*l^2*m_p + I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w + L^2*M*R^2*l^2*m_p*m_w), 0, 0, 0,                                                                                                                                                                            (M^2*R^2*g*l^2*(I_p - L*L_M*m_p))/(I_M*I_p*I_w + I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M + I_w*L^2*M*l^2*m_p + I_p*M*R^2*l^2*m_p + I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w + L^2*M*R^2*l^2*m_p*m_w), 0;
    0, 0, 0, 0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        0, 1;
    -(M*g*l*(L*m_p + L*M + L_M*M)*(I_w*L + I_w*L_M + L*R^2*m_w + L_M*R^2*m_p + L_M*R^2*m_w))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w), 0, 0, 0, -(M*g*l*(I_p*I_w + I_w*L^2*M + I_w*L_M^2*M + I_p*M*R^2 + I_w*L^2*m_p + I_p*R^2*m_p + I_p*R^2*m_w + L^2*M*R^2*m_w + L_M^2*M*R^2*m_p + L_M^2*M*R^2*m_w + 2*I_w*L*L_M*M + L^2*R^2*m_p*m_w + 2*L*L_M*M*R^2*m_w))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w), 0];

B =[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0;
    -(I_M*I_w + I_M*M*R^2 - I_w*M*l^2 + I_M*R^2*m_p + I_M*R^2*m_w + I_M*L*M*R + I_M*L_M*M*R - M*R^2*l^2*m_p - M*R^2*l^2*m_w + I_M*L*R*m_p - L*M*R*l^2*m_p)/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w),                                                                                                       (I_M*I_w + I_M*M*R^2 - I_w*M*l^2 + I_M*R^2*m_p + I_M*R^2*m_w - M*R^2*l^2*m_p - M*R^2*l^2*m_w + I_w*L*M*l + I_w*L_M*M*l + L*M*R^2*l*m_w + L_M*M*R^2*l*m_p + L_M*M*R^2*l*m_w)/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w);
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0;
    (R*(I_M*I_p + I_M*L^2*M + I_M*L_M^2*M - I_p*M*l^2 + I_M*L^2*m_p + 2*I_M*L*L_M*M - L^2*M*l^2*m_p + I_M*L*M*R + I_M*L_M*M*R + I_M*L*R*m_p - L*M*R*l^2*m_p))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w),                                                                                                                                                                                                  -(R^2*(I_M*L*M + I_M*L_M*M - I_p*M*l + I_M*L*m_p - L*M*l^2*m_p + L*L_M*M*l*m_p))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w);
    0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0;
    (M*l*(I_w*L + I_w*L_M - I_p*R + L*R^2*m_w + L_M*R^2*m_p + L_M*R^2*m_w + L*L_M*R*m_p))/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w), (I_p*I_w + I_w*L^2*M + I_w*L_M^2*M + I_p*M*R^2 + I_w*L^2*m_p + I_p*R^2*m_p + I_p*R^2*m_w + L^2*M*R^2*m_w + L_M^2*M*R^2*m_p + L_M^2*M*R^2*m_w + 2*I_w*L*L_M*M + L^2*R^2*m_p*m_w - I_w*L*M*l - I_w*L_M*M*l + 2*L*L_M*M*R^2*m_w - L*M*R^2*l*m_w - L_M*M*R^2*l*m_p - L_M*M*R^2*l*m_w)/(I_M*I_p*I_w - I_p*I_w*M*l^2 + I_M*I_w*L^2*m_p + I_M*I_p*R^2*m_p + I_M*I_p*R^2*m_w + I_M*I_w*L^2*M + I_M*I_w*L_M^2*M + I_M*I_p*M*R^2 + I_M*L^2*M*R^2*m_w + I_M*L_M^2*M*R^2*m_p + I_M*L_M^2*M*R^2*m_w + 2*I_M*I_w*L*L_M*M - I_w*L^2*M*l^2*m_p - I_p*M*R^2*l^2*m_p - I_p*M*R^2*l^2*m_w + I_M*L^2*R^2*m_p*m_w + 2*I_M*L*L_M*M*R^2*m_w - L^2*M*R^2*l^2*m_p*m_w)];


ran=rank([B,A*B,A^2*B,A^3*B,A^4*B,A^5*B]);
dt=0.001;
C=eye(6);
D=zeros(6,2);
sys_c = ss(A, B, C, D);
sys_d = c2d(sys_c, dt);
[A_d, B_d, C_d, D_d] = ssdata(sys_d);
%     Q=diag([0.5,0.5,200,100,2000,10]);
%     R=diag([10,30]);
Q=Q1;
R=R1;
%离散
[K,P]=dlqr(A_d,B_d,Q,R);
%连续
[Kc,Pc]=lqr(A,B,Q,R);

end

