# Quade

Quade an emulator for quadruple format intermediate representation used by CSCI
E-95 at Harvard Extension School.

Quadruples consists of:

  * One operation
  * One destination
  * Up to two sources

   e.g. `(addSignedWord t0, t1, t2)`

Everything outside a pair of parens is ignored, allowing maximum flexibility
with the language.  This is intended to handle parsing the output of student
compiler's.  Operations are case insensitive.

## Symbol and String tables

## System Calls

