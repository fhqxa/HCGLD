clear;clc;close all;
fontsize=16;
figure;
 %% DD
 x1=0.1:0.1:0.9;%x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
 FH1=[0.8903, 0.8903, 0.8920 ,0.8931, 0.8917, 0.8756, 0.8539 ,0.8217 ,0.7732 ]; %a数据y值
 ACC1=[0.7572,0.7572,0.7616,0.7633,0.7605,0.7241,0.6687,0.5837,0.4709 ]; %b数据y值
 plot(x1,FH1,'-*',x1,ACC1,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC1)-0.1,min(FH1)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC1)-0.1:0.1:min(FH1)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% FP
figure;
x2=0.1:0.1:0.9;
FH2=[0.7742 ,0.8024,0.8217,0.8166,0.7921,0.7619,0.7385,	0.7238 ,0.7213 ]; %a数据y值
ACC2=[0.4901 ,0.5613 ,0.6085 ,0.5953 ,0.5411,0.4707 ,0.4175,0.3838 ,0.3778 ]; %b数据y值
plot(x2,FH2,'-*',x2,ACC2,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC2)-0.1,min(FH2)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC2)-0.1:0.1:min(FH2)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述


%% VOC
figure;
x3 = 0.1:0.1:0.9;
FH3 = [0.6520 	0.6520 	0.6521 	0.6561 	0.6595 	0.6560 	0.6470 	0.6404 	0.6391 ]; %a数据y值
ACC3 = [0.3848 	0.3848 	0.3849 	0.3935 	0.4030 	0.4157 	0.4159 	0.4160 	0.4177  ]; %b数据y值
plot(x3,FH3,'-*',x3,ACC3,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC3)-0.1,min(FH3)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC3)-0.1:0.1:min(FH3)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% CLEF
figure;
x4 = 0.1:0.1:0.9;
FH4 = [0.8571 	0.8571 	0.8571 	0.8574 	0.8594 	0.8632 	0.8642 	0.8620 	0.8590 ]; %a数据y值
ACC4 = [0.7629 	0.7629 	0.7629 	0.7634 	0.7667 	0.7755 	0.7797 	0.7780 	0.7741 ]; %b数据y值
plot(x4,FH4,'-*',x4,ACC4,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC4)-0.1,min(FH4)+0.1])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC4)-0.1:0.05:min(FH4)+0.15]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% CAR
figure;
x5 = 0.1:0.1:0.9;
FH5 = [0.8357 	0.8357 	0.8379 	0.8438 	0.8513 	0.8575 	0.8647 	0.8704 	0.8742 ]; %a数据y值
ACC5 = [0.6866 	0.6866 	0.6921 	0.7046 	0.7193 	0.7321 	0.7481 	0.7600 	0.7684 ]; %b数据y值
plot(x5,FH5,'-*',x5,ACC5,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC5)-0.1,min(FH5)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC5)-0.1:0.1:min(FH5)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% SUN
figure;
x6 = 0.1:0.1:0.9;
FH6 = [0.8610 	0.8619 	0.8672 	0.8744 	0.8806 	0.8837 	0.8827 	0.8742 	0.8461 ]; %a数据y值
ACC6 = [0.6692 	0.6716 	0.6849 	0.7028 	0.7185 	0.7290 	0.7266 	0.7022 	0.6300 ]; %b数据y值
plot(x6,FH6,'-*',x6,ACC6,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC6)-0.1,min(FH6)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC6)-0.1:0.1:min(FH6)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% ILSVRC
figure;
x7 = 0.1:0.1:0.9;
FH7 = [0.9775 	0.9775 	0.9775 	0.9776 	0.9780 	0.9778 	0.9774 	0.9770 	0.9752 ]; %a数据y值
ACC7 = [0.9193 	0.9193 	0.9196 	0.9199 	0.9214 	0.9204 	0.9187 	0.9170 	0.9102 ]; %b数据y值
plot(x7,FH7,'-*',x7,ACC7,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC7)-0.1,min(FH7)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC7)-0.1:0.1:min(FH7)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% CIFAR-2-8
figure;
x8 = 0.1:0.1:0.9;
FH8 = [0.9251 	0.9251 	0.9251 	0.9264 	0.9289 	0.9336 	0.9381 	0.9404 	0.9441 ]; %a数据y值
ACC8 = [0.8559 	0.8559 	0.8559 	0.8590 	0.8642 	0.8737 	0.8831 	0.8889 	0.8978 ]; %b数据y值
plot(x8,FH8,'-*',x8,ACC8,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC8)-0.1,min(FH8)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC8)-0.1:0.1:min(FH8)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述

%% CIFAR-3-7
figure;
x8 = 0.1:0.1:0.9;
FH8 = [0.9235 	0.9235 	0.9235 	0.9241 	0.9272 	0.9309 	0.9353 	0.9385 	0.9387 ]; %a数据y值
ACC8 = [0.8564 	0.8564 	0.8564 	0.8580 	0.8637 	0.8736 	0.8827 	0.8897 	0.8880 ]; %b数据y值
plot(x8,FH8,'-*',x8,ACC8,'-^','LineWidth',1); %线性，颜色，标记
axis([0,1,min(ACC8)-0.1,min(FH8)+0.2])  %确定x轴与y轴框图大小
set(gca,'XTick',[0.1:0.1:0.9],'FontSize',fontsize) %x轴范围1-6，间隔1
set(gca,'YTick',[min(ACC8)-0.1:0.1:min(FH8)+0.2]) %y轴范围0-700，间隔100
legend('FH','ACC');   %右上角标注
xlabel('Threshold \it{\theta}')  %x轴坐标描述