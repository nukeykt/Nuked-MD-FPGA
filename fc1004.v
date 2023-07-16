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
 *  FC1004 emulator
 *  Thanks:
 *      org (ogamespec):
 *          FC1004 decap and die shot.
 *      andkorzh, HardWareMan (emu-russia):
 *          help & support.
 *
 */

// 1: input, 0: output

module fc1004
	(
	input [7:0] SD,
	output SE1,
	output SE0,
	output SC,
	output RAS1,
	output CAS1,
	output WE1,
	output WE0,
	output OE1,
	input [7:0] RD_i,
	output [7:0] RD_o,
	output RD_d,
	output [7:0] AD_i,
	output [7:0] AD_o,
	output [7:0] AD_d,
	output [7:0] DAC_R,
	output [7:0] DAC_G,
	output [7:0] DAC_B,
	output YS,
	output SPA_B_pull,
	output VSYNC,
	input CSYNC_i,
	output CSYNC_pull,
	input HSYNC_i,
	output HSYNC_pull,
	input M3,
	input NTSC,
	output VPA,
	output HALT_pull,
	output RESET_pull,
	input FC0,
	input FC1,
	input MREQ_i,
	output MREQ_pull,
	output [8:0] MOL, MOR,
	input SOUND_i,
	output SOUND_pull,
	input ZRES_i,
	output ZRES_pull,
	input ZBAK,
	output NMI,
	input ZBR_i,
	output ZBR_o
	output ZBR_d,
	input WAIT_i,
	output WAIT_pull,
	output EOE,
	output NOE,
	output ZRAM,
	output REF,
	output CAS2,
	output RAS2,
	output ASEL,
	output ROM,
	output FDC,
	output FDWR,
	output CE0,
	output TIME,
	input CART,
	output IA14,
	input WRES,
	input DISK_i,
	output DISK_o,
	output DISK_d,
	input TEST0_i,
	output TEST0_o,
	output TEST0_d,
	input TEST1,
	input TEST2,
	input TEST3,
	input [6:0] PC_i,
	output [6:0] PC_o,
	output [6:0] PC_d,
	input [6:0] PB_i,
	output [6:0] PB_o,
	output [6:0] PB_d,
	input [6:0] PA_i,
	output [6:0] PA_o,
	output [6:0] PA_d,
	input JAP_i,
	output JAP_o,
	output JAP_d,
	input FRES_i,
	output FRES_o,
	output FRES_d,
	input ZV_i,
	output ZV_o,
	output ZV_d,
	input VZ_i,
	output VZ_o,
	output VZ_d,
	output [15:0] ZA_i,
	output [15:0] ZA_o,
	output [15:0] ZA_d,
	input SRES,
	input SEL1,
	input CLK_i,
	output CLK_o,
	output CLK_d,
	output SBCR,
	input ZCLK_i,
	output ZCLK_o,
	output ZCLK_d,
	input EDCLK_i,
	output EDCLK_o,
	output EDCLK_d,
	input [15:0] VD_i,
	output [15:0] VD_o,
	output [15:0] VD_d,
	input [22:0] VA_i,
	output [22:0] VA_o,
	output [22:0] VA_d,
	output [15:0] PSG,
	output INT_pull,
	output BR_pull,
	output BGACK_i,
	output BGACK_pull,
	input BG,
	output IPL1_pull,
	output IPL2_pull,
	input IORQ,
	input ZRD_i,
	output ZRD_o,
	output ZRD_d,
	input ZWR_i,
	output ZWR_o,
	output ZWR_d,
	input M1,
	input AS_i,
	output AS_o,
	output AS_d,
	input UDS_i,
	output UDS_o,
	output UDS_d,
	input LDS_i,
	output LDS_o,
	output LDS_d,
	input RW_i,
	output RW_o,
	output RW_d,
	input DTACK_i,
	output DTACK_pull,
	output UWR,
	input LWR_i,
	output LWR_o,
	output LWR_d,
	input CAS0_i,
	output CAS0_o,
	output CAS0_d,
	output RAS0,
	input [7:0] ZD_i,
	output [7:0] ZD_o,
	output [7:0] ZD_d
	);
	
	wire vdp_ys; // w1009
	wire vdp_vsync,
	wire vdp_hsync_pull; // ~l136
	wire vdp_hl;
	wire vdp_clk1_o;
	wire vdp_clk0;
	wire vdp_edclk_o; // mclk_dclk
	wire vdp_edclk_d; // reg_test1[1]
	wire [15:0] vdp_cd_o;
	wire vdp_cd_d; // vdp_data_dir = ~w151 | ext_test_2
	wire [22:0] vdp_ca_o;
	wire vdp_ca_d; // vdp_address_dir = ~w267 | ext_test_2
	wire vdp_br_pull; // ~w42
	wire vdp_bgack_pull; // ~w64
	wire vdp_mreq;
	wire vdp_intak;
	wire vdp_dtack_pull; // ~w117
	wire vdp_lwr;
	wire vdp_oe0;
	wire vdp_cas0;
	wire [7:0] vdp_ra;
	
	ym7101 vdp(
		.MCLK(MCLK),
		.SD(SD),
		.SE1(SE1),
		.SE0(SE0),
		.SC(SC),
		.RAS1(RAS1),
		.CAS1(CAS1),
		.WE1(WE1),
		.WE0(WE0),
		.OE1(OE1),
		.RD_i(RD_i),
		.RD_o(RD_o),
		.RD_d(RD_d),
		.DAC_R(DAC_R),
		.DAC_G(DAC_G),
		.DAC_B(DAC_B),
		.AD_i(AD_i),
		.AD_o(AD_o),
		.AD_d(AD_d),
		.YS(vdp_ys),
		.SPA_B_i(SPA_B_i),
		.SPA_B_pull(SPA_B_pull),
		.VSYNC(vdp_vsync),
		.CSYNC_i(CSYNC_i),
		.CSYNC_pull(CSYNC_pull),
		.HSYNC_i(HSYNC_i),
		.HSYNC_pull(vdp_hsync_pull),
		.HL(vdp_hl),
		.SEL0(M3),
		.PAL(~NTSC),
		.RESET(SRES),
		.CLK1_i(CLK_i),
		.CLK1_o(vdp_clk1_o);
		.SBCR(SBCR),
		.CLK0(vdp_clk0),
		.EDCLK_i(EDCLK_i),
		.EDCLK_o(vdp_edclk_o),
		.EDCLK_d(vdp_edclk_d),
		.CD_i(VD_i),
		.CD_o(vdp_cd_o),
		.CD_d(vdp_cd_d),
		.CA_i(VA_i),
		.CA_o(vdp_ca_o),
		.CA_d(vdp_ca_d),
		.SOUND(PSG),
		.INT_pull(INT_pull),
		.BR_pull(vdp_br_pull),
		.BGACK_i(BGACK_i),
		.BGACK_pull(vdp_bgack_pull),
		.BG(BG),
		.MREQ(vdp_mreq),
		.INTAK(vdp_intak),
		.IPL0_pull(IPL0_pull),
		.IPL1_pull(IPL1_pull),
		.IORQ(IORQ),
		.RD(ZRD_i),
		.WR(ZWR_i),
		.M1(M1),
		.AS(AS_i),
		.UDS(UDS_i),
		.LDS(LDS_i),
		.RW(RW_i),
		.DTACK_i(DTACK_i),
		.DTACK_pull(vdp_dtack_pull),
		.UWR(UWR),
		.LWR(vdp_lwr),
		.OE0(vdp_oe0),
		.CAS0(vdp_cas0),
		.RAS0(RAS0),
		.RA(vdp_ra)
		);
	
	wire fm_clk;
	wire [7:0] fm_data_o;
	wire fm_data_d;
	wire fm_test_o;
	wire fm_test_d; // reg_2c[7]
	wire fm_cs;
	wire fm_irq;
	
	ym3438 fm
		(
		.MCLK(MCLK),
		.PHI(fm_clk),
		.DATA_i(ZD_i),
		.DATA_o(fm_data_o),
		.DATA_o_z(fm_data_d),
		.TEST_i(TEST0_i),
		.TEST_o(fm_test_o),
		.TEST_o_z(fm_test_d),
		.IC(ZRES_i),
		.CS(fm_cs),
		.WR(ZWR_i),
		.RD(ZRD_i),
		.ADDRESS(ZA_i[1:0]),
		.IRQ(fm_irq),
		.MOL(MOL),
		.MOR(MOR)
		);
	
	

	
endmodule
