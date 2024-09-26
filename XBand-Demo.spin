{
----------------------------------------------------------------------------------------------------
    Filename:       XBand-Demo.spin
    Description:    Demo of the X-band motion sensor driver
    Author:         Jesse Burt
    Started:        Jan 22, 2023
    Updated:        Sep 26, 2024
    Copyright (c) 2024 - See end of file for terms of use.
----------------------------------------------------------------------------------------------------
}

CON
   
    _clkmode    = xtal1+pll16x
    _xinfreq    = 5_000_000


' -- User-modifiable constants
    MOVE_THRESH = 2                             ' threshold: above this is considered movement
' --

OBJ

    time:   "time"
    ser:    "com.serial.terminal.ansi" | SER_BAUD=115_200
    sensor: "sensor.motion.x-band" | OUT_PIN=0, EN_PIN=1


PUB main() | cycles

    setup()

    repeat
        cycles := sensor.cycles()
        ser.pos_xy(0, 3)
        ser.printf1(@"Cycles = %4.4d\n\r", cycles)    

        if ( cycles > MOVE_THRESH )
            ser.str(@"Motion detected") 
        ser.clear_line()


PUB setup()

    ser.start()
    time.msleep(30)
    ser.clear()
    ser.strln(@"Serial terminal started")

    if ( sensor.start() )
        sensor.set_meas_period(500)
        ser.strln(@"X-Band motion sensor driver started")
    else
        ser.strln(@"X-Band motion sensor driver failed to start - halting")
        repeat


DAT
{
Copyright 2024 Jesse Burt

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

