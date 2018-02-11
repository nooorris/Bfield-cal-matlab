clc;clear;
%% running parameters
DUMP_PERIOSITY=500;
DUMP_NUM=65;
TIME_STEP=46.161969725E-15;

%% grid parameters
GridMin = [6e-3,-4.5e-3,7e-3];
GridMax = [14e-3 31.4e-3 10e-3];
Cells =[160,700,60];
Gridlen = (GridMax - GridMin)./Cells;


%% observed point parameters
point = [10e-3 28.866e-3 8.5e-3];
indices= ceil((point-GridMin)./Gridlen);

%% 
READ_INT=2;
sample=0:READ_INT:DUMP_NUM;
Bzfield=zeros(1,length(sample));
time = zeros(1,length(sample));

for i = 1:length(time)
    a=h5read(['vsim_B_' int2str(sample(i)) '.h5'],'/B');
    time(i)= h5readatt(['vsim_B_' int2str(sample(i)) '.h5'],'/B','time');
    Bzfield(i)=a(3,indices(3),indices(2),indices(1));
end


plot(time,Bzfield,'*--');
xlabel('time/s');
ylabel('magnetic field/T');
title('100nc Bz field in the center of ring')


