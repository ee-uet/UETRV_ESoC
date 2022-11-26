#!/usr/bin/python3
import serial
import time

up_bound = 2000
left_bound = 3000
port_name = '/dev/ttyUSB0'
baud_rate = 57600

ser = serial.Serial(port_name, baud_rate, timeout = 100)

time.sleep(9)
no_of_bytes = ser.inWaiting()           # get no. of bytes in buffer
data = ser.read(no_of_bytes)            # read everything in buffer
print('No. of bytes = ' + str(no_of_bytes))
print('Raw data = ' + str(data))

#no_of_bytes = 2
#
#while(1):
#	x = int.from_bytes(bytes=ser.read(no_of_bytes), byteorder="little", signed="True")
#	y = int.from_bytes(bytes=ser.read(no_of_bytes), byteorder="little", signed="True")
#	ser.write(b'\x75') # D=0x44, l=0x6C, d=0x64, r=0x72, u=0x75
#	print("X = " + str(x))
#	print("Y = " + str(y))
#	print('Loopback = ' + str(ser.read(1)))
