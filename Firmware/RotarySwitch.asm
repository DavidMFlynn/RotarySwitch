;====================================================================================================
;
;    Filename:      RotarySwitch.asm
;    Date:          7/12/2019
;    File Version:  1.0a1
;
;    Author:        David M. Flynn
;    Company:       Oxford V.U.E., Inc.
;    E-Mail:        dflynn@oxfordvue.com
;    Web Site:      http://www.oxfordvue.com/
;
;====================================================================================================
;    Rotary Switch is a no-break/no-make before make rotary switch
;
;  5 Photo sensors, enable and A0..A3, allow 2..16 positions
;  Drives 1 of 16 outputs on command and doesn't change until a new valid command is received.
;  Start button input and active LED output.
;
;
;    History:
; 1.0a1   7/12/2019    Works!
; 1.0d1   7/11/2019	First code. Copied from SerialServo
;
;====================================================================================================
; Options
;
;====================================================================================================
;====================================================================================================
; What happens next:
;   At power up the system LED will blink.
;   Align knob to desired setting and press start button.
;   Hold start button for 2 seconds to disable.
;   If enable is active select output from address A0..A3
;   If there is an active setting
;      If input Ena,A0..A3 matches setting then light Active LED.
;      If input does not match setting the fast blink Active LED.
;====================================================================================================
;
;   Pin 1 (RA2/AN2) Output A2 (Digital Output)
;   Pin 2 (RA3/AN3) Output A3 (Digital Output)
;   Pin 3 (RA4/AN4) Output Enable (Active Low Output)
;   Pin 4 (RA5/MCLR*) VPP/MCLR*
;   Pin 5 (GND) Ground
;   Pin 6 (RB0) Input A0 (Active Low Input)
;   Pin 7 (RB1/AN11/SDA1) Input A1 (Active Low Input)
;   Pin 8 (RB2/AN10/TX) RX (Optional, future feature) or Active LED (Active High Output)
;   Pin 9 (RB3/CCP1) Input A2 (Active Low Input)
;
;   Pin 10 (RB4/AN8/SLC1) Input A3 (Active Low Input)
;   Pin 11 (RB5/AN7) Start Button (Active Low Input)
;   Pin 12 (RB6/AN5/CCP2) ICSPCLK
;   Pin 13 (RB7/AN6) ICSPDAT
;   Pin 14 (Vcc) +5 volts
;   Pin 15 (RA6) Input Enable (Active Low Input)
;   Pin 16 (RA7/CCP2) System LED (Active Low Output)(System LED)
;   Pin 17 (RA0/AN0) Output A0 (Digital Output)
;   Pin 18 (RA1) Output A1 (Digital Output)
;
;====================================================================================================
;
;
	list	p=16f1847,r=hex,W=1	; list directive to define processor
	nolist
	include	p16f1847.inc	; processor specific variable definitions
	list
;
	__CONFIG _CONFIG1,_FOSC_INTOSC & _WDTE_OFF & _MCLRE_OFF & _IESO_OFF
;
;
; INTOSC oscillator: I/O function on CLKIN pin
; WDT disabled
; PWRT disabled
; MCLR/VPP pin function is digital input
; Program memory code protection is disabled
; Data memory code protection is disabled
; Brown-out Reset enabled
; CLKOUT function is disabled. I/O or oscillator function on the CLKOUT pin
; Internal/External Switchover mode is disabled
; Fail-Safe Clock Monitor is enabled
;
	__CONFIG _CONFIG2,_WRT_OFF & _PLLEN_ON & _LVP_OFF
;
; Write protection off
; 4x PLL Enabled
; Stack Overflow or Underflow will cause a Reset
; Brown-out Reset Voltage (Vbor), low trip point selected.
; Low-voltage programming enabled
;
; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.
;
	constant	oldCode=0
	constant	useRS232=0
	constant	UseEEParams=0
;
;
#Define	_C	STATUS,C
#Define	_Z	STATUS,Z
;
;====================================================================================================
	nolist
	include	F1847_Macros.inc
	list
;
;    Port A bits
PortADDRBits	EQU	b'11100000'
PortAValue	EQU	b'00010000'
ANSELA_Val	EQU	b'00000000'	;All Digital
;
#Define	OUT_A0	LATA,0	;Output A0 (Digital Output)
#Define	OUT_A1	LATA,1	;Output A1 (Digital Output)
#Define	OUT_A2	LATA,2	;Output A2 (Digital Output)
#Define	OUT_A3	LATA,3	;Output A3 (Digital Output)
#Define	OUT_Enable	LATA,4	;Output Enable (Active Low Output)
#Define	RA5_In	PORTA,5	;VPP/MCLR*
#Define	In_Enable	PORTA,6	;Input Enable (Active Low Input)
#Define	RA7_In	PORTA,7	;Sys LED D2 System LED
SysLED_Bit	EQU	7	;Sys LED (Active Low Output)
#Define	SysLED_Tris	TRISA,SysLED_Bit	;Sys LED (Active Low Output)
;
;
;    Port B bits
PortBDDRBits	EQU	b'11111111'	;All Inputs
PortBValue	EQU	b'00000100'
ANSELB_Val	EQU	b'00000000'	; All Digital
;
#Define	IN_A0	PORTB,0	;Input A0 (Active Low Input)
#Define	IN_A1	PORTB,1	;Input A1 (Active Low Input)
#Define	Active_LED	PORTB,2	;Active LED (Active High Output)
#Define	IN_A2	PORTB,3	;Input A2 (Active Low Input)
#Define	IN_A3	PORTB,4	;Input A3 (Active Low Input)
#Define	Start_Btn	PORTB,5	;Start Button (Active Low Input)
#Define	RB6_In	PORTB,6	;ICSPCLK
#Define	RB7_In	PORTB,7	;ICSPDAT
;
LED1_Bit	EQU	2	;LED1 (Active Low Output)
#Define	LED1_Tris	TRISB,LED1_Bit	;LED1 (Active Low Output)
#Define	LED1_Lat	LATB,LED1_Bit	;LED1 (Active Low Output)
;
;
;========================================================================================
;========================================================================================
;
;Constants
All_In	EQU	0xFF
All_Out	EQU	0x00
;
;OSCCON_Value	EQU	b'01110010'	; 8 MHz
OSCCON_Value	EQU	b'11110000'	;32MHz
;
;T2CON_Value	EQU	b'01001110'	;T2 On, /16 pre, /10 post
T2CON_Value	EQU	b'01001111'	;T2 On, /64 pre, /10 post
PR2_Value	EQU	.125
;
LEDTIME	EQU	d'100'	;1.00 seconds
LEDErrorTime	EQU	d'10'
LEDFastTime	EQU	d'20'
;
;
;TXSTA_Value	EQU	b'00100000'	;8 bit, TX enabled, Async, low speed
TXSTA_Value	EQU	b'00100100'	;8 bit, TX enabled, Async, high speed
RCSTA_Value	EQU	b'10010000'	;RX enabled, 8 bit, Continious receive
BAUDCON_Value	EQU	b'00001000'	;BRG16=1
; 8MHz clock low speed (BRGH=0,BRG16=1)
;Baud_300	EQU	d'1666'	;0.299, -0.02%
;Baud_1200	EQU	d'416'	;1.199, -0.08%
;Baud_2400	EQU	d'207'	;2.404, +0.16%
;Baud_9600	EQU	d'51'	;9.615, +0.16%
; 32MHz clock low speed (BRGH=1,BRG16=1)
Baud_300	EQU	.26666	;300, 0.00%
Baud_1200	EQU	.6666	;1200, 0.00%
Baud_2400	EQU	.3332	;2400, +0.01%
Baud_9600	EQU	.832	;9604, +0.04%
Baud_19200	EQU	.416	;19.18k, -0.08%
Baud_38400	EQU	.207	;38.46k, +0.16%
Baud_57600	EQU	.138	;57.55k, -0.08%
BaudRate	EQU	Baud_38400
;
;
DebounceTime	EQU	.10
kMaxMode	EQU	.4
;
;================================================================================================
;***** VARIABLE DEFINITIONS
; there are 256 bytes of ram, Bank0 0x20..0x7F, Bank1 0xA0..0xEF, Bank2 0x120..0x16F
; there are 256 bytes of EEPROM starting at 0x00 the EEPROM is not mapped into memory but
;  accessed through the EEADR and EEDATA registers
;================================================================================================
;  Bank0 Ram 020h-06Fh 80 Bytes
;
	cblock	0x20
;
	SysLED_Time		;sys LED time
	SysLEDCount		;sys LED Timer tick count
;
	LED1_Blinks		;0=off,1,2,3
	LED1_Time		;1=On, 10,20,100 Blink time
	LED1_BlinkCount		;LED1_Blinks..0
	LED1_Count		;tick count
;
	EEAddrTemp		;EEProm address to read or write
	EEDataTemp		;Data to be writen to EEProm
;
;
	Timer1Lo		;1st 16 bit timer
	Timer1Hi		; 50 mS RX timeiout
	Timer2Lo		;2nd 16 bit timer
	Timer2Hi		; 2s Input timer
	Timer3Lo		;3rd 16 bit timer
	Timer3Hi		; GP wait timer
	Timer4Lo		;4th 16 bit timer
	Timer4Hi		; debounce timer
;
	TXByte		;Next byte to send
	RXByte		;Last byte received
	SerFlags
;
;
	CurrentInput		;Value of sensors, 0..15, Bit 7 = In enable
	CurrentOutput		;Current output 0..15, bit 7 = enable
	SelectedOutput		;Commanded output 0..15, bit 7 = enable
;
	SysFlags
;
	endc
;--------------------------------------------------------------
;
;---SerFlags bits---
#Define	DataReceivedFlag	SerFlags,1
#Define	DataSentFlag	SerFlags,2
;
;
;
#Define	OutputActive	SysFlags,0
#Define	InEquOut	SysFlags,1
#Define	BtnPress	SysFlags,2
#Define	ClearOutsFlag	SysFlags,3
#Define	InputError	SysFlags,4
;
;================================================================================================
;  Bank1 Ram 0A0h-0EFh 80 Bytes
;
;================================================================================================
;  Bank2 Ram 120h-16Fh 80 Bytes
;
#Define	Ser_Buff_Bank	2
;
	cblock	0x120
	Ser_In_Bytes		;Bytes in Ser_In_Buff
	Ser_Out_Bytes		;Bytes in Ser_Out_Buff
	Ser_In_InPtr
	Ser_In_OutPtr
	Ser_Out_InPtr
	Ser_Out_OutPtr
	Ser_In_Buff:20
	Ser_Out_Buff:20
	endc
;
;================================================================================================
;  Bank3 Ram 1A0h-1EFh 80 Bytes
;=========================================================================================
;  Bank5 Ram 2A0h-2EFh 80 Bytes
;=======================================================================================================
;  Common Ram 70-7F same for all banks
;      except for ISR_W_Temp these are used for paramiter passing and temp vars
;=======================================================================================================
;
	cblock	0x70
	Param70
	Param71
	Param72
	Param73
	Param74
	Param75
	Param76
	Param77
	Param78
	Param79
	Param7A
	Param7B
	Param7C
	Param7D
	Param7E
	Param7F
	endc
;
;=========================================================================================
;Conditions
HasISR	EQU	0x80	;used to enable interupts 0x80=true 0x00=false
;
;=========================================================================================
;==============================================================================================
; ID Locations
	__idlocs	0x10d4
;
;==============================================================================================
; EEPROM locations (NV-RAM) 0x00..0x7F (offsets)
;
; default values
	ORG	0xF000
	de	0x00	;nvSysFlags
;
	cblock	0x0000
	nvSysFlags
	endc
;
#Define	nvFirstParamByte	nvSysFlags
#Define	nvLastParamByte	nvSysFlags
;
;
;==============================================================================================
;============================================================================================
;
;
	ORG	0x000	; processor reset vector
	CLRF	STATUS
	CLRF	PCLATH
  	goto	start	; go to beginning of program
;
;===============================================================================================
; Interupt Service Routine
;
; we loop through the interupt service routing every 0.01 seconds
;
;
	ORG	0x004	; interrupt vector location
	CLRF	PCLATH
	CLRF	BSR	; bank0
;
;
	BTFSS	PIR1,TMR2IF
	goto	SystemTick_end
;
	BCF	PIR1,TMR2IF	; reset interupt flag bit
;------------------
; These routines run 100 times per second
;
;------------------
;Decrement timers until they are zero
;
	call	DecTimer1	;if timer 1 is not zero decrement
	call	DecTimer2
	call	DecTimer3
	call	DecTimer4
;
;-----------------------------------------------------------------
; blink LEDs
;
; All LEDs off
	movlb	0x01	;bank 1
	bsf	SysLED_Tris
	bsf	LED1_Tris
;
;
; Sys LED time
	movlb	0x00	;bank 0
	DECFSZ	SysLEDCount,F	;Is it time?
	bra	SystemBlink_end	; No, not yet
;
	MOVF	SysLED_Time,W
	MOVWF	SysLEDCount
	movlb	0x01	;bank 1
	bcf	SysLED_Tris
SystemBlink_end:
; Flash LEDs
; Get Button Value
	movlb	0x00	;bank 0
;
	movf	LED1_Blinks,F
	SKPZ		;LED1 active?
	bra	LED1_Blinking	; Yes
	clrf	LED1_BlinkCount
	clrf	LED1_Count
	bra	LED1_Blink_end
;
LED1_Blinking	movf	LED1_Count,W
	iorwf	LED1_BlinkCount,W
	SKPNZ		;Startup?
	bra	LED1_Start
;
	decfsz	LED1_Count,F	;Done w/ blink
	bra	LED1_Blink_end	; no
;
	movf	LED1_BlinkCount,F
	SKPNZ		;Done w/ cycle?
	bra	LED1_Start	; Yes
;
	decfsz	LED1_BlinkCount,F
	bra	LED1_NextBlink
	movf	LED1_Time,W	;1 = On, 1..FF blink time
	movwf	LED1_Count
	bra	LED1_Blink_end
;
LED1_Start	movf	LED1_Blinks,W
	movwf	LED1_BlinkCount
LED1_NextBlink	movf	LED1_Time,W
	movwf	LED1_Count
;
	movlb	0x01
	BCF	LED1_Tris
LED1_Blink_end:
;-------------
;
;
SystemTick_end:
	movlb	0	; bank 0
;
;==================================================================================
	if useRS232
;-----------------------------------------------------------------------------------------
;AUSART Serial ISR
;
IRQ_Ser	BTFSS	PIR1,RCIF	;RX has a byte?
	BRA	IRQ_Ser_End
	CALL	RX_TheByte
;
IRQ_Ser_End:
	endif
;-----------------------------------------------------------------------------------------
	retfie		; return from interrupt
;
;
;=========================================================================================
;*****************************************************************************************
;=========================================================================================
;
	include <F1847_Common.inc>
;
;=========================================================================================
;
start	call	InitializeIO
;
;
;=========================================================================================
;*****************************************************************************************
;=========================================================================================
MainLoop	CLRWDT
;
	if useRS232
	call	GetSerInBytes
	SKPZ		;Any data?
	CALL	RS232_Parse	; yes
;
	movlb	1
	btfss	RXDataIsNew
	bra	ML_1
	mCall0To1	HandleRXData
ML_1:
	endif
;
;
;---------------------
; Read the button and set the output
	call	HandleButton	;ClearOutsFlag, BtnPress
	btfss	BtnPress	;Has the button been pressed?
	bra	ML_Btn_Inactive	; No
	bcf	BtnPress
	call	ReadInput
	btfss	CurrentInput,7	;Valid input?
	bra	ML_Btn_Error	; No
	bcf	InputError
	movf	CurrentInput,W
	movwf	SelectedOutput
	call	SetOutput
	bra	ML_Btn_End
;
ML_Btn_Inactive	btfss	ClearOutsFlag
	bra	ML_Btn_End
	bcf	ClearOutsFlag
	bcf	SelectedOutput,7	;disable outputs
	call	SetOutput
	bra	ML_Btn_End
;
ML_Btn_Error	bsf	InputError
	movlw	LEDErrorTime
	movwf	LED1_Time
	movlw	0x01
	movwf	LED1_Blinks
;
ML_Btn_End:
;---------------------
; if not an error
;   if output is active
;     if in = out light LED
;     else fast blink LED
	btfsc	InputError
	bra	ML_LED_End
	btfss	CurrentOutput,7
	bra	ML_LED_Off
	call	ReadInput
	btfss	CurrentInput,7	;Valid input?
	bra	ML_LED_Fast	; No
;
	movf	CurrentOutput,W
	subwf	CurrentInput,W
	SKPZ		;In = Out?
	bra	ML_LED_Fast	; No
; Set LED ON
	movlw	0x01
	movwf	LED1_Blinks
	movlw	0x01
	movwf	LED1_Time
	bra	ML_LED_End
;
ML_LED_Fast	movlw	LEDFastTime
	movwf	LED1_Time
	movlw	0x01
	movwf	LED1_Blinks
	bra	ML_LED_End
;
ML_LED_Off	clrf	LED1_Blinks
;
ML_LED_End:
;
;---------------------
	if useRS232
;---------------------
; Handle Serial Communications
	BTFSC	PIR1,TXIF	;TX done?
	CALL	TX_TheByte	; Yes
;
; move any serial data received into the 32 byte input buffer
	BTFSS	DataReceivedFlag
	BRA	ML_Ser_Out
	MOVF	RXByte,W
	BCF	DataReceivedFlag
	CALL	StoreSerIn
;
; If the serial data has been sent and there are bytes in the buffer, send the next byte
;
ML_Ser_Out	BTFSS	DataSentFlag
	BRA	ML_Ser_End
	CALL	GetSerOut
	BTFSS	Param78,0
	BRA	ML_Ser_End
	MOVWF	TXByte
	BCF	DataSentFlag
ML_Ser_End:
	endif
;----------------------
;
;
	goto	MainLoop
;=========================================================================================
;*****************************************************************************************
;=========================================================================================
;
;=========================================================================================	
;=========================================================================================
;DebounceTime
;Timer4Lo, Timer2Lo
;
; Entry: none
; Exit: ClearOutsFlag, BtnPress
; RAM Used: none
; Calls: (0) none
;
HandleButton	movlb	0x00	;bank 0
;
	movf	Timer4Lo,F
	SKPNZ		;Debounced?
	bra	HdlBtn_1	; Yes
;
	btfss	Start_Btn	;Is Btn still active?
	bra	HdlBtn_DB	; Yes
;
	return
;
; we are de-bounced
HdlBtn_1	btfsc	Start_Btn	;Is Btn active?
	return		; No
	bsf	BtnPress
;
	movlw	.200	;2s clear outputs timer
	movwf	Timer2Lo
;
HdlBtn_DB	movlw	DebounceTime
	movwf	Timer4Lo
;
	movf	Timer2Lo,F
	SKPNZ		;Active for >2s?
	bsf	ClearOutsFlag	; Yes
	return
;
;
;=========================================================================================
; Read Input
;
; Entry: none
; Exit: CurrentInput
; RAM Used:
; Calls:
;
ReadInput	movlb	0	;bank 0
	clrf	CurrentInput
	btfsc	In_Enable
	bra	ReadInput_End
;
	bsf	CurrentInput,7
	btfss	IN_A0
	bsf	CurrentInput,0
	btfss	IN_A1
	bsf	CurrentInput,1
	btfss	IN_A2
	bsf	CurrentInput,2
	btfss	IN_A3
	bsf	CurrentInput,3
;
ReadInput_End:
	return
;
;=========================================================================================
; Set Output
;
; Entry: SelectedOutput
; Exit: OutputActive, CurrentOutput
; RAM Used: Param78, Param79
; Calls: (0) none
SetOutput	movlb	0	;bank 0
	movf	SelectedOutput,W
	movwf	Param78
	subwf	CurrentOutput,W
	SKPNZ
	bra	SetOutput_Done
;
	movlb	2	;bank 2
	bsf	OUT_Enable	;disable
	movf	Param78,W
	andlw	0x0F	;keep address bits
	movwf	Param79
	movf	LATA,W
	andlw	0xF0
	iorwf	Param79,W
	movwf	LATA
	btfsc	Param78,7
	bcf	OUT_Enable	;enable drive
;
SetOutput_Done	movlb	0	;bank 0
	movf	SelectedOutput,W
	movwf	CurrentOutput
	bcf	OutputActive
	btfsc	CurrentOutput,7
	bsf	OutputActive
	return
;=========================================================================================
; call once
;=========================================================================================
;
InitializeIO	MOVLB	0x01	; select bank 1
	bsf	OPTION_REG,NOT_WPUEN	; disable pullups on port B
	bcf	OPTION_REG,TMR0CS	; TMR0 clock Fosc/4
	bcf	OPTION_REG,PSA	; prescaler assigned to TMR0
	bsf	OPTION_REG,PS0	;111 8mhz/4/256=7812.5hz=128uS/Ct=0.032768S/ISR
	bsf	OPTION_REG,PS1	;101 8mhz/4/64=31250hz=32uS/Ct=0.008192S/ISR
	bsf	OPTION_REG,PS2
;
	MOVLB	0x01	; bank 1
	MOVLW	OSCCON_Value
	MOVWF	OSCCON
	movlw	b'00010111'	; WDT prescaler 1:65536 period is 2 sec (RESET value)
	movwf	WDTCON
;
	MOVLB	0x03	; bank 3
	movlw	ANSELA_Val
	movwf	ANSELA
	movlw	ANSELB_Val
	movwf	ANSELB
;
;Setup T2 for 100/s
	movlb	0	; bank 0
	MOVLW	T2CON_Value
	MOVWF	T2CON
	MOVLW	PR2_Value
	MOVWF	PR2
	movlb	1	; bank 1
	bsf	PIE1,TMR2IE	; enable Timer 2 interupt
;
;
; clear memory to zero
	movlb	0	; bank 0
	CALL	ClearRam
	CLRWDT
; not used	CALL	CopyToRam
;
;
	MOVLB	0x00	;Bank 0
; setup data ports
	movlw	PortBValue
	movwf	PORTB	;init port B
	movlw	PortAValue
	movwf	PORTA
	MOVLB	0x01	; bank 1
	movlw	PortADDRBits
	movwf	TRISA
	movlw	PortBDDRBits	;setup for programer
	movwf	TRISB
;
	if useRS232
; setup serial I/O
	BANKSEL	BAUDCON	; bank 3
	movlw	BAUDCON_Value
	movwf	BAUDCON
	MOVLW	low BaudRate
	MOVWF	SPBRGL
	MOVLW	high BaudRate
	MOVWF	SPBRGH
	MOVLW	TXSTA_Value
	MOVWF	TXSTA
	MOVLW	RCSTA_Value
	MOVWF	RCSTA
	movlb	0x01	; bank 1
	BSF	PIE1,RCIE	; Serial Receive interupt
	movlb	0x00	; bank 0
;
	endif
;
	CLRWDT
;-----------------------
;
	MOVLB	0x00	;bank 0
	movlw	.100	;Set the debounce timer to
	movwf	Timer4Lo	; ignore Btn for 1st second.
;
	MOVLW	LEDTIME
	MOVWF	SysLED_Time
	movlw	0x01
	movwf	SysLEDCount	;start blinking right away
;
	bsf	INTCON,PEIE	; enable periferal interupts
	bsf	INTCON,GIE	; enable interupts
;
	return
;
;=========================================================================================
;=========================================================================================
;
;
;
	END
;
