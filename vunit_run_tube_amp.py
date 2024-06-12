#!/usr/bin/env python3

from pathlib import Path
from vunit import VUnit

# ROOT
ROOT = Path(__file__).resolve().parent
VU = VUnit.from_argv()

# tube_amp_power = VU.add_library("tube_amp_power")
# tube_amp_power.add_source_files(ROOT / "testbenches/measurement_interface/measurement_interface_tb.vhd")

#floating point testbenches

mcu = VU.add_library("mcu")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_type_definitions/float_word_length_24_bit_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_type_definitions/float_type_definitions_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_arithmetic_operations/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/normalizer/normalizer_configuration/normalizer_with_1_stage_pipe_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/denormalizer/denormalizer_configuration/denormalizer_with_1_stage_pipe_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/normalizer/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/denormalizer/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_to_real_conversions" / "*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_adder/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_multiplier/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_alu/*.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_floating_point/float_to_integer_converter/float_to_integer_converter_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/real_to_fixed/real_to_fixed_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/multiplier/configuration/multiply_with_1_input_and_output_registers_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/multiplier/multiplier_base_types_22bit_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/multiplier/multiplier_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/division/division_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/division/division_internal_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_fixed_point/division/division_pkg_body.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/processor_configuration/float_processor_ram_width_pkg.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/multi_port_ram_pkg.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x2_write_x1.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_sim_read_x2_write_x1.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x4_write_x1.vhd")
mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_sim_read_x4_write_x1.vhd")

mcu.add_source_files(ROOT / "source/hVHDL_microprogram_processor/processor_configuration/processor_configuration_pkg.vhd")
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
mcu.add_source_files(ROOT / "hil_simulation/supply_model/pfc_model_pkg.vhd")

mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/boost_model_pkg.vhd")
mcu.add_source_files(ROOT / "hil_simulation/vhdl_sources/boost/boost_rtl_entity.vhd")

mcu.add_source_files(ROOT / "hil_simulation/supply_model/supply_model_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/supply_model/rtl_model_tube_power_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/supply_model/boost_rtl_tb.vhd")

mcu.add_source_files(ROOT / "hil_simulation/supply_model/boost_entity_tb.vhd")
mcu.add_source_files(ROOT / "hil_simulation/hil_testbenches/boost/boost_closed_loop_tb.vhd")

dhb = VU.add_library("dhb")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator_pkg.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime_pkg.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/deadtime.vhd")
dhb.add_source_files(ROOT / "source/top/system_control/component_interconnect/power_supply_control/dhb_control/phase_modulator/phase_modulator.vhd")
dhb.add_source_files(ROOT / "testbenches/dhb_modulator/phase_modulator_tb.vhd")

dhb.add_source_files(ROOT / "testbenches/dhb_modulator/dhb_modulator_tb.vhd")


VU.main()
