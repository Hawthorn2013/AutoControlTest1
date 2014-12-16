clear;
clc;
XZ_K=10;
s = tf('s');
G0=tf(XZ_K,conv([1,0],[1,1]));
Gama=45;%������λԣ��
GamaE=12;%������λԣ��
w=logspace(-1,3);
[Gm_G,Pm_G,Wg_G,Wp_G] = margin(G0);%Gm��Ϊ��ֵԣ�ȣ�Pm��Ϊ���ԣ�ȣ���Wp��Ϊ��ԽƵ��
disp(['��ԽƵ��Ϊ��',num2str(Wp_G),' rad/s']);
disp(['��ֵԣ��Ϊ��',num2str(Gm_G),' dB']);
disp(['��λԣ��Ϊ��',num2str(Pm_G),' dec']);
Fei0=Gama-Pm_G+GamaE;
Aerfa=(1-sin(deg2rad(Fei0)))/(1+sind(Fei0));%��������
K_OmigaM=10*log10(1/Aerfa);%��ǰУ��װ����OmigaM��������
OmigaC2=Wp_G*10^(K_OmigaM/40);%У����Ĵ�ԽƵ��
OmigaM = OmigaC2;%
disp('Ҫ��У����Ĵ�ԽƵ��>=4.4 rad/s');
disp(['У����ԽƵ��Ϊ��',num2str(OmigaC2),' rad/s']);
Omiga1 = OmigaM*Aerfa^0.5;
Omiga2 = OmigaM/Aerfa^0.5;
Tao=1/Omiga1;
Gc = (Tao*s+1)/(Tao*Aerfa*s+1);%��ǰ��������
G = G0*Gc;

figure(1);
hold on;
bode(G0,'b',w);
bode(G,'r',w);
title('Bodeͼ');
legend('У��ǰ','У����');
grid on;
%xlabel('w');
%ylabel('\Phi(w)');

figure(2);
hold on;
nyquist(G0,'b');
nyquist(G,'r');
title('Nyquistͼ');
legend('У��ǰ','У����');
grid on;