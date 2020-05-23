%%pfc voltage control

c = 68e-6*4;
p = bodeoptions;
p.FreqUnits = 'Hz';
kp = 0.0327;
ki = 3;
dc_voltage = ss(0, 1/c, 1, 0);
s = tf('s');
pi_control = kp+ki/s;

dc_voltage_controlled = feedback(dc_voltage*pi_control,1);
dc_voltage_sensitivity = (1-dc_voltage_controlled);
dc_voltage_load_sens = (1-dc_voltage_controlled)*dc_voltage;

w = logspace(1,3,100);

figure(1)
    bode(pi_control * dc_voltage,w,p)
    grid on

figure(2)
    bode(dc_voltage_sensitivity,w,p)
    grid on

figure(3)
    step(-dc_voltage_load_sens)
grid on

%% pfc current control
ikp = 13;
iki = 33000;
current_pi = ikp+iki/s;

pfc_inductor = 1.24e-3;

pfc_current = ss(0, 1/pfc_inductor, 1, 0);

current_controlled = feedback(pfc_current*current_pi,1);
current_sensitivity = (1-current_controlled);
current_load_sens = (1-current_controlled)*pfc_inductor;

figure(4)
    bode(current_pi * pfc_current,p)
    grid on
    
figure(5)
    bode(current_sensitivity,p)
    grid on

%% control gain scaling
op_amp_meas_gain = 6800/330;
shunt_resistor = 10e-3;
measurement_range_in_volts = 1.65;

current_max_value = measurement_range_in_volts/op_amp_meas_gain/shunt_resistor;

vac_measurement_gain = 1/660;
