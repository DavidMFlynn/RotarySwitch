// ******************************************
// Rotary Switch for Track Ladder Selection
// Filename: R-Switch.scad
// Created: 5/31/2019
// Revision: 1.1.1 12/5/2019
// Units: mm
// ******************************************
//  ***** History *****
// 1.1.1 12/5/2019 Added 0.5mm to spacer ring.
// 1.1.0 8/14/2019 Magnet Detents.
// 1.0.7 8/11/2019 CW16 w/ stop.
// 1.0.6 8/5/2019 Added 14 step variant.
// 1.0.6 7/24/2019 Added 9 step variant.
// 1.0.5 7/18/2019 Added spring cover to top.
// 1.0.4 7/17/2019 Added DetentSpringCover and alignment mark.
// 1.0.3 7/15/2019 Tightened code wheel space.
// 1.0.2 7/12/2019 Increased size of detent ball hole. Rotated mounting holes.
// 1.0.1 7/11/2019 #6-32 flat head alignment screws. Lots of cleanup FC1
// 1.0.0 6/4/2019 Thicker code wheel.
// 0.9.1 6/3/2019 Added Detent to code wheel
// 0.9 5/31/2019 First Code
// ******************************************
//  ***** Notes *****
//
// CodeOffset_a works best if half of Code_a, or at least 16
// ******************************************
//  ***** for STL output
//Knob_Pointed(SP_d=48, HasButton=true);

CW14_nCodes=14;
CW14_d=70;
CW14_Code_a=22.5;
CW14_CodeOffset_a=16;

CW16_nCodes=16;
CW16_d=70;
CW16_Code_a=21.5; // leave room for stop
//CW16_Code_a=22.5; // no bottom gap
CW16_CodeOffset_a=16;

CW8_nCodes=8;
CW8_d=60;
CW8_CodeOffset_a=16;
CW8_Code_a=37.5;

CWn_nCodes=9;
CWn_d=70;
CWn_CodeOffset_a=16;
CWn_Code_a=30.0;

//rotate([0,180,0]) DetentMagHolder();

// -----------------------------
//  ***** Generic Set CWn *****
// Button on knob, n positions, w/ stop
// Knob(SP_d=CWn_d, nCodes=CWn_nCodes, HasButton=true);
// NumberPlate(SP_d=CWn_d, nDetents=CWn_nCodes, Detent_a=CWn_Code_a);
// rotate([180,0,0]) ReadHeadTopPlate(CW_d=CWn_d, nCodes=CWn_nCodes, Code_a=CWn_Code_a, CodeOffset_a=CWn_CodeOffset_a);
// SpacerRing(CW_d=CWn_d, nCodes=CWn_nCodes, Code_a=CWn_Code_a, HasStop=true);
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=CWn_d, nCodes=CWn_nCodes, Code_a=CWn_Code_a, CodeOffset_a=CWn_CodeOffset_a, PCB_Mounting_Ears=true);
// DetentSpringCover(); // print 2
// ---------------------------------
//  ***** for Castlegate West *****
// Button on knob, 14 positions, w/ stop
//
// Knob(SP_d=CW14_d, nCodes=CW14_nCodes, HasButton=true);
// NumberPlate(SP_d=CW14_d, nDetents=CW14_nCodes, Detent_a=CW14_Code_a);
// rotate([180,0,0]) ReadHeadTopPlate(CW_d=CW14_d, nCodes=CW14_nCodes, Code_a=CW14_Code_a, CodeOffset_a=CW14_CodeOffset_a);
// SpacerRing(CW_d=CW14_d, nCodes=CW14_nCodes, Code_a=CW14_Code_a, HasStop=true);
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=CW14_d, nCodes=CW14_nCodes, Code_a=CW14_Code_a, CodeOffset_a=CW14_CodeOffset_a, PCB_Mounting_Ears=true);
// CodeWheel(CW_d=CW14_d, nCodes=CW14_nCodes, Code_a=CW14_Code_a, CodeOffset_a=CW14_CodeOffset_a); // 14 position
// DetentSpringCover(); // print 2
// ---------------------------------
//  ***** for Castlegate East *****
// Button on knob, 16 positions, w/ stop
//
// Knob(SP_d=CW16_d, nCodes=16, HasButton=true);
// NumberPlate(SP_d=CW16_d, nDetents=CW16_nCodes, Detent_a=CW16_Code_a);
// rotate([180,0,0]) ReadHeadTopPlate(CW_d=CW16_d, nCodes=CW16_nCodes, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a);
// SpacerRing(CW_d=CW16_d, nCodes=CW16_nCodes, Code_a=CW16_Code_a, HasStop=true, HasMagnets=true);
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=CW16_d, nCodes=CW16_nCodes, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a, PCB_Mounting_Ears=true);
// CodeWheel(CW_d=CW16_d, nCodes=CW16_nCodes, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a, HasMagnets=false);
// DetentSpringCover(); // print 2
// ---------------------------------


// Knob(SP_d=SelectionPlate_d, nCodes=8, HasButton=false); // good for 1..9
// Knob(SP_d=CW16_d, nCodes=16, HasButton=true); // good for 10..
// NumberPlate(SP_d=CW16_d, nDetents=16, Detent_a=20); // 16 position
// NumberPlate(nDetents=12, Detent_a=28); // 12 position
// NumberPlate(nDetents=8, Detent_a=37.5); // 8 position
// CodeWheel(CW_d=CW16_d, nCodes=16, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a); // 16 position
// CodeWheel(CW_d=60, nCodes=12, Code_a=28, CodeOffset_a=14);
// CodeWheel(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15, HasStop=true); // 8 position
// SpacerRing(CW_d=60, nCodes=8, Code_a=37.5, HasStop=true); // 8 position
// SpacerRing(CW_d=CW16_d, nCodes=16, Code_a=CW16_Code_a, HasStop=true); // 16 position

// rotate([180,0,0]) ReadHeadTopPlate(CW_d=CW16_d, nCodes=16, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a);  // 16 position
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=CW16_d, nCodes=16, Code_a=CW16_Code_a, CodeOffset_a=CW16_CodeOffset_a, PCB_Mounting_Ears=true);  // 16 position

// rotate([180,0,0]) ReadHeadTopPlate(CW_d=60, nCodes=12, Code_a=28, CodeOffset_a=14);  // 12 position
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=60, nCodes=12, Code_a=28, CodeOffset_a=14, PCB_Mounting_Ears=true);  // 12 position

// rotate([180,0,0]) ReadHeadTopPlate(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15);  // 8 position
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15, PCB_Mounting_Ears=true);  // 8 position
// rotate([180,0,0]) ReadHeadBotPlate(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15, PCB_Mounting_Ears=false);  // 8 position
// DetentSpringCover(); // print 2
// ******************************************
//  ***** for Viewing *****
// ShowRotarySwitchExpanded();
// ShowRotarySwitchExpanded(CW_d=CW8_d,nCodes=CW8_nCodes,Code_a=CW8_Code_a,CodeOffset_a=CW8_CodeOffset_a);
// ShowRotarySwitchExpanded(CW_d=CW16_d,nCodes=CW16_nCodes,Code_a=CW16_Code_a,CodeOffset_a=CW16_CodeOffset_a,HasStop=false);
// ******************************************

include<CommonStuffSAEmm.scad>

Overlap=0.05;
$fn=90;
IDXtra=0.2;

DW_Ball_d=5/16*25.4; // Detent ball diameter
CodeSpace=2.6; // Radius space between code holes
Shaft_d=12.7;

SelectionPlate_d=60;
BoltInset=3.5;
ReadHeadBorder=BoltInset;
Mag_l = 0.125 * 25.4;
Mag_d = 0.125 * 25.4;

module CodeWheelAnimation(CW_d=60,nCodes=8,Code_a=37.5,CodeOffset_a=16,HasStop=true){
	// Set steps to nCodes
	T_a=-$t*nCodes*Code_a;
	
	translate([00,0,24.5]) rotate([0,0,Code_a/2+Code_a*(nCodes/2-1)+T_a]) color("Brown") 
		Knob(SP_d=CW_d, nCodes=nCodes, HasButton=true);
	
	translate([00,0,20])  color("Gray") NumberPlate(SP_d=CW_d, nDetents=nCodes, Detent_a=Code_a); 
	
	//translate([0,0,20]) color("LightBlue") ReadHeadTopPlate(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a);

	translate([0,0,0]) color("Green") rotate([0,0,T_a]) 
		CodeWheel(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, HasStop=HasStop);
	
	//translate([40,0,20]) 
	//translate([00,0,12]) color("Tan") SpacerRing(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, HasStop=true); // 8 position
	
	//color("LightGray") ReadHeadBotPlate(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, PCB_Mounting_Ears=HasStop); 

} // CodeWheelAnimation

//CodeWheelAnimation(CW_d=CW16_d,nCodes=CW16_nCodes,Code_a=CW16_Code_a,CodeOffset_a=CW16_CodeOffset_a,HasStop=false);

module ShowRotarySwitchExpanded(CW_d=60,nCodes=8,Code_a=37.5,CodeOffset_a=16,HasStop=true){
	translate([00,0,100]) rotate([0,0,37.5*3.5]) color("Brown") Knob(SP_d=CW_d, nCodes=nCodes, HasButton=true);
	
	translate([00,0,80])  color("Gray") NumberPlate(SP_d=CW_d, nDetents=nCodes, Detent_a=Code_a); 
	
	translate([40,0,60]) color("LightBlue") ReadHeadTopPlate(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a);

	translate([-40,0,40]) color("Green") CodeWheel(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, HasStop=HasStop);
	
	//translate([40,0,20]) 
	translate([00,0,12]) color("Tan") SpacerRing(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, HasStop=true); // 8 position
	
	color("LightGray") ReadHeadBotPlate(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, PCB_Mounting_Ears=HasStop); 

} // ShowRotarySwitchExpanded

//ShowRotarySwitchExpanded();

module RoundRect(X=10,Y=10,Z=2,R=1){
	hull(){
	translate([-X/2+R,-Y/2+R,0]) cylinder(r=R,h=Z);
	translate([X/2-R,-Y/2+R,0]) cylinder(r=R,h=Z);
	translate([-X/2+R,Y/2-R,0]) cylinder(r=R,h=Z);
	translate([X/2-R,Y/2-R,0]) cylinder(r=R,h=Z);
	}
} // RoundRect

module Knob_Pointed(SP_d=SelectionPlate_d, HasButton=false){
	K_Grip_h=15;
	K_Grip_d=34;
	k_GripTop_h=2;
	
	
	// Top
	translate([0,0,3])
	difference(){
		union(){
			cylinder(d=K_Grip_d,h=K_Grip_h);
			translate([0,0,K_Grip_h-Overlap]) cylinder(d1=K_Grip_d,d2=12.7,h=k_GripTop_h);
		} // union
		
		for (j=[0:6]) rotate([0,0,360/7*j]) translate([K_Grip_d/2+3,0,-Overlap])
			cylinder(d=11,h=K_Grip_h+k_GripTop_h+Overlap*2);
		
		// shaft hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=K_Grip_h-3+Overlap*2);
		translate([0,0,K_Grip_h-3]) cylinder(d1=Shaft_d+IDXtra,d2=8+IDXtra,h=3);
		
		// Set screws
		translate([0,0,(K_Grip_h-3)/2]) rotate([0,90,0]) Bolt8Hole(depth=K_Grip_d/2+2);
		translate([0,0,(K_Grip_h-3)/2]) rotate([0,0,360/7*2]) rotate([0,90,0]) Bolt8Hole(depth=K_Grip_d/2+2);
		
		if (HasButton==true) cylinder(d=8+IDXtra,h=K_Grip_h+k_GripTop_h+Overlap);
	} // diff
	
	// Transition
	difference(){
		cylinder(d1=K_Grip_d+6,d2=K_Grip_d,h=3+Overlap);
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=3+Overlap*3);
	} // diff
	
	translate([0,0,-1.2+Overlap])
	difference(){
		cylinder(d=SP_d,h=1.2);
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=3);
	} // diff
	
	//Pointer
		translate([0,SP_d/2-4,-1.1]) rotate([0,0,-30]) cylinder(d=8,h=2.5,$fn=3);
} // Knob_Pointed

//Knob_Pointed(SP_d=48, HasButton=true);

module Knob(SP_d=SelectionPlate_d, nCodes=16, HasButton=false){
	K_Grip_h=15;
	K_Grip_d=34;
	k_GripTop_h=2;
	
	VW_h= nCodes>9? 10:8;
	
	// Top
	translate([0,0,3])
	difference(){
		union(){
			cylinder(d=K_Grip_d,h=K_Grip_h);
			translate([0,0,K_Grip_h-Overlap]) cylinder(d1=K_Grip_d,d2=12.7,h=k_GripTop_h);
		} // union
		
		for (j=[0:6]) rotate([0,0,360/7*j]) translate([K_Grip_d/2+3,0,-Overlap])
			cylinder(d=11,h=K_Grip_h+k_GripTop_h+Overlap*2);
		
		// shaft hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=K_Grip_h-3+Overlap*2);
		translate([0,0,K_Grip_h-3]) cylinder(d1=Shaft_d+IDXtra,d2=8+IDXtra,h=3);
		
		// Set screws
		translate([0,0,(K_Grip_h-3)/2]) rotate([0,90,0]) Bolt8Hole(depth=K_Grip_d/2+2);
		translate([0,0,(K_Grip_h-3)/2]) rotate([0,0,360/7*2]) rotate([0,90,0]) Bolt8Hole(depth=K_Grip_d/2+2);
		
		if (HasButton==true) cylinder(d=8+IDXtra,h=K_Grip_h+k_GripTop_h+Overlap);
	} // diff
	
	// Transition
	difference(){
		cylinder(d1=K_Grip_d+6,d2=K_Grip_d,h=3+Overlap);
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=3+Overlap*3);
	} // diff
	
	translate([0,0,-1.2+Overlap])
	difference(){
		cylinder(d=SP_d,h=1.2);
		
		// Number window
		translate([0,SP_d/2-VW_h/2-2,-Overlap]) RoundRect(X=10,Y=VW_h,Z=1.2+Overlap*2,R=1.5);
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=3);
	} // diff
} // Knob

//translate([0,0,3+1.2+Overlap]) rotate([0,0,10]) Knob(HasButton=true);

module NumberPlate(SP_d=SelectionPlate_d, nDetents=16, Detent_a=0){
	kNP_h=3;
	
	difference(){
		cylinder(d=SP_d,h=kNP_h);
		
		// number go here
		translate([0,0,-Overlap]) cylinder(d=SP_d-4,h=kNP_h+Overlap*2);
	} // diff
	
	difference(){
		union(){
			cylinder(d=SP_d,h=1.2);
			cylinder(d=SP_d-22,h=kNP_h);
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=4);
		// Alignment holes
		translate([0,12.7,kNP_h]) Bolt6FlatHeadHole();
		translate([0,-12.7,kNP_h]) Bolt6FlatHeadHole();
	} // diff
	
	D_a = Detent_a==0? 360/nDetents:Detent_a;
	O_a = (360 - D_a * (nDetents-1))/2;
	echo("Detent Angle =",D_a);
	
	for (j=[0:nDetents-1]) rotate([0,0,-(D_a*j+O_a)]) translate([0,-SP_d/2+6.5,0])
		rotate([0,0,(D_a*j+O_a)]) linear_extrude(2) 
			text(text=str(j+1),font="Liberation Sans:style=Bold", size=6,valign="center",halign="center");
		
} // NumberPlate

//NumberPlate(nDetents=16, Detent_a=0);


module ReadHeadHoles(CW_d=60, nCodes=16, Code_a=0, CodeOffset_a=15, HoleIdx=0){
	C_a = Code_a==0? 360/nCodes:Code_a;
	echo("Code Angle =",C_a);
	
	// Enable Hole
	if (HoleIdx==0 || HoleIdx==1)
	translate([CW_d/2-CodeSpace,0,0]) children();
	
	// Bit 0
	if (HoleIdx==0 || HoleIdx==2)
	rotate([0,0,CodeOffset_a]) translate([CW_d/2-CodeSpace*2,0,0]) children();
			
	// Bit 1
	if (HoleIdx==0 || HoleIdx==3)
	if (nCodes>2) 
		rotate([0,0,CodeOffset_a*2]) translate([CW_d/2-CodeSpace*3,0,0]) children();
				
	// Bit 2
	if (HoleIdx==0 || HoleIdx==4)
	if (nCodes>4) 
		rotate([0,0,CodeOffset_a*3]) translate([CW_d/2-CodeSpace*4,0,0]) children();
	//translate([CW_d/2-CodeSpace*3,0,0]) children();
				
	// Bit 3
	if (HoleIdx==0 || HoleIdx==5)
	if (nCodes>8) 
		rotate([0,0,CodeOffset_a*4]) translate([CW_d/2-CodeSpace*5,0,0]) children();
	//rotate([0,0,CodeOffset_a]) translate([CW_d/2-CodeSpace*4,0,0]) children();
				
	// Bit 4
	if (HoleIdx==0 || HoleIdx==6)
	if (nCodes>16) 
		rotate([0,0,CodeOffset_a*5]) translate([CW_d/2-CodeSpace*6,0,0]) children();
	//rotate([0,0,CodeOffset_a*2]) translate([CW_d/2-CodeSpace*5,0,0]) children();
			
} // ReadHeadHoles

//cylinder(d=60,h=0.05);
//ReadHeadHoles(CW_d=60, nCodes=32, Code_a=0, CodeOffset_a=15) color("Blue") cylinder(d=3,h=3);


module ReadHeadTopPlate(CW_d=60, nCodes=16, Code_a=0, CodeOffset_a=15){
	Plate_h=10;
	Border=ReadHeadBorder;
	nBolts=6;
	DetentSpringCover_h=2;
	
	difference(){
		union(){
			cylinder(d=CW_d+Border*2,h=Plate_h);
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+30])
					hull(){
						translate([CW_d/2+1+BoltInset,0,0])	cylinder(d=BoltInset*2,h=Plate_h);
						translate([CW_d/2,-BoltInset-1,0]) cube([0.01,BoltInset*2+2,Plate_h]);
					} // hull
					
			// Alignment mark
			rotate([0,0,-15]) translate([CW_d/2+Border,0,0]) cylinder(d=3,h=Plate_h);
		} // union
		
		// Detent spring cover
		translate([DetentHoleLoc_X,0,Plate_h-DetentSpringCover_h-IDXtra]){
		
			cylinder(d=DW_Ball_d+6+IDXtra*2,h=DetentSpringCover_h+IDXtra+Overlap);
			translate([0,DW_Ball_d/2+BoltInset,0]) cylinder(d=BoltInset*2+IDXtra*2,h=DetentSpringCover_h+IDXtra+Overlap);
			translate([0,-DW_Ball_d/2-BoltInset,0]) cylinder(d=BoltInset*2+IDXtra*2,h=DetentSpringCover_h+IDXtra+Overlap);
		
			// Screw bosses for cover
			translate([0,DW_Ball_d/2+BoltInset,0]) Bolt4Hole();
			translate([0,-DW_Ball_d/2-BoltInset,0]) Bolt4Hole();
		}

		// Code wheel hub
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+5,h=5);
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=Plate_h+Overlap*2);
		
		// Detent Hole
		rotate([0,0,180]) translate([-DetentHoleLoc_X,0,-Overlap]) cylinder(d=DW_Ball_d+IDXtra*2,h=Plate_h+Overlap*2);
		
		// LED holes T-1 LEDs
		kLED_d=3.1;
		kLED_h=5;
		
		ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a) {
			translate([0,0,-Overlap]) cylinder(d=kLED_d+IDXtra,h=kLED_h+Overlap); 
				translate([0,0,kLED_h-Overlap]) cylinder(d1=kLED_d+IDXtra,d2=5,h=1+Overlap);
				translate([0,0,kLED_h+1-Overlap]) cylinder(d=5,h=Plate_h);}
		
		// Wire path
		hull(){
			ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a)
				translate([0,0,Plate_h-2.5+Overlap]) cylinder(d=3.5,h=2.5,$fn=30); 
		} // hull
		hull(){
			rotate([0,0,15]) translate([CW_d/2-5,0,Plate_h-2.5+Overlap]){
				cylinder(d=5,h=2.5,$fn=18); sphere(d=5,$fn=18);}
			rotate([0,0,15]) translate([CW_d/2+Border,0,Plate_h-2.5+Overlap]){
				cylinder(d=5,h=2.5,$fn=18); sphere(d=5,$fn=18);}
		} // hull
		
				
		// Bolts
		PerimeterBoltCircle(CW_d=CW_d,nBolts=nBolts) translate([0,0,Plate_h]) Bolt4Hole();
		
		translate([0,12.7,Plate_h]) Bolt6Hole();
		translate([0,-12.7,Plate_h]) Bolt6Hole();
	} // diff
	
	// Mounting ears
	for (j=[0:2]) rotate([0,0,120*j+180])
		difference(){
			hull(){ 
				translate([CW_d/2+Border/2+2,0,Plate_h-3]) cylinder(d=10,h=3);
				translate([CW_d/2+Border+4,0,Plate_h-3]) cylinder(d=10,h=3);
			} // hull
			
			translate([CW_d/2+Border+4,0,Plate_h]) Bolt6ClearHole();
		} // diff
	
} // ReadHeadTopPlate

//ReadHeadTopPlate(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15);
//ReadHeadTopPlate(CW_d=70, nCodes=16, Code_a=22.5, CodeOffset_a=16);

module PerimeterBoltCircle(CW_d=60,nBolts=6){
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+30]) translate([CW_d/2+1+BoltInset,0,0])
		children();
} // PerimeterBoltCircle

// PerimeterBoltCircle(CW_d=CW_d) ....;


module DetentMagHolder(){
	Plate_h=2;
	
	difference(){
		union(){
			cylinder(d=DW_Ball_d+6,h=Plate_h);
			translate([0,0,-10+Plate_h]) cylinder(d=0.3125*25.4,h=10);
			
			// Screw bosses for cover
			translate([0,DW_Ball_d/2+BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
			translate([0,-DW_Ball_d/2-BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
		} // union
		
		// Magnet
		translate([0,0,-10+Plate_h-Overlap]) cylinder(d=Mag_d,h=10+Overlap*2);
		
		// Screw bosses for cover
		translate([0,DW_Ball_d/2+BoltInset,Plate_h+0.2]) Bolt4FlatHeadHole(); //Bolt4Hole();
		translate([0,-DW_Ball_d/2-BoltInset,Plate_h+0.2]) Bolt4FlatHeadHole(); //Bolt4Hole();
	} // diff
} // DetentMagHolder

//DetentMagHolder();

module DetentSpringCover(){
	Plate_h=2;
	
	difference(){
		union(){
			cylinder(d=DW_Ball_d+6,h=Plate_h);
			// Screw bosses for cover
			translate([0,DW_Ball_d/2+BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
			translate([0,-DW_Ball_d/2-BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
		} // union
		
		// Screw bosses for cover
		translate([0,DW_Ball_d/2+BoltInset,Plate_h+0.2]) Bolt4FlatHeadHole(); //Bolt4Hole();
		translate([0,-DW_Ball_d/2-BoltInset,Plate_h+0.2]) Bolt4FlatHeadHole(); //Bolt4Hole();
	} // diff
} // DetentSpringCover

//DetentSpringCover();
DetentHoleLoc_X=-16;

module ReadHeadBotPlate(CW_d=60, nCodes=16, Code_a=0, CodeOffset_a=15, PCB_Mounting_Ears=true){
	Plate_h=10;
	Border=ReadHeadBorder;
	nBolts=6;
	PCB_BoltSpacing=3.25*25.4;
	PCB_Standoff_h=12.7;
	PCB_Edge=2.925*25.4;
	Deck_h=3;
	
	difference(){
		union(){
			translate([0,0,Plate_h-Deck_h]) cylinder(d=CW_d+Border*2,h=Deck_h);
			cylinder(d=Shaft_d+10,h=Plate_h);
			
			translate([0,0,Plate_h-Deck_h]) 
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+30])
					hull(){
						translate([CW_d/2+1+BoltInset,0,0])	cylinder(d=BoltInset*2,h=Deck_h);
						translate([CW_d/2,-BoltInset-1,0]) cube([0.01,BoltInset*2+2,Deck_h]);
					} // hull
			
			// Detent Hole
			translate([DetentHoleLoc_X,0,0]){
				cylinder(d=DW_Ball_d+6,h=Plate_h);
				// Screw bosses for cover
				translate([0,DW_Ball_d/2+BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
				translate([0,-DW_Ball_d/2-BoltInset,0]) cylinder(d=BoltInset*2,h=Plate_h);
				// domed cover
				//scale([1,1,0.5]) sphere(d=DW_Ball_d+6);
				}
				
			ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a)
				cylinder(d=12,h=Plate_h);
			
			if (PCB_Mounting_Ears==true) {
				translate([-CW_d/2-Border+5,PCB_BoltSpacing/2,-PCB_Standoff_h]) cylinder(d=10,h=PCB_Standoff_h+Plate_h);
				translate([-CW_d/2-Border+5,-PCB_BoltSpacing/2,-PCB_Standoff_h]) cylinder(d=10,h=PCB_Standoff_h+Plate_h);
				hull(){
					translate([-CW_d/2-Border+5+PCB_Edge,0,-PCB_Standoff_h]) cylinder(d=10,h=PCB_Standoff_h+Plate_h);
					translate([-CW_d/2-Border+5+PCB_Edge+2,0,-PCB_Standoff_h]) cylinder(d=10,h=PCB_Standoff_h+Plate_h);
				} // hull
				
				hull(){
					translate([-CW_d/2-Border+5+PCB_Edge,0,0]) cylinder(d=10,h=Plate_h);
					cylinder(d=10,h=Plate_h);
				} // hull
				
				hull(){
					translate([-CW_d/2-Border+5,PCB_BoltSpacing/2,0]) cylinder(d=10,h=Plate_h);
					cylinder(d=10,h=Plate_h);
				} // hull
				hull(){
					translate([-CW_d/2-Border+5,-PCB_BoltSpacing/2,0]) cylinder(d=10,h=Plate_h);
					cylinder(d=10,h=Plate_h);
				} // hull
			} // if
			
			// Alignment mark
			rotate([0,0,-15]) translate([CW_d/2+Border,0,Plate_h-Deck_h]) cylinder(d=3,h=Deck_h);
		} // union
		
		if (PCB_Mounting_Ears==true) {
			translate([-CW_d/2-Border+5,PCB_BoltSpacing/2,-PCB_Standoff_h]) rotate([180,0,0]) Bolt6Hole();
			translate([-CW_d/2-Border+5,-PCB_BoltSpacing/2,-PCB_Standoff_h]) rotate([180,0,0]) Bolt6Hole();
			translate([-CW_d/2-Border+5+PCB_Edge+2,0,-PCB_Standoff_h]) rotate([180,0,0]) Bolt6Hole();
		} // if
		
		// Wire path
		for (j=[2:6])
		hull(){
			ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, HoleIdx=j-1)
				translate([0,0,-Overlap]) cylinder(d=4.5,h=3,$fn=30); 
			ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a, HoleIdx=j)
				translate([0,0,-Overlap]) cylinder(d=4.5,h=3,$fn=30); 
		} // hull
		hull(){
			rotate([0,0,15]) translate([CW_d/2-5,0,-Overlap]){
				cylinder(d=5,h=2.5,$fn=18); translate([0,0,2.5]) sphere(d=5,$fn=18);}
			rotate([0,0,15]) translate([CW_d/2+Border,0,-Overlap]){
				cylinder(d=5,h=2.5,$fn=18); translate([0,0,2.5]) sphere(d=5,$fn=18);}
		} // hull
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=Plate_h+Overlap*2);
		
		// Detent Hole
		rotate([0,0,180]) translate([-DetentHoleLoc_X,0,0]){
			translate([0,0,-Overlap]) cylinder(d=DW_Ball_d+IDXtra*2,h=Plate_h+Overlap*2);
			// Screw bosses for cover
			translate([0,DW_Ball_d/2+BoltInset,Plate_h]) Bolt4Hole();
			translate([0,-DW_Ball_d/2-BoltInset,Plate_h]) Bolt4Hole();
		}
		
		// Photo Sensor holes TO-18 case
		kSensor_d=4.7;
		kSensor_h=6;
		kSensorShoulder_d=7.5;
		ReadHeadHoles(CW_d=CW_d, nCodes=nCodes, Code_a=Code_a, CodeOffset_a=CodeOffset_a) {
			// LEDs
			translate([0,0,Plate_h-kSensor_h]) cylinder(d=kSensor_d+IDXtra,h=kSensor_h+Overlap); 
				//translate([0,0,Plate_h-kSensor_h-1]) cylinder(d2=kSensor_d+IDXtra,d1=kSensorShoulder_d,h=1+Overlap);
				translate([0,0,-Overlap]) cylinder(d=kSensorShoulder_d,h=Plate_h-kSensor_h+Overlap*2);}
		
		// Bolts
		PerimeterBoltCircle(CW_d=CW_d,nBolts=nBolts)
				rotate([180,0,0]) Bolt4HeadHole();
	} // diff
	
} // ReadHeadBotPlate

//ReadHeadBotPlate(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15);
//ReadHeadBotPlate(CW_d=60, nCodes=12, Code_a=28, CodeOffset_a=14, PCB_Mounting_Ears=true);  // 12 position
//ReadHeadBotPlate(CW_d=60, nCodes=16, Code_a=20, CodeOffset_a=16, PCB_Mounting_Ears=true);  // 16 position

module SpacerRing(CW_d=60, nCodes=16, Code_a=0, HasStop=true, HasMagnets=true){
	nBolts=6;
	Plate_h= HasMagnets? Mag_l+0.5:3;
	
	C_a = Code_a==0? 360/nCodes:Code_a;
	echo("Code Angle =",C_a);
	
	difference(){
		union(){
			cylinder(d=CW_d+ReadHeadBorder*2,h=Plate_h);
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+30])
					hull(){
						translate([CW_d/2+1+BoltInset,0,0])	cylinder(d=BoltInset*2,h=Plate_h);
						translate([CW_d/2,-BoltInset-1,0]) cube([0.01,BoltInset*2+2,Plate_h]);
					} // hull
					
			// Alignment mark
			rotate([0,0,-15]) translate([CW_d/2+ReadHeadBorder,0,0]) cylinder(d=3,h=Plate_h);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=CW_d+2.5,h=Plate_h+Overlap*2);
		
		// Bolts
		PerimeterBoltCircle(CW_d=CW_d,nBolts=nBolts) translate([0,0,Plate_h]) Bolt4ClearHole();
	} // diff
	
	if (HasStop==true) rotate([0,0,-C_a/2]) translate([CW_d/2+1,0,0]) cylinder(d=2.2,h=3);
} // SpacerRing

// translate([0,0,-3-Overlap*2]) SpacerRing(CW_d=70, nCodes=8, Code_a=37.5, HasStop=true);

module CodeWheel(CW_d=60, nCodes=16, Code_a=0, CodeOffset_a=15, HasStop=true, HasMagnets=true){
	CW_h= HasMagnets? Mag_l:2.1;
	CodeHole_d=1.8;
	DetentHole_d=3.5;
	
	C_a = Code_a==0? 360/nCodes:Code_a;
	echo("Code Angle =",C_a);
	
	difference(){
		union(){
			cylinder(d=CW_d,h=CW_h);
			cylinder(d=Shaft_d+4,h=CW_h+5);
		} // union
		
		for (j=[0:nCodes-1]) rotate([0,0,C_a*j]){
			// Enable Hole
			translate([CW_d/2-CodeSpace,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
			
			// Detent Hole
			if (HasMagnets==true){
				rotate([0,0,180]) translate([16,0,-Overlap]) cylinder(d=Mag_d,h=CW_h+Overlap*2);
			}else{
				rotate([0,0,180]) translate([16,0,-Overlap]) cylinder(d=DetentHole_d,h=CW_h+Overlap*2);
			}
			
			// Bit 0
			if (floor(j/2)*2 != j)
				rotate([0,0,CodeOffset_a]) translate([CW_d/2-CodeSpace*2,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
			
			// Bit 1
			if (nCodes>2) 
				if (floor(j/4)*2 != floor(j/2))
					rotate([0,0,CodeOffset_a*2]) translate([CW_d/2-CodeSpace*3,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
				
			// Bit 2
			if (nCodes>4) 
				if (floor(j/8)*2 != floor(j/4))
					rotate([0,0,CodeOffset_a*3]) translate([CW_d/2-CodeSpace*4,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
				
			// Bit 3
			if (nCodes>8) 
				if (floor(j/16)*2 != floor(j/8))
					rotate([0,0,CodeOffset_a*4]) translate([CW_d/2-CodeSpace*5,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
				
			// Bit 4
			if (nCodes>16) 
				if (floor(j/32)*2 != floor(j/16))
					rotate([0,0,CodeOffset_a*5]) translate([CW_d/2-CodeSpace*6,0,-Overlap]) cylinder(d=CodeHole_d,h=CW_h+Overlap*2);
			
		} // for
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Shaft_d+IDXtra,h=CW_h+5+Overlap*2);
	} // diff
	
	if (HasStop==true){
		rotate([0,0,-C_a/2-3.5]) translate([CW_d/2,0,0]) cylinder(d=2.2,h=CW_h);
		rotate([0,0,-C_a/2+3.5+C_a*(nCodes-1)]) translate([CW_d/2,0,0]) cylinder(d=2.2,h=CW_h);
	}
} // CodeWheel

//translate([0,0,-2]) rotate([0,0,-37.5*7]) CodeWheel(CW_d=60, nCodes=8, Code_a=37.5, CodeOffset_a=15, HasStop=true);
//CodeWheel(CW_d=60, nCodes=12, Code_a=28, CodeOffset_a=14, HasStop=true);
//CodeWheel(CW_d=62, nCodes=16, Code_a=20, CodeOffset_a=16, HasStop=true);

