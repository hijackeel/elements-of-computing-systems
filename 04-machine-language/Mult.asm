// Computes R0*R1 and stores the result in R2.
// Assumes R0>=0, R1>=0, and R0*R1<32768.

@R2 // Load address of R2 into A.
M=0 // Clear R2.

// Handle special case where R0 == 0 and R1 > 0.
// Not strictly necessary, but will increase speed if R1 is a high number.
@R0 // Load address of R0 into A.
D=M // Load value at R0 into D.
@END_LOOP // Load address of END_LOOP label into A.
D;JEQ     // If R0 == 0 then jump to END_LOOP.

// Handle special case where R1 == 0 and R0 > 0.
// Strictly necessary.
@R1 // Load address of R1 into A.
D=M // Load value at R1 into D.
@END_LOOP // Load address of END_LOOP label into A.
D;JEQ     // If R1 == 0 then jump to END_LOOP.

(MULTIPLY_LOOP) // R2 will have R0 added to it R1 times.
  
  @R0   // Load address of R0 into A.
  D=M   // Load value at R0 into D.
  @R2   // Load address of R2 into A.
  M=D+M // R2 += R0.

  @R1   // Load address of R1 into A.
  M=M-1 // R1 -= 1.
  D=M   // Load value at R1 into D.
  @MULTIPLY_LOOP // Load address of MULTIPLY_LOOP label into A.
  D;JGT          // If R1 > 0 then jump to MULTIPLY_LOOP.

(END_LOOP) // Infinite loop is conventional "termination" of Hack programs.
  @END_LOOP // Load address of END_LOOP label into A.
  0;JMP     // Jump to END_LOOP.
