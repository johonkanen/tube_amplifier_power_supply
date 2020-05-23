%% dhb phase vs output current

phase = round(linspace(2,40,10));
disp(phase)

current = [0.0725375, 0.113539, 0.218862, 0.3, 0.395245, 0.466715, ...
    0.550496, 0.613131, 0.686035, 0.740124];

plot(phase,current)