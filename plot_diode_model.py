import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))

#change directory to the lc filter directory

fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

# load vhdl simulation data
vhdl_data = pd.read_csv(path_to_this_file + '/diode_model_tb.dat', delim_whitespace=True)

vhdl_data.plot(ax=axT, x="time", y="ivol", label="input voltage")
vhdl_data.plot(ax=axT, x="time", y="volt", label="input voltage")
vhdl_data.plot(ax=axT, x="time", y="Lvol", label="inductor voltage")
# vhdl_data.plot(ax=axT, x="time", y="vref", label="vhdl reference voltage")
vhdl_data.plot(ax=axB, x="time", y="curr", label="vhdl current")
vhdl_data.plot(ax=axB, x="time", y="iref", label="inductor current")

plt.show()
plt.close('all')
