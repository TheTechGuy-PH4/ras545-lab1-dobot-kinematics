clear;
clc;
close all;

L0=0; L1=150; L2=150; L3=90;
theta1 = 26.8640; theta2= -0.4890; theta3 = 17.4398-theta2 ; theta4 = -theta3; theta5 = 8.7759;

%Z_Rotation
Rz1= [[cosd(theta1) -sind(theta1)  0;
       sind(theta1)  cosd(theta1)  0;
       0             0             1]]
Rz2= [[cosd(theta2) -sind(theta2)  0;
       sind(theta2)  cosd(theta2)  0;
       0             0             1]]
Rz3= [[cosd(theta3) -sind(theta3)  0;
       sind(theta3)  cosd(theta3)  0;
       0             0             1]]
Rz4= [[cosd(theta4) -sind(theta4)  0;
       sind(theta4)  cosd(theta4)  0;
       0             0             1]]
Rz5= [[cosd(theta5) -sind(theta5)  0;
       sind(theta5)  cosd(theta5)  0;
       0             0             1]]
%Projection
P1 = [1  0  0;
      0  0  1;
      0 -1  0]
P2 = [1  0  0;
      0  1  0;
      0  0  1]
P3 = [1  0  0;
      0  1  0;
      0  0  1]
P4 = [1  0  0;
      0  0 -1;
      0  1  0]
P5 = [1  0  0;
      0  1  0;
      0  0  1]

%Rotation along joints
R01 = Rz1*P1
R12 = Rz2*P2
R23 = Rz3*P3
R34 = Rz4*P4
R45 = Rz5*P5

%Homogeneous Mtx
H01 = [R01 [0;0;L0]; 0 0 0 1]
H12 = [R12 [L1*sind(theta2);-L1*cosd(theta2);0]; 0 0 0 1]
H23 = [R23 [L2*cosd(theta3); L2*sind(theta3);0]; 0 0 0 1]
H34 = [R34 [L3*cosd(theta4); L3*sind(theta4);0]; 0 0 0 1]
H45 = [R45 [0;0;0]; 0 0 0 1]
H05 = H01 * H12 * H23 * H34 * H45;
H05 = round(H05,4)

%Translational part
Px = H05(1,4)
Py = H05(2,4)
Pz = H05(3,4)

rotm = H05((1:3),(1:3));
eulZYX = rotm2eul(rotm)
rad2deg(eulZYX)