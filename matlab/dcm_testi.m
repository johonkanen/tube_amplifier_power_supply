i = 2.32/2; %measurement from centre of waveform
D = .1; %duty divided by 2 due to ltspice simulation model
uin = 120;
uo = 350;
l = 200e-6; %inductor
ts = 1/135e3; %switching period

%correction factor for boost measurement in dcm operation
% i1 = i*(D-2*i/(uin-uo)*l/ts)
% 
i2= i*(2*i*uo*l)/((uo-uin)*(ts*uin))
i2jee = 2*l/ts*(i^2*uo)/((uo-uin)*uin)

%inductance estimating correction factor
% l2 = (uin*D/2*ts)/i
% 
% i*(D+2*i/(uo-uin)*l2/ts)
% 
% i1i2 = i1./i2