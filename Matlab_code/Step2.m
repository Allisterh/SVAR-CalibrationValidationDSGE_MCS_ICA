clear all
close all 

%----------------------------------------------------------------
% 1. Obtain the simulated data and a first analysis
%----------------------------------------------------------------
%{
Simul_data_0= readtable('Simul_data.csv');

% C-1,Y-8,Pi-3, N-5, W_real-2
Simul_data = Simul_data_0(:,[1,8,3,5,2]);
figure
tiledlayout(5,1)
nexttile
plot(1:size(Simul_data,1),Simul_data.C);
title('Consumption')
grid on
nexttile
plot(1:size(Simul_data,1),Simul_data.Y);
title('Output')
grid on
nexttile
plot(1:size(Simul_data,1),Simul_data.Pi);
title('Inflation')
grid on
nexttile
plot(1:size(Simul_data,1),Simul_data.N);
title('Hour worked')
grid on
nexttile
plot(1:size(Simul_data,1),Simul_data.W_real);
title('Real wage')
grid on

%}
%----------------------------------------------------------------
% 2. Obtain the Real data and a first analysis
%----------------------------------------------------------------
Real_data_0 = readtable('2023-09.csv');

%slicing 1973:Q1 - 2021:Q1 (251, io uso 247 per evitare covid)
Q1_1971=59;
%Q1_2021=251;
Q1_2019=243;

Real_data = Real_data_0(Q1_1971:Q1_2019,:);




%{
%'PCECC96'-3,'GDPC1'-2,'CPIAUCSL'-121,'AWHMAN'-78,'AHETPIx'-132
Real_data = Real_data_0(Q1_1971:Q1_2019,:);
% I want to take Yr/Nr so that to have GDP per capita as in the model
Cr=Real_data.PCECC96;
Yr=(Real_data.GDPC1/Real_data.%population);

Pir=Real_data.CPIAUCSL;
Nr=Real_data.AWHMAN;
Wr=Real_data.AHETPIx;


Cr_diff=diff(Real_data.PCECC96);
Yr_diff=diff(Real_data.GDPC1);
Pir_diff=diff(Real_data.CPIAUCSL);
Nr_diff=Nr(2:end); %do not growth hence no diff, but to be comfortable I just take one data less
Wr_diff=diff(Real_data.AHETPIx);

time=Real_data_0.sasdate(Q1_1971:Q1_2019);

%{
figure
tiledlayout(5,1)
nexttile
plot(time,Cr);
title('Consumption')
grid on
nexttile
plot(time,Yr);
title('Output')
grid on
nexttile
plot(time,Pir);
title('Inflation')
grid on
nexttile
plot(time,Nr);
title('Hour worked')
grid on
nexttile
plot(time,Wr);
title('Real wage')
grid on

figure
grid on
plot(time(2:end),Cr_diff);
hold on
plot(time(2:end),Yr_diff);
hold on
plot(time(2:end),Pir_diff);
hold on
plot(time(2:end),Nr_diff);
hold on
plot(time(2:end),Wr_diff);
hold on
%}


%----------------------------------------------------------------
% 3. Creat varm model
%----------------------------------------------------------------

Tbl1=array2timetable([Cr_diff,Yr_diff,Pir_diff,Nr_diff,Wr_diff], 'rowtimes', time(2:end), 'VariableNames',{'Consumption','Output','Inflation','Hour worked','Real wage'});



num_series=5;
seriesnames={'Consumption','Output','Inflation','Hour worked','Real wage'};

VAR=varm(num_series,2);
VAR.SeriesNames=seriesnames;
[EstMdl,EstSE,logL,Tbl2] = estimate(VAR,Tbl1);
%}
