[![Build Status](https://travis-ci.org/stbenjam/quade.svg?branch=master)](https://travis-ci.org/stbenjam/quade)

# Quade

Quade an emulator for quadruple format intermediate representation used
by CSCI E-95 at Harvard Extension School.

Quadruples consist of up to four fields, typically:

  * One operation
  * One destination
  * Up to two sources

   e.g. `(addSignedWord t0, t1, t2)`

Comments begin with `#` and end on a newline.

## Building

Run `make`, run quade with a filename argument, see test/ for example IR:

```
./quade <filename>
```

## Symbol and String tables

TODO

## System Calls

TODO
