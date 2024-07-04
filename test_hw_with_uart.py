import os
import sys
import time

this_file_path = os.path.dirname(os.path.realpath(__file__))
sys.path.append(this_file_path + '/source/fpga_communication/fpga_uart_pc_software/')
comport = sys.argv[1]

from uart_communication_functions import *
from vhdl_parser import *

tubepsu_addresses = VHDLParser('tubepsu_addresses_pkg.vhd')


uart = uart_link(comport, 128e6/24)

for name, address in tubepsu_addresses.constants.items():
    data = uart.request_data_from_address(address)
    print(f"{name} (address {address}): {data}")

number_of_points = 2000


def simulate_cl_data(uart, address_to_stream, number_of_points):
    time.sleep(0.02)
    uart.request_data_stream_from_address(address_to_stream, number_of_points)
    time.sleep(0.01)
    uart.write_data_to_address(1, int(3*2**11))
    time.sleep(0.03)
    uart.write_data_to_address(1, int(65535-2*2**11))
    time.sleep(0.03)
    uart.write_data_to_address(2, int(30*2**7))
    time.sleep(0.010)
    uart.write_data_to_address(2, int(150*2**7))
    time.sleep(0.010)
    uart.write_data_to_address(2, int(100*2**7))
    time.sleep(0.020)
    uart.write_data_to_address(1, int(0*2**11))
    time.sleep(0.010)
    uart.write_data_to_address(11, int(230*2**7))
    time.sleep(0.020)
    uart.write_data_to_address(11, int(200*2**7))
    time.sleep(0.010)

    streamed_data = uart.get_streamed_data(number_of_points).astype(np.int16)
    # uart.write_data_to_address(3, int(0.75*2**15))
    uart.write_data_to_address(2, int(100*2**7))
    uart.write_data_to_address(1, int(0*2**11))
    
    return streamed_data

simulated_current = simulate_cl_data(uart , 4 , 50000);
simulated_voltage = simulate_cl_data(uart , 5 , 50000);


(fig, ax) = pyplot.subplots(2, 1)
ax[0].plot(simulated_voltage / 2**6, label='Simulated Voltage from fpga')
ax[0].set_ylabel('Voltage (scaled)')
ax[0].legend() 
ax[0].set_xticklabels([])  # Remove x-axis numbers from the top figure 

ax[1].plot(simulated_current / 2**7, label='Simulated Current from fpga')
ax[1].set_ylabel('Current (scaled)')
ax[1].legend()  # Show legend for the second plot

pyplot.show()
