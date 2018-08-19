.data
# Strings
_StringLabel_0000: .asciiz  "First argument should be value to count up to.\n"
_StringLabel_0001: .asciiz  "Fizz"
_StringLabel_0002: .asciiz  "Buzz"
_StringLabel_0003: .asciiz  "\n"

.text
  # (procBegin, atoi)
_Global_atoi:
  ##################### Stack Frame #####################
  ############# CALLERS ARGUMENT BUILD AREA #############
  #
  #   total size = 0
  #
  ############# GENERAL REGISTER SAVE AREA ##############
  #
  #   ra size=4 offset=0
  #   fp size=4 offset=4
  #   s0 size=4 offset=8
  #   s1 size=4 offset=12
  #   s2 size=4 offset=16
  #   s3 size=4 offset=20
  #   s4 size=4 offset=24
  #   s5 size=4 offset=28
  #   s6 size=4 offset=32
  #   s7 size=4 offset=36
  #   total size = 40
  #
  #####################  TEMPS AREA #####################
  #
  #   spilled t0012 to offset=40
  #   spilled t0013 to offset=44
  #   spilled t0014 to offset=48
  #   spilled t0023 to offset=52
  #   spilled t0024 to offset=56
  #   spilled t0025 to offset=60
  #   spilled t0026 to offset=64
  #   spilled t0027 to offset=68
  #   spilled t0028 to offset=72
  #   spilled t0029 to offset=76
  #   spilled t0030 to offset=80
  #   spilled t0031 to offset=84
  #   spill registers = 12
  #
  ############## AUTOMATIC VARIABLE ALLOCATION ##########
  #
  #   name=result size=4, offset=88
  #   name=i size=4, offset=92
  #
  ################### FUNCTION PARAMETERS  ##############
  #
  #   name=str size=4, offset=96
  #
  #######################################################

  li $k0, -96                     # Total stack size: 96
  addu $sp, $sp, $k0              # Allocate space on stack
  sw $fp, 4($sp)                  # Save old FP
  move $fp, $sp                   # Set FP
  # Save RA:
  sw $ra, 0($fp)

  # Save S registers
  sw $s0, 8($fp)
  sw $s1, 12($fp)
  sw $s2, 16($fp)
  sw $s3, 20($fp)
  sw $s4, 24($fp)
  sw $s5, 28($fp)
  sw $s6, 32($fp)
  sw $s7, 36($fp)

  # (constInt, t0000, 0)
  li $s0, 0
  # (addressOf, t0001, result)
  addiu $s1, $fp, 88
  # (storeWord, t0001, t0000)
  sw $s0, 0($s1)

  # (constInt, t0002, 0)
  li $s0, 0
  # (addressOf, t0003, i)
  addiu $s1, $fp, 92
  # (storeWord, t0003, t0002)
  sw $s0, 0($s1)

  # (label, _GeneratedLabel_1)

_GeneratedLabel_1:
  # (addressOf, t0004, str)
  addiu $s0, $fp, 96
  # (loadWord, t0005, t0004)
  lw $s1, 0($s0)
  # (addressOf, t0006, i)
  addiu $s2, $fp, 92
  # (loadWord, t0007, t0006)
  lw $s3, 0($s2)
  # (constInt, t0008, 1)
  li $s4, 1
  # (multSignedWord, t0009, t0007, t0008)
  mult $s3, $s4
  mflo $s5
  # (addSignedWord, t0010, t0005, t0009)
  addu $s6, $s1, $s5
  # (loadSignedByte, t0011, t0010)
  lb $s7, 0($s6)
  # (castByteToSignedWord, t0012, t0011)
  sll $t0, $s7, 24
  sra $t0, $t0, 24

  # SPILL STORE: orig=12, fp offset=40
  sw $t0, 40($fp)

  # (constInt, t0013, 0)
  li $t0, 0

  # SPILL STORE: orig=13, fp offset=44
  sw $t0, 44($fp)


  #  FILL LOAD: orig=12, fp offset=40
  lw $t1, 40($fp)


  #  FILL LOAD: orig=13, fp offset=44
  lw $t2, 44($fp)

  # (neWord, t0014, t0012, t0013)
  sne $t0, $t1, $t2

  # SPILL STORE: orig=14, fp offset=48
  sw $t0, 48($fp)


  #  FILL LOAD: orig=14, fp offset=48
  lw $t0, 48($fp)

  # (gotoIfFalse, t0014, _GeneratedLabel_2)
  beq $t0, $zero, _GeneratedLabel_2

  # (addressOf, t0015, str)
  addiu $s0, $fp, 96
  # (loadWord, t0016, t0015)
  lw $s1, 0($s0)
  # (addressOf, t0017, i)
  addiu $s2, $fp, 92
  # (loadWord, t0018, t0017)
  lw $s3, 0($s2)
  # (constInt, t0019, 1)
  li $s4, 1
  # (multSignedWord, t0020, t0018, t0019)
  mult $s3, $s4
  mflo $s5
  # (addSignedWord, t0021, t0016, t0020)
  addu $s6, $s1, $s5
  # (loadSignedByte, t0022, t0021)
  lb $s7, 0($s6)
  # (castByteToSignedWord, t0023, t0022)
  sll $t0, $s7, 24
  sra $t0, $t0, 24

  # SPILL STORE: orig=23, fp offset=52
  sw $t0, 52($fp)

  # (constInt, t0024, 48)
  li $t0, 48

  # SPILL STORE: orig=24, fp offset=56
  sw $t0, 56($fp)


  #  FILL LOAD: orig=23, fp offset=52
  lw $t1, 52($fp)


  #  FILL LOAD: orig=24, fp offset=56
  lw $t2, 56($fp)

  # (subSignedWord, t0025, t0023, t0024)
  subu $t0, $t1, $t2

  # SPILL STORE: orig=25, fp offset=60
  sw $t0, 60($fp)

  # (addressOf, t0026, result)
  addiu $t0, $fp, 88

  # SPILL STORE: orig=26, fp offset=64
  sw $t0, 64($fp)


  #  FILL LOAD: orig=26, fp offset=64
  lw $t1, 64($fp)

  # (loadWord, t0027, t0026)
  lw $t0, 0($t1)

  # SPILL STORE: orig=27, fp offset=68
  sw $t0, 68($fp)

  # (constInt, t0028, 10)
  li $t0, 10

  # SPILL STORE: orig=28, fp offset=72
  sw $t0, 72($fp)


  #  FILL LOAD: orig=27, fp offset=68
  lw $t1, 68($fp)


  #  FILL LOAD: orig=28, fp offset=72
  lw $t2, 72($fp)

  # (multSignedWord, t0029, t0027, t0028)
  mult $t1, $t2
  mflo $t0

  # SPILL STORE: orig=29, fp offset=76
  sw $t0, 76($fp)


  #  FILL LOAD: orig=25, fp offset=60
  lw $t1, 60($fp)


  #  FILL LOAD: orig=29, fp offset=76
  lw $t2, 76($fp)

  # (addSignedWord, t0030, t0025, t0029)
  addu $t0, $t1, $t2

  # SPILL STORE: orig=30, fp offset=80
  sw $t0, 80($fp)

  # (addressOf, t0031, result)
  addiu $t0, $fp, 88

  # SPILL STORE: orig=31, fp offset=84
  sw $t0, 84($fp)


  #  FILL LOAD: orig=31, fp offset=84
  lw $t0, 84($fp)


  #  FILL LOAD: orig=30, fp offset=80
  lw $t1, 80($fp)

  # (storeWord, t0031, t0030)
  sw $t1, 0($t0)

  # (addressOf, t0032, i)
  addiu $s0, $fp, 92
  # (loadWord, t0033, t0032)
  lw $s1, 0($s0)
  # (constInt, t0034, 1)
  li $s2, 1
  # (addSignedWord, t0035, t0033, t0034)
  addu $s3, $s1, $s2
  # (storeWord, t0032, t0035)
  sw $s3, 0($s0)

  # (goto, _GeneratedLabel_1)
  b _GeneratedLabel_1
  # (label, _GeneratedLabel_2)

_GeneratedLabel_2:
  # (addressOf, t0036, result)
  addiu $s0, $fp, 88
  # (loadWord, t0037, t0036)
  lw $s1, 0($s0)
  # (returnWord, t0037)
  move $v0, $s1
  # (goto, _GeneratedLabel_0)
  b _GeneratedLabel_0

  # (label, _GeneratedLabel_0)

_GeneratedLabel_0:
  # (procEnd, atoi)
  # Restore S registers
  lw $s0, 8($fp)
  lw $s1, 12($fp)
  lw $s2, 16($fp)
  lw $s3, 20($fp)
  lw $s4, 24($fp)
  lw $s5, 28($fp)
  lw $s6, 32($fp)
  lw $s7, 36($fp)

  # Restore RA:
  lw $ra, 0($fp)

  # Restore old FP:
  lw $fp, 4($fp)

  or $sp, $fp, $zero

  jr $ra
  # (procBegin, main)
main:
  ##################### Stack Frame #####################
  ############# CALLERS ARGUMENT BUILD AREA #############
  #
  #   param 0 = 0
  #   total size = 4
  #
  ############# GENERAL REGISTER SAVE AREA ##############
  #
  #   ra size=4 offset=4
  #   fp size=4 offset=8
  #   s0 size=4 offset=12
  #   s1 size=4 offset=16
  #   s2 size=4 offset=20
  #   s3 size=4 offset=24
  #   s4 size=4 offset=28
  #   s5 size=4 offset=32
  #   s6 size=4 offset=36
  #   s7 size=4 offset=40
  #   total size = 40
  #
  #####################  TEMPS AREA #####################
  #
  #   spill registers = 0
  #
  ############## AUTOMATIC VARIABLE ALLOCATION ##########
  #
  #   name=i size=4, offset=44
  #   name=fizz size=4, offset=48
  #   name=buzz size=4, offset=52
  #   name=max size=4, offset=56
  #
  #######################################################
  #
  #   double word alignment space = 4
  #
  ################### FUNCTION PARAMETERS  ##############
  #
  #   name=argc size=4, offset=184
  #   name=argv size=4, offset=188
  #
  #######################################################

  li $k0, -184                     # Total stack size: 184
  addu $sp, $sp, $k0              # Allocate space on stack
  sw $fp, 8($sp)                  # Save old FP
  move $fp, $sp                   # Set FP
  # Save RA:
  sw $ra, 4($fp)

  # Save S registers
  sw $s0, 12($fp)
  sw $s1, 16($fp)
  sw $s2, 20($fp)
  sw $s3, 24($fp)
  sw $s4, 28($fp)
  sw $s5, 32($fp)
  sw $s6, 36($fp)
  sw $s7, 40($fp)

  # (addressOf, t0038, argc)
  addiu $s0, $fp, 184
  # (loadWord, t0039, t0038)
  lw $s1, 0($s0)
  # (constInt, t0040, 2)
  li $s2, 2
  # (ltSignedWord, t0041, t0039, t0040)
  slt $s3, $s1, $s2
  # (gotoIfFalse, t0041, _GeneratedLabel_4)
  beq $s3, $zero, _GeneratedLabel_4
  # (addressOf, t0042, _StringLabel_0000)
  la $s4, _StringLabel_0000
  # (parameter, 0, t0042)

  # Parameter: 0
  sw $s4, 0($fp)
  move $a0, $s4

  # (syscall, syscall_print_string, 4)
  li $v0, 4
  syscall

  # (constInt, t0043, 1)
  li $s0, 1
  # (parameter, 0, t0043)

  # Parameter: 0
  sw $s0, 0($fp)
  move $a0, $s0

  # (syscall, syscall_exit2, 17)
  li $v0, 17
  syscall

  # (goto, _GeneratedLabel_4)
  b _GeneratedLabel_4
  # (label, _GeneratedLabel_4)

_GeneratedLabel_4:
  # (addressOf, t0044, argv)
  addiu $s0, $fp, 188
  # (constInt, t0045, 1)
  li $s1, 1
  # (constInt, t0046, 4)
  li $s2, 4
  # (multSignedWord, t0047, t0045, t0046)
  mult $s1, $s2
  mflo $s3
  # (addSignedWord, t0048, t0044, t0047)
  addu $s4, $s0, $s3
  # (loadWord, t0049, t0048)
  lw $s5, 0($s4)
  # (parameter, 0, t0049)

  # Parameter: 0
  sw $s5, 0($fp)
  move $a0, $s5

  # (call, atoi)
  jal _Global_atoi
  # (resultWord, t0050)
  move $s6, $v0
  # (addressOf, t0051, max)
  addiu $s7, $fp, 56
  # (storeWord, t0051, t0050)
  sw $s6, 0($s7)

  # (constInt, t0052, 1)
  li $s0, 1
  # (addressOf, t0053, i)
  addiu $s1, $fp, 44
  # (storeWord, t0053, t0052)
  sw $s0, 0($s1)

  # (label, _GeneratedLabel_5)

_GeneratedLabel_5:
  # (addressOf, t0054, i)
  addiu $s0, $fp, 44
  # (loadWord, t0055, t0054)
  lw $s1, 0($s0)
  # (addressOf, t0056, max)
  addiu $s2, $fp, 56
  # (loadWord, t0057, t0056)
  lw $s3, 0($s2)
  # (leSignedWord, t0058, t0055, t0057)
  sle $s4, $s1, $s3
  # (gotoIfFalse, t0058, _GeneratedLabel_6)
  beq $s4, $zero, _GeneratedLabel_6

  # (addressOf, t0059, i)
  addiu $s0, $fp, 44
  # (loadWord, t0060, t0059)
  lw $s1, 0($s0)
  # (constInt, t0061, 3)
  li $s2, 3
  # (remSignedWord, t0062, t0060, t0061)
  div $s1, $s2
  mfhi $s3
  # (constInt, t0063, 0)
  li $s4, 0
  # (eqWord, t0064, t0062, t0063)
  seq $s5, $s3, $s4
  # (addressOf, t0065, fizz)
  addiu $s6, $fp, 48
  # (storeWord, t0065, t0064)
  sw $s5, 0($s6)
  # (gotoIfFalse, t0064, _GeneratedLabel_7)
  beq $s5, $zero, _GeneratedLabel_7
  # (addressOf, t0066, _StringLabel_0001)
  la $s7, _StringLabel_0001
  # (parameter, 0, t0066)

  # Parameter: 0
  sw $s7, 0($fp)
  move $a0, $s7

  # (syscall, syscall_print_string, 4)
  li $v0, 4
  syscall

  # (goto, _GeneratedLabel_7)
  b _GeneratedLabel_7
  # (label, _GeneratedLabel_7)

_GeneratedLabel_7:
  # (addressOf, t0067, i)
  addiu $s0, $fp, 44
  # (loadWord, t0068, t0067)
  lw $s1, 0($s0)
  # (constInt, t0069, 5)
  li $s2, 5
  # (remSignedWord, t0070, t0068, t0069)
  div $s1, $s2
  mfhi $s3
  # (constInt, t0071, 0)
  li $s4, 0
  # (eqWord, t0072, t0070, t0071)
  seq $s5, $s3, $s4
  # (addressOf, t0073, buzz)
  addiu $s6, $fp, 52
  # (storeWord, t0073, t0072)
  sw $s5, 0($s6)
  # (gotoIfFalse, t0072, _GeneratedLabel_8)
  beq $s5, $zero, _GeneratedLabel_8
  # (addressOf, t0074, _StringLabel_0002)
  la $s7, _StringLabel_0002
  # (parameter, 0, t0074)

  # Parameter: 0
  sw $s7, 0($fp)
  move $a0, $s7

  # (syscall, syscall_print_string, 4)
  li $v0, 4
  syscall

  # (goto, _GeneratedLabel_8)
  b _GeneratedLabel_8
  # (label, _GeneratedLabel_8)

_GeneratedLabel_8:
  # (addressOf, t0075, fizz)
  addiu $s0, $fp, 48
  # (loadWord, t0076, t0075)
  lw $s1, 0($s0)
  # (gotoIfFalse, t0076, _GeneratedLabel_9)
  beq $s1, $zero, _GeneratedLabel_9
  # (constInt, t0081, 1)
  li $s2, 1
  # (goto, _GeneratedLabel_11)
  b _GeneratedLabel_11
  # (label, _GeneratedLabel_9)

_GeneratedLabel_9:
  # (constInt, t0081, 0)
  li $s2, 0
  # (label, _GeneratedLabel_10)

_GeneratedLabel_10:
  # (addressOf, t0079, buzz)
  addiu $s3, $fp, 52
  # (loadWord, t0080, t0079)
  lw $s4, 0($s3)
  # (gotoIfFalse, t0080, _GeneratedLabel_11)
  beq $s4, $zero, _GeneratedLabel_11
  # (constInt, t0081, 1)
  li $s2, 1
  # (label, _GeneratedLabel_11)

_GeneratedLabel_11:
  # (unaryLogicalNegation, t0082, t0081)
  seq $s5, $s2, $zero
  # (gotoIfFalse, t0082, _GeneratedLabel_12)
  beq $s5, $zero, _GeneratedLabel_12
  # (addressOf, t0083, i)
  addiu $s6, $fp, 44
  # (loadWord, t0084, t0083)
  lw $s7, 0($s6)
  # (parameter, 0, t0084)

  # Parameter: 0
  sw $s7, 0($fp)
  move $a0, $s7

  # (syscall, syscall_print_int, 1)
  li $v0, 1
  syscall

  # (goto, _GeneratedLabel_12)
  b _GeneratedLabel_12
  # (label, _GeneratedLabel_12)

_GeneratedLabel_12:
  # (addressOf, t0085, _StringLabel_0003)
  la $s0, _StringLabel_0003
  # (parameter, 0, t0085)

  # Parameter: 0
  sw $s0, 0($fp)
  move $a0, $s0

  # (syscall, syscall_print_string, 4)
  li $v0, 4
  syscall

  # (addressOf, t0086, i)
  addiu $s0, $fp, 44
  # (loadWord, t0087, t0086)
  lw $s1, 0($s0)
  # (constInt, t0088, 1)
  li $s2, 1
  # (addSignedWord, t0089, t0087, t0088)
  addu $s3, $s1, $s2
  # (storeWord, t0086, t0089)
  sw $s3, 0($s0)

  # (goto, _GeneratedLabel_5)
  b _GeneratedLabel_5
  # (label, _GeneratedLabel_6)

_GeneratedLabel_6:
  # (label, _GeneratedLabel_3)

_GeneratedLabel_3:
  # (procEnd, main)
  # Restore S registers
  lw $s0, 12($fp)
  lw $s1, 16($fp)
  lw $s2, 20($fp)
  lw $s3, 24($fp)
  lw $s4, 28($fp)
  lw $s5, 32($fp)
  lw $s6, 36($fp)
  lw $s7, 40($fp)

  # Restore RA:
  lw $ra, 4($fp)

  # Restore old FP:
  lw $fp, 8($fp)

  or $sp, $fp, $zero

  jr $ra


