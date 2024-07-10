from PyQSPICE import clsQSPICE as pqs

import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt

#make this file root for relative paths
import os
path_to_this_file = os.path.dirname(os.path.realpath(__file__))

#change directory to the lc filter directory
pqs.chdir(path_to_this_file + '/../../../hil_simulation/qspice_ref_models/boost_simulation')

run = pqs('boost_closed_loop.qsch')

run.qsch2cir()
run.cir2qraw()


fig1, (axT, axB) = plt.subplots(2,1,sharex=True,constrained_layout=True)

run_closed_loop = pqs('boost_closed_loop.qsch')
run_closed_loop.qsch2cir()
run_closed_loop.cir2qraw()
run_closed_loop.setNline(4999)

closed_loop_results = run_closed_loop.LoadQRAW(["V(vdc)", "I(L1)", "V(sampled_current)"])
closed_loop_results.plot(ax=axT, x="Time",  y="V(vdc)", label="QSPICE voltage")
closed_loop_results.plot(ax=axB, x="Time",  y="V(sampled_current)", label="QSPICE current")

# load vhdl simulation data
vhdl_data = pd.read_csv(path_to_this_file + '/../../../boost_current_closed_loop.dat', delim_whitespace=True)

# vhdl_data.plot(ax=axT, x="time", y="volt", label="vhdl voltage")
vhdl_data.plot(ax=axT, x="time", y="vref", label="vhdl reference voltage")
# vhdl_data.plot(ax=axB, x="time", y="curr", label="vhdl current")
vhdl_data.plot(ax=axB, x="time", y="iref", label="vhdl reference current")

plt.show()
plt.close('all')
