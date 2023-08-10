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
	input MCLK,
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
	input [7:0] AD_i,
	output [7:0] AD_o,
	output AD_d,
	output [7:0] DAC_R,
	output [7:0] DAC_G,
	output [7:0] DAC_B,
	output YS,
	input SPA_B_i,
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
	output MREQ_o,
	output MREQ_d,
	output [8:0] MOL, MOR,
	output [9:0] MOL_2612, MOR_2612,
	input SOUND_i,
	output SOUND_o,
	output SOUND_d,
	input ZRES_i,
	output ZRES_o,
	output ZRES_d,
	input ZBAK,
	output NMI,
	input ZBR_i,
	output ZBR_o,
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
	input IO_i,
	output IO_o,
	output IO_d,
	input [15:0] ZA_i,
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
	input BGACK_i,
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
	output [7:0] ZD_d,
	output vdp_hclk1,
	output vdp_intfield,
	output vdp_de_h,
	output vdp_de_v,
	output vdp_m5, // md mode
	output vdp_rs1, // h32/h40
	output vdp_m2, // v28/v30
	output vdp_lcb,
	output vdp_psg_clk1,
	output fm_clk1
	);
	
	wire vdp_ys; // w1009
	wire vdp_vsync;
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
	wire vdp_oe0;
	wire vdp_cas0;
	wire [7:0] vdp_ra;
	
	wire fm_clk;
	wire [7:0] fm_data_o;
	wire fm_data_d;
	wire fm_data_d2;
	wire fm_test_d; // reg_2c[7]
	wire fm_cs;
	wire fm_irq;
	
	wire arb_oe0;
	wire arb_vd8_o;
	wire arb_za0_o;
	wire [15:8] arb_za_o;
	wire [22:7] arb_va_o;
	wire arb_bgack_o;
	wire arb_strobe_dir;
	wire arb_dtack_o;
	wire arb_br;
	wire arb_ce0;
	wire arb_wait_o;
	wire arb_zbr;
	wire arb_sound;
	wire arb_vz;
	wire arb_vres;
	wire arb_vdpm;
	wire arb_io;
	wire arb_zv;
	wire arb_intak;
	wire arb_edclk;
	wire arb_vtoz;
	wire arb_w12;
	wire arb_w131;
	wire arb_w142;
	wire arb_w310;
	wire arb_w353;
	
	wire ioc_io;
	wire ioc_zv;
	wire ioc_vz;
	wire ioc_hl;
	wire ioc_fres;
	wire ioc_bc1;
	wire ioc_bc2;
	wire ioc_bc3;
	wire ioc_bc4;
	wire ioc_bc5;
	wire [7:0] ioc_vdata;
	wire ioc_reg_3e_q;
	wire [7:0] ioc_zdata;
	wire [6:0] ioc_ztov_address;
	
	wire tmss_test_0;
	wire tmss_test_1;
	wire tmss_test_2;
	wire tmss_test_3;
	wire tmss_test_4;
	
	wire no_tmss_flag;
	
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
		.CLK1_o(vdp_clk1_o),
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
		.IPL1_pull(IPL1_pull),
		.IPL2_pull(IPL2_pull),
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
		.LWR(LWR_o),
		.OE0(vdp_oe0),
		.CAS0(vdp_cas0),
		.RAS0(RAS0),
		.RA(vdp_ra),
		.ext_test_2(tmss_test_2),
		.vdp_hclk1(vdp_hclk1),
		.vdp_intfield(vdp_intfield),
		.vdp_de_h(vdp_de_h),
		.vdp_de_v(vdp_de_v),
		.vdp_m5(vdp_m5),
		.vdp_rs1(vdp_rs1),
		.vdp_m2(vdp_m2),
		.vdp_lcb(vdp_lcb),
		.vdp_psg_clk1(vdp_psg_clk1)
		);
	
	ym3438 fm
		(
		.MCLK(MCLK),
		.PHI(fm_clk),
		.DATA_i(ZD_i),
		.DATA_o(fm_data_o),
		.DATA_o_z(fm_data_d),
		.TEST_i(TEST0_i),
		.TEST_o(TEST0_o),
		.TEST_o_z(fm_test_d),
		.IC(ZRES_i),
		.CS(fm_cs),
		.WR(ZWR_i),
		.RD(ZRD_i),
		.ADDRESS(ZA_i[1:0]),
		.IRQ(fm_irq),
		.MOL(MOL),
		.MOR(MOR),
		.MOL_2612(MOL_2612),
		.MOR_2612(MOR_2612),
		.fm_clk1(fm_clk1)
		);
	
	
	assign AS_d = arb_strobe_dir;
	assign UDS_d = arb_strobe_dir;
	assign LDS_d = arb_strobe_dir;
	assign WAIT_pull = ~arb_wait_o;
	assign SOUND_o = arb_sound;
	
	ym6045 arb
		(
		.MCLK(MCLK),
		.VCLK(CLK_i),
		.ZCLK(ZCLK_i),
		.VD8_i(VD_i[8]),
		.ZA_i(ZA_i[15:7]),
		.ZA0_i(ZA_i[0]),
		.VA_i(VA_i[22:7]),
		.ZRD_i(ZRD_i),
		.M1(M1),
		.ZWR_i(ZWR_i),
		.BGACK_i(BGACK_i),
		.BG(BG),
		.IORQ(IORQ),
		.RW_i(RW_i),
		.UDS_i(UDS_i),
		.AS_i(AS_i),
		.DTACK_i(DTACK_i),
		.LDS_i(LDS_i),
		.CAS0(CAS0_i),
		.M3(M3),
		.WRES(WRES),
		.CART(CART),
		.OE0(arb_oe0),
		.WAIT_i(WAIT_i),
		.ZBAK(ZBAK),
		.MREQ_i(MREQ_i),
		.FC0(FC0),
		.FC1(FC1),
		.SRES(SRES),
		.test_mode_0(tmss_test_0),
		.ZD0_i(ZD_i[0]),
		.HSYNC(HSYNC_i),
		.VD8_o(arb_vd8_o),
		.ZA0_o(arb_za0_o),
		.ZA_o(arb_za_o),
		.VA_o(arb_va_o),
		.ZRD_o(ZRD_o),
		.UDS_o(UDS_o),
		.ZWR_o(ZWR_o),
		.BGACK_o(arb_bgack_o),
		.AS_o(AS_o),
		.RW_d(RW_d),
		.RW_o(RW_o),
		.LDS_o(LDS_o),
		.strobe_dir(arb_strobe_dir),
		.DTACK_o(arb_dtack_o),
		.BR(arb_br),
		.IA14(IA14),
		.TIME(TIME),
		.CE0(arb_ce0),
		.FDWR(FDWR),
		.FDC(FDC),
		.ROM(ROM),
		.ASEL(ASEL),
		.EOE(EOE),
		.NOE(NOE),
		.RAS2(RAS2),
		.CAS2(CAS2),
		.REF(REF),
		.ZRAM(ZRAM),
		.WAIT_o(arb_wait_o),
		.ZBR(arb_zbr),
		.NMI(NMI),
		.ZRES(ZRES_o),
		.SOUND(arb_sound),
		.VZ(arb_vz),
		.MREQ_o(MREQ_o),
		.VRES(arb_vres),
		.VPA(VPA),
		.VDPM(arb_vdpm),
		.IO(arb_io),
		.ZV(arb_zv),
		.INTAK(arb_intak),
		.EDCLK(arb_edclk),
		.vtoz(arb_vtoz),
		.w12(arb_w12),
		.w131(arb_w131),
		.w142(arb_w142),
		.w310(arb_w310),
		.w353(arb_w353)
		);
	
	ym6046 ioc
		(
		.MCLK(MCLK),
		.PORT_A_i(PA_i),
		.PORT_B_i(PB_i),
		.PORT_C_i(PC_i),
		.test(TEST0_i),
		.M3(M3),
		.IO(ioc_io),
		.CAS0(CAS0_i),
		.SRES(SRES),
		.VCLK(CLK_i),
		.NTSC(NTSC),
		.DISK(DISK_i),
		.JAP(JAP_i),
		.ZA_i(ZA_i[7:0]),
		.ZD_i(ZD_i),
		.VA_i(VA_i[6:0]),
		.VD_i(VD_i),
		.LWR(LWR_i),
		.t1(tmss_test_1),
		.ZV(ioc_zv),
		.VZ(ioc_vz),
		.PORT_A_d(PA_d),
		.PORT_B_d(PB_d),
		.PORT_C_d(PC_d),
		.PORT_A_o(PA_o),
		.PORT_B_o(PB_o),
		.PORT_C_o(PC_o),
		.HL(ioc_hl),
		.FRES(ioc_fres),
		.bc1(ioc_bc1),
		.bc2(ioc_bc2),
		.bc3(ioc_bc3),
		.bc4(ioc_bc4),
		.bc5(ioc_bc5),
		.vdata(ioc_vdata),
		.reg_3e_q(ioc_reg_3e_q),
		.zdata(ioc_zdata),
		.ztov_address(ioc_ztov_address),
		.no_tmss_flag(no_tmss_flag)
		);
	
	wire tmss_ce0_i;
	wire [15:0] tmss_vd_o;
	wire tmss_dtack;
	wire tmss_reset;
	wire tmss_ce0_o;
	wire tmss_data_out_en;

	tmss tmss_
		(
		.MCLK(MCLK),
		.VD_i(VD_i),
		.test({ TEST3, TEST2, TEST1 }),
		.JAP(JAP_i),
		.AS(AS_i),
		.LDS(LDS_i),
		.UDS(UDS_i),
		.RW(RW_i),
		.VA(VA_i),
		.SRES(SRES),
		.CE0_i(tmss_ce0_i),
		.M3(M3),
		.CART(CART),
		.INTAK(vdp_intak),
		.VD_o(tmss_vd_o),
		.DTACK(tmss_dtack),
		.RESET(tmss_reset),
		.CE0_o(tmss_ce0_o),
		.test_0(tmss_test_0),
		.test_1(tmss_test_1),
		.test_2(tmss_test_2),
		.test_3(tmss_test_3),
		.test_4(tmss_test_4),
		.data_out_en(tmss_data_out_en),
		.no_tmss_flag(no_tmss_flag)
		);
	
	assign ZA_o[0] = arb_za0_o;
	assign ZA_o[7:1] = VA_i[6:0];
	assign ZA_o[15:8] = arb_vtoz ? 8'h0 : arb_za_o[15:8];
	
	assign ZA_d[0] = (tmss_test_1 ^ tmss_test_3) | arb_vz;
	assign ZA_d[1] = (tmss_test_1 & ~tmss_test_3) | ioc_bc1;
	assign ZA_d[6:2] = {5{ioc_bc1}};
	assign ZA_d[7] = (tmss_test_1 & tmss_test_3) | ioc_bc1;
	assign ZA_d[15:8] = {8{arb_vz}};
	
	assign VA_o =
		(vdp_ca_d ? 23'h0 : vdp_ca_o) |
		(arb_w131 ? 23'h0 : { 3'h0, arb_va_o[19:7], 7'h0 }) |
		(arb_w142 ? 23'h0 : { arb_va_o[22:20], 20'h0 }) |
		(ioc_bc5 ? 23'h0 : { 16'h0, ioc_ztov_address });
	
	assign VA_d =
		((vdp_ca_d & arb_w142) ? 23'h700000 : 23'h0) |
		((vdp_ca_d & arb_w131) ? 23'hfff80 : 23'h0) |
		((vdp_ca_d & ioc_bc5) ? 23'h7f : 23'h0);
	
	wire colorbus = ~(tmss_test_1 & tmss_test_2 & tmss_test_3);
	
	assign fm_data_d2 = fm_data_d | tmss_test_3;
	
	assign ZD_o =
		(ioc_bc4 ? 8'h0 : ioc_zdata) |
		(colorbus ? 8'h0 : vdp_ra) |
		(fm_data_d2 ? 8'h0 : fm_data_o);
	
	assign ZD_d = (ioc_bc4 & colorbus & fm_data_d2) ? 8'hff : 8'h0;
	
	wire [15:0] ioc_vdata_word = { ioc_vdata[7:1], M3 ? ioc_vdata[0] : ioc_reg_3e_q, ioc_vdata[7:0] };
	
	assign VD_o =
		(vdp_cd_d ? 16'h0 : vdp_cd_o) |
		(arb_w12 ? 16'h0 : { 7'h0, arb_vd8_o, 8'h0 }) |
		(ioc_bc2 ? 16'h0 : { 8'h0, ioc_vdata_word[7:0] }) |
		(ioc_bc3 ? 16'h0 : {ioc_vdata_word[15:8], 8'h0 }) |
		(tmss_data_out_en ? 16'h0 : tmss_vd_o);
	
	assign VD_d = { {7{vdp_cd_d & ioc_bc3 & tmss_data_out_en}}, vdp_cd_d & ioc_bc3 & tmss_data_out_en & arb_w12, {8{vdp_cd_d & ioc_bc2 & tmss_data_out_en}} };
	
	assign YS = tmss_test_2 ? arb_w353 : vdp_ys;
	assign VSYNC = tmss_test_2 ? arb_w310 : vdp_vsync;
	assign HSYNC_pull = vdp_hsync_pull & ~tmss_test_2;
	wire cpu_reset = (tmss_test_0 | arb_vres) & tmss_reset;
	assign HALT_pull = ~cpu_reset;
	assign RESET_pull = ~cpu_reset;
	assign MREQ_d = arb_vz;
	assign SOUND_d = tmss_test_0;
	assign ZRES_d = tmss_test_0;
	assign ZBR_o = tmss_test_0 ? vdp_hl : arb_zbr;
	assign ZBR_d = tmss_test_0 & tmss_test_1;
	assign CE0 = tmss_test_4 ? tmss_ce0_i : tmss_ce0_o;
	assign DISK_o = vdp_intak;
	assign DISK_d = ~tmss_test_2 | tmss_test_0;
	assign TEST0_d = fm_test_d | tmss_test_3;
	assign JAP_o = arb_oe0;
	assign JAP_d = ~(tmss_test_0 & ~tmss_test_2);
	assign FRES_o = tmss_test_1 ? vdp_mreq : ioc_fres;
	assign FRES_d = tmss_test_0 & ~tmss_test_1;
	assign ZV_o = arb_zv;
	assign ZV_d = tmss_test_0;
	assign VZ_o = arb_vz;
	assign VZ_d = tmss_test_0;
	assign IO_o = arb_io;
	assign IO_d = tmss_test_0;
	assign CLK_o = vdp_clk1_o;
	assign CLK_d = tmss_test_2 | SEL1;
	assign ZCLK_o = vdp_clk0;
	assign ZCLK_d = tmss_test_2;
	assign EDCLK_o = (tmss_test_0 & ~tmss_test_2) ? vdp_edclk_o : arb_edclk;
	assign EDCLK_d = tmss_test_0 & (tmss_test_2 | ~vdp_edclk_d);
	wire br = 
		((tmss_test_0 & tmss_test_2) ? (fm_irq | tmss_test_3) : 1'h1) &
		(~tmss_test_0 ? arb_br : 1'h1) &
		(~tmss_test_2 ? ~vdp_br_pull : 1'h1);
	assign BR_pull = ~br;
	wire bgack = arb_bgack_o & (tmss_test_2 | ~vdp_bgack_pull);
	assign BGACK_pull = ~bgack;
	assign ZRD_d = arb_vz;
	assign ZWR_d = arb_vz;
	wire dtack = arb_dtack_o & tmss_dtack & (tmss_test_2 | ~vdp_dtack_pull);
	assign DTACK_pull = ~dtack;
	assign CAS0_o = vdp_cas0;
	assign CAS0_d = tmss_test_2;
	assign LWR_d = tmss_test_2;
	
	assign vdp_hl = tmss_test_1 ? ZBR_i : ioc_hl;
	assign vdp_intak = tmss_test_0 ? DISK_i : arb_intak;
	assign arb_oe0 = (~tmss_test_0 & tmss_test_2) ? JAP_i : vdp_oe0;
	assign vdp_mreq = tmss_test_0 ? FRES_i : arb_vdpm;
	assign ioc_vz = tmss_test_0 ? VZ_i : arb_vz;
	assign ioc_zv = tmss_test_0 ? ZV_i : arb_zv;
	assign ioc_io = tmss_test_0 ? IO_i : arb_io;
	assign tmss_ce0_i = tmss_test_0 ? SEL1 : arb_ce0;
	
	assign fm_clk = tmss_test_2 ? CLK_i : vdp_clk1_o;
	assign fm_cs = tmss_test_0 ? SOUND_i : arb_sound;
	
endmodule
