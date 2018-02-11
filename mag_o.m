clc;clear;close all;
%% running parameters
DUMP_PERIOSITY=500;
DUMP_NUM=100;                                 % need adjustment 
TIME_STEP=46.161969725E-15;

%% grid parameters
GridMin = [6e-3,-4.5e-3,7e-3];
GridMax = [14e-3 31.4e-3 10e-3];
Cells =[160,700,60];
Gridlen = (GridMax - GridMin)./Cells;


%% observed point parameters
point = [10e-3 28.866e-3 8.5e-3];             % need adjustment 
indices= ceil((point-GridMin)./Gridlen);

%% initialize and read setting
READ_INT=2;                                   % need adjustment 
sample=0:READ_INT:DUMP_NUM;
Bxfield=zeros(1,length(sample));
Byfield=zeros(1,length(sample));
Bzfield=zeros(1,length(sample));
time = zeros(1,length(sample));

for i = 1:length(time)
    a=h5read(['vsim_B_' int2str(sample(i)) '.h5'],'/B',[1,indices(3),indices(2),indices(1)],[3,2,2,2]);
    time(i)= h5readatt(['vsim_B_' int2str(sample(i)) '.h5'],'/B','time');
    Bzfield(i)=a(3,1,1,1);
    Byfield(i)=a(2,1,1,1);
    Bxfield(i)=a(1,1,1,1);
end
    Bfield=sqrt(Bxfield.^2+Byfield.^2+Bzfield.^2);
%% plot setting
figure
subplot(2,2,1)
plot(time,Bxfield,'*--');
xlabel('time/s');
ylabel('Bx field/T');
title('10nc Bx field in the center of ring')

subplot(2,2,2)
plot(time,Byfield,'*--');
xlabel('time/s');
ylabel('By field/T');
title('10nc By field in the center of ring')

subplot(2,2,3)
plot(time,Bzfield,'*--');
xlabel('time/s');
ylabel('Bz field/T');
title('10nc Bz field in the center of ring')


subplot(2,2,4)
plot(time,Bfield,'*--');
xlabel('time/s');
ylabel('B field/T');
title('10nc B field in the center of ring')


