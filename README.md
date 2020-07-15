# Arbin-Battery-Cycling-GUI
GUI for generating battery data figures from Arbin battery cyclers.

BatteryDataProgram.m contains the GUI which calls upon the other 8 scripts/functions.

Assumes galvanostatic cycling with rests at constant rate, and where steps 2 and 4 are the constant current steps.

User inputs of file path, current density, and which 3 cycles should be plotted, checkboxes for optional processing of statistics, all cycles, dQ/dV, and capacity retention.

Push continue to begin running code, GUI should close following plotting of figures.
