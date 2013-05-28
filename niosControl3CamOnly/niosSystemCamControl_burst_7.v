//Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//
//Burst adapter parameters:
//adapter is mastered by: cpu_0/data_master
//adapter masters: fp_result/s1
//asp_debug: 0
//byteaddr_width: 6
//ceil_data_width: 32
//data_width: 32
//dbs_shift: 0
//dbs_upstream_burstcount_width: 4
//downstream_addr_shift: 2
//downstream_burstcount_width: 1
//downstream_max_burstcount: 1
//downstream_pipeline: 1
//dynamic_slave: 0
//master_always_burst_max_burst: 0
//master_burst_on_burst_boundaries_only: 1
//master_data_width: 32
//master_interleave: 0
//master_linewrap_bursts: 0
//nativeaddr_width: 4
//slave_always_burst_max_burst: 0
//slave_burst_on_burst_boundaries_only: 0
//slave_interleave: 0
//slave_linewrap_bursts: 0
//upstream_burstcount: upstream_burstcount
//upstream_burstcount_width: 4
//upstream_max_burstcount: 8
//zero_address_width: 0


module niosSystemCamControl_burst_7 (
                                      // inputs:
                                       clk,
                                       downstream_readdata,
                                       downstream_readdatavalid,
                                       downstream_waitrequest,
                                       reset_n,
                                       upstream_address,
                                       upstream_burstcount,
                                       upstream_byteenable,
                                       upstream_debugaccess,
                                       upstream_nativeaddress,
                                       upstream_read,
                                       upstream_write,
                                       upstream_writedata,

                                      // outputs:
                                       reg_downstream_address,
                                       reg_downstream_arbitrationshare,
                                       reg_downstream_burstcount,
                                       reg_downstream_byteenable,
                                       reg_downstream_debugaccess,
                                       reg_downstream_nativeaddress,
                                       reg_downstream_read,
                                       reg_downstream_write,
                                       reg_downstream_writedata,
                                       upstream_readdata,
                                       upstream_readdatavalid,
                                       upstream_waitrequest
                                    )
;

  output  [  3: 0] reg_downstream_address;
  output  [  3: 0] reg_downstream_arbitrationshare;
  output           reg_downstream_burstcount;
  output  [  3: 0] reg_downstream_byteenable;
  output           reg_downstream_debugaccess;
  output  [  3: 0] reg_downstream_nativeaddress;
  output           reg_downstream_read;
  output           reg_downstream_write;
  output  [ 31: 0] reg_downstream_writedata;
  output  [ 31: 0] upstream_readdata;
  output           upstream_readdatavalid;
  output           upstream_waitrequest;
  input            clk;
  input   [ 31: 0] downstream_readdata;
  input            downstream_readdatavalid;
  input            downstream_waitrequest;
  input            reset_n;
  input   [  5: 0] upstream_address;
  input   [  3: 0] upstream_burstcount;
  input   [  3: 0] upstream_byteenable;
  input            upstream_debugaccess;
  input   [  3: 0] upstream_nativeaddress;
  input            upstream_read;
  input            upstream_write;
  input   [ 31: 0] upstream_writedata;

  wire    [  5: 0] current_upstream_address;
  wire    [  3: 0] downstream_address;
  wire    [  3: 0] downstream_arbitrationshare;
  wire             downstream_burstcount;
  wire    [  3: 0] downstream_byteenable;
  wire             downstream_debugaccess;
  wire    [  3: 0] downstream_nativeaddress;
  wire             downstream_read;
  wire             downstream_write;
  wire    [ 31: 0] downstream_writedata;
  reg     [  3: 0] reg_downstream_address;
  reg     [  3: 0] reg_downstream_arbitrationshare;
  reg              reg_downstream_burstcount;
  reg     [  3: 0] reg_downstream_byteenable;
  reg              reg_downstream_debugaccess;
  reg     [  3: 0] reg_downstream_nativeaddress;
  reg              reg_downstream_read;
  reg              reg_downstream_write;
  reg     [ 31: 0] reg_downstream_writedata;
  reg     [  5: 0] registered_upstream_address;
  wire             sync_nativeaddress;
  reg     [  2: 0] transactions_remaining;
  reg     [ 31: 0] upstream_readdata;
  reg              upstream_readdatavalid;
  wire             upstream_waitrequest;
  assign sync_nativeaddress = |upstream_nativeaddress;
  //downstream, which is an e_avalon_master
  //upstream, which is an e_avalon_slave
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_upstream_address <= 0;
      else if (~|transactions_remaining)
          registered_upstream_address <= upstream_address;
    end


  assign current_upstream_address = ~|transactions_remaining ? upstream_address : registered_upstream_address;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          transactions_remaining <= 0;
      else 
        transactions_remaining <= (upstream_read & ~upstream_waitrequest) ? (upstream_burstcount - 1) : (downstream_read & ~downstream_waitrequest & (|transactions_remaining)) ? (transactions_remaining - downstream_burstcount) : transactions_remaining;
    end


  assign downstream_burstcount = 1;
  assign downstream_arbitrationshare = upstream_burstcount;
  assign downstream_address = current_upstream_address;
  assign downstream_nativeaddress = upstream_nativeaddress;
  assign downstream_read = upstream_read | (|transactions_remaining);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          upstream_readdatavalid <= 0;
      else 
        upstream_readdatavalid <= downstream_readdatavalid;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          upstream_readdata <= 0;
      else 
        upstream_readdata <= downstream_readdata;
    end


  assign downstream_write = upstream_write & !downstream_read;
  assign downstream_byteenable = upstream_byteenable;
  assign downstream_writedata = upstream_writedata;
  assign upstream_waitrequest = downstream_waitrequest | (|transactions_remaining);
  assign downstream_debugaccess = upstream_debugaccess;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_address <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_address <= downstream_address;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_arbitrationshare <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_arbitrationshare <= downstream_arbitrationshare;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_burstcount <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_burstcount <= downstream_burstcount;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_byteenable <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_byteenable <= downstream_byteenable;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_debugaccess <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_debugaccess <= downstream_debugaccess;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_nativeaddress <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_nativeaddress <= downstream_nativeaddress;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_read <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_read <= downstream_read;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_write <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_write <= downstream_write;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          reg_downstream_writedata <= 0;
      else if (~downstream_waitrequest)
          reg_downstream_writedata <= downstream_writedata;
    end



endmodule

