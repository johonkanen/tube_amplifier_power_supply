import os
import sys
import time

this_file_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(this_file_path + '/source/fpga_communication/fpga_uart_pc_software/')
comport = sys.argv[1]

from uart_communication_functions import *

uart = uart_link(comport, 128e6/24)
print("component interconnect data : ", uart.request_data_from_address(100))
print("system control data : ", uart.request_data_from_address(101))

number_of_points = 2000
uart.write_data_to_address(3, 16384);

def simulate_data(uart, address_to_stream, number_of_points):
    uart.write_data_to_address(3, int(0.75*2**15))
    time.sleep(0.01)
    uart.request_data_stream_from_address(address_to_stream, number_of_points)
    uart.write_data_to_address(3, int(0.5*2**15))
    time.sleep(0.0005)
    uart.write_data_to_address(3, int(0.25*2**15))
    time.sleep(0.0005)
    uart.write_data_to_address(2, int(120*2**7))
    time.sleep(0.0005)
    uart.write_data_to_address(1, int(10*2**11))
    streamed_data = uart.get_streamed_data(number_of_points).astype(np.int16)
    uart.write_data_to_address(3, int(0.75*2**15))
    uart.write_data_to_address(2, int(100*2**7))
    uart.write_data_to_address(1, int(0*2**11))
    
    return streamed_data

def simulate_cl_data(uart, address_to_stream, number_of_points):
    time.sleep(0.02)
    uart.request_data_stream_from_address(address_to_stream, number_of_points)
    uart.write_data_to_address(1, int(00*2**11))
    time.sleep(0.02)
    uart.write_data_to_address(1, int(2*2**11))
    time.sleep(0.02)
    uart.write_data_to_address(1, int(65535-2*2**11))

    streamed_data = uart.get_streamed_data(number_of_points).astype(np.int16)
    uart.write_data_to_address(3, int(0.75*2**15))
    uart.write_data_to_address(2, int(100*2**7))
    uart.write_data_to_address(1, int(0*2**11))
    
    return streamed_data

simulated_current = simulate_cl_data(uart , 4 , 20000);
simulated_voltage = simulate_cl_data(uart , 5 , 20000);


ad_measurement = uart.stream_data_from_address(102, number_of_points);

(fig, ax) = pyplot.subplots(2, 1)
ax[0].plot(simulated_voltage / 2**6, label='Simulated Voltage from fpga')
ax[0].set_ylabel('Voltage (scaled)')
ax[0].legend() 
ax[0].set_xticklabels([])  # Remove x-axis numbers from the top figure 

ax[1].plot(simulated_current / 2**7, label='Simulated Current from fpga')
ax[1].set_ylabel('Current (scaled)')
ax[1].legend()  # Show legend for the second plot

pyplot.show()
