#!/usr/bin/env python3

from pathlib import Path
from vunit import VUnit

# ROOT
ROOT = Path(__file__).resolve().parent
VU = VUnit.from_argv(compile_builtins=True, vhdl_standard="2019")

#floating point testbenches

mcu = VU.add_library("mcu")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_type_definitions/float_word_length_24_bit_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_type_definitions/float_type_definitions_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_arithmetic_operations/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/normalizer/normalizer_configuration/normalizer_with_1_stage_pipe_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/denormalizer/denormalizer_configuration/denormalizer_with_1_stage_pipe_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/normalizer/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/denormalizer/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_to_real_conversions" / "*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_adder/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_multiplier/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_alu/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_floating_point/float_to_integer_converter/float_to_integer_converter_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/real_to_fixed/real_to_fixed_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/multiplier/configuration/multiply_with_1_input_and_output_registers_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/multiplier/multiplier_base_types_22bit_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/multiplier/multiplier_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/division/division_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/division/division_internal_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/division/division_pkg_body.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_fixed_point/sincos/sincos_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/processor_configuration/float_processor_ram_width_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/multi_port_ram_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x2_write_x1.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_sim_read_x2_write_x1.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x4_write_x1.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_sim_read_x4_write_x1.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/vhdl_assembler/microinstruction_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/vhdl_assembler/float_assembler_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/simple_processor/test_programs_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/processor_configuration/float_pipeline_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/simple_processor/simple_processor_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/memory_processor/memory_processing_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/memory_processor/memory_processor.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/simple_processor/float_example_program_pkg.vhd")

mcu.add_source_files(ROOT / "source/fpga_communication/hVHDL_fpga_interconnect/interconnect_configuration/data_15_address_15_bit_pkg.vhd")
mcu.add_source_files(ROOT / "source/fpga_communication/hVHDL_fpga_interconnect/fpga_interconnect_pkg.vhd")


mcu.add_source_files(ROOT / "source/hVHDL_dynamic_model_verification_library/simulator_utilities/write_pkg.vhd")

mcu.add_source_files(ROOT / "hil_simulation/processor_configuration/tube_amp_processor_configuration_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/boost_model_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/boost_rtl_entity_interface_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/boost_rtl_entity.vhd")

mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/current_control/current_control_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/voltage_control/voltage_control_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/pfc_control_pkg.vhd")

mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/boost_rtl_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/boost_closed_loop_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/boost_voltage_closed_loop_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/pfc/pfc_closed_loop_tb.vhd")

mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/diode_model_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/diode_model_rtl_tb.vhd")

mcu.add_source_files(ROOT / "source/boost_control/boost_control_entity.vhd")
mcu.add_source_files(ROOT / "tubepsu_addresses_pkg.vhd")
mcu.add_source_files(ROOT / "testbenches/pfc_control/pfc_control_tb.vhd")

# mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/entity/boost_entity_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/entity/boost_rtl_closed_loop_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/pfc/pfc_entity_tb.vhd")

dhb = VU.add_library("dhb")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime_pkg.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator.vhd")
dhb.add_source_files(ROOT / "testbenches/dhb_modulator/phase_modulator_tb.vhd")

dhb.add_source_files(ROOT / "testbenches/dhb_modulator/dhb_modulator_tb.vhd")

vhdl2019 = VU.add_library("vhdl2019")
vhdl2019.add_source_files(ROOT / "testbenches/vhdl2019_test_pkg.vhd")
vhdl2019.add_source_files(ROOT / "testbenches/vhdl2019_test_tb.vhd")
vhdl2019.add_source_files(ROOT / "testbenches/vhdl2019_test_w_entity_tb.vhd")

vhdl2019_unresolved = VU.add_library("vhdl2019_unresolved")
vhdl2019_unresolved.add_source_files(ROOT / "testbenches/vhdl2019_test_unresolved_tb.vhd")

vhdl2008 = VU.add_library("vhdl2008")
vhdl2008.add_source_files(ROOT / "testbenches/vhdl2008/test_generic_pkg.vhd")
vhdl2008.add_source_files(ROOT / "testbenches/vhdl2008/gentest_nopackage_generic_tb.vhd")

vhdl2008_pkg_generic = VU.add_library("vhdl2008_pkg_generic")
vhdl2008_pkg_generic.add_source_files(ROOT / "testbenches/vhdl2008/test_generic_pkg.vhd")
vhdl2008_pkg_generic.add_source_files(ROOT / "testbenches/vhdl2008/gentest_w_package_generic_tb.vhd")


main_state_machine = VU.add_library("main_state_machine")
main_state_machine.add_source_files(ROOT / "source/common/timing/delay_timer_pkg.vhd")
main_state_machine.add_source_files(ROOT / "source/common/timing/delay_timer.vhd")
main_state_machine.add_source_files(ROOT / "source/main_state_machine/main_state_machine_pkg.vhd")
main_state_machine.add_source_files(ROOT / "testbenches/main_state_machine/mock_component_interconnect_pkg.vhd")
main_state_machine.add_source_files(ROOT / "source/top/system_control/component_interconnect/component_interconnect_pkg_body.vhd")
main_state_machine.add_source_files(ROOT / "testbenches/main_state_machine/main_state_machine_tb.vhd")


VU.set_sim_option("nvc.sim_flags", ["-w"])
VU.main()
