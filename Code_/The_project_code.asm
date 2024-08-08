
_Switch:

;The_project_code.c,10 :: 		void Switch()
;The_project_code.c,12 :: 		if (portB == south_R_west_G)
	MOVF       PORTB+0, 0
	XORWF      _south_R_west_G+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Switch0
;The_project_code.c,14 :: 		portB =  south_R_west_Y;
	MOVF       _south_R_west_Y+0, 0
	MOVWF      PORTB+0
;The_project_code.c,15 :: 		switch_flag = 0;
	CLRF       _switch_flag+0
;The_project_code.c,16 :: 		}
	GOTO       L_Switch1
L_Switch0:
;The_project_code.c,17 :: 		else if(portB == south_G_west_R)
	MOVF       PORTB+0, 0
	XORWF      _south_G_west_R+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Switch2
;The_project_code.c,19 :: 		portB = south_Y_west_R;
	MOVF       _south_Y_west_R+0, 0
	MOVWF      PORTB+0
;The_project_code.c,20 :: 		switch_flag = 1;
	MOVLW      1
	MOVWF      _switch_flag+0
;The_project_code.c,21 :: 		}
L_Switch2:
L_Switch1:
;The_project_code.c,23 :: 		for(j = 3; j > 0; j--)
	MOVLW      3
	MOVWF      _j+0
L_Switch3:
	MOVF       _j+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_Switch4
;The_project_code.c,26 :: 		for(i = 0; i < 5; i++)
	CLRF       _i+0
L_Switch6:
	MOVLW      5
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Switch7
;The_project_code.c,28 :: 		left = j / 10;      // 15 --> 15 / 10 = 1
	MOVLW      10
	MOVWF      R4+0
	MOVF       _j+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _left+0
;The_project_code.c,29 :: 		right = j % 10;     // 15 --> 15 % 10 = 5
	MOVLW      10
	MOVWF      R4+0
	MOVF       _j+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;The_project_code.c,30 :: 		portD = 0b00000001;
	MOVLW      1
	MOVWF      PORTD+0
;The_project_code.c,31 :: 		portC = right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;The_project_code.c,32 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_Switch9:
	DECFSZ     R13+0, 1
	GOTO       L_Switch9
	DECFSZ     R12+0, 1
	GOTO       L_Switch9
;The_project_code.c,33 :: 		portD = 0b00000010;
	MOVLW      2
	MOVWF      PORTD+0
;The_project_code.c,34 :: 		portC = left;
	MOVF       _left+0, 0
	MOVWF      PORTC+0
;The_project_code.c,35 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_Switch10:
	DECFSZ     R13+0, 1
	GOTO       L_Switch10
	DECFSZ     R12+0, 1
	GOTO       L_Switch10
;The_project_code.c,26 :: 		for(i = 0; i < 5; i++)
	INCF       _i+0, 1
;The_project_code.c,36 :: 		}
	GOTO       L_Switch6
L_Switch7:
;The_project_code.c,23 :: 		for(j = 3; j > 0; j--)
	DECF       _j+0, 1
;The_project_code.c,37 :: 		}
	GOTO       L_Switch3
L_Switch4:
;The_project_code.c,40 :: 		if (portB == south_R_west_Y)
	MOVF       PORTB+0, 0
	XORWF      _south_R_west_Y+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Switch11
;The_project_code.c,42 :: 		portB = south_G_west_R;
	MOVF       _south_G_west_R+0, 0
	MOVWF      PORTB+0
;The_project_code.c,43 :: 		switch_flag = 0;
	CLRF       _switch_flag+0
;The_project_code.c,44 :: 		}
	GOTO       L_Switch12
L_Switch11:
;The_project_code.c,46 :: 		else if(portB == south_Y_west_R)
	MOVF       PORTB+0, 0
	XORWF      _south_Y_west_R+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Switch13
;The_project_code.c,48 :: 		portB = south_R_west_G;
	MOVF       _south_R_west_G+0, 0
	MOVWF      PORTB+0
;The_project_code.c,49 :: 		switch_flag = 1;
	MOVLW      1
	MOVWF      _switch_flag+0
;The_project_code.c,50 :: 		}
L_Switch13:
L_Switch12:
;The_project_code.c,52 :: 		}
L_end_Switch:
	RETURN
; end of _Switch

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;The_project_code.c,57 :: 		void interrupt()
;The_project_code.c,61 :: 		if(RBIF_BIT == 1)
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt14
;The_project_code.c,63 :: 		x = portB;
	MOVF       PORTB+0, 0
	MOVWF      _x+0
;The_project_code.c,64 :: 		RBIF_BIT = 0 ;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;The_project_code.c,66 :: 		if(portB.b6 == 0 && portA.b0 == 0)
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt17
	BTFSC      PORTA+0, 0
	GOTO       L_interrupt17
L__interrupt46:
;The_project_code.c,68 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;The_project_code.c,69 :: 		}
L_interrupt17:
;The_project_code.c,70 :: 		}
L_interrupt14:
;The_project_code.c,71 :: 		}
L_end_interrupt:
L__interrupt49:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;The_project_code.c,80 :: 		void main()
;The_project_code.c,82 :: 		adcon1 = 6;
	MOVLW      6
	MOVWF      ADCON1+0
;The_project_code.c,83 :: 		trisA.b4 = 1;
	BSF        TRISA+0, 4
;The_project_code.c,84 :: 		trisA.b0 = 1;
	BSF        TRISA+0, 0
;The_project_code.c,85 :: 		trisC = 0;
	CLRF       TRISC+0
;The_project_code.c,86 :: 		portC = 0;
	CLRF       PORTC+0
;The_project_code.c,87 :: 		trisD.b0 = 0;  trisD.b1 = 0;
	BCF        TRISD+0, 0
	BCF        TRISD+0, 1
;The_project_code.c,88 :: 		portD.b0 = 1;  portD.b1 = 1;
	BSF        PORTD+0, 0
	BSF        PORTD+0, 1
;The_project_code.c,89 :: 		trisB = 0b11000000;
	MOVLW      192
	MOVWF      TRISB+0
;The_project_code.c,90 :: 		portB = 0;
	CLRF       PORTB+0
;The_project_code.c,94 :: 		NOT_RBPU_BIT = 0; // Turn ON the internal feeding .. It zero because it's inverted
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;The_project_code.c,96 :: 		x = portB;         // To remove the dismatch in the start of program
	MOVF       PORTB+0, 0
	MOVWF      _x+0
;The_project_code.c,97 :: 		RBIF_BIT = 0;     // During the transformation from unknown to zero the IF be one
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;The_project_code.c,98 :: 		GIE_BIT = 1; // Turn ON the Global Interrupt enable bit
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;The_project_code.c,99 :: 		RBIE_BIT = 1; // Turn ON the Enable bit of bits B4 --> B7
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;The_project_code.c,102 :: 		while(portA.B4 == 1);
L_main18:
	BTFSS      PORTA+0, 4
	GOTO       L_main19
	GOTO       L_main18
L_main19:
;The_project_code.c,104 :: 		loop_15s:
___main_loop_15s:
;The_project_code.c,105 :: 		for (counter = 15; counter > 0; counter--)
	MOVLW      15
	MOVWF      _counter+0
L_main20:
	MOVF       _counter+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;The_project_code.c,107 :: 		if (flag)
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
;The_project_code.c,109 :: 		flag = 0;
	CLRF       _flag+0
;The_project_code.c,110 :: 		Switch();
	CALL       _Switch+0
;The_project_code.c,111 :: 		if(switch_flag)
	MOVF       _switch_flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
;The_project_code.c,113 :: 		break;
	GOTO       L_main21
;The_project_code.c,114 :: 		}
L_main24:
;The_project_code.c,117 :: 		goto loop_15s;
	GOTO       ___main_loop_15s
;The_project_code.c,119 :: 		}
L_main23:
;The_project_code.c,121 :: 		if (counter > 3) // First 12 s the south is green and west is red
	MOVF       _counter+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;The_project_code.c,123 :: 		portB = south_G_west_R;
	MOVF       _south_G_west_R+0, 0
	MOVWF      PORTB+0
;The_project_code.c,124 :: 		}
	GOTO       L_main27
L_main26:
;The_project_code.c,128 :: 		portB = south_Y_west_R;
	MOVF       _south_Y_west_R+0, 0
	MOVWF      PORTB+0
;The_project_code.c,129 :: 		}
L_main27:
;The_project_code.c,131 :: 		for (sec = 0; sec < 5; sec++)
	CLRF       _sec+0
L_main28:
	MOVLW      5
	SUBWF      _sec+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;The_project_code.c,133 :: 		left = counter / 10;      // 15 --> 15 / 10 = 1
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _left+0
;The_project_code.c,134 :: 		right = counter % 10;     // 15 --> 15 % 10 = 5
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;The_project_code.c,135 :: 		portD = 0b00000001;
	MOVLW      1
	MOVWF      PORTD+0
;The_project_code.c,136 :: 		portC = right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;The_project_code.c,137 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
;The_project_code.c,138 :: 		portD = 0b00000010;
	MOVLW      2
	MOVWF      PORTD+0
;The_project_code.c,139 :: 		portC = left;
	MOVF       _left+0, 0
	MOVWF      PORTC+0
;The_project_code.c,140 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
;The_project_code.c,131 :: 		for (sec = 0; sec < 5; sec++)
	INCF       _sec+0, 1
;The_project_code.c,141 :: 		}
	GOTO       L_main28
L_main29:
;The_project_code.c,105 :: 		for (counter = 15; counter > 0; counter--)
	DECF       _counter+0, 1
;The_project_code.c,142 :: 		}
	GOTO       L_main20
L_main21:
;The_project_code.c,144 :: 		loop_23s:
___main_loop_23s:
;The_project_code.c,145 :: 		for (counter = 23; counter > 0; counter--)
	MOVLW      23
	MOVWF      _counter+0
L_main33:
	MOVF       _counter+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;The_project_code.c,147 :: 		if (flag)
	MOVF       _flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main36
;The_project_code.c,149 :: 		flag = 0;
	CLRF       _flag+0
;The_project_code.c,150 :: 		Switch();
	CALL       _Switch+0
;The_project_code.c,151 :: 		if(switch_flag)
	MOVF       _switch_flag+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main37
;The_project_code.c,153 :: 		break;
	GOTO       L_main34
;The_project_code.c,154 :: 		}
L_main37:
;The_project_code.c,157 :: 		goto loop_23s;
	GOTO       ___main_loop_23s
;The_project_code.c,159 :: 		}
L_main36:
;The_project_code.c,161 :: 		if (counter > 3) // The first 20 s the west is green and south is red
	MOVF       _counter+0, 0
	SUBLW      3
	BTFSC      STATUS+0, 0
	GOTO       L_main39
;The_project_code.c,163 :: 		portB = south_R_west_G;
	MOVF       _south_R_west_G+0, 0
	MOVWF      PORTB+0
;The_project_code.c,164 :: 		}
	GOTO       L_main40
L_main39:
;The_project_code.c,167 :: 		portB = south_R_west_Y;
	MOVF       _south_R_west_Y+0, 0
	MOVWF      PORTB+0
;The_project_code.c,168 :: 		}
L_main40:
;The_project_code.c,170 :: 		for (sec = 0; sec < 5; sec++)
	CLRF       _sec+0
L_main41:
	MOVLW      5
	SUBWF      _sec+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main42
;The_project_code.c,172 :: 		left = counter / 10;      // 15 --> 15 / 10 = 1
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      _left+0
;The_project_code.c,173 :: 		right = counter % 10;     // 15 --> 15 % 10 = 5
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;The_project_code.c,174 :: 		portD = 0b00000001;
	MOVLW      1
	MOVWF      PORTD+0
;The_project_code.c,175 :: 		portC = right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;The_project_code.c,176 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
;The_project_code.c,177 :: 		portD = 0b00000010;
	MOVLW      2
	MOVWF      PORTD+0
;The_project_code.c,178 :: 		portC = left;
	MOVF       _left+0, 0
	MOVWF      PORTC+0
;The_project_code.c,179 :: 		delay_ms(15);
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
;The_project_code.c,170 :: 		for (sec = 0; sec < 5; sec++)
	INCF       _sec+0, 1
;The_project_code.c,180 :: 		}
	GOTO       L_main41
L_main42:
;The_project_code.c,145 :: 		for (counter = 23; counter > 0; counter--)
	DECF       _counter+0, 1
;The_project_code.c,181 :: 		}
	GOTO       L_main33
L_main34:
;The_project_code.c,183 :: 		goto loop_15s;
	GOTO       ___main_loop_15s
;The_project_code.c,184 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
