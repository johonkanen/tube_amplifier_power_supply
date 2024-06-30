import pandas as pd
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))
fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

vhdl_data = pd.read_csv(path_to_this_file + '/../supply_model_tb.dat', delim_whitespace=True)
vhdl_data.plot(ax=axT, x="time", y="volt", label="voltage")
vhdl_data.plot(ax=axB, x="time", y="curr", label="current")
vhdl_data.plot(ax=axB, x="time", y="load", label="load")
vhdl_data.plot(ax=axB, x="time", y="dcur", label="dc link current")

plt.show()
plt.close('all')
