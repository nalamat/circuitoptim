# CircuitOptim

A circuit optimization toolbox for MATLAB based on SPICE simulations


## Netlist formatting

Prepare your netlist as you would normally do, then wrap numeric parameters
needed to be optimized in square brackets. At the end of the line add two stars
(**) and for each parameter in brackets, write optimization options again
enclosed in brackets with the following format:

    [lower_bound upper_bound (scale)]

Lower and upper bounds can be determined in the SPICE fashion: 1e3, 1K or 1000.
Scale is optional and has to be either 'lin' or 'dec' with latter being the
default value. The following example optimizes resistance of R1 between 1 and
100K Ohm in a decade scale:

    R1 VCC GND [1K]  ** [1 100K dec]

Remember if either of lower or upper bounds are not specified, the
corresponding parameter won't take any part in optimization.


## Web and contact

Visit CircuitOptim's page at GitHub:
    http://github.com/nalamat/circuitoptim

Ask questions, report bugs and give suggestions here:
    http://github.com/nalamat/circuitoptim/issues

Feel free to email me about anything:
    nnalamat@gmail.com