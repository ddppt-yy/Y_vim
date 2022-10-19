//-------------------------------------------------------------------------------
// Created by		: BELLING
// Filename			: crg.v
// Author			: yanhai/8913
// Created On		: 2021-12-20 15:12
// Last Modified	: 2022-10-19 19:02
// Version			: v1.0
// Description		: 
//						
//						
//-------------------------------------------------------------------------------

// `timescale 1ns / 1ps


module CRG
//********************
//parameter
//********************
// #(  parameter   A   =   1,
//     parameter   B   =   0
// )
//********************
//port
//********************
(
    //input
    input                           clk        , 
    input                           por        , 
    input                           por_rst    , 
    input                           ana_rx_rst , 
    input                           rx         , 
    input                           cfg_clk_close, 
    input                           init_err_cnt_flg,
    //output
    output                          init_cnt_flg         , // 1:cnt ne 0; 0:cnt eq 0;
    output                          clk_flg              , // note:  1.open clock 0.close clock
    output                          fuse_auto_load_start , 
    output                          rst_n                  
);
//********************
//localparam
//********************
// localparam  A   =   1;
// localparam  B   =   1;
//********************
//wire
//********************
wire                    por_dly;
wire                    rx_high;
wire                    cnt_flg;
//********************
//reg
//********************
reg                     rx_high_tmp;
reg [10-1    :0]        cnt1023     ;
//********************
//main code
//********************
//rst_n
assign rst_n = ~(por_rst | ana_rx_rst);

//por_dly //this will change when stdcell config
assign por_dly = por;

//rx_high
// always @(posedge clk or negedge rst_n) begin 
//   if (rst_n == 1'b0) begin
//       rx_high_tmp <= `U_DLY 1'b0; 
//   end
//   else if (rx == 1'b0) begin
//       rx_high_tmp <= `U_DLY 1'b1; 
//   end
//   else;
// end
// assign rx_high = (~rx) | rx_high_tmp;

//get rx posedge and negedge
reg rx_dly;
wire rx_pos;
wire rx_neg;
always @(posedge clk or negedge rst_n) begin 
    if (rst_n == 1'b0) begin
        rx_dly <= `U_DLY 1'b0;
    end
    else begin
        rx_dly <= `U_DLY rx;
    end
end
assign rx_pos =   rx  & (~rx_dly);
assign rx_neg = (~rx) &   rx_dly ;
always @(posedge clk or negedge rst_n) begin 
    if (rst_n == 1'b0) begin
        rx_high_tmp <= `U_DLY 1'b0;
    end
    else if (rx_pos == 1'b1 || rx_neg == 1'b1) begin
        rx_high_tmp <= `U_DLY 1'b1;
    end
    else;
end
assign rx_high = rx_high_tmp


//cnt1023
always @(posedge clk or negedge rst_n) begin 
  if (rst_n == 1'b0) begin
      cnt1023 <= `U_DLY 10'd0; 
  end
  else if (init_err_cnt_flg == 1'b1) begin
      cnt1023 <= `U_DLY 10'd511; 
  end
  else if (cfg_clk_close == 1'b1) begin
      cnt1023 <= `U_DLY 10'd1023; 
  end
  else if (rx_high == 1'b1) begin
      cnt1023 <= `U_DLY 10'd0; 
  end
  else if (cnt1023 == 10'd1023) begin
      cnt1023 <= `U_DLY 10'd1023; 
  end
  else begin
      cnt1023 <= `U_DLY 10'd1 + cnt1023; 
  end
end

//cnt flg    1.open clock 0.close clock
assign cnt_flg = (cnt1023 == 10'd1023) ? 1'b0 : 1'b1;

assign clk_flg = (por_dly & cnt_flg) ^ por_rst;

// fuse_auto_load_start
assign fuse_auto_load_start = (cnt1023[9] == 1'b1) ? 1'b1 : 1'b0;

assign init_cnt_flg = (cnt1023 != 10'd0) ? 1'b1 : 1'b0; // 1:cnt ne 0; 0:cnt eq 0;



endmodule

//********************
//change log
//********************
//  date        modify
//  xx          xx
//



