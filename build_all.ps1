# Define the commands to run in parallel
$commands = @(
    {
        cd build_vivado
        Remove-Item -Recurse -Force *  # Force clean the folder
        d:\xilinx\Vivado\2024.1\bin\vivado.bat -mode batch -source C:\dev\tube_amplifier_power_supply\spartan_7\tcl_scripts\full_run.tcl
        d:\xilinx\Vivado\2024.1\bin\vivado.bat -mode batch -source C:\dev\tube_amplifier_power_supply\spartan_7\tcl_scripts\load_image.tcl -tclargs tube_power
        cd ..
        python test_hw_with_uart.py com7
        # exit
    } ,
    {
        d:/msys64/msys2.exe ./msys2_script_w_plot.sh 
        # exit
    },
    {
        Start-Process -FilePath .\test_with_titanium.bat -wait
        python test_hw_with_uart.py com14
        # exit
    }
)

$processes = foreach ($command in $commands) {
    Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", $command
}

# Optionally, wait for all processes to complete
foreach ($process in $processes) {
    $process.WaitForExit()
}
