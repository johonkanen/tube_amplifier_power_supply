
echo "Hello from MSYS2!"
# Add more commands here as needed
export PATH=$PATH:/c/Users/jaarh/AppData/Local/Programs/Python/Python311/
export VUNIT_NVC_PATH=/c/Program\ Files/NVC/bin/
export VUNIT_SIMULATOR=nvc
cd /c/dev/tube_amplifier_power_supply/
python vunit_run_tube_amp.py -p 16
