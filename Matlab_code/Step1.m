clear all
clean_dynare_files;



%----------------------------------------------------------------
% 1. Paramethers declaration
%----------------------------------------------------------------
%NK non linear DSGE

siggma = 1;
varphi=5;
phi_pi = 1.5;
phi_y  = 0.125;
theta=3/4;
rho_nu =0.5;
rho_z  = 0.5;
rho_a  = 0.9;
betta  = 0.99;
eta  =3.77; %footnote 11, p. 115
alppha=1/4;
epsilon=9;
tau=0; %//1/epsilon;


%RBC DSGE
%{
alpha = 0.3;  
beta  = 0.99;
sigma = 1;
delta = 0.025;
rhoa = 0;
%}

%NK DSGE
%values to stractural parameters
%{
beta=0.99;      %discount factor
om=0.75;        %firm able to readjust
eta=1;          %log linear utility function
si=1;           %log linear utility function
phi_pi=1.5;
phi_x=0.1;
rho_a=0.9; %persistence technological shock
rho_v=0.5; %persistence monetary shock
rho_u=0.3; %
%}


%----------------------------------------------------------------
% 2. Obtain model simulation
%----------------------------------------------------------------
%params= [alpha,beta,sigma,delta,rhoa];
params = [alppha,betta,rho_a,rho_nu,rho_z,siggma,varphi,phi_pi,phi_y,eta,epsilon,theta,tau];
%params=[beta,om,eta,si,phi_pi,phi_x,rho_a,rho_v,rho_u];
periods=193;
Simul_data_0=Simul_data(params,periods,"NK_NL_DSGE");


%----------------------------------------------------------------
% 3. Rough Analysis of simulated data
%----------------------------------------------------------------
%NK NL DSGE
%Y-8,Pi-3, N-5, W_real-2 A-4
%{
Simul_data = Simul_data_0(:,[8,3,5,2,4]);
figure
tiledlayout(5,1)
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
nexttile
plot(1:size(Simul_data,1),Simul_data.A);
title('Tech')
%}

%RBC DSGE
%{
%C-1 k-2 a-3
Simul_data = Simul_data_0;
figure
tiledlayout(3,1)
nexttile
plot(1:size(Simul_data,1),Simul_data.c);
title('Consumption')
nexttile
plot(1:size(Simul_data,1),Simul_data.k);
title('capital')
nexttile
plot(1:size(Simul_data,1),Simul_data.a);
title('tech')
%}




