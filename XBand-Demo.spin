{
    --------------------------------------------
    Filename: XBand-Demo.spin
    Author: Jesse Burt
    Description: Demo of the X-band motion sensor driver
    Copyright (c) 2023
    Started Jan 22, 2023
    Updated Jan 22, 2023
    See end of file for terms of use.
    --------------------------------------------
}
CON
   
    _clkmode    = cfg#_clkmode
    _xinfreq    = cfg#_xinfreq

' -- User-modifiable constants
    SER_BAUD    = 115_200

    X_EN_PIN    = 10
    X_OUT_PIN   = 9
    MOVE_THRESH = 2                             ' threshold above is considered movement
' --

OBJ

    cfg:    "boardcfg.flip"
    ser:    "com.serial.terminal.ansi"
    time:   "time"
    sensor: "sensor.motion.x-band"

PUB main() | cycles

    setup()

    repeat
        cycles := sensor.cycles()
        ser.pos_xy(0, 3)
        ser.printf1(@"Cycles = %4.4d\n\r", cycles)    

        if (cycles > MOVE_THRESH)
            ser.str(@"Motion detected") 
        ser.clear_line()

PUB setup()

    ser.start(SER_BAUD)
    time.msleep(30)
    ser.clear()
    ser.strln(@"Serial terminal started")

    if (sensor.startx(X_OUT_PIN, X_EN_PIN))
        sensor.set_meas_period(500)
        ser.strln(@"X-Band motion sensor driver started")
    else
        ser.strln(@"X-Band motion sensor driver failed to start - halting")
        repeat

DAT
{
Copyright 2022 Jesse Burt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

