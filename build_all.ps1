# Define the commands to run in parallel
$commands = @(
    {
        cd build_vivado
        Remove-Item -Recurse -Force *  # Force clean the folder
        d:\xilinx\Vivado\2024.1\bin\vivado.bat -mode batch -source C:\dev\tube_amplifier_power_supply\spartan_7\tcl_scripts\full_run.tcl
        d:\xilinx\Vivado\2024.1\bin\vivado.bat -mode batch -source C:\dev\tube_amplifier_power_supply\spartan_7\tcl_scripts\load_image.tcl -tclargs tube_power
        python ..\test_hw_with_uart.py com7
    },
    {
        cd build_quartus
        Remove-Item -Recurse -Force *  # Force clean the folder
        D:\intelFPGA_lite\23.1std\quartus\bin64\quartus_sh.exe -t C:\dev\tube_amplifier_power_supply\cyclone_10\tcl\cl10_tube_psu_v5.tcl -card_version u10
        Get-Content output_files/cl10_tubepsu.sta.summary -TotalCount 20
    },
    {
        cd build_ecp5
        Remove-Item -Recurse -Force *  # Force clean the folder
        d:\lscc\diamond\3.13\bin\nt64\pnmainc.exe C:\dev\tube_amplifier_power_supply\lfe5u\tcl_scripts\ecp5_compile.tcl
    }
)

# # Start the jobs
# $jobs = foreach ($command in $commands) {
#     Start-Job -ScriptBlock $command
# }

# # Wait for all jobs to complete
# $jobs | ForEach-Object { $_ | Wait-Job }

# # Retrieve the output of the jobs
# $jobs | ForEach-Object {
#     $jobOutput = Receive-Job -Job $_
#     $jobOutput
#     # Remove the job
#     Remove-Job -Job $_
# }
#
$processes = foreach ($command in $commands) {
    Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", $command
}

# Optionally, wait for all processes to complete
foreach ($process in $processes) {
    $process.WaitForExit()
}
