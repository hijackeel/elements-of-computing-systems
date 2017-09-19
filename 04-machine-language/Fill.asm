// Press any key to blacken screen.
// Unpress key to clear screen.

@16383 // Initialize
D=A    //  pointer below
@index //  lowest address
M=D    //  of screen.

(CHECK_KBD)
@KBD // Get value
D=M  // of pressed key.
@NO_KEY_PRESS // Skip KEY_PRESS
D;JEQ         //  if value equals zero.

(KEY_PRESS)
@index     // Check if
D=M+1      //  whole
@KBD       //  screen
D=A-D      //  is filled.
@CHECK_KBD // Wait for key
D;JEQ      //  unpress if so. Else:
  @index     // Increment pointer
  AM=M+1     //  and load into A.
  M=!M       // Flip pixel.
  @CHECK_KBD // Check
  0;JMP      //  KBD.

(NO_KEY_PRESS)
@16383     // Check if
D=A        //  whole
@index     //  screen
D=M-D      //  is clear.
@CHECK_KBD // Wait for key
D;JEQ      //  press if so. Else:
  @index     // Point to
  A=M        //  pixel.
  M=!M       // Flip it.
  @index     // Decrement
  M=M-1      //  pointer.
  @CHECK_KBD // Check
  0;JMP      //  KBD.
