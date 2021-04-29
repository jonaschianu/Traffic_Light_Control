clear all;
close all;
% h=0:24
h = linspace(0,24,25)';
EB_traffic=2*max(sin(2*pi*(h-3)/12) + 2*sin(2*pi*(h-5)/36),0.1);
WB_traffic=2*max(sin(2*pi*(h-4)/12) + 2*sin(2*pi*(h-2)/36),0.1);
NB_traffic=0.8*max(sin(2*pi*(h-3)/12) + 2*sin(2*pi*(h-5)/36),0.1);
SB_traffic=0.8*max(sin(2*pi*(h-4)/12) + 2*sin(2*pi*(h-2)/36),0.1);

bike_walkers = 0.5*max(sin(2*pi*(h-7)/30),0);

People_traffic = 2*EB_traffic + 2*WB_traffic + 2*NB_traffic + 2*SB_traffic + bike_walkers;


% N=2,s=2000,Xc=0.85;
% y=(EB_traffic*60)/(N*s);
% C=30*Xc./(Xc-y)

% C=80
% s=2000
% 
% g=(C/s)*(EB_traffic+WB_traffic);

Y=[EB_traffic,WB_traffic];
figure(1)
stairs(h,Y)
% plot(h,EB_traffic,h,WB_traffic);
title('Road A');
legend('Eastbound','Westbound');
ylabel('Vehicles per minute');
xlabel('hours');
xlim([0 24]);
xticks([0:4:24]);
grid on; 


Y=[NB_traffic,SB_traffic];
figure(2)
stairs(h,Y)
% plot(h,EB_traffic,h,WB_traffic);
title('Road B');
legend('Northbound','southbound');
ylabel('Vehicles per minute');
xlabel('hours');
xlim([0 24]);
xticks([0:4:24]);
grid on; 

% Y=[NB_traffic,h,SB_traffic];
% figure(2)
% % plot(h,NB_traffic,h,SB_traffic);
% 
% stairs(h,Y)
% title('Road B');
% legend('Northbound','southbound');
% ylabel('Vehciles per minute');
% xlabel('hours');
% xlim([0 24]);
% xticks([0:4:24]);
% grid on;

figure(3)
% plot(h,bike_walkers);
stairs(h,bike_walkers)
title('Bikers and Pedestarian Traffic');
ylabel('Bikers/Pedestarian per minute');
xlabel('hours');
xlim([0 24]);
xticks([0:4:24]);
grid on;

figure(4)
plot(h,People_traffic);
title('Total Traffic at intersection (vehicle = 2 people)');
ylabel('People per minute');
xlabel('hours');
xlim([0 24]);
xticks([0:4:24]);
grid on;

% close all;

s=2000; %saturation
u=s/3600;
cycle_length=112; %just green and red
% 75(20,55),112(30,80)
Rate_EB=EB_traffic/60;
Rate_WB=WB_traffic/60;
Rate_NB=NB_traffic/60;
Rate_SB=SB_traffic/60;

Intensity_EB=Rate_EB/u;
Intensity_WB=Rate_WB/u;
Intensity_NB=Rate_NB/u;
Intensity_SB=Rate_SB/u;

X_EB=Rate_EB./(2*(1-Intensity_EB));
X_WB=Rate_WB./(2*(1-Intensity_WB));
X_NB=Rate_NB./(2*(1-Intensity_NB));
X_SB=Rate_SB./(2*(1-Intensity_SB));

%%Differentiatiate D with respect to r and set equation to 0
% syms r
% D=(X_EB+X_WB+X_NB+X_SB)*r^2+(X_NB+X_SB)*(cycle_length*-2)*r+(X_NB+X_SB)*(cycle_length^2)
% diff(D)
% solve(diff(D(1))==0)

r=(X_NB+X_SB)*(cycle_length)./(X_EB+X_WB+X_NB+X_SB);

r_EB=r; g_EB=cycle_length-r;
r_WB=r; g_WB=cycle_length-r;
r_NB=cycle_length-r; g_NB=r;
r_SB=cycle_length-r; g_SB=r;

% num=[10 30 10 30 10 30]
% num1=[10 30 10 30 10 30]
% num2=[10 30 10 30 10 30]
% num3=[10 30 10 30 10 30]
% num4=[10 30 10 30 10 30]
% num5=[10 30 10 30 10 30]

r = [repmat(20,8,1);repmat(30,14,1);repmat(20,3,1)];
g = [repmat(55,8,1);repmat(80,14,1);repmat(55,3,1)];
y= [repmat(5,25,1)];
w=g;
cycle= [repmat(75,8,1);repmat(110,14,1);repmat(75,3,1)];

figure(5)
[hour,timing]=stairs(h,[r,g,y,w,cycle]);
plot(hour(:,1),timing(:,1),'r',hour(:,2),timing(:,2),'g',hour(:,3),timing(:,3),'y',hour(:,4),timing(:,4),'--k',hour(:,5),timing(:,5),'b')
title('Road A Timing');
legend('r_EB/r_WB','g_EB/g_WB','y_EB/y_WB','w_EB/w_WB','cycle_EB/cycle_WB');
ylabel('timing [s]');
xlabel('hours [hr]');
xlim([0 24]);
ylim([0 115]);
xticks([0:4:24]);
grid on; 

g = [repmat(20,8,1);repmat(30,14,1);repmat(20,3,1)];
r = [repmat(55,8,1);repmat(80,14,1);repmat(55,3,1)];
y= [repmat(5,25,1)];
w=g;
cycle= [repmat(75,8,1);repmat(110,14,1);repmat(75,3,1)];

figure(6)
[hour,timing]=stairs(h,[r,g,y,w,cycle]);
plot(hour(:,1),timing(:,1),'r',hour(:,2),timing(:,2),'g',hour(:,3),timing(:,3),'y',hour(:,4),timing(:,4),'--k',hour(:,5),timing(:,5),'b')
title('Road B Timing');
legend('r_NB/r_SB','g_NB/g_SB','y_NB/y_SB','w_NB/w_SB','cycle_NB/cycle_SB');
ylabel('timing [s]');
xlabel('hours [hr]');
xlim([0 24]);
ylim([0 115]);
xticks([0:4:24]);
grid on; 