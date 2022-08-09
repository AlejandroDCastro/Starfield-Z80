# Starfield-Z80
Starfield effect made in Z80 assembly by Alejandro Castro Valero, using CPCtelera framework.

***

## Requirements
* **CPCtelera** framework
* **Windows**, **Linux** and **OSX** operating system

***

## Compilation
* `cd starfield`
* `make`
  * `starfield.cdt` emulates an amstrad cassette
  * `starfield.dsk` disk file
  * `starfield.sna` snapshot
* `cpct_winape starfield.sna` | `cpct_winape starfield.dsk` | `cpct_rvm starfield.cdt` execution
