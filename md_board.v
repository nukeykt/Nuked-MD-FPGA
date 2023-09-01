/*
 * Copyright (C) 2023 nukeykt
 *
 * This file is part of Nuked-MD.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 *  MD1 VA7, MD2 board
 *  Thanks:
 *      org, andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */

//`define M68K_CHEAT
//`define Z80_CHEAT
//`define EXT_CLOCKS
//`define VRAM_128K

module md_board
	(
	// input MCLK,
	input MCLK2,
	input ext_reset,
	input reset_button,
	input ext_vres,
	input ext_zres,
	
	// 68k/z80 ram
	output [14:0] ram_68k_address,
	output [1:0] ram_68k_byteena,
	output [15:0] ram_68k_data,
	output ram_68k_wren,
	input [15:0] ram_68k_o,
	output [12:0] ram_z80_address,
	output [7:0] ram_z80_data,
	output ram_z80_wren,
	input [7:0] ram_z80_o,
	
	// cart
	input M3,
	input [15:0] cart_data,
	input cart_data_en,
	output [22:0] cart_address,
	output cart_cs,
	output cart_oe,
	output cart_lwr,
	output cart_uwr,
	output cart_time,
	output cart_cas2,
	output [15:0] cart_data_wr,
	output cart_dma, // BGACK
	input cart_m3_pause,
	input ext_dtack,
	input pal,
	input jap,
	
	// tmss
	input tmss_enable,
	input [15:0] tmss_data,
	output [9:0] tmss_address,

`ifdef M68K_CHEAT
	output [22:0] m68k_addr,
	output [15:0] m68k_bus_do,
	input [15:0]  m68k_di,
`endif

`ifdef Z80_CHEAT
	output [15:0] z80_addr,
	output  [7:0] z80_bus_do,
	input   [7:0] z80_di,
`endif

`ifdef EXT_CLOCKS
	output ext_VCLK_o,
	output ext_ZCLK_o,
	input ext_VCLK_i,
	input ext_ZCLK_i,
`endif
	
	// video
	output [7:0] V_R, V_G, V_B,
	output V_HS, V_VS, V_CS,
	
	// audio
	output [15:0] A_L,
	output [15:0] A_R,
	output [17:0] A_L_2612,
	output [17:0] A_R_2612,
	output [8:0] MOL, MOR, // ym3438 linear, unsigned
	output [9:0] MOL_2612, MOR_2612, // ym2612 dac emulation, signed
	output [15:0] PSG,
	output [2:0] DAC_ch_index,
	output fm_sel23,
	
	// input
	input [6:0] PA_i,
	output [6:0] PA_o,
	output [6:0] PA_d,
	input [6:0] PB_i,
	output [6:0] PB_o,
	output [6:0] PB_d,
	input [6:0] PC_i,
	output [6:0] PC_o,
	output [6:0] PC_d,
	
	output vdp_hclk1,
	output vdp_intfield,
	output vdp_de_h,
	output vdp_de_v,
	output vdp_m5, // md mode
	output vdp_rs1, // h32/h40
	output vdp_m2, // v28/v30
	output vdp_lcb,
	output vdp_psg_clk1,
	input  vdp_cramdot_dis,
	output fm_clk1,
	output vdp_hsync2,
	input ym2612_status_enable,
	input dma_68k_req,
	input dma_z80_req,
	output dma_z80_ack,
	output res_z80
	
	);
	
	wire [7:0] SD;
	wire SE1;
	wire SE0;
	wire SC;
	wire RAS1;
	wire CAS1;
	wire WE1;
	wire WE0;
	wire OE1;
	wire [7:0] RD;
	wire [7:0] ym_RD_o;
	wire ym_RD_d;
	wire [7:0] AD;
	wire [7:0] ym_AD_o;
	wire ym_AD_d;
	wire [7:0] DAC_R;
	wire [7:0] DAC_G;
	wire [7:0] DAC_B;
	wire YS;
	wire SPA_B;
	wire SPA_B_pull;
	wire VSYNC;
	wire CSYNC;
	wire CSYNC_pull;
	wire HSYNC;
	wire HSYNC_pull;
	//wire M3;
	reg _M3;
	wire NTSC;
	wire VPA;
	wire ym_HALT_pull;
	wire ym_RESET_pull;
	wire FC0;
	wire FC1;
	reg MREQ;
	wire ym_MREQ_o;
	wire ym_MREQ_d;
	wire SOUND;
	wire SOUND_o;
	wire SOUND_d;
	wire ZRES;
	wire ZRES_o;
	wire ZRES_d;
	wire ZBAK;
	wire NMI;
	wire ZBR;
	wire ZBR_o;
	wire ZBR_d;
	wire WAIT;
	wire ym_WAIT_pull;
	wire EOE;
	wire NOE;
	wire ZRAM;
	wire REF;
	wire CAS2;
	wire RAS2;
	wire ASEL;
	wire ROM;
	wire FDC;
	wire FDWR;
	wire CE0;
	wire TIME;
	wire CART;
	wire IA14;
	wire WRES;
	wire DISK;
	wire ym_DISK_o;
	wire ym_DISK_d;
	wire TEST0;
	wire TEST0_o;
	wire TEST0_d;
	wire TEST1;
	wire TEST2;
	wire TEST3;
	//wire [6:0] PC;
	//wire [6:0] ym_PC_o;
	//wire [6:0] ym_PC_d;
	//wire [6:0] PB;
	//wire [6:0] ym_PB_o;
	//wire [6:0] ym_PB_d;
	//wire [6:0] PA;
	//wire [6:0] ym_PA_o;
	//wire [6:0] ym_PA_d;
	wire JAP;
	wire ym_JAP_o;
	wire ym_JAP_d;
	wire FRES;
	wire FRES_o;
	wire FRES_d;
	wire ZV;
	wire ZV_o;
	wire ZV_d;
	wire VZ;
	wire VZ_o;
	wire VZ_d;
	wire IO;
	wire IO_o;
	wire IO_d;
	reg [15:0] ZA;
	wire [15:0] ym_ZA_o;
	wire [15:0] ym_ZA_d;
	wire SRES;
	wire SEL1;
	wire VCLK;
	wire VCLK_o;
	wire VCLK_d;
	wire SBCR;
	wire ZCLK;
	wire ZCLK_o;
	wire ZCLK_d;
	wire EDCLK;
	wire EDCLK_o;
	wire EDCLK_d;
	reg [15:0] VD;
	wire [15:0] ym_VD_o;
	wire [15:0] ym_VD_d;
	reg [22:0] VA;
	wire [22:0] ym_VA_o;
	wire [22:0] ym_VA_d;
	wire ym_INT_pull;
	wire ym_BR_pull;
	reg BGACK;
	wire ym_BGACK_pull;
	wire BG;
	wire ym_IPL1_pull;
	wire ym_IPL2_pull;
	reg IORQ;
	reg ZRD;
	wire ym_ZRD_o;
	wire ym_ZRD_d;
	reg ZWR;
	wire ym_ZWR_o;
	wire ym_ZWR_d;
	wire M1;
	reg AS;
	wire ym_AS_o;
	wire ym_AS_d;
	reg UDS;
	wire ym_UDS_o;
	wire ym_UDS_d;
	reg LDS;
	wire ym_LDS_o;
	wire ym_LDS_d;
	reg RW;
	wire ym_RW_o;
	wire ym_RW_d;
	reg DTACK;
	wire ym_DTACK_pull;
	wire UWR;
	wire LWR;
	wire LWR_o;
	wire LWR_d;
	wire CAS0;
	wire CAS0_o;
	wire CAS0_d;
	wire RAS0;
	reg [7:0] ZD;
	wire [7:0] ym_ZD_o;
	wire [7:0] ym_ZD_d;
	
	reg MCLK_e;
	
	always @(posedge MCLK2)
	begin
		MCLK_e <= ~MCLK_e;
	end
	
	fc1004 ym
		(
		.MCLK(MCLK2),
		.MCLK_e(MCLK_e),
		.SD(SD),
		.SE1(SE1),
		.SE0(SE0),
		.SC(SC),
		.RAS1(RAS1),
		.CAS1(CAS1),
		.WE1(WE1),
		.WE0(WE0),
		.OE1(OE1),
		.RD_i(RD),
		.RD_o(ym_RD_o),
		.RD_d(ym_RD_d),
		.AD_i(AD),
		.AD_o(ym_AD_o),
		.AD_d(ym_AD_d),
		.DAC_R(DAC_R),
		.DAC_G(DAC_G),
		.DAC_B(DAC_B),
		.YS(YS),
		.SPA_B_i(SPA_B),
		.SPA_B_pull(SPA_B_pull),
		.VSYNC(VSYNC),
		.CSYNC_i(CSYNC),
		.CSYNC_pull(CSYNC_pull),
		.HSYNC_i(HSYNC),
		.HSYNC_pull(HSYNC_pull),
		.M3(_M3),
		.NTSC(NTSC),
		.VPA(VPA),
		.HALT_pull(ym_HALT_pull),
		.RESET_pull(ym_RESET_pull),
		.FC0(FC0),
		.FC1(FC1),
		.MREQ_i(MREQ),
		.MREQ_o(ym_MREQ_o),
		.MREQ_d(ym_MREQ_d),
		.MOL(MOL),
		.MOR(MOR),
		.MOL_2612(MOL_2612),
		.MOR_2612(MOR_2612),
		.SOUND_i(SOUND),
		.SOUND_o(SOUND_o),
		.SOUND_d(SOUND_d),
		.ZRES_i(ZRES),
		.ZRES_o(ZRES_o),
		.ZRES_d(ZRES_d),
		.ZBAK(ZBAK),
		.NMI(NMI),
		.ZBR_i(ZBR),
		.ZBR_o(ZBR_o),
		.ZBR_d(ZBR_d),
		.WAIT_i(WAIT),
		.WAIT_pull(ym_WAIT_pull),
		.EOE(EOE),
		.NOE(NOE),
		.ZRAM(ZRAM),
		.REF(REF),
		.CAS2(CAS2),
		.RAS2(RAS2),
		.ASEL(ASEL),
		.ROM(ROM),
		.FDC(FDC),
		.FDWR(FDWR),
		.CE0(CE0),
		.TIME(TIME),
		.CART(CART),
		.IA14(IA14),
		.WRES(WRES),
		.DISK_i(DISK),
		.DISK_o(ym_DISK_o),
		.DISK_d(ym_DISK_d),
		.TEST0_i(TEST0),
		.TEST0_o(TEST0_o),
		.TEST0_d(TEST0_d),
		.TEST1(TEST1),
		.TEST2(TEST2),
		.TEST3(TEST3),
		.PC_i(PC_i),
		.PC_o(PC_o),
		.PC_d(PC_d),
		.PB_i(PB_i),
		.PB_o(PB_o),
		.PB_d(PB_d),
		.PA_i(PA_i),
		.PA_o(PA_o),
		.PA_d(PA_d),
		.JAP_i(JAP),
		.JAP_o(ym_JAP_o),
		.JAP_d(ym_JAP_d),
		.FRES_i(FRES),
		.FRES_o(FRES_o),
		.FRES_d(FRES_d),
		.ZV_i(ZV),
		.ZV_o(ZV_o),
		.ZV_d(ZV_d),
		.VZ_i(VZ),
		.VZ_o(VZ_o),
		.VZ_d(VZ_d),
		.IO_i(IO),
		.IO_o(IO_o),
		.IO_d(IO_d),
		.ZA_i(ZA),
		.ZA_o(ym_ZA_o),
		.ZA_d(ym_ZA_d),
		.SRES(SRES),
		.SEL1(SEL1),
		.CLK_i(VCLK),
		.CLK_o(VCLK_o),
		.CLK_d(VCLK_d),
		.SBCR(SBCR),
		.ZCLK_i(ZCLK),
		.ZCLK_o(ZCLK_o),
		.ZCLK_d(ZCLK_d),
		.EDCLK_i(EDCLK),
		.EDCLK_o(EDCLK_o),
		.EDCLK_d(EDCLK_d),
		.VD_i(VD),
		.VD_o(ym_VD_o),
		.VD_d(ym_VD_d),
		.VA_i(VA),
		.VA_o(ym_VA_o),
		.VA_d(ym_VA_d),
		.PSG(PSG),
		.INT_pull(ym_INT_pull),
		.BR_pull(ym_BR_pull),
		.BGACK_i(BGACK),
		.BGACK_pull(ym_BGACK_pull),
		.BG(BG),
		.IPL1_pull(ym_IPL1_pull),
		.IPL2_pull(ym_IPL2_pull),
		.IORQ(IORQ),
		.ZRD_i(ZRD),
		.ZRD_o(ym_ZRD_o),
		.ZRD_d(ym_ZRD_d),
		.ZWR_i(ZWR),
		.ZWR_o(ym_ZWR_o),
		.ZWR_d(ym_ZWR_d),
		.M1(M1),
		.AS_i(AS),
		.AS_o(ym_AS_o),
		.AS_d(ym_AS_d),
		.UDS_i(UDS),
		.UDS_o(ym_UDS_o),
		.UDS_d(ym_UDS_d),
		.LDS_i(LDS),
		.LDS_o(ym_LDS_o),
		.LDS_d(ym_LDS_d),
		.RW_i(RW),
		.RW_o(ym_RW_o),
		.RW_d(ym_RW_d),
		.DTACK_i(DTACK),
		.DTACK_pull(ym_DTACK_pull),
		.UWR(UWR),
		.LWR_i(LWR),
		.LWR_o(LWR_o),
		.LWR_d(LWR_d),
		.CAS0_i(CAS0),
		.CAS0_o(CAS0_o),
		.CAS0_d(CAS0_d),
		.RAS0(RAS0),
		.ZD_i(ZD),
		.ZD_o(ym_ZD_o),
		.ZD_d(ym_ZD_d),
		.vdp_hclk1(vdp_hclk1),
		.vdp_intfield(vdp_intfield),
		.vdp_de_h(vdp_de_h),
		.vdp_de_v(vdp_de_v),
		.vdp_m5(vdp_m5),
		.vdp_rs1(vdp_rs1),
		.vdp_m2(vdp_m2),
		.vdp_lcb(vdp_lcb),
		.vdp_psg_clk1(vdp_psg_clk1),
		.vdp_cramdot_dis(vdp_cramdot_dis),
		.fm_clk1(fm_clk1),
		.DAC_ch_index(DAC_ch_index),
		.tmss_enable(tmss_enable),
		.tmss_data(tmss_data),
		.tmss_address(tmss_address),
		.vdp_hsync2(vdp_hsync2),
		.ym2612_status_enable(ym2612_status_enable)
		);
	
	assign fm_sel23 = TEST0_o;
	
	wire [2:0] IPL;
	reg BR;
	wire BERR;
	wire m68k_RESET_pull;
	wire m68k_HALT_pull;
	wire [15:0] m68k_VD_o;
	wire m68k_VD_d2;
	wire [15:0] m68k_VD_d;
	wire [2:0] FC;
	wire FC_z;
	wire m68k_RW_o;
	wire m68k_RW_d;
	wire [22:0] m68k_VA_o;
	wire m68k_VA_d2;
	wire [22:0] m68k_VA_d;
	wire m68k_S_d;
	wire m68k_AS_o;
	wire m68k_LDS_o;
	wire m68k_UDS_o;
	
	wire HALT;
	wire RESET;
	
`ifdef EXT_CLOCKS
	assign ext_VCLK_o = VCLK;
	assign ext_ZCLK_o = ZCLK;
`endif
	
	m68kcpu m68k
		(
		.MCLK(MCLK2),
`ifndef EXT_CLOCKS
		.CLK(VCLK),
`else
		.CLK(ext_VCLK_i),
`endif
		.BR(BR),
		.BGACK(BGACK),
		.DTACK(DTACK),
		.IPL(IPL),
		.BERR(BERR),
		.RESET_i(RESET),
		.RESET_pull(m68k_RESET_pull),
		.HALT_i(HALT),
		.HALT_pull(m68k_HALT_pull),
`ifndef M68K_CHEAT
		.DATA_i(VD),
`else
		.DATA_i(m68k_di),
`endif
		.DATA_o(m68k_VD_o),
		.DATA_z(m68k_VD_d2),
		.BG(BG),
		.FC(FC),
		.FC_z(FC_z),
		.RW(m68k_RW_o),
		.RW_z(m68k_RW_d),
		.ADDRESS(m68k_VA_o),
		.ADDRESS_z(m68k_VA_d2),
		.AS(m68k_AS_o),
		.LDS(m68k_LDS_o),
		.UDS(m68k_UDS_o),
		.strobe_z(m68k_S_d),
		.VPA(VPA)
		);

`ifdef M68K_CHEAT
	assign m68k_addr = m68k_VA_o;
	assign m68k_bus_do = VD;
`endif
	
	wire [15:0] z80_ZA_o;
	wire z80_ZA_d2;
	wire [15:0] z80_ZA_d;
	wire [7:0] z80_ZD_o;
	wire z80_ZD_d2;
	wire [7:0] z80_ZD_d;
	wire z80_MREQ_o;
	wire z80_MREQ_d;
	wire z80_IORQ_o;
	wire z80_IORQ_d;
	wire z80_ZRD_o;
	wire z80_ZRD_d;
	wire z80_ZWR_o;
	wire z80_ZWR_d;
	wire INT;
	
	z80cpu z80
		(
		.MCLK(MCLK2),
`ifndef EXT_CLOCKS
		.CLK(ZCLK),
`else
		.CLK(ext_ZCLK_i),
`endif
		.ADDRESS(z80_ZA_o),
		.ADDRESS_z(z80_ZA_d2),
`ifndef Z80_CHEAT
		.DATA_i(ZD),
`else
		.DATA_i(z80_di),
`endif
		.DATA_o(z80_ZD_o),
		.DATA_z(z80_ZD_d2),
		.M1(M1),
		.MREQ(z80_MREQ_o),
		.MREQ_z(z80_MREQ_d),
		.IORQ(z80_IORQ_o),
		.IORQ_z(z80_IORQ_d),
		.RD(z80_ZRD_o),
		.RD_z(z80_ZRD_d),
		.WR(z80_ZWR_o),
		.WR_z(z80_ZWR_d),
		.RFSH(),
		.HALT(),
		.WAIT(WAIT),
		.INT(INT),
		.NMI(NMI),
		.BUSRQ(ZBR),
		.BUSAK(ZBAK),
		.RESET(ZRES)
		);
	
`ifdef Z80_CHEAT
	assign z80_addr = z80_ZA_o;
	assign z80_bus_do = ZD;
`endif

	wire [7:0] vram1_AD_o;
	wire vram1_AD_d;
	wire [7:0] vram1_SD_o;
	wire vram1_SD_d;
	
	vram vram1
		(
		.MCLK(MCLK2),
		.RAS(RAS1),
		.CAS(CAS1),
		.WE(WE0),
		.OE(OE1),
		.SC(SC),
		.SE(SE0),
		.AD(AD),
		.RD_i(AD),
		.RD_o(vram1_AD_o),
		.RD_d(vram1_AD_d),
		.SD_o(vram1_SD_o),
		.SD_d(vram1_SD_d)
		);

`ifdef VRAM_128K
	wire [7:0] vram2_RD_o;
	wire vram2_RD_d;
	wire [7:0] vram2_SD_o;
	wire vram2_SD_d;
	
	vram vram2
		(
		.MCLK(MCLK2),
		.RAS(RAS1),
		.CAS(CAS1),
		.WE(WE1),
		.OE(OE1),
		.SC(SC),
		.SE(SE1),
		.AD(AD),
		.RD_i(RD),
		.RD_o(vram2_RD_o),
		.RD_d(vram2_RD_d),
		.SD_o(vram2_SD_o),
		.SD_d(vram2_SD_d)
		);
`endif
	
	assign ram_68k_address = { VA[14], IA14, VA[12:0] };
	assign ram_68k_byteena = { ~UWR, ~LWR };
	assign ram_68k_data = VD;
	assign ram_68k_wren = (~UWR | ~LWR) & ~RAS0;
	
	assign ram_z80_address = ZA[12:0];
	assign ram_z80_data = ZD;
	assign ram_z80_wren = ~ZRAM & ~ZWR;
	
	//wire [14:0] ram_68k_address = { VA[14], IA14, VA[12:0] };
	//
	//wire [15:0] ram_68k_o;
	//
	//ram_68k ram_68k
	//	(
	//	.address(ram_68k_address),
	//	.byteena({ ~UWR, ~LWR }),
	//	.clock(MCLK2),
	//	.data(VD),
	//	.wren((~UWR | ~LWR) & ~RAS0),
	//	.q(ram_68k_o)
	//	);
	//
	//wire [7:0] ram_z80_o;
	//
	//ram_z80 ram_z80
	//	(
	//	.address(ZA[12:0]),
	//	.clock(MCLK2),
	//	.data(ZD),
	//	.wren(~ZRAM & ~ZWR),
	//	.q(ram_z80_o)
	//	);
	
	reg [7:0] RD_mem;
	reg [7:0] AD_mem;
	reg [7:0] SD_mem;
	
`ifndef VRAM_128K
	assign RD =
		(~ym_RD_d ? ym_RD_o : RD_mem);
`else
	assign RD =
		(~ym_RD_d ? ym_RD_o : 8'h0) |
		(~vram2_RD_d ? vram2_RD_o : 8'h0) |
		((ym_RD_d & vram2_RD_d) ? RD_mem : 8'h0);
`endif
	
	assign AD =
		(~ym_AD_d ? ym_AD_o : 8'h0) |
		(~vram1_AD_d ? vram1_AD_o : 8'h0) |
		((ym_AD_d & vram1_AD_d) ? AD_mem : 8'h0);
	
	always @(posedge MCLK2)
	begin
		RD_mem <= RD;
		AD_mem <= AD;
		SD_mem <= SD;
	end
	
	assign ZBR = (ZBR_d | ZBR_o) & ~dma_z80_req;
	
	assign WAIT = ~ym_WAIT_pull;
	
	assign z80_ZA_d = {16{z80_ZA_d2}};
	
	assign z80_ZD_d = {8{z80_ZD_d2}};
	wire [7:0] ram_ZD_d = {8{ZRD | ZRAM}};
	
	assign m68k_VA_d = {23{m68k_VA_d2}};
	
	wire [22:0] m3_cart_VA_d = {_M3, _M3, _M3, 20'hfffff};
	wire [22:0] m3_cart_VA_o = {~cart_m3_pause, 1'h0, 1'h1, 20'h0};
	
	assign m68k_VD_d = {16{m68k_VD_d2}};
	wire [15:0] ram_VD_d = {{8{EOE|RAS0}}, {8{NOE|RAS0}}};
	//wire [15:0] cart_VD_d = M3 ?{16{CAS0 | CE0}}
	//	: {8'hff, {8{ VA[17] | CAS0 | CE0 }}};
	wire [15:0] cart_VD_d = _M3 ? {16{~cart_data_en}}
		: {8'hff, {8{~cart_data_en}}};
	
	always @(posedge MCLK2)
	begin
		VD <= 
			(~ym_VD_d & ym_VD_o) |
			(~m68k_VD_d & m68k_VD_o) |
			(~ram_VD_d & ram_68k_o) |
			(~cart_VD_d & cart_data) |
			((ym_VD_d & m68k_VD_d & ram_VD_d & cart_VD_d) & VD);
	
		VA <=
			(~ym_VA_d & ym_VA_o) |
			(~m68k_VA_d & m68k_VA_o) |
			(~m3_cart_VA_d & m3_cart_VA_o) |
			((ym_VA_d & m68k_VA_d & m3_cart_VA_d) & VA);
	
		ZD <=
			(~ym_ZD_d & ym_ZD_o) |
			(~z80_ZD_d & z80_ZD_o) |
			(~ram_ZD_d & ram_z80_o) |
			((ym_ZD_d & z80_ZD_d & ram_ZD_d) & 8'hff);
	
		ZA <=
			(~ym_ZA_d & ym_ZA_o) |
			(~z80_ZA_d & z80_ZA_o) |
			((ym_ZA_d & z80_ZA_d) & ZA);
	
		DTACK <= ~ym_DTACK_pull & ~ext_dtack;
	
		BGACK <= ~ym_BGACK_pull;
	
		BR <= ~ym_BR_pull & ~dma_68k_req;
		
		AS <= ym_AS_d & m68k_S_d ? 1'h1 :
			(~ym_AS_d & ym_AS_o) |
			(~m68k_S_d & m68k_AS_o);
		UDS <= ym_UDS_d & m68k_S_d ? 1'h1 :
			(~ym_UDS_d & ym_UDS_o) |
			(~m68k_S_d & m68k_UDS_o);
		LDS <= ym_LDS_d & m68k_S_d ? 1'h1 :
			(~ym_LDS_d & ym_LDS_o) |
			(~m68k_S_d & m68k_LDS_o);
		RW <= ym_RW_d & m68k_RW_d ? 1'h1 :
			(~ym_RW_d & ym_RW_o) |
			(~m68k_RW_d & m68k_RW_o);
		
		_M3 <= M3;
	
		ZRD <= ym_ZRD_d & z80_ZRD_d ? 1'h1 :
			(~ym_ZRD_d & ym_ZRD_o) |
			(~z80_ZRD_d & z80_ZRD_o);
		ZWR <= ym_ZWR_d & z80_ZWR_d ? 1'h1 :
			(~ym_ZWR_d & ym_ZWR_o) |
			(~z80_ZWR_d & z80_ZWR_o);
		MREQ <= ym_MREQ_d & z80_MREQ_d ? 1'h1 :
			(~ym_MREQ_d & ym_MREQ_o) |
			(~z80_MREQ_d & z80_MREQ_o);
		IORQ <= z80_IORQ_d ? 1'h1 : z80_IORQ_o;
	end
	
	assign RESET = ~(ym_RESET_pull | m68k_RESET_pull | ext_vres);
	assign HALT = ~(ym_HALT_pull | m68k_HALT_pull | ext_vres);
	
	//assign PA =
	//	(~ym_PA_d & ym_PA_o) | (ym_PA_d & 7'h7f);
		
	//assign PB =
	//	(~ym_PB_d & ym_PB_o) | (ym_PB_d & 7'h7f);
		
	//assign PC =
	//	(~ym_PC_d & ym_PC_o) | (ym_PC_d & 7'h7f);
	
	assign VCLK = (~VCLK_d & VCLK_o);
	assign ZCLK = (~ZCLK_d & ZCLK_o);
	assign EDCLK = (~EDCLK_d & EDCLK_o);
	
	assign NTSC = ~pal;
	assign JAP = ~jap;
	assign DISK = 1'h1;
	
	assign LWR = ~LWR_d & LWR_o;
	
	assign CSYNC = ~CSYNC_pull;
	assign HSYNC = ~HSYNC_pull;
	assign SPA_B = ~SPA_B_pull;
	
	assign FC0 = FC_z | FC[0];
	assign FC1 = FC_z | FC[1];
	
	assign IPL[0] = 1'h1;
	assign IPL[1] = ~ym_IPL1_pull;
	assign IPL[2] = ~ym_IPL2_pull;
	
	assign BERR = 1'h1;
	
`ifndef VRAM_128K
	assign SD =
		vram1_SD_d ? SD_mem : vram1_SD_o;
`else
	assign SD =
		(~vram1_SD_d ? vram1_SD_o : 8'h0) |
		(~vram2_SD_d ? vram2_SD_o : 8'h0) |
		((vram1_SD_d & vram2_SD_d) ? SD_mem : 8'h0);
`endif
	
	assign INT = ~ym_INT_pull;
	
	assign ZRES = (ZRES_d ? 1'h1 : ZRES_o) & ~ext_zres;
	
	assign SOUND = ~SOUND_d & SOUND_o;
	assign VZ = ~VZ_d & VZ_o;
	assign ZV = ~ZV_d & ZV_o;
	assign IO = ~IO_d & IO_o;
	assign CAS0 = ~CAS0_d & CAS0_o;
	
	assign V_R = DAC_R;
	assign V_G = DAC_G;
	assign V_B = DAC_B;
	
	assign V_VS = VSYNC;
	assign V_HS = HSYNC;
	assign V_CS = CSYNC;
	
	assign SRES = ~ext_reset;
	
	wire [8:0] MOL_s = MOL - 9'h100;
	wire [8:0] MOR_s = MOR - 9'h100;
	
	assign A_L = {MOL_s[8], MOL_s,6'h0} + PSG;
	assign A_R = {MOR_s[8], MOR_s,6'h0} + PSG;
	
	assign A_L_2612 = {MOL_2612[9], MOL_2612,7'h0} + {{2{MOL_2612[9]}}, MOL_2612,6'h0} + {2'h0, PSG};
	assign A_R_2612 = {MOR_2612[9], MOR_2612,7'h0} + {{2{MOR_2612[9]}}, MOR_2612,6'h0} + {2'h0, PSG};
	
	assign cart_address = VA[22:0];
	assign cart_cs = ~CE0;
	assign cart_oe = ~CAS0;
	assign cart_lwr = ~LWR;
	assign cart_uwr = ~UWR;
	assign cart_time = ~TIME;
	assign cart_data_wr = VD;
	assign cart_cas2 = ~CAS2;
	assign cart_dma = ~BGACK;
	
	assign dma_z80_ack = ~ZBAK;
	assign res_z80 = ~ZRES;
	
	assign CART = 1'h0;
	
	assign SEL1 = 1'h0;
	
	assign TEST0 = 1'h0; //TEST0_d ? 1'h1 : TEST0_o;
	assign TEST1 = 1'h1;
	assign TEST2 = 1'h1;
	assign TEST3 = 1'h1;
	
	assign WRES = ~reset_button;
	
	assign FRES = FRES_d ? 1'h1 : FRES_o;

endmodule
