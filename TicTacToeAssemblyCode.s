 mov r0, 1000
mov r3, 0
mov r4, 1
mov r5, 2
st r4, 0[r0]
st r5, 4[r0]
st r4, 8[r0]
st r5, 12[r0]
st r4, 16[r0]
st r3, 20[r0]
st r3, 24[r0]
st r3, 28[r0]
st r3, 32[r0]
st r3, 36[r0]
st r3, 40[r0]
st r3, 44[r0]
st r3, 48[r0]
st r4, 52[r0]
st r3, 56[r0]
st r3, 60[r0]
st r5, 64[r0]
st r3, 68[r0]
st r3, 72[r0]
st r3, 76[r0]
st r3, 80[r0]
st r4, 84[r0]
st r3, 88[r0]
st r3, 92[r0]
st r3, 96[r0]
st r3, 100[r0]
st r5, 104[r0]
st r3, 108[r0]
st r3, 112[r0]
st r3, 116[r0]
st r3, 120[r0]
st r4, 124[r0]
st r3, 128[r0]
st r3, 132[r0]
st r3, 136[r0]
st r3, 140[r0]
////////////////////////////////////////////////////
mov r0, 1000
mov r4,r0   	// base address TEMPORARY ADDRESS
mov r1, 0        // 1-count
mov r2, 0        // 2-count
mov r13, 0       // status


mov r5, 36            // number of elements

.counter:
	cmp r5,0
	beq .check_done
	ld r3,0[r4]
	cmp r3,0
	beq .next
	cmp r3,1
	beq .one
	cmp r3,2
	beq .two
	b .illegal
.one:
	add r1,r1,1
	b .next
.two:
	add r2,r2,1
	b .next
.next:
	add r4,r4,4
	sub r5,r5,1
	b .counter

.check_done:
	cmp r2,r1
	bgt .illegal

	sub r6, r1, r2    
    	cmp r6, 1
    	bgt .illegal       
	b .win_check




.win_check:
	mov r1,0  // Did player 1 win
	mov r2,0  // Did player 2 win
	mov r7,0  // row index
////////////////////////////////////////////////////////  ROW CHECK  /////////////////////////////////////////////////////////////////
.rowchecker:
	cmp r7,6
	beq .rowoverflow
	mov r8,1  //col index
	.rowinner:
		cmp r8,5
		beq .row_next_row
		mul r9,r8,4 
		mul r10,r7,24
		add r4,r9,r10
		add r4,r4,r0
		ld r5, 0[r4]
		cmp r5,0
		beq .rightcell
		ld r9, -4[r4]
		ld r10, 4[r4]
		cmp r9,r10
		beq .checkrowmid
		b .rightcell

////////// HELPER FUNTCIONS FOR ROW CHECKER //////////////// 

.checkrowmid:
	cmp r9,r5
	beq .whowon
	b .rightcell
.whowon:
	cmp r5,1
	beq .onewins
	b .twowins
.onewins:
	mov r1,1
	b .rightcell
.twowins:
	mov r2,1
	b .rightcell
.rightcell:
	add r8,r8,1
	b .rowinner
.row_next_row:
	add r7,r7,1
	b .rowchecker

.rowoverflow:
	cmp r1,r2
	beq .didtheybothwinrow
	mov r7,0
	mov r8,0
	b .colchecker
.didtheybothwinrow:
	cmp r1,1
	beq .illegal
	mov r7,0
	mov r8,0
	b .colchecker
			

	/////////////////////////////////////////////////////////////////// COLUMN CHECKER////////////////////////////////////////////////////////////
 // Same as row, but transposed

.colchecker:
	cmp r8,6
	beq .coloverflow
	mov r7,1
	.colinner:
		cmp r7,5
		beq .col_next_col
		mul r9,r8,4
		mul r10,r7,24
		add r4,r9,r10
		add r4,r4,r0
		ld r5, 0[r4]
		cmp r5,0
		beq .downcell
		ld r9, -24[r4]
		ld r10, 24[r4]
		cmp r9,r10
		beq .checkcolmid
		b .downcell

////////// HELPER FUNTCIONS FOR COLUMN CHECKER //////////////// 


.checkcolmid:
	cmp r9,r5
	beq .whowoncol
	b .downcell
.whowoncol:
	cmp r5,1
	beq .onewinscol
	b .twowinscol
.onewinscol:
	mov r1,1
	b .downcell
.twowinscol:
	mov r2,1
	b .downcell
.downcell:
	add r7,r7,1
	b .colinner
.col_next_col:
	add r8,r8,1
	b .colchecker

.coloverflow:
	cmp r1,r2
	beq .didtheybothwincol
	mov r7,1
	mov r8,1
	b .diachecker
.didtheybothwincol:
	cmp r1,1
	beq .illegal
	mov r7,1
	mov r8,1
	b .diachecker


/////////////////////////////////////////////////////////////////// DIAGONAL CHECKER////////////////////////////////////////////////////////////
.diachecker:
	cmp r7,5
	beq .diaoverflow
	mov r8,1  //col index
	.diainner:
		cmp r8,4
		bgt .dia_next_dia
		mul r9,r8,4 	
		mul r10,r7,24
		add r4,r9,r10
		add r4,r4,r0
		ld r5, 0[r4]
		cmp r5,0
		beq .diarightcell
		ld r9, -28[r4]
		ld r10, 28[r4]
		cmp r9,r10
		beq .checkdiamid
		b .diarightcell

////////// HELPER FUNTCIONS FOR DIA CHECKER //////////////// 

.checkdiamid:
	cmp r9,r5
	beq .whowondia
	b .diarightcell
.whowondia:
	cmp r5,1
	beq .onewinsdia
	b .twowinsdia
.onewinsdia:
	mov r1,1
	b .diarightcell
.twowinsdia:
	mov r2,1
	b .diarightcell
.diarightcell:
	add r8,r8,1
	b .diainner
.dia_next_dia:
	add r7,r7,1
	b .diachecker

.diaoverflow:
	cmp r1,r2
	beq .didtheybothwindia
	mov r7,1
	mov r8,1
	b .antidiachecker
.didtheybothwindia:
	cmp r1,1
	beq .illegal
	mov r7,1
	mov r8,1
	b .antidiachecker


/////////////////////////////////////////////////////////////////// ANTI-DIAGONAL CHECKER////////////////////////////////////////////////////////////
.antidiachecker:
	cmp r7,5
	beq .antidiaoverflow
	mov r8,1  //col index
	.antidiainner:
		cmp r8,4
		bgt .antidia_next_dia
		mul r9,r8,4 	
		mul r10,r7,24
		add r4,r9,r10
		add r4,r4,r0
		ld r5, 0[r4]
		cmp r5,0
		beq .antidiarightcell
		ld r9, -20[r4]
		ld r10, 20[r4]
		cmp r9,r10
		beq .checkantidiamid
		b .antidiarightcell
.checkantidiamid:
	cmp r9,r5
	beq .whowonantidia
	b .antidiarightcell
.whowonantidia:
	cmp r5,1
	beq .onewinsantidia
	b .twowinsantidia
.onewinsantidia:
	mov r1,1
	b .antidiarightcell
.twowinsantidia:
	mov r2,1
	b .antidiarightcell
.antidiarightcell:
	add r8,r8,1
	b .antidiainner
.antidia_next_dia:
	add r7,r7,1
	b .antidiachecker

.antidiaoverflow:
	cmp r1,r2
	beq .didtheybothwinantidia
	mov r7,0
	mov r8,0
	b .judgement
.didtheybothwinantidia:
	cmp r1,1
	beq .illegal
	mov r7,0
	mov r8,0
	b .judgement



///INCLUDE JUDGEMENT AFTER WINCHECK

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
.judgement:
	cmp r1,1
	beq .check_p2
	cmp r2,1
	beq .p2only
	mov r1, 0
	st r1,144[r0]
	b .exit
.check_p2:
	cmp r2,1
	beq .illegal
	mov r1, 1
	st r1,144[r0]
	b .exit
.p2only:
	mov r1, 2
	st r1,144[r0]
	b .exit
.illegal:
	mov r1, -1
	st r1,144[r0]
.exit: