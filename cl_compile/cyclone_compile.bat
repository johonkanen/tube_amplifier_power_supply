quartus_sh -t ../cyclone_10/tcl/cl10_tube_psu_v5.tcl -source_path ../cyclone_10/tcl/

rem quartus_pgm -c "USB-Blaster [USB-0]" -m JTAG -o "p;./output_files/cl10_tubepsu.sof"
rem quartus_cpf -c ../cyclone_10/tcl/generate_flash_image.cof
rem quartus_pgm -i -c "USB-Blaster [USB-0]" -m JTAG -o "ipv;./output_files/output_file.jic"
