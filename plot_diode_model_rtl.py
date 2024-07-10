import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))

#change directory to the lc filter directory

fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

# load vhdl simulation data
diode_model_rtl = pd.read_csv(path_to_this_file + '/diode_model_rtl_tb.dat', delim_whitespace = True)
diode_model     = pd.read_csv(path_to_this_file + '/diode_model_tb.dat', delim_whitespace = True)

diode_model_rtl.plot(ax=axT, x="time", y="ivol", label="input voltage")
diode_model_rtl.plot(ax=axT, x="time", y="volt", label="input voltage")
diode_model_rtl.plot(ax=axT, x="time", y="Lvol", label="inductor voltage")
diode_model.plot(ax=axT, x="time", y="ivol", label="input voltage")
diode_model.plot(ax=axT, x="time", y="volt", label="input voltage")
diode_model.plot(ax=axT, x="time", y="Lvol", label="inductor voltage")
# vhdl_data.plot(ax=axT, x="time", y="vref", label="vhdl reference voltage")
# vhdl_data.plot(ax=axB, x="time", y="curr", label="vhdl current")
diode_model_rtl.plot(ax=axB, x="time", y="iref", label="inductor current")
diode_model.plot(ax=axB, x="time", y="iref", label="inductor current")

plt.show()
plt.close('all')
