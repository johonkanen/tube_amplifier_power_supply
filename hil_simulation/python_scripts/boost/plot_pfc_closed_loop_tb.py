import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))

fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

# load vhdl simulation data
vhdl_data = pd.read_csv('./pfc_closed_loop_tb.dat', delim_whitespace=True)

vhdl_data.plot(ax=axT, x="time", y="vref", label="vhdl voltage")
# vhdl_data.plot(ax=axT, x="time", y="rvin", label="input voltage")
vhdl_data.plot(ax=axB, x="time", y="iref", label="vhdl current")
# vhdl_data.plot(ax=axB, x="time", y="cref", label="vhdl control current")
# vhdl_data.plot(ax=axB, x="time", y="iref", label="vhdl reference current")

plt.show()
plt.close('all')
