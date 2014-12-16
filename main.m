clear;
clc;
XZ_K=10;
s = tf('s');
G0=tf(XZ_K,conv([1,0],[1,1]));
Gama=45;%所需相位裕度
GamaE=12;%补偿相位裕度
w=logspace(-1,3);
[Gm_G,Pm_G,Wg_G,Wp_G] = margin(G0);%Gm即为幅值裕度，Pm即为相角裕度，，Wp即为穿越频率
disp(['穿越频率为：',num2str(Wp_G),' rad/s']);
disp(['幅值裕度为：',num2str(Gm_G),' dB']);
disp(['相位裕度为：',num2str(Pm_G),' dec']);
Fei0=Gama-Pm_G+GamaE;
Aerfa=(1-sin(deg2rad(Fei0)))/(1+sind(Fei0));%补偿增益
K_OmigaM=10*log10(1/Aerfa);%超前校正装置在OmigaM处的增益
OmigaC2=Wp_G*10^(K_OmigaM/40);%校正后的穿越频率
OmigaM = OmigaC2;%
disp('要求校正后的穿越频率>=4.4 rad/s');
disp(['校正后穿越频率为：',num2str(OmigaC2),' rad/s']);
Omiga1 = OmigaM*Aerfa^0.5;
Omiga2 = OmigaM/Aerfa^0.5;
Tao=1/Omiga1;
Gc = (Tao*s+1)/(Tao*Aerfa*s+1);%超前矫正函数
G = G0*Gc;

figure(1);
hold on;
bode(G0,'b',w);
bode(G,'r',w);
title('Bode图');
legend('校正前','校正后');
grid on;
%xlabel('w');
%ylabel('\Phi(w)');

figure(2);
hold on;
nyquist(G0,'b');
nyquist(G,'r');
title('Nyquist图');
legend('校正前','校正后');
grid on;