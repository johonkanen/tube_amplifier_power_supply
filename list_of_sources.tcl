add_vhdl_file_to_project $source_folder/../tubepsu_addresses_pkg.vhd
add_vhdl_file_to_project $source_folder/top/system_clocks_pkg.vhd

add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/multiplier/multiplier_pkg.vhd                                                       
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/sincos/sincos_pkg.vhd                                                               
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/first_order_filter/first_order_filter_pkg.vhd                                       
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/multiplier/multiplier_base_types_22bit_pkg.vhd                                      
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/real_to_fixed/real_to_fixed_pkg.vhd                                                 
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/multiplier/configuration/multiply_with_1_input_and_output_registers_pkg.vhd         
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/division/division_pkg.vhd                                                           
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/division/division_internal_pkg.vhd                                                  
add_vhdl_file_to_project $source_folder/hVHDL_fixed_point/division/division_pkg_body.vhd                                                      

add_vhdl_file_to_project $source_folder/fpga_communication/hVHDL_uart/uart_rx/uart_rx_pkg.vhd                                                 
add_vhdl_file_to_project $source_folder/fpga_communication/hVHDL_uart/uart_tx/uart_tx_pkg.vhd                                                 
add_vhdl_file_to_project $source_folder/fpga_communication/hVHDL_fpga_interconnect/interconnect_configuration/data_15_address_15_bit_pkg.vhd  
add_vhdl_file_to_project $source_folder/fpga_communication/communications.vhd                                                                 

add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_type_definitions/float_type_definitions_pkg.vhd                            
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/normalizer/normalizer_pkg.vhd                                                    
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/denormalizer/denormalizer_pkg.vhd                                                
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_to_real_conversions/float_to_real_functions_pkg.vhd                        
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_to_real_conversions/float_to_real_conversions_pkg.vhd                      
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_arithmetic_operations/float_arithmetic_operations_pkg.vhd                  
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_to_integer_converter/float_to_integer_converter_pkg.vhd                    
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_adder/float_adder_pkg.vhd                                                  
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_multiplier/float_multiplier_pkg.vhd                                        
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_alu/float_alu_pkg.vhd                                                      
add_vhdl_file_to_project $source_folder/hVHDL_floating_point/float_first_order_filter/float_first_order_filter_pkg.vhd                        

add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/multi_port_ram_pkg.vhd        
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_rtl_read_x2_write_x1.vhd 
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x2_write_x1.vhd      
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/vhdl_assembler/microinstruction_pkg.vhd                                  
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/vhdl_assembler/float_assembler_pkg.vhd                                   
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/simple_processor/simple_processor_pkg.vhd                                
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/simple_processor/test_programs_pkg.vhd                                   

add_vhdl_file_to_project $source_folder/../hil_simulation/processor_configuration/tube_amp_processor_configuration_pkg.vhd                              
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/processor_configuration/fixed_point_command_pipeline_pkg.vhd             
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/processor_configuration/float_processor_ram_width_pkg.vhd                
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/processor_configuration/float_pipeline_pkg.vhd                           
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/simple_processor/float_example_program_pkg.vhd                           
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/arch_rtl_read_x4_write_x1.vhd 
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/source/hVHDL_memory_library/multi_port_ram/ram_read_x4_write_x1.vhd      
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/memory_processor/memory_processor.vhd                                    
add_vhdl_file_to_project $source_folder/hVHDL_microprogram_processor/memory_processor/memory_processing_pkg.vhd                               
add_vhdl_file_to_project $source_folder/float_configuration/titanium_float_configuraion_pkg.vhd                                               

add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/boost_model_pkg.vhd                                                        
add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/boost_rtl_entity.vhd                                                       
add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/current_control/current_control_pkg.vhd                                    
add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/voltage_control/voltage_control_pkg.vhd                                    

add_vhdl_file_to_project $source_folder/boost_control/boost_control_entity.vhd                                                                
add_vhdl_file_to_project $source_folder/main_system_control/main_system_control.vhd                                                           
add_vhdl_file_to_project $source_folder/../testbenches/vhdl2019_test_pkg.vhd                                                                            
add_vhdl_file_to_project $source_folder/main_state_machine/main_state_machine_pkg.vhd                                                         
add_vhdl_file_to_project $source_folder/../testbenches/main_state_machine/mock_component_interconnect_pkg.vhd                                           
add_vhdl_file_to_project $source_folder/common/timing/delay_timer_pkg.vhd                                                                     
add_vhdl_file_to_project $source_folder/common/timing/delay_timer.vhd                                                                         
add_vhdl_file_to_project $source_folder/top/system_control/component_interconnect/component_interconnect_pkg_body.vhd                         
add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/pfc_control_pkg.vhd                                                        
add_vhdl_file_to_project $source_folder/../hil_simulation/vhdl_sources/boost/boost_rtl_entity_interface_pkg.vhd                                         
add_vhdl_file_to_project $source_folder/fpga_communication/hVHDL_fpga_interconnect/fpga_interconnect_generic_pkg.vhd                          
add_vhdl_file_to_project $source_folder/fpga_interconnect_pkg.vhd                                                                             
add_vhdl_file_to_project $source_folder/fpga_communication/communication_protocol_generic_pkg.vhd                                             
add_vhdl_file_to_project $source_folder/fpga_communication/uart_protocol_pkg.vhd                                                              
add_vhdl_file_to_project $source_folder/hil_simulator/hil_simulation.vhd                                                                      

add_vhdl_file_to_project $source_folder/efinix_top.vhd                                                                                        
