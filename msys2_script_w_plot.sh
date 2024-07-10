
echo "Hello from MSYS2!"
# Add more commands here as needed
export PATH=$PATH:/c/Users/jaarh/AppData/Local/Programs/Python/Python311/
export VUNIT_NVC_PATH=/c/Program\ Files/NVC/bin/
export VUNIT_SIMULATOR=nvc
cd /c/dev/tube_amplifier_power_supply/
python vunit_run_tube_amp.py -p 16

python hil_simulation/python_scripts/boost/plot_rtl_voltage_closed_loop_vs_qspice.py &
python hil_simulation/python_scripts/boost/plot_voltage_closed_loop_vs_qspice.py &
python hil_simulation/python_scripts/boost/plot_boost_closed_loop_vs_qspice.py &
python plot_diode_model.py &
python plot_diode_model_rtl.py &
python hil_simulation/python_scripts/boost/plot_boost_rtl_vs_qspice.py

wait
