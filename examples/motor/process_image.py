#!/usr/bin/python3

import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import serial

# u = 0x75
# d = 0x64
# l = 0x6c
# r = 0x72
# L = 0x4c
# D = 0x44

def is_ok(img, p, q):   # pixel is in image and is undrawn
    if p >= 0 and p < img.shape[0] and q >= 0 and q < img.shape[1]:
        s = img[p,q,0] + img[p,q,1] + img[p,q,2]
        #print("(%d,%d) is ok: " % (p,q,str(s != img.ndim)))
        return s == 0    # check if pixel is undrawn i.e. not white; drawn pixels are set to white after drawing them

def find_nearest_undrawn_pixel(img, x, y):
    for m in range(1, max(img.shape[0], img.shape[1])):
        for k in range(0, m):
            if is_ok(img, x+k, y+m):
                return   (x+k, y+m)
            if is_ok(img, x+k, y-m):
                return   (x+k, y-m)
            if is_ok(img, x+m, y+k):
                return   (x+m, y+k)
            if is_ok(img, x-m, y+k):
                return   (x-m, y+k)
    return (-1,-1)

def find_a_dot(img):
    white = img.shape[2]
    for r in range(0, img.shape[0]):
        for c in range(0, img.shape[1]):
            if is_ok(img, r, c):
                return (r,c)
    return (-1,-1)

def get_xy(ser):
    # receive x and y as in script in server
    no_of_bytes = 2
    x = int.from_bytes(bytes=ser.read(no_of_bytes), byteorder="little", signed="True")
    y = int.from_bytes(bytes=ser.read(no_of_bytes), byteorder="little", signed="True")
    return (x,y)

def send_cmd(ser, cmd):
    (x,y) = get_xy(ser)
    print("X = " + str(x))
    print("Y = " + str(y))
    print('Sending command ' + str(cmd))
    ser.write(cmd)   # check syntax
    #print('x = ' + str(x) + '  y = ' + str(y))
    print('Loopback = ' + str(ser.read(1)))
    print()

def move(ser, t, f):  # move(from, to)
    dx = t[0] - f[0]
    dy = t[1] - f[1]
    while dx > 0:
        send_cmd(ser, b'\x6c')  # send l
        dx = dx - 1
    while dx < 0:
        send_cmd(ser, b'\x72') # send r
        dx = dx + 1
    while dy > 0:
        send_cmd(ser, b'\x75')  # send u
        dy = dy - 1
    while dy < 0:
        send_cmd(ser, b'\x64')  # send d
        dy = dy + 1
    return t

def find_adjacent_undrawn_pixel(img, x, y):

    p = x - 1
    q = y
    if is_ok(img, p, q):
        return (p,q)
    
    p = x + 1
    q = y
    if is_ok(img, p, q):
        return (p,q)
    
    p = x
    q = y - 1
    if is_ok(img, p, q):
        return (p,q)
    
    p = x
    q = y + 1
    if is_ok(img, p, q):
        return (p,q)
    
    p = x - 1
    q = y - 1
    if is_ok(img, p, q):
        return (p,q)
    
    p = x + 1
    q = y - 1
    if is_ok(img, p, q):
        return (p,q)
    
    p = x - 1
    q = y + 1
    if is_ok(img, p, q):
        return (p,q)
    
    p = x + 1
    q = y + 1
    if is_ok(img, p, q):
        return (p,q)
    
    return (-1,-1)

def mark_done(img, x ,y):
    for k in range(0, img.ndim):
        img[x,y,k] = 1

if __name__ == '__main__':
    img = mpimg.imread('./image/latest_sine+spiral.png')
    
    port_name = '/dev/ttyUSB0'
    #port_name = '/dev/ttyUSB2'
    #port_name = '/dev/ttyUSB4'
    baud_rate = 57600
    
    ser = serial.Serial(port_name, baud_rate, timeout = 100)
    x = 0
    y = 0
    #(x,y) = get_xy(ser)

    # find an undrawn dot 
    dot = find_a_dot(img)
    print("Found dot (%d,%d)" % (dot[0],dot[1]))
    
    while dot != (-1,-1):
        # move to dot
        (x,y) = move(ser, dot, (x,y))
        print('Moved to (%d,%d)' % (x,y))
        
        # drop pen
        send_cmd(ser, b'\x44')  # send D

        # mark current dot done (drawn)
        # keep drawing until no adjacent dot
        #     find an adjacent dot
        while dot != (-1,-1):
            (x,y) = move(ser, dot, (x,y))
            #print('x = %d, y = %d' % (x,y))
            mark_done(img, x, y)
            #print(img)
            dot = find_adjacent_undrawn_pixel(img, x, y)
            #print('found: (%d,%d)' % (dot[0],dot[1]))
        
        send_cmd(ser, b'\x4c')  # send L
        # dot = find_a_dot(img)
        dot = find_nearest_undrawn_pixel(img, x, y)
        #print('find a dot found = (%d,%d)' % (dot[0], dot[1]))

    print('Finished!')
    
    #ser.close()
    #input('Press enter to continue...')
