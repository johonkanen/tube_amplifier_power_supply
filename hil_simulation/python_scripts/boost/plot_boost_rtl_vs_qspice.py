from PyQSPICE import clsQSPICE as pqs

import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))

#change directory to the lc filter directory
pqs.chdir(path_to_this_file + '/../../../hil_simulation/qspice_ref_models/boost_simulation')

run = pqs('rtl_boost_reference.qsch')

run.qsch2cir()
run.cir2qraw()

# no idea what this does
run.setNline(4999)

# run qspice simulation and load voltages and currents
df = run.LoadQRAW(["V(vdc)", "I(L1)", "V(sampled_current)"])

# load vhdl simulation data
# vhdl_data = pd.read_csv(path_to_this_file + '/../../../boost_rtl_tb.dat', delim_whitespace=True)

fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

df.plot(ax=axT, x="Time",  y="V(vdc)", label="QSPICE voltage")
vhdl_data.plot(ax=axT, x="time", y="volt", label="vhdl voltage")
vhdl_data.plot(ax=axT, x="time", y="vref", label="vhdl reference voltage")
df.plot(ax=axB, x="Time",  y="V(sampled_current)", label="QSPICE current")
vhdl_data.plot(ax=axB, x="time", y="curr", label="vhdl current")
vhdl_data.plot(ax=axB, x="time", y="iref", label="vhdl reference current")

plt.show()
plt.close('all')
