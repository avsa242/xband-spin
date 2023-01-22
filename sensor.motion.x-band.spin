{
    --------------------------------------------
    Filename: sensor.motion.x-band.spin
    Author: Jesse Burt
    Description: Driver for the SimplyTronics X-band motion sensor
        (SimplyTronics PN ST-00018, Parallax PN 32213)
    Copyright (c) 2023
    Started Jan 22, 2023
    Updated Jan 22, 2023
    See end of file for terms of use.
    --------------------------------------------

    NOTE: This is based on X Band Motion Detector.spin,
        originally written by Parallax.
}

VAR

    long _OUT_PIN, _EN_PIN
    long _meas_period

{ pull in symbols for counter modes }
#include "core.con.counters.spin"

PUB startx(OUT_PIN, EN_PIN): status
' Start the driver using custom I/O settings
'   OUT_PIN: 0..31 sensor output pin (out of the sensor, into the Propeller)
'   EN_PIN: 0..31 sensor enable pin (out of the Propeller, into the sensor)
'       (optional - specify invalid pin # to ignore)
    if (lookdown(OUT_PIN: 0..31))
        longmove(@_OUT_PIN, @OUT_PIN, 2)
        _meas_period := 500
        return (cogid+1)
    return FALSE

PUB defaults()
' Default settings
    _meas_period := 500

PUB cycles(): c | t
' Measure motion threshold
'   Returns: number of high states during measurement period
    powered(true)
    ctra := (POSEDGE_DETECT | _OUT_PIN)
    frqa := 1                                   ' add 1 for each cycle
    t := cnt
    phsa := 0                                   ' reset count
    waitcnt(t += (_meas_period * (clkfreq / 1000)))
    c := phsa
    powered(false)

PUB meas_period(): t
' Get currently set measurement period
'   Returns: milliseconds
    return _meas_period

PUB set_meas_period(t)
' Set measurement period in milliseconds
    _meas_period := t

PUB powered(p)
' Enable sensor power
'   Valid values: TRUE (non-zero), FALSE (0)
    if (lookdown(_EN_PIN: 0..31))               ' ignore unless the pin was defined on startup
        if (p)
            outa[_EN_PIN] := 1                  ' non-zero: enable sensor
            dira[_EN_PIN] := 1
        else
            outa[_EN_PIN] := 0                  ' zero: disable sensor
            dira[_EN_PIN] := 1

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

