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

number_of_points = 50000
uart.write_data_to_address(3, 16384);

time.sleep(0.1)
uart.request_data_stream_from_address(4, number_of_points);
time.sleep(0.05)
uart.write_data_to_address(3, 10000);
time.sleep(0.1)
uart.write_data_to_address(3, 16384);
simulated_current = uart.get_streamed_data(number_of_points).astype(np.int16);


time.sleep(0.1)
uart.request_data_stream_from_address(5, number_of_points);
time.sleep(0.05)
uart.write_data_to_address(3, 10000);
time.sleep(0.1)
uart.write_data_to_address(3, 16384);
simulated_voltage = uart.get_streamed_data(number_of_points).astype(np.int16);


ad_measurement = uart.stream_data_from_address(102, number_of_points);

(fig, ax) = pyplot.subplots(2, 2)
ax[0][0].plot(simulated_current/2**7) 
ax[0][1].plot(simulated_voltage/2**7) 
ax[1][0].plot(simulated_current) 
ax[1][1].plot(simulated_current) 

pyplot.show()
