//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


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

module cpu_0_jtag_debug_module_arbitrator (
                                            // inputs:
                                             clk,
                                             cpu_0_data_master_address_to_slave,
                                             cpu_0_data_master_byteenable,
                                             cpu_0_data_master_debugaccess,
                                             cpu_0_data_master_read,
                                             cpu_0_data_master_waitrequest,
                                             cpu_0_data_master_write,
                                             cpu_0_data_master_writedata,
                                             cpu_0_instruction_master_address_to_slave,
                                             cpu_0_instruction_master_read,
                                             cpu_0_jtag_debug_module_readdata,
                                             cpu_0_jtag_debug_module_resetrequest,
                                             reset_n,

                                            // outputs:
                                             cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                             cpu_0_jtag_debug_module_address,
                                             cpu_0_jtag_debug_module_begintransfer,
                                             cpu_0_jtag_debug_module_byteenable,
                                             cpu_0_jtag_debug_module_chipselect,
                                             cpu_0_jtag_debug_module_debugaccess,
                                             cpu_0_jtag_debug_module_readdata_from_sa,
                                             cpu_0_jtag_debug_module_resetrequest_from_sa,
                                             cpu_0_jtag_debug_module_write,
                                             cpu_0_jtag_debug_module_writedata,
                                             d1_cpu_0_jtag_debug_module_end_xfer
                                          )
;

  output           cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  output           cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  output  [  8: 0] cpu_0_jtag_debug_module_address;
  output           cpu_0_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_0_jtag_debug_module_byteenable;
  output           cpu_0_jtag_debug_module_chipselect;
  output           cpu_0_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  output           cpu_0_jtag_debug_module_resetrequest_from_sa;
  output           cpu_0_jtag_debug_module_write;
  output  [ 31: 0] cpu_0_jtag_debug_module_writedata;
  output           d1_cpu_0_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_debugaccess;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata;
  input            cpu_0_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_allgrants;
  wire             cpu_0_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_0_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_0_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_addend;
  wire             cpu_0_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_0_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_0_jtag_debug_module_arb_winner;
  wire             cpu_0_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_0_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_0_jtag_debug_module_begins_xfer;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_0_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_0_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire             cpu_0_jtag_debug_module_end_xfer;
  wire             cpu_0_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_0_jtag_debug_module_grant_vector;
  wire             cpu_0_jtag_debug_module_in_a_read_cycle;
  wire             cpu_0_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_0_jtag_debug_module_master_qreq_vector;
  wire             cpu_0_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  reg              cpu_0_jtag_debug_module_reg_firsttransfer;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_0_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_0_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_0_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_0_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_0_jtag_debug_module_waits_for_read;
  wire             cpu_0_jtag_debug_module_waits_for_write;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  reg              d1_cpu_0_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master;
  wire             wait_for_cpu_0_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_0_jtag_debug_module_end_xfer;
    end


  assign cpu_0_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module));
  //assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_readdata_from_sa = cpu_0_jtag_debug_module_readdata;

  assign cpu_0_data_master_requests_cpu_0_jtag_debug_module = ({cpu_0_data_master_address_to_slave[24 : 11] , 11'b0} == 25'h1108800) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //cpu_0_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_0_jtag_debug_module_arb_share_set_values = 1;

  //cpu_0_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_0_jtag_debug_module_non_bursting_master_requests = cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module |
    cpu_0_data_master_requests_cpu_0_jtag_debug_module |
    cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_0_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_0_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_share_counter_next_value = cpu_0_jtag_debug_module_firsttransfer ? (cpu_0_jtag_debug_module_arb_share_set_values - 1) : |cpu_0_jtag_debug_module_arb_share_counter ? (cpu_0_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_0_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_0_jtag_debug_module_allgrants = (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector) |
    (|cpu_0_jtag_debug_module_grant_vector);

  //cpu_0_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_end_xfer = ~(cpu_0_jtag_debug_module_waits_for_read | cpu_0_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_end_xfer & (~cpu_0_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_0_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_0_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & cpu_0_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests);

  //cpu_0_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_0_jtag_debug_module_arb_counter_enable)
          cpu_0_jtag_debug_module_arb_share_counter <= cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_0_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_0_jtag_debug_module & ~cpu_0_jtag_debug_module_non_bursting_master_requests))
          cpu_0_jtag_debug_module_slavearbiterlockenable <= |cpu_0_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //cpu_0_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_0_jtag_debug_module_slavearbiterlockenable2 = |cpu_0_jtag_debug_module_arb_share_counter_next_value;

  //cpu_0/data_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master cpu_0/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = cpu_0_jtag_debug_module_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_0_jtag_debug_module_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_data_master_requests_cpu_0_jtag_debug_module & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_0_jtag_debug_module_writedata = cpu_0_data_master_writedata;

  assign cpu_0_instruction_master_requests_cpu_0_jtag_debug_module = (({cpu_0_instruction_master_address_to_slave[24 : 11] , 11'b0} == 25'h1108800) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted cpu_0/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module <= cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module ? 1 : (cpu_0_jtag_debug_module_arbitration_holdoff_internal | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) ? 0 : last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_cpu_0_jtag_debug_module & cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  assign cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module = cpu_0_instruction_master_requests_cpu_0_jtag_debug_module & ~(cpu_0_data_master_arbiterlock);
  //allow new arb cycle for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/instruction_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[0];

  //cpu_0/instruction_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[0] && cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/data_master assignment into master qualified-requests vector for cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_jtag_debug_module_master_qreq_vector[1] = cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;

  //cpu_0/data_master grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_granted_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_grant_vector[1];

  //cpu_0/data_master saved-grant cpu_0/jtag_debug_module, which is an e_assign
  assign cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module = cpu_0_jtag_debug_module_arb_winner[1] && cpu_0_data_master_requests_cpu_0_jtag_debug_module;

  //cpu_0/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_double_vector = {cpu_0_jtag_debug_module_master_qreq_vector, cpu_0_jtag_debug_module_master_qreq_vector} & ({~cpu_0_jtag_debug_module_master_qreq_vector, ~cpu_0_jtag_debug_module_master_qreq_vector} + cpu_0_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_0_jtag_debug_module_arb_winner = (cpu_0_jtag_debug_module_allow_new_arb_cycle & | cpu_0_jtag_debug_module_grant_vector) ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_0_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_0_jtag_debug_module_allow_new_arb_cycle)
          cpu_0_jtag_debug_module_saved_chosen_master_vector <= |cpu_0_jtag_debug_module_grant_vector ? cpu_0_jtag_debug_module_grant_vector : cpu_0_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_0_jtag_debug_module_grant_vector = {(cpu_0_jtag_debug_module_chosen_master_double_vector[1] | cpu_0_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_0_jtag_debug_module_chosen_master_double_vector[0] | cpu_0_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu_0/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_0_jtag_debug_module_chosen_master_rot_left = (cpu_0_jtag_debug_module_arb_winner << 1) ? (cpu_0_jtag_debug_module_arb_winner << 1) : 1;

  //cpu_0/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_0_jtag_debug_module_grant_vector)
          cpu_0_jtag_debug_module_arb_addend <= cpu_0_jtag_debug_module_end_xfer? cpu_0_jtag_debug_module_chosen_master_rot_left : cpu_0_jtag_debug_module_grant_vector;
    end


  assign cpu_0_jtag_debug_module_begintransfer = cpu_0_jtag_debug_module_begins_xfer;
  //assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_jtag_debug_module_resetrequest_from_sa = cpu_0_jtag_debug_module_resetrequest;

  assign cpu_0_jtag_debug_module_chipselect = cpu_0_data_master_granted_cpu_0_jtag_debug_module | cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  //cpu_0_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_firsttransfer = cpu_0_jtag_debug_module_begins_xfer ? cpu_0_jtag_debug_module_unreg_firsttransfer : cpu_0_jtag_debug_module_reg_firsttransfer;

  //cpu_0_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_0_jtag_debug_module_unreg_firsttransfer = ~(cpu_0_jtag_debug_module_slavearbiterlockenable & cpu_0_jtag_debug_module_any_continuerequest);

  //cpu_0_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_0_jtag_debug_module_begins_xfer)
          cpu_0_jtag_debug_module_reg_firsttransfer <= cpu_0_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_0_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_0_jtag_debug_module_beginbursttransfer_internal = cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_0_jtag_debug_module_arbitration_holdoff_internal = cpu_0_jtag_debug_module_begins_xfer & cpu_0_jtag_debug_module_firsttransfer;

  //cpu_0_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_0_jtag_debug_module_write = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //cpu_0_jtag_debug_module_address mux, which is an e_mux
  assign cpu_0_jtag_debug_module_address = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_data_master >> 2) :
    (shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_cpu_0_jtag_debug_module_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_cpu_0_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_0_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_0_jtag_debug_module_end_xfer <= cpu_0_jtag_debug_module_end_xfer;
    end


  //cpu_0_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_read = cpu_0_jtag_debug_module_in_a_read_cycle & cpu_0_jtag_debug_module_begins_xfer;

  //cpu_0_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_read_cycle = (cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_0_jtag_debug_module_in_a_read_cycle;

  //cpu_0_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_0_jtag_debug_module_waits_for_write = cpu_0_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_0_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_0_jtag_debug_module_in_a_write_cycle = cpu_0_data_master_granted_cpu_0_jtag_debug_module & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_0_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_0_jtag_debug_module_counter = 0;
  //cpu_0_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_0_jtag_debug_module_byteenable = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_0_jtag_debug_module_debugaccess = (cpu_0_data_master_granted_cpu_0_jtag_debug_module)? cpu_0_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_cpu_0_jtag_debug_module + cpu_0_instruction_master_granted_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_cpu_0_jtag_debug_module + cpu_0_instruction_master_saved_grant_cpu_0_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_custom_instruction_master_arbitrator (
                                                    // inputs:
                                                     clk,
                                                     cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa,
                                                     cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa,
                                                     cpu_0_custom_instruction_master_start,
                                                     reset_n,

                                                    // outputs:
                                                     cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select,
                                                     cpu_0_custom_instruction_master_done,
                                                     cpu_0_custom_instruction_master_reset_n,
                                                     cpu_0_custom_instruction_master_result,
                                                     cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1
                                                  )
;

  output           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select;
  output           cpu_0_custom_instruction_master_done;
  output           cpu_0_custom_instruction_master_reset_n;
  output  [ 31: 0] cpu_0_custom_instruction_master_result;
  output           cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1;
  input            clk;
  input            cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;
  input   [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;
  input            cpu_0_custom_instruction_master_start;
  input            reset_n;

  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select;
  wire             cpu_0_custom_instruction_master_done;
  wire             cpu_0_custom_instruction_master_reset_n;
  wire    [ 31: 0] cpu_0_custom_instruction_master_result;
  wire             cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select = 1'b1;
  assign cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1 = cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select & cpu_0_custom_instruction_master_start;
  //cpu_0_custom_instruction_master_result mux, which is an e_mux
  assign cpu_0_custom_instruction_master_result = {32 {cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select}} & cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;

  //multi_done mux, which is an e_mux
  assign cpu_0_custom_instruction_master_done = {1 {cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select}} & cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;

  //cpu_0_custom_instruction_master_reset_n local reset_n, which is an e_assign
  assign cpu_0_custom_instruction_master_reset_n = reset_n;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_data_master_arbitrator (
                                      // inputs:
                                       clk,
                                       cpu_0_data_master_address,
                                       cpu_0_data_master_byteenable_sdram_0_s1,
                                       cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0,
                                       cpu_0_data_master_granted_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_granted_onchip_memory2_0_s1,
                                       cpu_0_data_master_granted_procHasControl_s1,
                                       cpu_0_data_master_granted_sdram_0_s1,
                                       cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0,
                                       cpu_0_data_master_granted_sysid_control_slave,
                                       cpu_0_data_master_granted_timer_0_s1,
                                       cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                       cpu_0_data_master_qualified_request_procHasControl_s1,
                                       cpu_0_data_master_qualified_request_sdram_0_s1,
                                       cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0,
                                       cpu_0_data_master_qualified_request_sysid_control_slave,
                                       cpu_0_data_master_qualified_request_timer_0_s1,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                       cpu_0_data_master_read_data_valid_procHasControl_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1,
                                       cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                       cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0,
                                       cpu_0_data_master_read_data_valid_sysid_control_slave,
                                       cpu_0_data_master_read_data_valid_timer_0_s1,
                                       cpu_0_data_master_requests_cpu_0_jtag_debug_module,
                                       cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                       cpu_0_data_master_requests_onchip_memory2_0_s1,
                                       cpu_0_data_master_requests_procHasControl_s1,
                                       cpu_0_data_master_requests_sdram_0_s1,
                                       cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0,
                                       cpu_0_data_master_requests_sysid_control_slave,
                                       cpu_0_data_master_requests_timer_0_s1,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       cpu_0_jtag_debug_module_readdata_from_sa,
                                       d1_cpu_0_jtag_debug_module_end_xfer,
                                       d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                       d1_onchip_memory2_0_s1_end_xfer,
                                       d1_procHasControl_s1_end_xfer,
                                       d1_sdram_0_s1_end_xfer,
                                       d1_sram_16bit_512k_0_avalon_slave_0_end_xfer,
                                       d1_sysid_control_slave_end_xfer,
                                       d1_timer_0_s1_end_xfer,
                                       jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                       jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                       onchip_memory2_0_s1_readdata_from_sa,
                                       procHasControl_s1_readdata_from_sa,
                                       registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                       reset_n,
                                       sdram_0_s1_readdata_from_sa,
                                       sdram_0_s1_waitrequest_from_sa,
                                       sram_16bit_512k_0_avalon_slave_0_readdata_from_sa,
                                       sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0,
                                       sysid_control_slave_readdata_from_sa,
                                       timer_0_s1_irq_from_sa,
                                       timer_0_s1_readdata_from_sa,

                                      // outputs:
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_dbs_address,
                                       cpu_0_data_master_dbs_write_16,
                                       cpu_0_data_master_irq,
                                       cpu_0_data_master_no_byte_enables_and_last_term,
                                       cpu_0_data_master_readdata,
                                       cpu_0_data_master_waitrequest
                                    )
;

  output  [ 24: 0] cpu_0_data_master_address_to_slave;
  output  [  1: 0] cpu_0_data_master_dbs_address;
  output  [ 15: 0] cpu_0_data_master_dbs_write_16;
  output  [ 31: 0] cpu_0_data_master_irq;
  output           cpu_0_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_0_data_master_readdata;
  output           cpu_0_data_master_waitrequest;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address;
  input   [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  input   [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_granted_onchip_memory2_0_s1;
  input            cpu_0_data_master_granted_procHasControl_s1;
  input            cpu_0_data_master_granted_sdram_0_s1;
  input            cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_data_master_granted_sysid_control_slave;
  input            cpu_0_data_master_granted_timer_0_s1;
  input            cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_data_master_qualified_request_procHasControl_s1;
  input            cpu_0_data_master_qualified_request_sdram_0_s1;
  input            cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_data_master_qualified_request_sysid_control_slave;
  input            cpu_0_data_master_qualified_request_timer_0_s1;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_data_master_read_data_valid_procHasControl_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1;
  input            cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_data_master_read_data_valid_sysid_control_slave;
  input            cpu_0_data_master_read_data_valid_timer_0_s1;
  input            cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  input            cpu_0_data_master_requests_onchip_memory2_0_s1;
  input            cpu_0_data_master_requests_procHasControl_s1;
  input            cpu_0_data_master_requests_sdram_0_s1;
  input            cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_data_master_requests_sysid_control_slave;
  input            cpu_0_data_master_requests_timer_0_s1;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input            d1_procHasControl_s1_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            d1_sram_16bit_512k_0_avalon_slave_0_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            d1_timer_0_s1_end_xfer;
  input            jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input   [ 31: 0] procHasControl_s1_readdata_from_sa;
  input            registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;
  input   [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;
  input            sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;
  input            timer_0_s1_irq_from_sa;
  input   [ 15: 0] timer_0_s1_readdata_from_sa;

  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  reg     [  1: 0] cpu_0_data_master_dbs_address;
  wire    [  1: 0] cpu_0_data_master_dbs_increment;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_0_data_master_irq;
  reg              cpu_0_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_run;
  reg              cpu_0_data_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [ 31: 0] p1_registered_cpu_0_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  reg     [ 31: 0] registered_cpu_0_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_requests_cpu_0_jtag_debug_module) & (cpu_0_data_master_granted_cpu_0_jtag_debug_module | ~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & ((~cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & ~jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 | ~cpu_0_data_master_requests_onchip_memory2_0_s1) & (cpu_0_data_master_granted_onchip_memory2_0_s1 | ~cpu_0_data_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_data_master_read | (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | ~(cpu_0_data_master_read | cpu_0_data_master_write) | (1 & (cpu_0_data_master_read | cpu_0_data_master_write)))) & 1 & (cpu_0_data_master_qualified_request_procHasControl_s1 | ~cpu_0_data_master_requests_procHasControl_s1) & ((~cpu_0_data_master_qualified_request_procHasControl_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_procHasControl_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_sdram_0_s1 | (cpu_0_data_master_read_data_valid_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1 & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_sdram_0_s1);

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_data_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = (cpu_0_data_master_granted_sdram_0_s1 | ~cpu_0_data_master_qualified_request_sdram_0_s1) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_read | (cpu_0_data_master_read_data_valid_sdram_0_s1 & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sdram_0_s1 | ~cpu_0_data_master_write | (1 & ~sdram_0_s1_waitrequest_from_sa & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | (cpu_0_data_master_write & !cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_dbs_address[1]) | ~cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0) & (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0) & ((~cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_data_master_read | (1 & 1 & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_data_master_write | (1 & ~d1_sram_16bit_512k_0_avalon_slave_0_end_xfer & (cpu_0_data_master_dbs_address[1]) & cpu_0_data_master_write))) & 1 & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_sysid_control_slave | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write))) & 1 & (cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_requests_timer_0_s1) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_read | (1 & 1 & cpu_0_data_master_read))) & ((~cpu_0_data_master_qualified_request_timer_0_s1 | ~cpu_0_data_master_write | (1 & cpu_0_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_data_master_address_to_slave = cpu_0_data_master_address[24 : 0];

  //cpu_0/data_master readdata mux, which is an e_mux
  assign cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_procHasControl_s1}} | procHasControl_s1_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | registered_cpu_0_data_master_readdata) &
    ({32 {~cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0}} | {sram_16bit_512k_0_avalon_slave_0_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0}) &
    ({32 {~cpu_0_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_timer_0_s1}} | timer_0_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_waitrequest <= ~0;
      else 
        cpu_0_data_master_waitrequest <= ~((~(cpu_0_data_master_read | cpu_0_data_master_write))? 0: (cpu_0_data_master_run & cpu_0_data_master_waitrequest));
    end


  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_0_data_master_readdata <= 0;
      else 
        registered_cpu_0_data_master_readdata <= p1_registered_cpu_0_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_0_data_master_readdata = ({32 {~cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave}} | jtag_uart_0_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_0_data_master_requests_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //irq assign, which is an e_assign
  assign cpu_0_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    timer_0_s1_irq_from_sa,
    jtag_uart_0_avalon_jtag_slave_irq_from_sa};

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_0_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_0_data_master_requests_sdram_0_s1)? (((cpu_0_data_master_dbs_address == 2'b10) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1)) :
    (((cpu_0_data_master_dbs_address == 2'b10) & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0));

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_sdram_0_s1 & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sdram_0_s1)) |
    cpu_0_data_master_read_data_valid_sdram_0_s1 |
    (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write & 1 & 1 & ~sdram_0_s1_waitrequest_from_sa) |
    (((~cpu_0_data_master_no_byte_enables_and_last_term) & cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_write & !cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0)) |
    (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_read & 1 & 1 & ~d1_sram_16bit_512k_0_avalon_slave_0_end_xfer) |
    ((cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_write & 1 & 1 & ({sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0 & ~d1_sram_16bit_512k_0_avalon_slave_0_end_xfer})));

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = (cpu_0_data_master_requests_sdram_0_s1)? sdram_0_s1_readdata_from_sa :
    sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_0_data_master_dbs_write_16 = (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    (~(cpu_0_data_master_dbs_address[1]))? cpu_0_data_master_writedata[15 : 0] :
    (cpu_0_data_master_dbs_address[1])? cpu_0_data_master_writedata[31 : 16] :
    cpu_0_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_0_data_master_dbs_increment = (cpu_0_data_master_requests_sdram_0_s1)? 2 :
    (cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_data_master_dbs_address + cpu_0_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_0_data_master_requests_sdram_0_s1 & ~cpu_0_data_master_waitrequest));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_data_master_dbs_address <= next_dbs_address;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_instruction_master_arbitrator (
                                             // inputs:
                                              clk,
                                              cpu_0_instruction_master_address,
                                              cpu_0_instruction_master_granted_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_granted_sdram_0_s1,
                                              cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0,
                                              cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                              cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0,
                                              cpu_0_instruction_master_read,
                                              cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                              cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                              cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0,
                                              cpu_0_instruction_master_requests_cpu_0_jtag_debug_module,
                                              cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                              cpu_0_instruction_master_requests_sdram_0_s1,
                                              cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0,
                                              cpu_0_jtag_debug_module_readdata_from_sa,
                                              d1_cpu_0_jtag_debug_module_end_xfer,
                                              d1_onchip_memory2_0_s1_end_xfer,
                                              d1_sdram_0_s1_end_xfer,
                                              d1_sram_16bit_512k_0_avalon_slave_0_end_xfer,
                                              onchip_memory2_0_s1_readdata_from_sa,
                                              reset_n,
                                              sdram_0_s1_readdata_from_sa,
                                              sdram_0_s1_waitrequest_from_sa,
                                              sram_16bit_512k_0_avalon_slave_0_readdata_from_sa,
                                              sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0,

                                             // outputs:
                                              cpu_0_instruction_master_address_to_slave,
                                              cpu_0_instruction_master_dbs_address,
                                              cpu_0_instruction_master_readdata,
                                              cpu_0_instruction_master_waitrequest
                                           )
;

  output  [ 24: 0] cpu_0_instruction_master_address_to_slave;
  output  [  1: 0] cpu_0_instruction_master_dbs_address;
  output  [ 31: 0] cpu_0_instruction_master_readdata;
  output           cpu_0_instruction_master_waitrequest;
  input            clk;
  input   [ 24: 0] cpu_0_instruction_master_address;
  input            cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_granted_sdram_0_s1;
  input            cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_qualified_request_sdram_0_s1;
  input            cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_instruction_master_read;
  input            cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  input            cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  input            cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  input            cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  input            cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  input            cpu_0_instruction_master_requests_sdram_0_s1;
  input            cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;
  input   [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_0_jtag_debug_module_end_xfer;
  input            d1_onchip_memory2_0_s1_end_xfer;
  input            d1_sdram_0_s1_end_xfer;
  input            d1_sram_16bit_512k_0_avalon_slave_0_end_xfer;
  input   [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata_from_sa;
  input            sdram_0_s1_waitrequest_from_sa;
  input   [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;
  input            sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;

  reg              active_and_waiting_last_time;
  reg     [ 24: 0] cpu_0_instruction_master_address_last_time;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_0_instruction_master_dbs_address;
  wire    [  1: 0] cpu_0_instruction_master_dbs_increment;
  reg              cpu_0_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_run;
  wire             cpu_0_instruction_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module) & (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module) & ((~cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module | ~cpu_0_instruction_master_read | (1 & ~d1_cpu_0_jtag_debug_module_end_xfer & cpu_0_instruction_master_read))) & 1 & (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) & (cpu_0_instruction_master_granted_onchip_memory2_0_s1 | ~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1) & ((~cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 | ~cpu_0_instruction_master_read | (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 & cpu_0_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_0_instruction_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (cpu_0_instruction_master_qualified_request_sdram_0_s1 | (cpu_0_instruction_master_read_data_valid_sdram_0_s1 & cpu_0_instruction_master_dbs_address[1]) | ~cpu_0_instruction_master_requests_sdram_0_s1) & (cpu_0_instruction_master_granted_sdram_0_s1 | ~cpu_0_instruction_master_qualified_request_sdram_0_s1) & ((~cpu_0_instruction_master_qualified_request_sdram_0_s1 | ~cpu_0_instruction_master_read | (cpu_0_instruction_master_read_data_valid_sdram_0_s1 & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read))) & 1 & (cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0) & (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0) & ((~cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | ~cpu_0_instruction_master_read | (1 & ~d1_sram_16bit_512k_0_avalon_slave_0_end_xfer & (cpu_0_instruction_master_dbs_address[1]) & cpu_0_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_0_instruction_master_address_to_slave = cpu_0_instruction_master_address[24 : 0];

  //cpu_0/instruction_master readdata mux, which is an e_mux
  assign cpu_0_instruction_master_readdata = ({32 {~cpu_0_instruction_master_requests_cpu_0_jtag_debug_module}} | cpu_0_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_requests_onchip_memory2_0_s1}} | onchip_memory2_0_s1_readdata_from_sa) &
    ({32 {~cpu_0_instruction_master_requests_sdram_0_s1}} | {sdram_0_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0}) &
    ({32 {~cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0}} | {sram_16bit_512k_0_avalon_slave_0_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_0_instruction_master_waitrequest = ~cpu_0_instruction_master_run;

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = (cpu_0_instruction_master_requests_sdram_0_s1)? sdram_0_s1_readdata_from_sa :
    sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_0_instruction_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_0_instruction_master_dbs_increment = (cpu_0_instruction_master_requests_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_0_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_0_instruction_master_dbs_address + cpu_0_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_0_instruction_master_dbs_address <= next_dbs_address;
    end


  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_0_instruction_master_read_data_valid_sdram_0_s1 |
    (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_instruction_master_read & 1 & 1 & ~d1_sram_16bit_512k_0_avalon_slave_0_end_xfer);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_0_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_address_last_time <= 0;
      else 
        cpu_0_instruction_master_address_last_time <= cpu_0_instruction_master_address;
    end


  //cpu_0/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_0_instruction_master_waitrequest & (cpu_0_instruction_master_read);
    end


  //cpu_0_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_address != cpu_0_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_0_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_last_time <= 0;
      else 
        cpu_0_instruction_master_read_last_time <= cpu_0_instruction_master_read;
    end


  //cpu_0_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_0_instruction_master_read != cpu_0_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_0_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_0_altera_nios_custom_instr_floating_point_inst_s1_arbitrator (
                                                                          // inputs:
                                                                           clk,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select,
                                                                           cpu_0_custom_instruction_master_clk_en,
                                                                           cpu_0_custom_instruction_master_dataa,
                                                                           cpu_0_custom_instruction_master_datab,
                                                                           cpu_0_custom_instruction_master_n,
                                                                           cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1,
                                                                           reset_n,

                                                                          // outputs:
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa,
                                                                           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start
                                                                        )
;

  output           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en;
  output  [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa;
  output  [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab;
  output           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;
  output  [  1: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n;
  output           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset;
  output  [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;
  output           cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start;
  input            clk;
  input            cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done;
  input   [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result;
  input            cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select;
  input            cpu_0_custom_instruction_master_clk_en;
  input   [ 31: 0] cpu_0_custom_instruction_master_dataa;
  input   [ 31: 0] cpu_0_custom_instruction_master_datab;
  input   [  7: 0] cpu_0_custom_instruction_master_n;
  input            cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1;
  input            reset_n;

  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;
  wire    [  1: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en = cpu_0_custom_instruction_master_clk_en;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa = cpu_0_custom_instruction_master_dataa;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab = cpu_0_custom_instruction_master_datab;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n = cpu_0_custom_instruction_master_n;
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start = cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1;
  //assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa = cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa = cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result;

  //assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa = cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa = cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done;

  //cpu_0_altera_nios_custom_instr_floating_point_inst/s1 local reset_n, which is an e_assign
  assign cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset = ~reset_n;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_0_avalon_jtag_slave_arbitrator (
                                                  // inputs:
                                                   clk,
                                                   cpu_0_data_master_address_to_slave,
                                                   cpu_0_data_master_read,
                                                   cpu_0_data_master_waitrequest,
                                                   cpu_0_data_master_write,
                                                   cpu_0_data_master_writedata,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable,
                                                   jtag_uart_0_avalon_jtag_slave_irq,
                                                   jtag_uart_0_avalon_jtag_slave_readdata,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest,
                                                   reset_n,

                                                  // outputs:
                                                   cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave,
                                                   cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave,
                                                   d1_jtag_uart_0_avalon_jtag_slave_end_xfer,
                                                   jtag_uart_0_avalon_jtag_slave_address,
                                                   jtag_uart_0_avalon_jtag_slave_chipselect,
                                                   jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_irq_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_read_n,
                                                   jtag_uart_0_avalon_jtag_slave_readdata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_reset_n,
                                                   jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa,
                                                   jtag_uart_0_avalon_jtag_slave_write_n,
                                                   jtag_uart_0_avalon_jtag_slave_writedata
                                                )
;

  output           cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  output           cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  output           d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  output           jtag_uart_0_avalon_jtag_slave_address;
  output           jtag_uart_0_avalon_jtag_slave_chipselect;
  output           jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_reset_n;
  output           jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_0_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            jtag_uart_0_avalon_jtag_slave_dataavailable;
  input            jtag_uart_0_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  input            jtag_uart_0_avalon_jtag_slave_readyfordata;
  input            jtag_uart_0_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave;
  reg              d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_allgrants;
  wire             jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_0_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_0_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_0_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_0_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  reg              jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_0_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 24: 0] shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master;
  wire             wait_for_jtag_uart_0_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_0_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave));
  //assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readdata_from_sa = jtag_uart_0_avalon_jtag_slave_readdata;

  assign cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave = ({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1109030) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_0_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_0_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_0_avalon_jtag_slave_waitrequest;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_0_avalon_jtag_slave_firsttransfer ? (jtag_uart_0_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_0_avalon_jtag_slave_arb_share_counter ? (jtag_uart_0_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_0_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_allgrants = |jtag_uart_0_avalon_jtag_slave_grant_vector;

  //jtag_uart_0_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_end_xfer = ~(jtag_uart_0_avalon_jtag_slave_waits_for_read | jtag_uart_0_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave = jtag_uart_0_avalon_jtag_slave_end_xfer & (~jtag_uart_0_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & jtag_uart_0_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_0_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_0_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_0_avalon_jtag_slave_arb_share_counter <= jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_0_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_0_avalon_jtag_slave & ~jtag_uart_0_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_0_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu_0/data_master jtag_uart_0/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //jtag_uart_0_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest)) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //jtag_uart_0_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;

  //cpu_0/data_master saved-grant jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_jtag_uart_0_avalon_jtag_slave = cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart_0/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_0_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_0_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_0_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_0_avalon_jtag_slave_chipselect = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  //jtag_uart_0_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_firsttransfer = jtag_uart_0_avalon_jtag_slave_begins_xfer ? jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_0_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_0_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_0_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_0_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_0_avalon_jtag_slave_begins_xfer)
          jtag_uart_0_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_0_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_0_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_0_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_read_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read);

  //~jtag_uart_0_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_write_n = ~(cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write);

  assign shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //jtag_uart_0_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_address = shifted_address_to_jtag_uart_0_avalon_jtag_slave_from_cpu_0_data_master >> 2;

  //d1_jtag_uart_0_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_0_avalon_jtag_slave_end_xfer <= jtag_uart_0_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_0_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_read = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_read_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_0_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_0_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_0_avalon_jtag_slave_waits_for_write = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle & jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_0_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_in_a_write_cycle = cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_0_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_0_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_0_avalon_jtag_slave_irq_from_sa = jtag_uart_0_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart_0/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_memory2_0_s1_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_byteenable,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_waitrequest,
                                         cpu_0_data_master_write,
                                         cpu_0_data_master_writedata,
                                         cpu_0_instruction_master_address_to_slave,
                                         cpu_0_instruction_master_read,
                                         onchip_memory2_0_s1_readdata,
                                         reset_n,

                                        // outputs:
                                         cpu_0_data_master_granted_onchip_memory2_0_s1,
                                         cpu_0_data_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_data_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_data_master_requests_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_granted_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1,
                                         cpu_0_instruction_master_requests_onchip_memory2_0_s1,
                                         d1_onchip_memory2_0_s1_end_xfer,
                                         onchip_memory2_0_s1_address,
                                         onchip_memory2_0_s1_byteenable,
                                         onchip_memory2_0_s1_chipselect,
                                         onchip_memory2_0_s1_clken,
                                         onchip_memory2_0_s1_readdata_from_sa,
                                         onchip_memory2_0_s1_reset,
                                         onchip_memory2_0_s1_write,
                                         onchip_memory2_0_s1_writedata,
                                         registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1
                                      )
;

  output           cpu_0_data_master_granted_onchip_memory2_0_s1;
  output           cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_data_master_requests_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  output           cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  output           d1_onchip_memory2_0_s1_end_xfer;
  output  [ 11: 0] onchip_memory2_0_s1_address;
  output  [  3: 0] onchip_memory2_0_s1_byteenable;
  output           onchip_memory2_0_s1_chipselect;
  output           onchip_memory2_0_s1_clken;
  output  [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  output           onchip_memory2_0_s1_reset;
  output           onchip_memory2_0_s1_write;
  output  [ 31: 0] onchip_memory2_0_s1_writedata;
  output           registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input            cpu_0_instruction_master_read;
  input   [ 31: 0] onchip_memory2_0_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_saved_grant_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  reg              cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1;
  reg              d1_onchip_memory2_0_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_memory2_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
  wire    [ 11: 0] onchip_memory2_0_s1_address;
  wire             onchip_memory2_0_s1_allgrants;
  wire             onchip_memory2_0_s1_allow_new_arb_cycle;
  wire             onchip_memory2_0_s1_any_bursting_master_saved_grant;
  wire             onchip_memory2_0_s1_any_continuerequest;
  reg     [  1: 0] onchip_memory2_0_s1_arb_addend;
  wire             onchip_memory2_0_s1_arb_counter_enable;
  reg     [  1: 0] onchip_memory2_0_s1_arb_share_counter;
  wire    [  1: 0] onchip_memory2_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] onchip_memory2_0_s1_arb_share_set_values;
  wire    [  1: 0] onchip_memory2_0_s1_arb_winner;
  wire             onchip_memory2_0_s1_arbitration_holdoff_internal;
  wire             onchip_memory2_0_s1_beginbursttransfer_internal;
  wire             onchip_memory2_0_s1_begins_xfer;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire    [  3: 0] onchip_memory2_0_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_memory2_0_s1_chosen_master_rot_left;
  wire             onchip_memory2_0_s1_clken;
  wire             onchip_memory2_0_s1_end_xfer;
  wire             onchip_memory2_0_s1_firsttransfer;
  wire    [  1: 0] onchip_memory2_0_s1_grant_vector;
  wire             onchip_memory2_0_s1_in_a_read_cycle;
  wire             onchip_memory2_0_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_memory2_0_s1_master_qreq_vector;
  wire             onchip_memory2_0_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  reg              onchip_memory2_0_s1_reg_firsttransfer;
  wire             onchip_memory2_0_s1_reset;
  reg     [  1: 0] onchip_memory2_0_s1_saved_chosen_master_vector;
  reg              onchip_memory2_0_s1_slavearbiterlockenable;
  wire             onchip_memory2_0_s1_slavearbiterlockenable2;
  wire             onchip_memory2_0_s1_unreg_firsttransfer;
  wire             onchip_memory2_0_s1_waits_for_read;
  wire             onchip_memory2_0_s1_waits_for_write;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
  wire             registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire    [ 24: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_onchip_memory2_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~onchip_memory2_0_s1_end_xfer;
    end


  assign onchip_memory2_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_onchip_memory2_0_s1 | cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1));
  //assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_memory2_0_s1_readdata_from_sa = onchip_memory2_0_s1_readdata;

  assign cpu_0_data_master_requests_onchip_memory2_0_s1 = ({cpu_0_data_master_address_to_slave[24 : 14] , 14'b0} == 25'h1104000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //registered rdv signal_name registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 assignment, which is an e_assign
  assign registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in;

  //onchip_memory2_0_s1_arb_share_counter set values, which is an e_mux
  assign onchip_memory2_0_s1_arb_share_set_values = 1;

  //onchip_memory2_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_memory2_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1 |
    cpu_0_data_master_requests_onchip_memory2_0_s1 |
    cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_memory2_0_s1_any_bursting_master_saved_grant = 0;

  //onchip_memory2_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_memory2_0_s1_arb_share_counter_next_value = onchip_memory2_0_s1_firsttransfer ? (onchip_memory2_0_s1_arb_share_set_values - 1) : |onchip_memory2_0_s1_arb_share_counter ? (onchip_memory2_0_s1_arb_share_counter - 1) : 0;

  //onchip_memory2_0_s1_allgrants all slave grants, which is an e_mux
  assign onchip_memory2_0_s1_allgrants = (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector) |
    (|onchip_memory2_0_s1_grant_vector);

  //onchip_memory2_0_s1_end_xfer assignment, which is an e_assign
  assign onchip_memory2_0_s1_end_xfer = ~(onchip_memory2_0_s1_waits_for_read | onchip_memory2_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_memory2_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_memory2_0_s1 = onchip_memory2_0_s1_end_xfer & (~onchip_memory2_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_memory2_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_memory2_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & onchip_memory2_0_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests);

  //onchip_memory2_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_share_counter <= 0;
      else if (onchip_memory2_0_s1_arb_counter_enable)
          onchip_memory2_0_s1_arb_share_counter <= onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //onchip_memory2_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_memory2_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_memory2_0_s1) | (end_xfer_arb_share_counter_term_onchip_memory2_0_s1 & ~onchip_memory2_0_s1_non_bursting_master_requests))
          onchip_memory2_0_s1_slavearbiterlockenable <= |onchip_memory2_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //onchip_memory2_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_memory2_0_s1_slavearbiterlockenable2 = |onchip_memory2_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = onchip_memory2_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master onchip_memory2_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = onchip_memory2_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_onchip_memory2_0_s1 & cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_memory2_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_onchip_memory2_0_s1 = cpu_0_data_master_requests_onchip_memory2_0_s1 & ~((cpu_0_data_master_read & ((|cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read & ~onchip_memory2_0_s1_waits_for_read & ~(|cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register);

  //shift register p1 cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_data_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_data_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //onchip_memory2_0_s1_writedata mux, which is an e_mux
  assign onchip_memory2_0_s1_writedata = cpu_0_data_master_writedata;

  //mux onchip_memory2_0_s1_clken, which is an e_mux
  assign onchip_memory2_0_s1_clken = 1'b1;

  assign cpu_0_instruction_master_requests_onchip_memory2_0_s1 = (({cpu_0_instruction_master_address_to_slave[24 : 14] , 14'b0} == 25'h1104000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted onchip_memory2_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 <= cpu_0_data_master_saved_grant_onchip_memory2_0_s1 ? 1 : (onchip_memory2_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_onchip_memory2_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_onchip_memory2_0_s1 & cpu_0_data_master_requests_onchip_memory2_0_s1;

  assign cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1 = cpu_0_instruction_master_requests_onchip_memory2_0_s1 & ~((cpu_0_instruction_master_read & ((|cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in = cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read & ~onchip_memory2_0_s1_waits_for_read & ~(|cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register);

  //shift register p1 cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register = {cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register, cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register_in};

  //cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= 0;
      else 
        cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register <= p1_cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;
    end


  //local readdatavalid cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1 = cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1_shift_register;

  //allow new arb cycle for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/instruction_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_onchip_memory2_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for onchip_memory2_0/s1, which is an e_assign
  assign onchip_memory2_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_onchip_memory2_0_s1;

  //cpu_0/data_master grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_onchip_memory2_0_s1 = onchip_memory2_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant onchip_memory2_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_onchip_memory2_0_s1 = onchip_memory2_0_s1_arb_winner[1] && cpu_0_data_master_requests_onchip_memory2_0_s1;

  //onchip_memory2_0/s1 chosen-master double-vector, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_double_vector = {onchip_memory2_0_s1_master_qreq_vector, onchip_memory2_0_s1_master_qreq_vector} & ({~onchip_memory2_0_s1_master_qreq_vector, ~onchip_memory2_0_s1_master_qreq_vector} + onchip_memory2_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_memory2_0_s1_arb_winner = (onchip_memory2_0_s1_allow_new_arb_cycle & | onchip_memory2_0_s1_grant_vector) ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;

  //saved onchip_memory2_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_saved_chosen_master_vector <= 0;
      else if (onchip_memory2_0_s1_allow_new_arb_cycle)
          onchip_memory2_0_s1_saved_chosen_master_vector <= |onchip_memory2_0_s1_grant_vector ? onchip_memory2_0_s1_grant_vector : onchip_memory2_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_memory2_0_s1_grant_vector = {(onchip_memory2_0_s1_chosen_master_double_vector[1] | onchip_memory2_0_s1_chosen_master_double_vector[3]),
    (onchip_memory2_0_s1_chosen_master_double_vector[0] | onchip_memory2_0_s1_chosen_master_double_vector[2])};

  //onchip_memory2_0/s1 chosen master rotated left, which is an e_assign
  assign onchip_memory2_0_s1_chosen_master_rot_left = (onchip_memory2_0_s1_arb_winner << 1) ? (onchip_memory2_0_s1_arb_winner << 1) : 1;

  //onchip_memory2_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_arb_addend <= 1;
      else if (|onchip_memory2_0_s1_grant_vector)
          onchip_memory2_0_s1_arb_addend <= onchip_memory2_0_s1_end_xfer? onchip_memory2_0_s1_chosen_master_rot_left : onchip_memory2_0_s1_grant_vector;
    end


  //~onchip_memory2_0_s1_reset assignment, which is an e_assign
  assign onchip_memory2_0_s1_reset = ~reset_n;

  assign onchip_memory2_0_s1_chipselect = cpu_0_data_master_granted_onchip_memory2_0_s1 | cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  //onchip_memory2_0_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_firsttransfer = onchip_memory2_0_s1_begins_xfer ? onchip_memory2_0_s1_unreg_firsttransfer : onchip_memory2_0_s1_reg_firsttransfer;

  //onchip_memory2_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_memory2_0_s1_unreg_firsttransfer = ~(onchip_memory2_0_s1_slavearbiterlockenable & onchip_memory2_0_s1_any_continuerequest);

  //onchip_memory2_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_memory2_0_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_memory2_0_s1_begins_xfer)
          onchip_memory2_0_s1_reg_firsttransfer <= onchip_memory2_0_s1_unreg_firsttransfer;
    end


  //onchip_memory2_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_memory2_0_s1_beginbursttransfer_internal = onchip_memory2_0_s1_begins_xfer;

  //onchip_memory2_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_memory2_0_s1_arbitration_holdoff_internal = onchip_memory2_0_s1_begins_xfer & onchip_memory2_0_s1_firsttransfer;

  //onchip_memory2_0_s1_write assignment, which is an e_mux
  assign onchip_memory2_0_s1_write = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //onchip_memory2_0_s1_address mux, which is an e_mux
  assign onchip_memory2_0_s1_address = (cpu_0_data_master_granted_onchip_memory2_0_s1)? (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_data_master >> 2) :
    (shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master >> 2);

  assign shifted_address_to_onchip_memory2_0_s1_from_cpu_0_instruction_master = cpu_0_instruction_master_address_to_slave;
  //d1_onchip_memory2_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_memory2_0_s1_end_xfer <= 1;
      else 
        d1_onchip_memory2_0_s1_end_xfer <= onchip_memory2_0_s1_end_xfer;
    end


  //onchip_memory2_0_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_read = onchip_memory2_0_s1_in_a_read_cycle & 0;

  //onchip_memory2_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_onchip_memory2_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_memory2_0_s1_in_a_read_cycle;

  //onchip_memory2_0_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_memory2_0_s1_waits_for_write = onchip_memory2_0_s1_in_a_write_cycle & 0;

  //onchip_memory2_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_memory2_0_s1_in_a_write_cycle = cpu_0_data_master_granted_onchip_memory2_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_memory2_0_s1_in_a_write_cycle;

  assign wait_for_onchip_memory2_0_s1_counter = 0;
  //onchip_memory2_0_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_memory2_0_s1_byteenable = (cpu_0_data_master_granted_onchip_memory2_0_s1)? cpu_0_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_memory2_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_onchip_memory2_0_s1 + cpu_0_instruction_master_granted_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_onchip_memory2_0_s1 + cpu_0_instruction_master_saved_grant_onchip_memory2_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module procHasControl_s1_arbitrator (
                                      // inputs:
                                       clk,
                                       cpu_0_data_master_address_to_slave,
                                       cpu_0_data_master_read,
                                       cpu_0_data_master_waitrequest,
                                       cpu_0_data_master_write,
                                       cpu_0_data_master_writedata,
                                       procHasControl_s1_readdata,
                                       reset_n,

                                      // outputs:
                                       cpu_0_data_master_granted_procHasControl_s1,
                                       cpu_0_data_master_qualified_request_procHasControl_s1,
                                       cpu_0_data_master_read_data_valid_procHasControl_s1,
                                       cpu_0_data_master_requests_procHasControl_s1,
                                       d1_procHasControl_s1_end_xfer,
                                       procHasControl_s1_address,
                                       procHasControl_s1_chipselect,
                                       procHasControl_s1_readdata_from_sa,
                                       procHasControl_s1_reset_n,
                                       procHasControl_s1_write_n,
                                       procHasControl_s1_writedata
                                    )
;

  output           cpu_0_data_master_granted_procHasControl_s1;
  output           cpu_0_data_master_qualified_request_procHasControl_s1;
  output           cpu_0_data_master_read_data_valid_procHasControl_s1;
  output           cpu_0_data_master_requests_procHasControl_s1;
  output           d1_procHasControl_s1_end_xfer;
  output  [  1: 0] procHasControl_s1_address;
  output           procHasControl_s1_chipselect;
  output  [ 31: 0] procHasControl_s1_readdata_from_sa;
  output           procHasControl_s1_reset_n;
  output           procHasControl_s1_write_n;
  output  [ 31: 0] procHasControl_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input   [ 31: 0] procHasControl_s1_readdata;
  input            reset_n;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_procHasControl_s1;
  wire             cpu_0_data_master_qualified_request_procHasControl_s1;
  wire             cpu_0_data_master_read_data_valid_procHasControl_s1;
  wire             cpu_0_data_master_requests_procHasControl_s1;
  wire             cpu_0_data_master_saved_grant_procHasControl_s1;
  reg              d1_procHasControl_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_procHasControl_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] procHasControl_s1_address;
  wire             procHasControl_s1_allgrants;
  wire             procHasControl_s1_allow_new_arb_cycle;
  wire             procHasControl_s1_any_bursting_master_saved_grant;
  wire             procHasControl_s1_any_continuerequest;
  wire             procHasControl_s1_arb_counter_enable;
  reg     [  1: 0] procHasControl_s1_arb_share_counter;
  wire    [  1: 0] procHasControl_s1_arb_share_counter_next_value;
  wire    [  1: 0] procHasControl_s1_arb_share_set_values;
  wire             procHasControl_s1_beginbursttransfer_internal;
  wire             procHasControl_s1_begins_xfer;
  wire             procHasControl_s1_chipselect;
  wire             procHasControl_s1_end_xfer;
  wire             procHasControl_s1_firsttransfer;
  wire             procHasControl_s1_grant_vector;
  wire             procHasControl_s1_in_a_read_cycle;
  wire             procHasControl_s1_in_a_write_cycle;
  wire             procHasControl_s1_master_qreq_vector;
  wire             procHasControl_s1_non_bursting_master_requests;
  wire    [ 31: 0] procHasControl_s1_readdata_from_sa;
  reg              procHasControl_s1_reg_firsttransfer;
  wire             procHasControl_s1_reset_n;
  reg              procHasControl_s1_slavearbiterlockenable;
  wire             procHasControl_s1_slavearbiterlockenable2;
  wire             procHasControl_s1_unreg_firsttransfer;
  wire             procHasControl_s1_waits_for_read;
  wire             procHasControl_s1_waits_for_write;
  wire             procHasControl_s1_write_n;
  wire    [ 31: 0] procHasControl_s1_writedata;
  wire    [ 24: 0] shifted_address_to_procHasControl_s1_from_cpu_0_data_master;
  wire             wait_for_procHasControl_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~procHasControl_s1_end_xfer;
    end


  assign procHasControl_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_procHasControl_s1));
  //assign procHasControl_s1_readdata_from_sa = procHasControl_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign procHasControl_s1_readdata_from_sa = procHasControl_s1_readdata;

  assign cpu_0_data_master_requests_procHasControl_s1 = ({cpu_0_data_master_address_to_slave[24 : 4] , 4'b0} == 25'h1109020) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //procHasControl_s1_arb_share_counter set values, which is an e_mux
  assign procHasControl_s1_arb_share_set_values = 1;

  //procHasControl_s1_non_bursting_master_requests mux, which is an e_mux
  assign procHasControl_s1_non_bursting_master_requests = cpu_0_data_master_requests_procHasControl_s1;

  //procHasControl_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign procHasControl_s1_any_bursting_master_saved_grant = 0;

  //procHasControl_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign procHasControl_s1_arb_share_counter_next_value = procHasControl_s1_firsttransfer ? (procHasControl_s1_arb_share_set_values - 1) : |procHasControl_s1_arb_share_counter ? (procHasControl_s1_arb_share_counter - 1) : 0;

  //procHasControl_s1_allgrants all slave grants, which is an e_mux
  assign procHasControl_s1_allgrants = |procHasControl_s1_grant_vector;

  //procHasControl_s1_end_xfer assignment, which is an e_assign
  assign procHasControl_s1_end_xfer = ~(procHasControl_s1_waits_for_read | procHasControl_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_procHasControl_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_procHasControl_s1 = procHasControl_s1_end_xfer & (~procHasControl_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //procHasControl_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign procHasControl_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_procHasControl_s1 & procHasControl_s1_allgrants) | (end_xfer_arb_share_counter_term_procHasControl_s1 & ~procHasControl_s1_non_bursting_master_requests);

  //procHasControl_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          procHasControl_s1_arb_share_counter <= 0;
      else if (procHasControl_s1_arb_counter_enable)
          procHasControl_s1_arb_share_counter <= procHasControl_s1_arb_share_counter_next_value;
    end


  //procHasControl_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          procHasControl_s1_slavearbiterlockenable <= 0;
      else if ((|procHasControl_s1_master_qreq_vector & end_xfer_arb_share_counter_term_procHasControl_s1) | (end_xfer_arb_share_counter_term_procHasControl_s1 & ~procHasControl_s1_non_bursting_master_requests))
          procHasControl_s1_slavearbiterlockenable <= |procHasControl_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master procHasControl/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = procHasControl_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //procHasControl_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign procHasControl_s1_slavearbiterlockenable2 = |procHasControl_s1_arb_share_counter_next_value;

  //cpu_0/data_master procHasControl/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = procHasControl_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //procHasControl_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign procHasControl_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_procHasControl_s1 = cpu_0_data_master_requests_procHasControl_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //procHasControl_s1_writedata mux, which is an e_mux
  assign procHasControl_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_procHasControl_s1 = cpu_0_data_master_qualified_request_procHasControl_s1;

  //cpu_0/data_master saved-grant procHasControl/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_procHasControl_s1 = cpu_0_data_master_requests_procHasControl_s1;

  //allow new arb cycle for procHasControl/s1, which is an e_assign
  assign procHasControl_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign procHasControl_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign procHasControl_s1_master_qreq_vector = 1;

  //procHasControl_s1_reset_n assignment, which is an e_assign
  assign procHasControl_s1_reset_n = reset_n;

  assign procHasControl_s1_chipselect = cpu_0_data_master_granted_procHasControl_s1;
  //procHasControl_s1_firsttransfer first transaction, which is an e_assign
  assign procHasControl_s1_firsttransfer = procHasControl_s1_begins_xfer ? procHasControl_s1_unreg_firsttransfer : procHasControl_s1_reg_firsttransfer;

  //procHasControl_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign procHasControl_s1_unreg_firsttransfer = ~(procHasControl_s1_slavearbiterlockenable & procHasControl_s1_any_continuerequest);

  //procHasControl_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          procHasControl_s1_reg_firsttransfer <= 1'b1;
      else if (procHasControl_s1_begins_xfer)
          procHasControl_s1_reg_firsttransfer <= procHasControl_s1_unreg_firsttransfer;
    end


  //procHasControl_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign procHasControl_s1_beginbursttransfer_internal = procHasControl_s1_begins_xfer;

  //~procHasControl_s1_write_n assignment, which is an e_mux
  assign procHasControl_s1_write_n = ~(cpu_0_data_master_granted_procHasControl_s1 & cpu_0_data_master_write);

  assign shifted_address_to_procHasControl_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //procHasControl_s1_address mux, which is an e_mux
  assign procHasControl_s1_address = shifted_address_to_procHasControl_s1_from_cpu_0_data_master >> 2;

  //d1_procHasControl_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_procHasControl_s1_end_xfer <= 1;
      else 
        d1_procHasControl_s1_end_xfer <= procHasControl_s1_end_xfer;
    end


  //procHasControl_s1_waits_for_read in a cycle, which is an e_mux
  assign procHasControl_s1_waits_for_read = procHasControl_s1_in_a_read_cycle & procHasControl_s1_begins_xfer;

  //procHasControl_s1_in_a_read_cycle assignment, which is an e_assign
  assign procHasControl_s1_in_a_read_cycle = cpu_0_data_master_granted_procHasControl_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = procHasControl_s1_in_a_read_cycle;

  //procHasControl_s1_waits_for_write in a cycle, which is an e_mux
  assign procHasControl_s1_waits_for_write = procHasControl_s1_in_a_write_cycle & 0;

  //procHasControl_s1_in_a_write_cycle assignment, which is an e_assign
  assign procHasControl_s1_in_a_write_cycle = cpu_0_data_master_granted_procHasControl_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = procHasControl_s1_in_a_write_cycle;

  assign wait_for_procHasControl_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //procHasControl/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module (
                                                             // inputs:
                                                              clear_fifo,
                                                              clk,
                                                              data_in,
                                                              read,
                                                              reset_n,
                                                              sync_reset,
                                                              write,

                                                             // outputs:
                                                              data_out,
                                                              empty,
                                                              fifo_contains_ones_n,
                                                              full
                                                           )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module (
                                                                    // inputs:
                                                                     clear_fifo,
                                                                     clk,
                                                                     data_in,
                                                                     read,
                                                                     reset_n,
                                                                     sync_reset,
                                                                     write,

                                                                    // outputs:
                                                                     data_out,
                                                                     empty,
                                                                     fifo_contains_ones_n,
                                                                     full
                                                                  )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_byteenable,
                                cpu_0_data_master_dbs_address,
                                cpu_0_data_master_dbs_write_16,
                                cpu_0_data_master_no_byte_enables_and_last_term,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_instruction_master_address_to_slave,
                                cpu_0_instruction_master_dbs_address,
                                cpu_0_instruction_master_read,
                                reset_n,
                                sdram_0_s1_readdata,
                                sdram_0_s1_readdatavalid,
                                sdram_0_s1_waitrequest,

                               // outputs:
                                cpu_0_data_master_byteenable_sdram_0_s1,
                                cpu_0_data_master_granted_sdram_0_s1,
                                cpu_0_data_master_qualified_request_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1,
                                cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_data_master_requests_sdram_0_s1,
                                cpu_0_instruction_master_granted_sdram_0_s1,
                                cpu_0_instruction_master_qualified_request_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1,
                                cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register,
                                cpu_0_instruction_master_requests_sdram_0_s1,
                                d1_sdram_0_s1_end_xfer,
                                sdram_0_s1_address,
                                sdram_0_s1_byteenable_n,
                                sdram_0_s1_chipselect,
                                sdram_0_s1_read_n,
                                sdram_0_s1_readdata_from_sa,
                                sdram_0_s1_reset_n,
                                sdram_0_s1_waitrequest_from_sa,
                                sdram_0_s1_write_n,
                                sdram_0_s1_writedata
                             )
;

  output  [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  output           cpu_0_data_master_granted_sdram_0_s1;
  output           cpu_0_data_master_qualified_request_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1;
  output           cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_data_master_requests_sdram_0_s1;
  output           cpu_0_instruction_master_granted_sdram_0_s1;
  output           cpu_0_instruction_master_qualified_request_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  output           cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  output           cpu_0_instruction_master_requests_sdram_0_s1;
  output           d1_sdram_0_s1_end_xfer;
  output  [ 21: 0] sdram_0_s1_address;
  output  [  1: 0] sdram_0_s1_byteenable_n;
  output           sdram_0_s1_chipselect;
  output           sdram_0_s1_read_n;
  output  [ 15: 0] sdram_0_s1_readdata_from_sa;
  output           sdram_0_s1_reset_n;
  output           sdram_0_s1_waitrequest_from_sa;
  output           sdram_0_s1_write_n;
  output  [ 15: 0] sdram_0_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input            cpu_0_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_0_s1_readdata;
  input            sdram_0_s1_readdatavalid;
  input            sdram_0_s1_waitrequest;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_saved_grant_sdram_0_s1;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  wire             cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_saved_grant_sdram_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
  wire    [ 21: 0] sdram_0_s1_address;
  wire             sdram_0_s1_allgrants;
  wire             sdram_0_s1_allow_new_arb_cycle;
  wire             sdram_0_s1_any_bursting_master_saved_grant;
  wire             sdram_0_s1_any_continuerequest;
  reg     [  1: 0] sdram_0_s1_arb_addend;
  wire             sdram_0_s1_arb_counter_enable;
  reg     [  1: 0] sdram_0_s1_arb_share_counter;
  wire    [  1: 0] sdram_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_0_s1_arb_share_set_values;
  wire    [  1: 0] sdram_0_s1_arb_winner;
  wire             sdram_0_s1_arbitration_holdoff_internal;
  wire             sdram_0_s1_beginbursttransfer_internal;
  wire             sdram_0_s1_begins_xfer;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire    [  3: 0] sdram_0_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_0_s1_chosen_master_rot_left;
  wire             sdram_0_s1_end_xfer;
  wire             sdram_0_s1_firsttransfer;
  wire    [  1: 0] sdram_0_s1_grant_vector;
  wire             sdram_0_s1_in_a_read_cycle;
  wire             sdram_0_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_0_s1_master_qreq_vector;
  wire             sdram_0_s1_move_on_to_next_transaction;
  wire             sdram_0_s1_non_bursting_master_requests;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid_from_sa;
  reg              sdram_0_s1_reg_firsttransfer;
  wire             sdram_0_s1_reset_n;
  reg     [  1: 0] sdram_0_s1_saved_chosen_master_vector;
  reg              sdram_0_s1_slavearbiterlockenable;
  wire             sdram_0_s1_slavearbiterlockenable2;
  wire             sdram_0_s1_unreg_firsttransfer;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_waits_for_read;
  wire             sdram_0_s1_waits_for_write;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [ 24: 0] shifted_address_to_sdram_0_s1_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master;
  wire             wait_for_sdram_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_0_s1_end_xfer;
    end


  assign sdram_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sdram_0_s1 | cpu_0_instruction_master_qualified_request_sdram_0_s1));
  //assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdata_from_sa = sdram_0_s1_readdata;

  assign cpu_0_data_master_requests_sdram_0_s1 = ({cpu_0_data_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_waitrequest_from_sa = sdram_0_s1_waitrequest;

  //assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_0_s1_readdatavalid_from_sa = sdram_0_s1_readdatavalid;

  //sdram_0_s1_arb_share_counter set values, which is an e_mux
  assign sdram_0_s1_arb_share_set_values = (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    (cpu_0_data_master_granted_sdram_0_s1)? 2 :
    (cpu_0_instruction_master_granted_sdram_0_s1)? 2 :
    1;

  //sdram_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1 |
    cpu_0_data_master_requests_sdram_0_s1 |
    cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_0_s1_any_bursting_master_saved_grant = 0;

  //sdram_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_0_s1_arb_share_counter_next_value = sdram_0_s1_firsttransfer ? (sdram_0_s1_arb_share_set_values - 1) : |sdram_0_s1_arb_share_counter ? (sdram_0_s1_arb_share_counter - 1) : 0;

  //sdram_0_s1_allgrants all slave grants, which is an e_mux
  assign sdram_0_s1_allgrants = (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector) |
    (|sdram_0_s1_grant_vector);

  //sdram_0_s1_end_xfer assignment, which is an e_assign
  assign sdram_0_s1_end_xfer = ~(sdram_0_s1_waits_for_read | sdram_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_0_s1 = sdram_0_s1_end_xfer & (~sdram_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_0_s1 & sdram_0_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests);

  //sdram_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_share_counter <= 0;
      else if (sdram_0_s1_arb_counter_enable)
          sdram_0_s1_arb_share_counter <= sdram_0_s1_arb_share_counter_next_value;
    end


  //sdram_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_0_s1) | (end_xfer_arb_share_counter_term_sdram_0_s1 & ~sdram_0_s1_non_bursting_master_requests))
          sdram_0_s1_slavearbiterlockenable <= |sdram_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sdram_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_0_s1_slavearbiterlockenable2 = |sdram_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = sdram_0_s1_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master sdram_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = sdram_0_s1_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 <= cpu_0_instruction_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_sdram_0_s1 & cpu_0_instruction_master_requests_sdram_0_s1;

  //sdram_0_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_0_s1_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_sdram_0_s1 = cpu_0_data_master_requests_sdram_0_s1 & ~((cpu_0_data_master_read & (~cpu_0_data_master_waitrequest | (|cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register))) | ((~cpu_0_data_master_waitrequest | cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_sdram_0_s1) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //unique name for sdram_0_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_0_s1_move_on_to_next_transaction = sdram_0_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_data_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_data_master_granted_sdram_0_s1),
      .data_out             (cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_data_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_data_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_data_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_data_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_data_master_rdv_fifo_empty_sdram_0_s1;

  //sdram_0_s1_writedata mux, which is an e_mux
  assign sdram_0_s1_writedata = cpu_0_data_master_dbs_write_16;

  assign cpu_0_instruction_master_requests_sdram_0_s1 = (({cpu_0_instruction_master_address_to_slave[24 : 23] , 23'b0} == 25'h800000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted sdram_0/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 <= cpu_0_data_master_saved_grant_sdram_0_s1 ? 1 : (sdram_0_s1_arbitration_holdoff_internal | ~cpu_0_data_master_requests_sdram_0_s1) ? 0 : last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_sdram_0_s1 & cpu_0_data_master_requests_sdram_0_s1;

  assign cpu_0_instruction_master_qualified_request_sdram_0_s1 = cpu_0_instruction_master_requests_sdram_0_s1 & ~((cpu_0_instruction_master_read & ((|cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register))) | cpu_0_data_master_arbiterlock);
  //rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1_module rdv_fifo_for_cpu_0_instruction_master_to_sdram_0_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_0_instruction_master_granted_sdram_0_s1),
      .data_out             (cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1),
      .full                 (),
      .read                 (sdram_0_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_0_s1_waits_for_read)
    );

  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register = ~cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;
  //local readdatavalid cpu_0_instruction_master_read_data_valid_sdram_0_s1, which is an e_mux
  assign cpu_0_instruction_master_read_data_valid_sdram_0_s1 = (sdram_0_s1_readdatavalid_from_sa & cpu_0_instruction_master_rdv_fifo_output_from_sdram_0_s1) & ~ cpu_0_instruction_master_rdv_fifo_empty_sdram_0_s1;

  //allow new arb cycle for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_sdram_0_s1;

  //cpu_0/instruction_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[0];

  //cpu_0/instruction_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[0] && cpu_0_instruction_master_requests_sdram_0_s1;

  //cpu_0/data_master assignment into master qualified-requests vector for sdram_0/s1, which is an e_assign
  assign sdram_0_s1_master_qreq_vector[1] = cpu_0_data_master_qualified_request_sdram_0_s1;

  //cpu_0/data_master grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_granted_sdram_0_s1 = sdram_0_s1_grant_vector[1];

  //cpu_0/data_master saved-grant sdram_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_sdram_0_s1 = sdram_0_s1_arb_winner[1] && cpu_0_data_master_requests_sdram_0_s1;

  //sdram_0/s1 chosen-master double-vector, which is an e_assign
  assign sdram_0_s1_chosen_master_double_vector = {sdram_0_s1_master_qreq_vector, sdram_0_s1_master_qreq_vector} & ({~sdram_0_s1_master_qreq_vector, ~sdram_0_s1_master_qreq_vector} + sdram_0_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_0_s1_arb_winner = (sdram_0_s1_allow_new_arb_cycle & | sdram_0_s1_grant_vector) ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;

  //saved sdram_0_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_saved_chosen_master_vector <= 0;
      else if (sdram_0_s1_allow_new_arb_cycle)
          sdram_0_s1_saved_chosen_master_vector <= |sdram_0_s1_grant_vector ? sdram_0_s1_grant_vector : sdram_0_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_0_s1_grant_vector = {(sdram_0_s1_chosen_master_double_vector[1] | sdram_0_s1_chosen_master_double_vector[3]),
    (sdram_0_s1_chosen_master_double_vector[0] | sdram_0_s1_chosen_master_double_vector[2])};

  //sdram_0/s1 chosen master rotated left, which is an e_assign
  assign sdram_0_s1_chosen_master_rot_left = (sdram_0_s1_arb_winner << 1) ? (sdram_0_s1_arb_winner << 1) : 1;

  //sdram_0/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_arb_addend <= 1;
      else if (|sdram_0_s1_grant_vector)
          sdram_0_s1_arb_addend <= sdram_0_s1_end_xfer? sdram_0_s1_chosen_master_rot_left : sdram_0_s1_grant_vector;
    end


  //sdram_0_s1_reset_n assignment, which is an e_assign
  assign sdram_0_s1_reset_n = reset_n;

  assign sdram_0_s1_chipselect = cpu_0_data_master_granted_sdram_0_s1 | cpu_0_instruction_master_granted_sdram_0_s1;
  //sdram_0_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_firsttransfer = sdram_0_s1_begins_xfer ? sdram_0_s1_unreg_firsttransfer : sdram_0_s1_reg_firsttransfer;

  //sdram_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_0_s1_unreg_firsttransfer = ~(sdram_0_s1_slavearbiterlockenable & sdram_0_s1_any_continuerequest);

  //sdram_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_0_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_0_s1_begins_xfer)
          sdram_0_s1_reg_firsttransfer <= sdram_0_s1_unreg_firsttransfer;
    end


  //sdram_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_0_s1_beginbursttransfer_internal = sdram_0_s1_begins_xfer;

  //sdram_0_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_0_s1_arbitration_holdoff_internal = sdram_0_s1_begins_xfer & sdram_0_s1_firsttransfer;

  //~sdram_0_s1_read_n assignment, which is an e_mux
  assign sdram_0_s1_read_n = ~((cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read));

  //~sdram_0_s1_write_n assignment, which is an e_mux
  assign sdram_0_s1_write_n = ~(cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_data_master = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_0_s1_address mux, which is an e_mux
  assign sdram_0_s1_address = (cpu_0_data_master_granted_sdram_0_s1)? (shifted_address_to_sdram_0_s1_from_cpu_0_data_master >> 1) :
    (shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master >> 1);

  assign shifted_address_to_sdram_0_s1_from_cpu_0_instruction_master = {cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_0_s1_end_xfer <= 1;
      else 
        d1_sdram_0_s1_end_xfer <= sdram_0_s1_end_xfer;
    end


  //sdram_0_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_read = sdram_0_s1_in_a_read_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_read_cycle = (cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sdram_0_s1 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_0_s1_in_a_read_cycle;

  //sdram_0_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_0_s1_waits_for_write = sdram_0_s1_in_a_write_cycle & sdram_0_s1_waitrequest_from_sa;

  //sdram_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_0_s1_in_a_write_cycle = cpu_0_data_master_granted_sdram_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_0_s1_in_a_write_cycle;

  assign wait_for_sdram_0_s1_counter = 0;
  //~sdram_0_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_0_s1_byteenable_n = ~((cpu_0_data_master_granted_sdram_0_s1)? cpu_0_data_master_byteenable_sdram_0_s1 :
    -1);

  assign {cpu_0_data_master_byteenable_sdram_0_s1_segment_1,
cpu_0_data_master_byteenable_sdram_0_s1_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_sdram_0_s1 = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_sdram_0_s1_segment_0 :
    cpu_0_data_master_byteenable_sdram_0_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_sdram_0_s1 + cpu_0_instruction_master_granted_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_sdram_0_s1 + cpu_0_instruction_master_saved_grant_sdram_0_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sram_16bit_512k_0_avalon_slave_0_arbitrator (
                                                     // inputs:
                                                      clk,
                                                      cpu_0_data_master_address_to_slave,
                                                      cpu_0_data_master_byteenable,
                                                      cpu_0_data_master_dbs_address,
                                                      cpu_0_data_master_dbs_write_16,
                                                      cpu_0_data_master_no_byte_enables_and_last_term,
                                                      cpu_0_data_master_read,
                                                      cpu_0_data_master_write,
                                                      cpu_0_instruction_master_address_to_slave,
                                                      cpu_0_instruction_master_dbs_address,
                                                      cpu_0_instruction_master_read,
                                                      reset_n,
                                                      sram_16bit_512k_0_avalon_slave_0_readdata,

                                                     // outputs:
                                                      cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0,
                                                      cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0,
                                                      d1_sram_16bit_512k_0_avalon_slave_0_end_xfer,
                                                      sram_16bit_512k_0_avalon_slave_0_address,
                                                      sram_16bit_512k_0_avalon_slave_0_byteenable_n,
                                                      sram_16bit_512k_0_avalon_slave_0_chipselect_n,
                                                      sram_16bit_512k_0_avalon_slave_0_read_n,
                                                      sram_16bit_512k_0_avalon_slave_0_readdata_from_sa,
                                                      sram_16bit_512k_0_avalon_slave_0_reset_n,
                                                      sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0,
                                                      sram_16bit_512k_0_avalon_slave_0_write_n,
                                                      sram_16bit_512k_0_avalon_slave_0_writedata
                                                   )
;

  output  [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  output           cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;
  output           d1_sram_16bit_512k_0_avalon_slave_0_end_xfer;
  output  [ 17: 0] sram_16bit_512k_0_avalon_slave_0_address;
  output  [  1: 0] sram_16bit_512k_0_avalon_slave_0_byteenable_n;
  output           sram_16bit_512k_0_avalon_slave_0_chipselect_n;
  output           sram_16bit_512k_0_avalon_slave_0_read_n;
  output  [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;
  output           sram_16bit_512k_0_avalon_slave_0_reset_n;
  output           sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;
  output           sram_16bit_512k_0_avalon_slave_0_write_n;
  output  [ 15: 0] sram_16bit_512k_0_avalon_slave_0_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input   [  3: 0] cpu_0_data_master_byteenable;
  input   [  1: 0] cpu_0_data_master_dbs_address;
  input   [ 15: 0] cpu_0_data_master_dbs_write_16;
  input            cpu_0_data_master_no_byte_enables_and_last_term;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input   [ 24: 0] cpu_0_instruction_master_address_to_slave;
  input   [  1: 0] cpu_0_instruction_master_dbs_address;
  input            cpu_0_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire    [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_0;
  wire    [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_1;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_saved_grant_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_arbiterlock;
  wire             cpu_0_instruction_master_arbiterlock2;
  wire             cpu_0_instruction_master_continuerequest;
  wire             cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_saved_grant_sram_16bit_512k_0_avalon_slave_0;
  reg              d1_reasons_to_wait;
  reg              d1_sram_16bit_512k_0_avalon_slave_0_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_0_data_master_granted_slave_sram_16bit_512k_0_avalon_slave_0;
  reg              last_cycle_cpu_0_instruction_master_granted_slave_sram_16bit_512k_0_avalon_slave_0;
  wire    [ 24: 0] shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_data_master;
  wire    [ 24: 0] shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_instruction_master;
  wire    [ 17: 0] sram_16bit_512k_0_avalon_slave_0_address;
  wire             sram_16bit_512k_0_avalon_slave_0_allgrants;
  wire             sram_16bit_512k_0_avalon_slave_0_allow_new_arb_cycle;
  wire             sram_16bit_512k_0_avalon_slave_0_any_bursting_master_saved_grant;
  wire             sram_16bit_512k_0_avalon_slave_0_any_continuerequest;
  reg     [  1: 0] sram_16bit_512k_0_avalon_slave_0_arb_addend;
  wire             sram_16bit_512k_0_avalon_slave_0_arb_counter_enable;
  reg     [  1: 0] sram_16bit_512k_0_avalon_slave_0_arb_share_counter;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_arb_share_set_values;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_arb_winner;
  wire             sram_16bit_512k_0_avalon_slave_0_arbitration_holdoff_internal;
  wire             sram_16bit_512k_0_avalon_slave_0_beginbursttransfer_internal;
  wire             sram_16bit_512k_0_avalon_slave_0_begins_xfer;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_byteenable_n;
  wire             sram_16bit_512k_0_avalon_slave_0_chipselect_n;
  wire    [  3: 0] sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_chosen_master_rot_left;
  wire             sram_16bit_512k_0_avalon_slave_0_counter_load_value;
  wire             sram_16bit_512k_0_avalon_slave_0_end_xfer;
  wire             sram_16bit_512k_0_avalon_slave_0_firsttransfer;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_grant_vector;
  wire             sram_16bit_512k_0_avalon_slave_0_in_a_read_cycle;
  wire             sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_master_qreq_vector;
  wire             sram_16bit_512k_0_avalon_slave_0_non_bursting_master_requests;
  wire             sram_16bit_512k_0_avalon_slave_0_read_n;
  wire    [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;
  reg              sram_16bit_512k_0_avalon_slave_0_reg_firsttransfer;
  wire             sram_16bit_512k_0_avalon_slave_0_reset_n;
  reg     [  1: 0] sram_16bit_512k_0_avalon_slave_0_saved_chosen_master_vector;
  reg              sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable;
  wire             sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable2;
  wire             sram_16bit_512k_0_avalon_slave_0_unreg_firsttransfer;
  reg              sram_16bit_512k_0_avalon_slave_0_wait_counter;
  wire             sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;
  wire             sram_16bit_512k_0_avalon_slave_0_waits_for_read;
  wire             sram_16bit_512k_0_avalon_slave_0_waits_for_write;
  wire             sram_16bit_512k_0_avalon_slave_0_write_n;
  wire    [ 15: 0] sram_16bit_512k_0_avalon_slave_0_writedata;
  wire             wait_for_sram_16bit_512k_0_avalon_slave_0_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sram_16bit_512k_0_avalon_slave_0_end_xfer;
    end


  assign sram_16bit_512k_0_avalon_slave_0_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 | cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0));
  //assign sram_16bit_512k_0_avalon_slave_0_readdata_from_sa = sram_16bit_512k_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_readdata_from_sa = sram_16bit_512k_0_avalon_slave_0_readdata;

  assign cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0 = ({cpu_0_data_master_address_to_slave[24 : 19] , 19'b0} == 25'h1080000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //sram_16bit_512k_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_arb_share_set_values = (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0)? 2 :
    (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0)? 2 :
    (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0)? 2 :
    (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0)? 2 :
    1;

  //sram_16bit_512k_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_non_bursting_master_requests = cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0 |
    cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0 |
    cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0 |
    cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;

  //sram_16bit_512k_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_any_bursting_master_saved_grant = 0;

  //sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value = sram_16bit_512k_0_avalon_slave_0_firsttransfer ? (sram_16bit_512k_0_avalon_slave_0_arb_share_set_values - 1) : |sram_16bit_512k_0_avalon_slave_0_arb_share_counter ? (sram_16bit_512k_0_avalon_slave_0_arb_share_counter - 1) : 0;

  //sram_16bit_512k_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_allgrants = (|sram_16bit_512k_0_avalon_slave_0_grant_vector) |
    (|sram_16bit_512k_0_avalon_slave_0_grant_vector) |
    (|sram_16bit_512k_0_avalon_slave_0_grant_vector) |
    (|sram_16bit_512k_0_avalon_slave_0_grant_vector);

  //sram_16bit_512k_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_end_xfer = ~(sram_16bit_512k_0_avalon_slave_0_waits_for_read | sram_16bit_512k_0_avalon_slave_0_waits_for_write);

  //end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0 = sram_16bit_512k_0_avalon_slave_0_end_xfer & (~sram_16bit_512k_0_avalon_slave_0_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sram_16bit_512k_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_arb_counter_enable = (end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0 & sram_16bit_512k_0_avalon_slave_0_allgrants) | (end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0 & ~sram_16bit_512k_0_avalon_slave_0_non_bursting_master_requests);

  //sram_16bit_512k_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_arb_share_counter <= 0;
      else if (sram_16bit_512k_0_avalon_slave_0_arb_counter_enable)
          sram_16bit_512k_0_avalon_slave_0_arb_share_counter <= sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value;
    end


  //sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable <= 0;
      else if ((|sram_16bit_512k_0_avalon_slave_0_master_qreq_vector & end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0) | (end_xfer_arb_share_counter_term_sram_16bit_512k_0_avalon_slave_0 & ~sram_16bit_512k_0_avalon_slave_0_non_bursting_master_requests))
          sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable <= |sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value;
    end


  //cpu_0/data_master sram_16bit_512k_0/avalon_slave_0 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable2 = |sram_16bit_512k_0_avalon_slave_0_arb_share_counter_next_value;

  //cpu_0/data_master sram_16bit_512k_0/avalon_slave_0 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //cpu_0/instruction_master sram_16bit_512k_0/avalon_slave_0 arbiterlock, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock = sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master sram_16bit_512k_0/avalon_slave_0 arbiterlock2, which is an e_assign
  assign cpu_0_instruction_master_arbiterlock2 = sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable2 & cpu_0_instruction_master_continuerequest;

  //cpu_0/instruction_master granted sram_16bit_512k_0/avalon_slave_0 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_instruction_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 <= 0;
      else 
        last_cycle_cpu_0_instruction_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 <= cpu_0_instruction_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 ? 1 : (sram_16bit_512k_0_avalon_slave_0_arbitration_holdoff_internal | ~cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0) ? 0 : last_cycle_cpu_0_instruction_master_granted_slave_sram_16bit_512k_0_avalon_slave_0;
    end


  //cpu_0_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_0_instruction_master_continuerequest = last_cycle_cpu_0_instruction_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 & cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;

  //sram_16bit_512k_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_any_continuerequest = cpu_0_instruction_master_continuerequest |
    cpu_0_data_master_continuerequest;

  assign cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 = cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0 & ~(((cpu_0_data_master_no_byte_enables_and_last_term | !cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0) & cpu_0_data_master_write) | cpu_0_instruction_master_arbiterlock);
  //sram_16bit_512k_0_avalon_slave_0_writedata mux, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_writedata = cpu_0_data_master_dbs_write_16;

  assign cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0 = (({cpu_0_instruction_master_address_to_slave[24 : 19] , 19'b0} == 25'h1080000) & (cpu_0_instruction_master_read)) & cpu_0_instruction_master_read;
  //cpu_0/data_master granted sram_16bit_512k_0/avalon_slave_0 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_0_data_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 <= 0;
      else 
        last_cycle_cpu_0_data_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 <= cpu_0_data_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 ? 1 : (sram_16bit_512k_0_avalon_slave_0_arbitration_holdoff_internal | ~cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0) ? 0 : last_cycle_cpu_0_data_master_granted_slave_sram_16bit_512k_0_avalon_slave_0;
    end


  //cpu_0_data_master_continuerequest continued request, which is an e_mux
  assign cpu_0_data_master_continuerequest = last_cycle_cpu_0_data_master_granted_slave_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;

  assign cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 = cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0 & ~(cpu_0_data_master_arbiterlock);
  //allow new arb cycle for sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_allow_new_arb_cycle = ~cpu_0_data_master_arbiterlock & ~cpu_0_instruction_master_arbiterlock;

  //cpu_0/instruction_master assignment into master qualified-requests vector for sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_master_qreq_vector[0] = cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;

  //cpu_0/instruction_master grant sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 = sram_16bit_512k_0_avalon_slave_0_grant_vector[0];

  //cpu_0/instruction_master saved-grant sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign cpu_0_instruction_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 = sram_16bit_512k_0_avalon_slave_0_arb_winner[0] && cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;

  //cpu_0/data_master assignment into master qualified-requests vector for sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_master_qreq_vector[1] = cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;

  //cpu_0/data_master grant sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 = sram_16bit_512k_0_avalon_slave_0_grant_vector[1];

  //cpu_0/data_master saved-grant sram_16bit_512k_0/avalon_slave_0, which is an e_assign
  assign cpu_0_data_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 = sram_16bit_512k_0_avalon_slave_0_arb_winner[1] && cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;

  //sram_16bit_512k_0/avalon_slave_0 chosen-master double-vector, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector = {sram_16bit_512k_0_avalon_slave_0_master_qreq_vector, sram_16bit_512k_0_avalon_slave_0_master_qreq_vector} & ({~sram_16bit_512k_0_avalon_slave_0_master_qreq_vector, ~sram_16bit_512k_0_avalon_slave_0_master_qreq_vector} + sram_16bit_512k_0_avalon_slave_0_arb_addend);

  //stable onehot encoding of arb winner
  assign sram_16bit_512k_0_avalon_slave_0_arb_winner = (sram_16bit_512k_0_avalon_slave_0_allow_new_arb_cycle & | sram_16bit_512k_0_avalon_slave_0_grant_vector) ? sram_16bit_512k_0_avalon_slave_0_grant_vector : sram_16bit_512k_0_avalon_slave_0_saved_chosen_master_vector;

  //saved sram_16bit_512k_0_avalon_slave_0_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_saved_chosen_master_vector <= 0;
      else if (sram_16bit_512k_0_avalon_slave_0_allow_new_arb_cycle)
          sram_16bit_512k_0_avalon_slave_0_saved_chosen_master_vector <= |sram_16bit_512k_0_avalon_slave_0_grant_vector ? sram_16bit_512k_0_avalon_slave_0_grant_vector : sram_16bit_512k_0_avalon_slave_0_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sram_16bit_512k_0_avalon_slave_0_grant_vector = {(sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector[1] | sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector[3]),
    (sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector[0] | sram_16bit_512k_0_avalon_slave_0_chosen_master_double_vector[2])};

  //sram_16bit_512k_0/avalon_slave_0 chosen master rotated left, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_chosen_master_rot_left = (sram_16bit_512k_0_avalon_slave_0_arb_winner << 1) ? (sram_16bit_512k_0_avalon_slave_0_arb_winner << 1) : 1;

  //sram_16bit_512k_0/avalon_slave_0's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_arb_addend <= 1;
      else if (|sram_16bit_512k_0_avalon_slave_0_grant_vector)
          sram_16bit_512k_0_avalon_slave_0_arb_addend <= sram_16bit_512k_0_avalon_slave_0_end_xfer? sram_16bit_512k_0_avalon_slave_0_chosen_master_rot_left : sram_16bit_512k_0_avalon_slave_0_grant_vector;
    end


  //sram_16bit_512k_0_avalon_slave_0_reset_n assignment, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_reset_n = reset_n;

  assign sram_16bit_512k_0_avalon_slave_0_chipselect_n = ~(cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 | cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0);
  //sram_16bit_512k_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_firsttransfer = sram_16bit_512k_0_avalon_slave_0_begins_xfer ? sram_16bit_512k_0_avalon_slave_0_unreg_firsttransfer : sram_16bit_512k_0_avalon_slave_0_reg_firsttransfer;

  //sram_16bit_512k_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_unreg_firsttransfer = ~(sram_16bit_512k_0_avalon_slave_0_slavearbiterlockenable & sram_16bit_512k_0_avalon_slave_0_any_continuerequest);

  //sram_16bit_512k_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_reg_firsttransfer <= 1'b1;
      else if (sram_16bit_512k_0_avalon_slave_0_begins_xfer)
          sram_16bit_512k_0_avalon_slave_0_reg_firsttransfer <= sram_16bit_512k_0_avalon_slave_0_unreg_firsttransfer;
    end


  //sram_16bit_512k_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_beginbursttransfer_internal = sram_16bit_512k_0_avalon_slave_0_begins_xfer;

  //sram_16bit_512k_0_avalon_slave_0_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_arbitration_holdoff_internal = sram_16bit_512k_0_avalon_slave_0_begins_xfer & sram_16bit_512k_0_avalon_slave_0_firsttransfer;

  //~sram_16bit_512k_0_avalon_slave_0_read_n assignment, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_read_n = ~(((cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_instruction_master_read))& ~sram_16bit_512k_0_avalon_slave_0_begins_xfer);

  //~sram_16bit_512k_0_avalon_slave_0_write_n assignment, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_write_n = ~(((cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_write)) & ~sram_16bit_512k_0_avalon_slave_0_begins_xfer & (sram_16bit_512k_0_avalon_slave_0_wait_counter >= 1));

  assign shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_data_master = {cpu_0_data_master_address_to_slave >> 2,
    cpu_0_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sram_16bit_512k_0_avalon_slave_0_address mux, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_address = (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0)? (shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_data_master >> 1) :
    (shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_instruction_master >> 1);

  assign shifted_address_to_sram_16bit_512k_0_avalon_slave_0_from_cpu_0_instruction_master = {cpu_0_instruction_master_address_to_slave >> 2,
    cpu_0_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sram_16bit_512k_0_avalon_slave_0_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sram_16bit_512k_0_avalon_slave_0_end_xfer <= 1;
      else 
        d1_sram_16bit_512k_0_avalon_slave_0_end_xfer <= sram_16bit_512k_0_avalon_slave_0_end_xfer;
    end


  //sram_16bit_512k_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_waits_for_read = sram_16bit_512k_0_avalon_slave_0_in_a_read_cycle & sram_16bit_512k_0_avalon_slave_0_begins_xfer;

  //sram_16bit_512k_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_in_a_read_cycle = (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_read) | (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sram_16bit_512k_0_avalon_slave_0_in_a_read_cycle;

  //sram_16bit_512k_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_waits_for_write = sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle & wait_for_sram_16bit_512k_0_avalon_slave_0_counter;

  //sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  assign sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle = cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle;

  assign sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0 = sram_16bit_512k_0_avalon_slave_0_wait_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sram_16bit_512k_0_avalon_slave_0_wait_counter <= 0;
      else 
        sram_16bit_512k_0_avalon_slave_0_wait_counter <= sram_16bit_512k_0_avalon_slave_0_counter_load_value;
    end


  assign sram_16bit_512k_0_avalon_slave_0_counter_load_value = ((sram_16bit_512k_0_avalon_slave_0_in_a_write_cycle & sram_16bit_512k_0_avalon_slave_0_begins_xfer))? 1 :
    (~sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0)? sram_16bit_512k_0_avalon_slave_0_wait_counter - 1 :
    0;

  assign wait_for_sram_16bit_512k_0_avalon_slave_0_counter = sram_16bit_512k_0_avalon_slave_0_begins_xfer | ~sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;
  //~sram_16bit_512k_0_avalon_slave_0_byteenable_n byte enable port mux, which is an e_mux
  assign sram_16bit_512k_0_avalon_slave_0_byteenable_n = ~((cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0)? cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0 :
    -1);

  assign {cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_1,
cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_0} = cpu_0_data_master_byteenable;
  assign cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0 = ((cpu_0_data_master_dbs_address[1] == 0))? cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_0 :
    cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sram_16bit_512k_0/avalon_slave_0 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0 + cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_0_data_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 + cpu_0_instruction_master_saved_grant_sram_16bit_512k_0_avalon_slave_0 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_0_data_master_address_to_slave,
                                         cpu_0_data_master_read,
                                         cpu_0_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_0_data_master_granted_sysid_control_slave,
                                         cpu_0_data_master_qualified_request_sysid_control_slave,
                                         cpu_0_data_master_read_data_valid_sysid_control_slave,
                                         cpu_0_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_0_data_master_granted_sysid_control_slave;
  output           cpu_0_data_master_qualified_request_sysid_control_slave;
  output           cpu_0_data_master_read_data_valid_sysid_control_slave;
  output           cpu_0_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_sysid_control_slave_from_cpu_0_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_0_data_master_requests_sysid_control_slave = (({cpu_0_data_master_address_to_slave[24 : 3] , 3'b0} == 25'h1109038) & (cpu_0_data_master_read | cpu_0_data_master_write)) & cpu_0_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_0_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu_0/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu_0/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_0_data_master_granted_sysid_control_slave = cpu_0_data_master_qualified_request_sysid_control_slave;

  //cpu_0/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_0_data_master_saved_grant_sysid_control_slave = cpu_0_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_0_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_0_data_master_granted_sysid_control_slave & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module timer_0_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_0_data_master_address_to_slave,
                                cpu_0_data_master_read,
                                cpu_0_data_master_waitrequest,
                                cpu_0_data_master_write,
                                cpu_0_data_master_writedata,
                                reset_n,
                                timer_0_s1_irq,
                                timer_0_s1_readdata,

                               // outputs:
                                cpu_0_data_master_granted_timer_0_s1,
                                cpu_0_data_master_qualified_request_timer_0_s1,
                                cpu_0_data_master_read_data_valid_timer_0_s1,
                                cpu_0_data_master_requests_timer_0_s1,
                                d1_timer_0_s1_end_xfer,
                                timer_0_s1_address,
                                timer_0_s1_chipselect,
                                timer_0_s1_irq_from_sa,
                                timer_0_s1_readdata_from_sa,
                                timer_0_s1_reset_n,
                                timer_0_s1_write_n,
                                timer_0_s1_writedata
                             )
;

  output           cpu_0_data_master_granted_timer_0_s1;
  output           cpu_0_data_master_qualified_request_timer_0_s1;
  output           cpu_0_data_master_read_data_valid_timer_0_s1;
  output           cpu_0_data_master_requests_timer_0_s1;
  output           d1_timer_0_s1_end_xfer;
  output  [  2: 0] timer_0_s1_address;
  output           timer_0_s1_chipselect;
  output           timer_0_s1_irq_from_sa;
  output  [ 15: 0] timer_0_s1_readdata_from_sa;
  output           timer_0_s1_reset_n;
  output           timer_0_s1_write_n;
  output  [ 15: 0] timer_0_s1_writedata;
  input            clk;
  input   [ 24: 0] cpu_0_data_master_address_to_slave;
  input            cpu_0_data_master_read;
  input            cpu_0_data_master_waitrequest;
  input            cpu_0_data_master_write;
  input   [ 31: 0] cpu_0_data_master_writedata;
  input            reset_n;
  input            timer_0_s1_irq;
  input   [ 15: 0] timer_0_s1_readdata;

  wire             cpu_0_data_master_arbiterlock;
  wire             cpu_0_data_master_arbiterlock2;
  wire             cpu_0_data_master_continuerequest;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_saved_grant_timer_0_s1;
  reg              d1_reasons_to_wait;
  reg              d1_timer_0_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_timer_0_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 24: 0] shifted_address_to_timer_0_s1_from_cpu_0_data_master;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_allgrants;
  wire             timer_0_s1_allow_new_arb_cycle;
  wire             timer_0_s1_any_bursting_master_saved_grant;
  wire             timer_0_s1_any_continuerequest;
  wire             timer_0_s1_arb_counter_enable;
  reg     [  1: 0] timer_0_s1_arb_share_counter;
  wire    [  1: 0] timer_0_s1_arb_share_counter_next_value;
  wire    [  1: 0] timer_0_s1_arb_share_set_values;
  wire             timer_0_s1_beginbursttransfer_internal;
  wire             timer_0_s1_begins_xfer;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_end_xfer;
  wire             timer_0_s1_firsttransfer;
  wire             timer_0_s1_grant_vector;
  wire             timer_0_s1_in_a_read_cycle;
  wire             timer_0_s1_in_a_write_cycle;
  wire             timer_0_s1_irq_from_sa;
  wire             timer_0_s1_master_qreq_vector;
  wire             timer_0_s1_non_bursting_master_requests;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  reg              timer_0_s1_reg_firsttransfer;
  wire             timer_0_s1_reset_n;
  reg              timer_0_s1_slavearbiterlockenable;
  wire             timer_0_s1_slavearbiterlockenable2;
  wire             timer_0_s1_unreg_firsttransfer;
  wire             timer_0_s1_waits_for_read;
  wire             timer_0_s1_waits_for_write;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire             wait_for_timer_0_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~timer_0_s1_end_xfer;
    end


  assign timer_0_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_0_data_master_qualified_request_timer_0_s1));
  //assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_readdata_from_sa = timer_0_s1_readdata;

  assign cpu_0_data_master_requests_timer_0_s1 = ({cpu_0_data_master_address_to_slave[24 : 5] , 5'b0} == 25'h1109000) & (cpu_0_data_master_read | cpu_0_data_master_write);
  //timer_0_s1_arb_share_counter set values, which is an e_mux
  assign timer_0_s1_arb_share_set_values = 1;

  //timer_0_s1_non_bursting_master_requests mux, which is an e_mux
  assign timer_0_s1_non_bursting_master_requests = cpu_0_data_master_requests_timer_0_s1;

  //timer_0_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign timer_0_s1_any_bursting_master_saved_grant = 0;

  //timer_0_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign timer_0_s1_arb_share_counter_next_value = timer_0_s1_firsttransfer ? (timer_0_s1_arb_share_set_values - 1) : |timer_0_s1_arb_share_counter ? (timer_0_s1_arb_share_counter - 1) : 0;

  //timer_0_s1_allgrants all slave grants, which is an e_mux
  assign timer_0_s1_allgrants = |timer_0_s1_grant_vector;

  //timer_0_s1_end_xfer assignment, which is an e_assign
  assign timer_0_s1_end_xfer = ~(timer_0_s1_waits_for_read | timer_0_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_timer_0_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_timer_0_s1 = timer_0_s1_end_xfer & (~timer_0_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //timer_0_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign timer_0_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_timer_0_s1 & timer_0_s1_allgrants) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests);

  //timer_0_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_arb_share_counter <= 0;
      else if (timer_0_s1_arb_counter_enable)
          timer_0_s1_arb_share_counter <= timer_0_s1_arb_share_counter_next_value;
    end


  //timer_0_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_slavearbiterlockenable <= 0;
      else if ((|timer_0_s1_master_qreq_vector & end_xfer_arb_share_counter_term_timer_0_s1) | (end_xfer_arb_share_counter_term_timer_0_s1 & ~timer_0_s1_non_bursting_master_requests))
          timer_0_s1_slavearbiterlockenable <= |timer_0_s1_arb_share_counter_next_value;
    end


  //cpu_0/data_master timer_0/s1 arbiterlock, which is an e_assign
  assign cpu_0_data_master_arbiterlock = timer_0_s1_slavearbiterlockenable & cpu_0_data_master_continuerequest;

  //timer_0_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign timer_0_s1_slavearbiterlockenable2 = |timer_0_s1_arb_share_counter_next_value;

  //cpu_0/data_master timer_0/s1 arbiterlock2, which is an e_assign
  assign cpu_0_data_master_arbiterlock2 = timer_0_s1_slavearbiterlockenable2 & cpu_0_data_master_continuerequest;

  //timer_0_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign timer_0_s1_any_continuerequest = 1;

  //cpu_0_data_master_continuerequest continued request, which is an e_assign
  assign cpu_0_data_master_continuerequest = 1;

  assign cpu_0_data_master_qualified_request_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1 & ~(((~cpu_0_data_master_waitrequest) & cpu_0_data_master_write));
  //timer_0_s1_writedata mux, which is an e_mux
  assign timer_0_s1_writedata = cpu_0_data_master_writedata;

  //master is always granted when requested
  assign cpu_0_data_master_granted_timer_0_s1 = cpu_0_data_master_qualified_request_timer_0_s1;

  //cpu_0/data_master saved-grant timer_0/s1, which is an e_assign
  assign cpu_0_data_master_saved_grant_timer_0_s1 = cpu_0_data_master_requests_timer_0_s1;

  //allow new arb cycle for timer_0/s1, which is an e_assign
  assign timer_0_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign timer_0_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign timer_0_s1_master_qreq_vector = 1;

  //timer_0_s1_reset_n assignment, which is an e_assign
  assign timer_0_s1_reset_n = reset_n;

  assign timer_0_s1_chipselect = cpu_0_data_master_granted_timer_0_s1;
  //timer_0_s1_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_firsttransfer = timer_0_s1_begins_xfer ? timer_0_s1_unreg_firsttransfer : timer_0_s1_reg_firsttransfer;

  //timer_0_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign timer_0_s1_unreg_firsttransfer = ~(timer_0_s1_slavearbiterlockenable & timer_0_s1_any_continuerequest);

  //timer_0_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timer_0_s1_reg_firsttransfer <= 1'b1;
      else if (timer_0_s1_begins_xfer)
          timer_0_s1_reg_firsttransfer <= timer_0_s1_unreg_firsttransfer;
    end


  //timer_0_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign timer_0_s1_beginbursttransfer_internal = timer_0_s1_begins_xfer;

  //~timer_0_s1_write_n assignment, which is an e_mux
  assign timer_0_s1_write_n = ~(cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write);

  assign shifted_address_to_timer_0_s1_from_cpu_0_data_master = cpu_0_data_master_address_to_slave;
  //timer_0_s1_address mux, which is an e_mux
  assign timer_0_s1_address = shifted_address_to_timer_0_s1_from_cpu_0_data_master >> 2;

  //d1_timer_0_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_timer_0_s1_end_xfer <= 1;
      else 
        d1_timer_0_s1_end_xfer <= timer_0_s1_end_xfer;
    end


  //timer_0_s1_waits_for_read in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_read = timer_0_s1_in_a_read_cycle & timer_0_s1_begins_xfer;

  //timer_0_s1_in_a_read_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_read_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = timer_0_s1_in_a_read_cycle;

  //timer_0_s1_waits_for_write in a cycle, which is an e_mux
  assign timer_0_s1_waits_for_write = timer_0_s1_in_a_write_cycle & 0;

  //timer_0_s1_in_a_write_cycle assignment, which is an e_assign
  assign timer_0_s1_in_a_write_cycle = cpu_0_data_master_granted_timer_0_s1 & cpu_0_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = timer_0_s1_in_a_write_cycle;

  assign wait_for_timer_0_s1_counter = 0;
  //assign timer_0_s1_irq_from_sa = timer_0_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign timer_0_s1_irq_from_sa = timer_0_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //timer_0/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module niosSystemCamControl_reset_clk_0_domain_synch_module (
                                                              // inputs:
                                                               clk,
                                                               data_in,
                                                               reset_n,

                                                              // outputs:
                                                               data_out
                                                            )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module niosSystemCamControl (
                              // 1) global signals:
                               clk_0,
                               reset_n,

                              // the_procHasControl
                               out_port_from_the_procHasControl,

                              // the_sdram_0
                               zs_addr_from_the_sdram_0,
                               zs_ba_from_the_sdram_0,
                               zs_cas_n_from_the_sdram_0,
                               zs_cke_from_the_sdram_0,
                               zs_cs_n_from_the_sdram_0,
                               zs_dq_to_and_from_the_sdram_0,
                               zs_dqm_from_the_sdram_0,
                               zs_ras_n_from_the_sdram_0,
                               zs_we_n_from_the_sdram_0,

                              // the_sram_16bit_512k_0
                               SRAM_ADDR_from_the_sram_16bit_512k_0,
                               SRAM_CE_N_from_the_sram_16bit_512k_0,
                               SRAM_DQ_to_and_from_the_sram_16bit_512k_0,
                               SRAM_LB_N_from_the_sram_16bit_512k_0,
                               SRAM_OE_N_from_the_sram_16bit_512k_0,
                               SRAM_UB_N_from_the_sram_16bit_512k_0,
                               SRAM_WE_N_from_the_sram_16bit_512k_0
                            )
;

  output  [ 17: 0] SRAM_ADDR_from_the_sram_16bit_512k_0;
  output           SRAM_CE_N_from_the_sram_16bit_512k_0;
  inout   [ 15: 0] SRAM_DQ_to_and_from_the_sram_16bit_512k_0;
  output           SRAM_LB_N_from_the_sram_16bit_512k_0;
  output           SRAM_OE_N_from_the_sram_16bit_512k_0;
  output           SRAM_UB_N_from_the_sram_16bit_512k_0;
  output           SRAM_WE_N_from_the_sram_16bit_512k_0;
  output           out_port_from_the_procHasControl;
  output  [ 11: 0] zs_addr_from_the_sdram_0;
  output  [  1: 0] zs_ba_from_the_sdram_0;
  output           zs_cas_n_from_the_sdram_0;
  output           zs_cke_from_the_sdram_0;
  output           zs_cs_n_from_the_sdram_0;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  output  [  1: 0] zs_dqm_from_the_sdram_0;
  output           zs_ras_n_from_the_sdram_0;
  output           zs_we_n_from_the_sdram_0;
  input            clk_0;
  input            reset_n;

  wire    [ 17: 0] SRAM_ADDR_from_the_sram_16bit_512k_0;
  wire             SRAM_CE_N_from_the_sram_16bit_512k_0;
  wire    [ 15: 0] SRAM_DQ_to_and_from_the_sram_16bit_512k_0;
  wire             SRAM_LB_N_from_the_sram_16bit_512k_0;
  wire             SRAM_OE_N_from_the_sram_16bit_512k_0;
  wire             SRAM_UB_N_from_the_sram_16bit_512k_0;
  wire             SRAM_WE_N_from_the_sram_16bit_512k_0;
  wire             clk_0_reset_n;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa;
  wire    [  1: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result;
  wire    [ 31: 0] cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select;
  wire             cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start;
  wire    [  4: 0] cpu_0_custom_instruction_master_a;
  wire    [  4: 0] cpu_0_custom_instruction_master_b;
  wire    [  4: 0] cpu_0_custom_instruction_master_c;
  wire             cpu_0_custom_instruction_master_clk_en;
  wire    [ 31: 0] cpu_0_custom_instruction_master_dataa;
  wire    [ 31: 0] cpu_0_custom_instruction_master_datab;
  wire             cpu_0_custom_instruction_master_done;
  wire             cpu_0_custom_instruction_master_estatus;
  wire    [ 31: 0] cpu_0_custom_instruction_master_ipending;
  wire             cpu_0_custom_instruction_master_multi_clk;
  wire             cpu_0_custom_instruction_master_multi_reset;
  wire    [  7: 0] cpu_0_custom_instruction_master_n;
  wire             cpu_0_custom_instruction_master_readra;
  wire             cpu_0_custom_instruction_master_readrb;
  wire             cpu_0_custom_instruction_master_reset_n;
  wire    [ 31: 0] cpu_0_custom_instruction_master_result;
  wire             cpu_0_custom_instruction_master_start;
  wire             cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1;
  wire             cpu_0_custom_instruction_master_status;
  wire             cpu_0_custom_instruction_master_writerc;
  wire    [ 24: 0] cpu_0_data_master_address;
  wire    [ 24: 0] cpu_0_data_master_address_to_slave;
  wire    [  3: 0] cpu_0_data_master_byteenable;
  wire    [  1: 0] cpu_0_data_master_byteenable_sdram_0_s1;
  wire    [  1: 0] cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0;
  wire    [  1: 0] cpu_0_data_master_dbs_address;
  wire    [ 15: 0] cpu_0_data_master_dbs_write_16;
  wire             cpu_0_data_master_debugaccess;
  wire             cpu_0_data_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_data_master_granted_procHasControl_s1;
  wire             cpu_0_data_master_granted_sdram_0_s1;
  wire             cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_granted_sysid_control_slave;
  wire             cpu_0_data_master_granted_timer_0_s1;
  wire    [ 31: 0] cpu_0_data_master_irq;
  wire             cpu_0_data_master_no_byte_enables_and_last_term;
  wire             cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_data_master_qualified_request_procHasControl_s1;
  wire             cpu_0_data_master_qualified_request_sdram_0_s1;
  wire             cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_qualified_request_sysid_control_slave;
  wire             cpu_0_data_master_qualified_request_timer_0_s1;
  wire             cpu_0_data_master_read;
  wire             cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire             cpu_0_data_master_read_data_valid_procHasControl_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_0_data_master_read_data_valid_timer_0_s1;
  wire    [ 31: 0] cpu_0_data_master_readdata;
  wire             cpu_0_data_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave;
  wire             cpu_0_data_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_data_master_requests_procHasControl_s1;
  wire             cpu_0_data_master_requests_sdram_0_s1;
  wire             cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_data_master_requests_sysid_control_slave;
  wire             cpu_0_data_master_requests_timer_0_s1;
  wire             cpu_0_data_master_waitrequest;
  wire             cpu_0_data_master_write;
  wire    [ 31: 0] cpu_0_data_master_writedata;
  wire    [ 24: 0] cpu_0_instruction_master_address;
  wire    [ 24: 0] cpu_0_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_0_instruction_master_dbs_address;
  wire             cpu_0_instruction_master_granted_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_granted_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_granted_sdram_0_s1;
  wire             cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sdram_0_s1;
  wire             cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_read;
  wire             cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1;
  wire             cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register;
  wire             cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0;
  wire    [ 31: 0] cpu_0_instruction_master_readdata;
  wire             cpu_0_instruction_master_requests_cpu_0_jtag_debug_module;
  wire             cpu_0_instruction_master_requests_onchip_memory2_0_s1;
  wire             cpu_0_instruction_master_requests_sdram_0_s1;
  wire             cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0;
  wire             cpu_0_instruction_master_waitrequest;
  wire    [  8: 0] cpu_0_jtag_debug_module_address;
  wire             cpu_0_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_0_jtag_debug_module_byteenable;
  wire             cpu_0_jtag_debug_module_chipselect;
  wire             cpu_0_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_0_jtag_debug_module_readdata_from_sa;
  wire             cpu_0_jtag_debug_module_resetrequest;
  wire             cpu_0_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_0_jtag_debug_module_write;
  wire    [ 31: 0] cpu_0_jtag_debug_module_writedata;
  wire             d1_cpu_0_jtag_debug_module_end_xfer;
  wire             d1_jtag_uart_0_avalon_jtag_slave_end_xfer;
  wire             d1_onchip_memory2_0_s1_end_xfer;
  wire             d1_procHasControl_s1_end_xfer;
  wire             d1_sdram_0_s1_end_xfer;
  wire             d1_sram_16bit_512k_0_avalon_slave_0_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             d1_timer_0_s1_end_xfer;
  wire             jtag_uart_0_avalon_jtag_slave_address;
  wire             jtag_uart_0_avalon_jtag_slave_chipselect;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_irq;
  wire             jtag_uart_0_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_reset_n;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_0_avalon_jtag_slave_writedata;
  wire    [ 11: 0] onchip_memory2_0_s1_address;
  wire    [  3: 0] onchip_memory2_0_s1_byteenable;
  wire             onchip_memory2_0_s1_chipselect;
  wire             onchip_memory2_0_s1_clken;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata;
  wire    [ 31: 0] onchip_memory2_0_s1_readdata_from_sa;
  wire             onchip_memory2_0_s1_reset;
  wire             onchip_memory2_0_s1_write;
  wire    [ 31: 0] onchip_memory2_0_s1_writedata;
  wire             out_port_from_the_procHasControl;
  wire    [  1: 0] procHasControl_s1_address;
  wire             procHasControl_s1_chipselect;
  wire    [ 31: 0] procHasControl_s1_readdata;
  wire    [ 31: 0] procHasControl_s1_readdata_from_sa;
  wire             procHasControl_s1_reset_n;
  wire             procHasControl_s1_write_n;
  wire    [ 31: 0] procHasControl_s1_writedata;
  wire             registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1;
  wire             reset_n_sources;
  wire    [ 21: 0] sdram_0_s1_address;
  wire    [  1: 0] sdram_0_s1_byteenable_n;
  wire             sdram_0_s1_chipselect;
  wire             sdram_0_s1_read_n;
  wire    [ 15: 0] sdram_0_s1_readdata;
  wire    [ 15: 0] sdram_0_s1_readdata_from_sa;
  wire             sdram_0_s1_readdatavalid;
  wire             sdram_0_s1_reset_n;
  wire             sdram_0_s1_waitrequest;
  wire             sdram_0_s1_waitrequest_from_sa;
  wire             sdram_0_s1_write_n;
  wire    [ 15: 0] sdram_0_s1_writedata;
  wire    [ 17: 0] sram_16bit_512k_0_avalon_slave_0_address;
  wire    [  1: 0] sram_16bit_512k_0_avalon_slave_0_byteenable_n;
  wire             sram_16bit_512k_0_avalon_slave_0_chipselect_n;
  wire             sram_16bit_512k_0_avalon_slave_0_read_n;
  wire    [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata;
  wire    [ 15: 0] sram_16bit_512k_0_avalon_slave_0_readdata_from_sa;
  wire             sram_16bit_512k_0_avalon_slave_0_reset_n;
  wire             sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0;
  wire             sram_16bit_512k_0_avalon_slave_0_write_n;
  wire    [ 15: 0] sram_16bit_512k_0_avalon_slave_0_writedata;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [  2: 0] timer_0_s1_address;
  wire             timer_0_s1_chipselect;
  wire             timer_0_s1_irq;
  wire             timer_0_s1_irq_from_sa;
  wire    [ 15: 0] timer_0_s1_readdata;
  wire    [ 15: 0] timer_0_s1_readdata_from_sa;
  wire             timer_0_s1_reset_n;
  wire             timer_0_s1_write_n;
  wire    [ 15: 0] timer_0_s1_writedata;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;
  cpu_0_jtag_debug_module_arbitrator the_cpu_0_jtag_debug_module
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_debugaccess                                      (cpu_0_data_master_debugaccess),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                  (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module        (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module          (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                 (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                        (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module           (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module   (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module          (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_jtag_debug_module_address                                    (cpu_0_jtag_debug_module_address),
      .cpu_0_jtag_debug_module_begintransfer                              (cpu_0_jtag_debug_module_begintransfer),
      .cpu_0_jtag_debug_module_byteenable                                 (cpu_0_jtag_debug_module_byteenable),
      .cpu_0_jtag_debug_module_chipselect                                 (cpu_0_jtag_debug_module_chipselect),
      .cpu_0_jtag_debug_module_debugaccess                                (cpu_0_jtag_debug_module_debugaccess),
      .cpu_0_jtag_debug_module_readdata                                   (cpu_0_jtag_debug_module_readdata),
      .cpu_0_jtag_debug_module_readdata_from_sa                           (cpu_0_jtag_debug_module_readdata_from_sa),
      .cpu_0_jtag_debug_module_resetrequest                               (cpu_0_jtag_debug_module_resetrequest),
      .cpu_0_jtag_debug_module_resetrequest_from_sa                       (cpu_0_jtag_debug_module_resetrequest_from_sa),
      .cpu_0_jtag_debug_module_write                                      (cpu_0_jtag_debug_module_write),
      .cpu_0_jtag_debug_module_writedata                                  (cpu_0_jtag_debug_module_writedata),
      .d1_cpu_0_jtag_debug_module_end_xfer                                (d1_cpu_0_jtag_debug_module_end_xfer),
      .reset_n                                                            (clk_0_reset_n)
    );

  cpu_0_custom_instruction_master_arbitrator the_cpu_0_custom_instruction_master
    (
      .clk                                                                                         (clk_0),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa                          (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa                        (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select                                (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select),
      .cpu_0_custom_instruction_master_done                                                        (cpu_0_custom_instruction_master_done),
      .cpu_0_custom_instruction_master_reset_n                                                     (cpu_0_custom_instruction_master_reset_n),
      .cpu_0_custom_instruction_master_result                                                      (cpu_0_custom_instruction_master_result),
      .cpu_0_custom_instruction_master_start                                                       (cpu_0_custom_instruction_master_start),
      .cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1 (cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1),
      .reset_n                                                                                     (clk_0_reset_n)
    );

  cpu_0_data_master_arbitrator the_cpu_0_data_master
    (
      .clk                                                                  (clk_0),
      .cpu_0_data_master_address                                            (cpu_0_data_master_address),
      .cpu_0_data_master_address_to_slave                                   (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable_sdram_0_s1                              (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0        (cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_dbs_address                                        (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                       (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_cpu_0_jtag_debug_module                    (cpu_0_data_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave              (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_granted_onchip_memory2_0_s1                        (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_granted_procHasControl_s1                          (cpu_0_data_master_granted_procHasControl_s1),
      .cpu_0_data_master_granted_sdram_0_s1                                 (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0           (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_granted_sysid_control_slave                        (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_granted_timer_0_s1                                 (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_irq                                                (cpu_0_data_master_irq),
      .cpu_0_data_master_no_byte_enables_and_last_term                      (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module          (cpu_0_data_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave    (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1              (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_qualified_request_procHasControl_s1                (cpu_0_data_master_qualified_request_procHasControl_s1),
      .cpu_0_data_master_qualified_request_sdram_0_s1                       (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 (cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_qualified_request_sysid_control_slave              (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_qualified_request_timer_0_s1                       (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_read                                               (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module            (cpu_0_data_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave      (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1                (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_read_data_valid_procHasControl_s1                  (cpu_0_data_master_read_data_valid_procHasControl_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                         (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register          (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0   (cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_read_data_valid_sysid_control_slave                (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_read_data_valid_timer_0_s1                         (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_readdata                                           (cpu_0_data_master_readdata),
      .cpu_0_data_master_requests_cpu_0_jtag_debug_module                   (cpu_0_data_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave             (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_onchip_memory2_0_s1                       (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_procHasControl_s1                         (cpu_0_data_master_requests_procHasControl_s1),
      .cpu_0_data_master_requests_sdram_0_s1                                (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0          (cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_requests_sysid_control_slave                       (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_requests_timer_0_s1                                (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_waitrequest                                        (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                              (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                          (cpu_0_data_master_writedata),
      .cpu_0_jtag_debug_module_readdata_from_sa                             (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                  (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                            (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                                      (d1_onchip_memory2_0_s1_end_xfer),
      .d1_procHasControl_s1_end_xfer                                        (d1_procHasControl_s1_end_xfer),
      .d1_sdram_0_s1_end_xfer                                               (d1_sdram_0_s1_end_xfer),
      .d1_sram_16bit_512k_0_avalon_slave_0_end_xfer                         (d1_sram_16bit_512k_0_avalon_slave_0_end_xfer),
      .d1_sysid_control_slave_end_xfer                                      (d1_sysid_control_slave_end_xfer),
      .d1_timer_0_s1_end_xfer                                               (d1_timer_0_s1_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                            (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                       (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                    (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .onchip_memory2_0_s1_readdata_from_sa                                 (onchip_memory2_0_s1_readdata_from_sa),
      .procHasControl_s1_readdata_from_sa                                   (procHasControl_s1_readdata_from_sa),
      .registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1     (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .reset_n                                                              (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                          (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                       (sdram_0_s1_waitrequest_from_sa),
      .sram_16bit_512k_0_avalon_slave_0_readdata_from_sa                    (sram_16bit_512k_0_avalon_slave_0_readdata_from_sa),
      .sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0                   (sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0),
      .sysid_control_slave_readdata_from_sa                                 (sysid_control_slave_readdata_from_sa),
      .timer_0_s1_irq_from_sa                                               (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata_from_sa                                          (timer_0_s1_readdata_from_sa)
    );

  cpu_0_instruction_master_arbitrator the_cpu_0_instruction_master
    (
      .clk                                                                         (clk_0),
      .cpu_0_instruction_master_address                                            (cpu_0_instruction_master_address),
      .cpu_0_instruction_master_address_to_slave                                   (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                                        (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_cpu_0_jtag_debug_module                    (cpu_0_instruction_master_granted_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1                        (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_granted_sdram_0_s1                                 (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0           (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module          (cpu_0_instruction_master_qualified_request_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1              (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1                       (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 (cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_read                                               (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module            (cpu_0_instruction_master_read_data_valid_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1                (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                         (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register          (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0   (cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_readdata                                           (cpu_0_instruction_master_readdata),
      .cpu_0_instruction_master_requests_cpu_0_jtag_debug_module                   (cpu_0_instruction_master_requests_cpu_0_jtag_debug_module),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1                       (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .cpu_0_instruction_master_requests_sdram_0_s1                                (cpu_0_instruction_master_requests_sdram_0_s1),
      .cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0          (cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_waitrequest                                        (cpu_0_instruction_master_waitrequest),
      .cpu_0_jtag_debug_module_readdata_from_sa                                    (cpu_0_jtag_debug_module_readdata_from_sa),
      .d1_cpu_0_jtag_debug_module_end_xfer                                         (d1_cpu_0_jtag_debug_module_end_xfer),
      .d1_onchip_memory2_0_s1_end_xfer                                             (d1_onchip_memory2_0_s1_end_xfer),
      .d1_sdram_0_s1_end_xfer                                                      (d1_sdram_0_s1_end_xfer),
      .d1_sram_16bit_512k_0_avalon_slave_0_end_xfer                                (d1_sram_16bit_512k_0_avalon_slave_0_end_xfer),
      .onchip_memory2_0_s1_readdata_from_sa                                        (onchip_memory2_0_s1_readdata_from_sa),
      .reset_n                                                                     (clk_0_reset_n),
      .sdram_0_s1_readdata_from_sa                                                 (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_waitrequest_from_sa                                              (sdram_0_s1_waitrequest_from_sa),
      .sram_16bit_512k_0_avalon_slave_0_readdata_from_sa                           (sram_16bit_512k_0_avalon_slave_0_readdata_from_sa),
      .sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0                          (sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0)
    );

  cpu_0 the_cpu_0
    (
      .D_ci_a                                (cpu_0_custom_instruction_master_a),
      .D_ci_b                                (cpu_0_custom_instruction_master_b),
      .D_ci_c                                (cpu_0_custom_instruction_master_c),
      .D_ci_n                                (cpu_0_custom_instruction_master_n),
      .D_ci_readra                           (cpu_0_custom_instruction_master_readra),
      .D_ci_readrb                           (cpu_0_custom_instruction_master_readrb),
      .D_ci_writerc                          (cpu_0_custom_instruction_master_writerc),
      .E_ci_dataa                            (cpu_0_custom_instruction_master_dataa),
      .E_ci_datab                            (cpu_0_custom_instruction_master_datab),
      .E_ci_multi_clk_en                     (cpu_0_custom_instruction_master_clk_en),
      .E_ci_multi_clock                      (cpu_0_custom_instruction_master_multi_clk),
      .E_ci_multi_done                       (cpu_0_custom_instruction_master_done),
      .E_ci_multi_reset                      (cpu_0_custom_instruction_master_multi_reset),
      .E_ci_multi_start                      (cpu_0_custom_instruction_master_start),
      .E_ci_result                           (cpu_0_custom_instruction_master_result),
      .W_ci_estatus                          (cpu_0_custom_instruction_master_estatus),
      .W_ci_ipending                         (cpu_0_custom_instruction_master_ipending),
      .W_ci_status                           (cpu_0_custom_instruction_master_status),
      .clk                                   (clk_0),
      .d_address                             (cpu_0_data_master_address),
      .d_byteenable                          (cpu_0_data_master_byteenable),
      .d_irq                                 (cpu_0_data_master_irq),
      .d_read                                (cpu_0_data_master_read),
      .d_readdata                            (cpu_0_data_master_readdata),
      .d_waitrequest                         (cpu_0_data_master_waitrequest),
      .d_write                               (cpu_0_data_master_write),
      .d_writedata                           (cpu_0_data_master_writedata),
      .i_address                             (cpu_0_instruction_master_address),
      .i_read                                (cpu_0_instruction_master_read),
      .i_readdata                            (cpu_0_instruction_master_readdata),
      .i_waitrequest                         (cpu_0_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_0_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_0_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_0_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_0_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_0_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_0_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_0_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_0_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_0_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_0_jtag_debug_module_writedata),
      .reset_n                               (cpu_0_custom_instruction_master_reset_n)
    );

  cpu_0_altera_nios_custom_instr_floating_point_inst_s1_arbitrator the_cpu_0_altera_nios_custom_instr_floating_point_inst_s1
    (
      .clk                                                                                         (clk_0),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en                                (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa                                 (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab                                 (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done                                  (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa                          (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done_from_sa),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n                                     (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset                                 (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result                                (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa                        (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result_from_sa),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select                                (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_select),
      .cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start                                 (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start),
      .cpu_0_custom_instruction_master_clk_en                                                      (cpu_0_custom_instruction_master_clk_en),
      .cpu_0_custom_instruction_master_dataa                                                       (cpu_0_custom_instruction_master_dataa),
      .cpu_0_custom_instruction_master_datab                                                       (cpu_0_custom_instruction_master_datab),
      .cpu_0_custom_instruction_master_n                                                           (cpu_0_custom_instruction_master_n),
      .cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1 (cpu_0_custom_instruction_master_start_cpu_0_altera_nios_custom_instr_floating_point_inst_s1),
      .reset_n                                                                                     (clk_0_reset_n)
    );

  cpu_0_altera_nios_custom_instr_floating_point_inst the_cpu_0_altera_nios_custom_instr_floating_point_inst
    (
      .clk    (clk_0),
      .clk_en (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_clk_en),
      .dataa  (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_dataa),
      .datab  (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_datab),
      .done   (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_done),
      .n      (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_n),
      .reset  (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_reset),
      .result (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_result),
      .start  (cpu_0_altera_nios_custom_instr_floating_point_inst_s1_start)
    );

  jtag_uart_0_avalon_jtag_slave_arbitrator the_jtag_uart_0_avalon_jtag_slave
    (
      .clk                                                               (clk_0),
      .cpu_0_data_master_address_to_slave                                (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave           (cpu_0_data_master_granted_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave (cpu_0_data_master_qualified_request_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_read                                            (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave   (cpu_0_data_master_read_data_valid_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave          (cpu_0_data_master_requests_jtag_uart_0_avalon_jtag_slave),
      .cpu_0_data_master_waitrequest                                     (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                           (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                       (cpu_0_data_master_writedata),
      .d1_jtag_uart_0_avalon_jtag_slave_end_xfer                         (d1_jtag_uart_0_avalon_jtag_slave_end_xfer),
      .jtag_uart_0_avalon_jtag_slave_address                             (jtag_uart_0_avalon_jtag_slave_address),
      .jtag_uart_0_avalon_jtag_slave_chipselect                          (jtag_uart_0_avalon_jtag_slave_chipselect),
      .jtag_uart_0_avalon_jtag_slave_dataavailable                       (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa               (jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_0_avalon_jtag_slave_irq                                 (jtag_uart_0_avalon_jtag_slave_irq),
      .jtag_uart_0_avalon_jtag_slave_irq_from_sa                         (jtag_uart_0_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_0_avalon_jtag_slave_read_n                              (jtag_uart_0_avalon_jtag_slave_read_n),
      .jtag_uart_0_avalon_jtag_slave_readdata                            (jtag_uart_0_avalon_jtag_slave_readdata),
      .jtag_uart_0_avalon_jtag_slave_readdata_from_sa                    (jtag_uart_0_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_readyfordata                        (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa                (jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_0_avalon_jtag_slave_reset_n                             (jtag_uart_0_avalon_jtag_slave_reset_n),
      .jtag_uart_0_avalon_jtag_slave_waitrequest                         (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa                 (jtag_uart_0_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_0_avalon_jtag_slave_write_n                             (jtag_uart_0_avalon_jtag_slave_write_n),
      .jtag_uart_0_avalon_jtag_slave_writedata                           (jtag_uart_0_avalon_jtag_slave_writedata),
      .reset_n                                                           (clk_0_reset_n)
    );

  jtag_uart_0 the_jtag_uart_0
    (
      .av_address     (jtag_uart_0_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_0_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_0_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_0_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_0_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_0_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_0_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_0_avalon_jtag_slave_writedata),
      .clk            (clk_0),
      .dataavailable  (jtag_uart_0_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_0_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_0_avalon_jtag_slave_reset_n)
    );

  onchip_memory2_0_s1_arbitrator the_onchip_memory2_0_s1
    (
      .clk                                                              (clk_0),
      .cpu_0_data_master_address_to_slave                               (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                     (cpu_0_data_master_byteenable),
      .cpu_0_data_master_granted_onchip_memory2_0_s1                    (cpu_0_data_master_granted_onchip_memory2_0_s1),
      .cpu_0_data_master_qualified_request_onchip_memory2_0_s1          (cpu_0_data_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_data_master_read                                           (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_onchip_memory2_0_s1            (cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_data_master_requests_onchip_memory2_0_s1                   (cpu_0_data_master_requests_onchip_memory2_0_s1),
      .cpu_0_data_master_waitrequest                                    (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                          (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                                      (cpu_0_data_master_writedata),
      .cpu_0_instruction_master_address_to_slave                        (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_granted_onchip_memory2_0_s1             (cpu_0_instruction_master_granted_onchip_memory2_0_s1),
      .cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1   (cpu_0_instruction_master_qualified_request_onchip_memory2_0_s1),
      .cpu_0_instruction_master_read                                    (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1     (cpu_0_instruction_master_read_data_valid_onchip_memory2_0_s1),
      .cpu_0_instruction_master_requests_onchip_memory2_0_s1            (cpu_0_instruction_master_requests_onchip_memory2_0_s1),
      .d1_onchip_memory2_0_s1_end_xfer                                  (d1_onchip_memory2_0_s1_end_xfer),
      .onchip_memory2_0_s1_address                                      (onchip_memory2_0_s1_address),
      .onchip_memory2_0_s1_byteenable                                   (onchip_memory2_0_s1_byteenable),
      .onchip_memory2_0_s1_chipselect                                   (onchip_memory2_0_s1_chipselect),
      .onchip_memory2_0_s1_clken                                        (onchip_memory2_0_s1_clken),
      .onchip_memory2_0_s1_readdata                                     (onchip_memory2_0_s1_readdata),
      .onchip_memory2_0_s1_readdata_from_sa                             (onchip_memory2_0_s1_readdata_from_sa),
      .onchip_memory2_0_s1_reset                                        (onchip_memory2_0_s1_reset),
      .onchip_memory2_0_s1_write                                        (onchip_memory2_0_s1_write),
      .onchip_memory2_0_s1_writedata                                    (onchip_memory2_0_s1_writedata),
      .registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1 (registered_cpu_0_data_master_read_data_valid_onchip_memory2_0_s1),
      .reset_n                                                          (clk_0_reset_n)
    );

  onchip_memory2_0 the_onchip_memory2_0
    (
      .address    (onchip_memory2_0_s1_address),
      .byteenable (onchip_memory2_0_s1_byteenable),
      .chipselect (onchip_memory2_0_s1_chipselect),
      .clk        (clk_0),
      .clken      (onchip_memory2_0_s1_clken),
      .readdata   (onchip_memory2_0_s1_readdata),
      .reset      (onchip_memory2_0_s1_reset),
      .write      (onchip_memory2_0_s1_write),
      .writedata  (onchip_memory2_0_s1_writedata)
    );

  procHasControl_s1_arbitrator the_procHasControl_s1
    (
      .clk                                                   (clk_0),
      .cpu_0_data_master_address_to_slave                    (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_procHasControl_s1           (cpu_0_data_master_granted_procHasControl_s1),
      .cpu_0_data_master_qualified_request_procHasControl_s1 (cpu_0_data_master_qualified_request_procHasControl_s1),
      .cpu_0_data_master_read                                (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_procHasControl_s1   (cpu_0_data_master_read_data_valid_procHasControl_s1),
      .cpu_0_data_master_requests_procHasControl_s1          (cpu_0_data_master_requests_procHasControl_s1),
      .cpu_0_data_master_waitrequest                         (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                               (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                           (cpu_0_data_master_writedata),
      .d1_procHasControl_s1_end_xfer                         (d1_procHasControl_s1_end_xfer),
      .procHasControl_s1_address                             (procHasControl_s1_address),
      .procHasControl_s1_chipselect                          (procHasControl_s1_chipselect),
      .procHasControl_s1_readdata                            (procHasControl_s1_readdata),
      .procHasControl_s1_readdata_from_sa                    (procHasControl_s1_readdata_from_sa),
      .procHasControl_s1_reset_n                             (procHasControl_s1_reset_n),
      .procHasControl_s1_write_n                             (procHasControl_s1_write_n),
      .procHasControl_s1_writedata                           (procHasControl_s1_writedata),
      .reset_n                                               (clk_0_reset_n)
    );

  procHasControl the_procHasControl
    (
      .address    (procHasControl_s1_address),
      .chipselect (procHasControl_s1_chipselect),
      .clk        (clk_0),
      .out_port   (out_port_from_the_procHasControl),
      .readdata   (procHasControl_s1_readdata),
      .reset_n    (procHasControl_s1_reset_n),
      .write_n    (procHasControl_s1_write_n),
      .writedata  (procHasControl_s1_writedata)
    );

  sdram_0_s1_arbitrator the_sdram_0_s1
    (
      .clk                                                                (clk_0),
      .cpu_0_data_master_address_to_slave                                 (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                       (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_sdram_0_s1                            (cpu_0_data_master_byteenable_sdram_0_s1),
      .cpu_0_data_master_dbs_address                                      (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                     (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_sdram_0_s1                               (cpu_0_data_master_granted_sdram_0_s1),
      .cpu_0_data_master_no_byte_enables_and_last_term                    (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_sdram_0_s1                     (cpu_0_data_master_qualified_request_sdram_0_s1),
      .cpu_0_data_master_read                                             (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sdram_0_s1                       (cpu_0_data_master_read_data_valid_sdram_0_s1),
      .cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register        (cpu_0_data_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_data_master_requests_sdram_0_s1                              (cpu_0_data_master_requests_sdram_0_s1),
      .cpu_0_data_master_waitrequest                                      (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                                            (cpu_0_data_master_write),
      .cpu_0_instruction_master_address_to_slave                          (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                               (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_sdram_0_s1                        (cpu_0_instruction_master_granted_sdram_0_s1),
      .cpu_0_instruction_master_qualified_request_sdram_0_s1              (cpu_0_instruction_master_qualified_request_sdram_0_s1),
      .cpu_0_instruction_master_read                                      (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1                (cpu_0_instruction_master_read_data_valid_sdram_0_s1),
      .cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register (cpu_0_instruction_master_read_data_valid_sdram_0_s1_shift_register),
      .cpu_0_instruction_master_requests_sdram_0_s1                       (cpu_0_instruction_master_requests_sdram_0_s1),
      .d1_sdram_0_s1_end_xfer                                             (d1_sdram_0_s1_end_xfer),
      .reset_n                                                            (clk_0_reset_n),
      .sdram_0_s1_address                                                 (sdram_0_s1_address),
      .sdram_0_s1_byteenable_n                                            (sdram_0_s1_byteenable_n),
      .sdram_0_s1_chipselect                                              (sdram_0_s1_chipselect),
      .sdram_0_s1_read_n                                                  (sdram_0_s1_read_n),
      .sdram_0_s1_readdata                                                (sdram_0_s1_readdata),
      .sdram_0_s1_readdata_from_sa                                        (sdram_0_s1_readdata_from_sa),
      .sdram_0_s1_readdatavalid                                           (sdram_0_s1_readdatavalid),
      .sdram_0_s1_reset_n                                                 (sdram_0_s1_reset_n),
      .sdram_0_s1_waitrequest                                             (sdram_0_s1_waitrequest),
      .sdram_0_s1_waitrequest_from_sa                                     (sdram_0_s1_waitrequest_from_sa),
      .sdram_0_s1_write_n                                                 (sdram_0_s1_write_n),
      .sdram_0_s1_writedata                                               (sdram_0_s1_writedata)
    );

  sdram_0 the_sdram_0
    (
      .az_addr        (sdram_0_s1_address),
      .az_be_n        (sdram_0_s1_byteenable_n),
      .az_cs          (sdram_0_s1_chipselect),
      .az_data        (sdram_0_s1_writedata),
      .az_rd_n        (sdram_0_s1_read_n),
      .az_wr_n        (sdram_0_s1_write_n),
      .clk            (clk_0),
      .reset_n        (sdram_0_s1_reset_n),
      .za_data        (sdram_0_s1_readdata),
      .za_valid       (sdram_0_s1_readdatavalid),
      .za_waitrequest (sdram_0_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram_0),
      .zs_ba          (zs_ba_from_the_sdram_0),
      .zs_cas_n       (zs_cas_n_from_the_sdram_0),
      .zs_cke         (zs_cke_from_the_sdram_0),
      .zs_cs_n        (zs_cs_n_from_the_sdram_0),
      .zs_dq          (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm         (zs_dqm_from_the_sdram_0),
      .zs_ras_n       (zs_ras_n_from_the_sdram_0),
      .zs_we_n        (zs_we_n_from_the_sdram_0)
    );

  sram_16bit_512k_0_avalon_slave_0_arbitrator the_sram_16bit_512k_0_avalon_slave_0
    (
      .clk                                                                         (clk_0),
      .cpu_0_data_master_address_to_slave                                          (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_byteenable                                                (cpu_0_data_master_byteenable),
      .cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0               (cpu_0_data_master_byteenable_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_dbs_address                                               (cpu_0_data_master_dbs_address),
      .cpu_0_data_master_dbs_write_16                                              (cpu_0_data_master_dbs_write_16),
      .cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0                  (cpu_0_data_master_granted_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_no_byte_enables_and_last_term                             (cpu_0_data_master_no_byte_enables_and_last_term),
      .cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0        (cpu_0_data_master_qualified_request_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_read                                                      (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0          (cpu_0_data_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0                 (cpu_0_data_master_requests_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_data_master_write                                                     (cpu_0_data_master_write),
      .cpu_0_instruction_master_address_to_slave                                   (cpu_0_instruction_master_address_to_slave),
      .cpu_0_instruction_master_dbs_address                                        (cpu_0_instruction_master_dbs_address),
      .cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0           (cpu_0_instruction_master_granted_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0 (cpu_0_instruction_master_qualified_request_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_read                                               (cpu_0_instruction_master_read),
      .cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0   (cpu_0_instruction_master_read_data_valid_sram_16bit_512k_0_avalon_slave_0),
      .cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0          (cpu_0_instruction_master_requests_sram_16bit_512k_0_avalon_slave_0),
      .d1_sram_16bit_512k_0_avalon_slave_0_end_xfer                                (d1_sram_16bit_512k_0_avalon_slave_0_end_xfer),
      .reset_n                                                                     (clk_0_reset_n),
      .sram_16bit_512k_0_avalon_slave_0_address                                    (sram_16bit_512k_0_avalon_slave_0_address),
      .sram_16bit_512k_0_avalon_slave_0_byteenable_n                               (sram_16bit_512k_0_avalon_slave_0_byteenable_n),
      .sram_16bit_512k_0_avalon_slave_0_chipselect_n                               (sram_16bit_512k_0_avalon_slave_0_chipselect_n),
      .sram_16bit_512k_0_avalon_slave_0_read_n                                     (sram_16bit_512k_0_avalon_slave_0_read_n),
      .sram_16bit_512k_0_avalon_slave_0_readdata                                   (sram_16bit_512k_0_avalon_slave_0_readdata),
      .sram_16bit_512k_0_avalon_slave_0_readdata_from_sa                           (sram_16bit_512k_0_avalon_slave_0_readdata_from_sa),
      .sram_16bit_512k_0_avalon_slave_0_reset_n                                    (sram_16bit_512k_0_avalon_slave_0_reset_n),
      .sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0                          (sram_16bit_512k_0_avalon_slave_0_wait_counter_eq_0),
      .sram_16bit_512k_0_avalon_slave_0_write_n                                    (sram_16bit_512k_0_avalon_slave_0_write_n),
      .sram_16bit_512k_0_avalon_slave_0_writedata                                  (sram_16bit_512k_0_avalon_slave_0_writedata)
    );

  sram_16bit_512k_0 the_sram_16bit_512k_0
    (
      .SRAM_ADDR (SRAM_ADDR_from_the_sram_16bit_512k_0),
      .SRAM_CE_N (SRAM_CE_N_from_the_sram_16bit_512k_0),
      .SRAM_DQ   (SRAM_DQ_to_and_from_the_sram_16bit_512k_0),
      .SRAM_LB_N (SRAM_LB_N_from_the_sram_16bit_512k_0),
      .SRAM_OE_N (SRAM_OE_N_from_the_sram_16bit_512k_0),
      .SRAM_UB_N (SRAM_UB_N_from_the_sram_16bit_512k_0),
      .SRAM_WE_N (SRAM_WE_N_from_the_sram_16bit_512k_0),
      .iADDR     (sram_16bit_512k_0_avalon_slave_0_address),
      .iBE_N     (sram_16bit_512k_0_avalon_slave_0_byteenable_n),
      .iCE_N     (sram_16bit_512k_0_avalon_slave_0_chipselect_n),
      .iCLK      (clk_0),
      .iDATA     (sram_16bit_512k_0_avalon_slave_0_writedata),
      .iOE_N     (sram_16bit_512k_0_avalon_slave_0_read_n),
      .iRST_N    (sram_16bit_512k_0_avalon_slave_0_reset_n),
      .iWE_N     (sram_16bit_512k_0_avalon_slave_0_write_n),
      .oDATA     (sram_16bit_512k_0_avalon_slave_0_readdata)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                     (clk_0),
      .cpu_0_data_master_address_to_slave                      (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_sysid_control_slave           (cpu_0_data_master_granted_sysid_control_slave),
      .cpu_0_data_master_qualified_request_sysid_control_slave (cpu_0_data_master_qualified_request_sysid_control_slave),
      .cpu_0_data_master_read                                  (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_sysid_control_slave   (cpu_0_data_master_read_data_valid_sysid_control_slave),
      .cpu_0_data_master_requests_sysid_control_slave          (cpu_0_data_master_requests_sysid_control_slave),
      .cpu_0_data_master_write                                 (cpu_0_data_master_write),
      .d1_sysid_control_slave_end_xfer                         (d1_sysid_control_slave_end_xfer),
      .reset_n                                                 (clk_0_reset_n),
      .sysid_control_slave_address                             (sysid_control_slave_address),
      .sysid_control_slave_readdata                            (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                    (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                             (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  timer_0_s1_arbitrator the_timer_0_s1
    (
      .clk                                            (clk_0),
      .cpu_0_data_master_address_to_slave             (cpu_0_data_master_address_to_slave),
      .cpu_0_data_master_granted_timer_0_s1           (cpu_0_data_master_granted_timer_0_s1),
      .cpu_0_data_master_qualified_request_timer_0_s1 (cpu_0_data_master_qualified_request_timer_0_s1),
      .cpu_0_data_master_read                         (cpu_0_data_master_read),
      .cpu_0_data_master_read_data_valid_timer_0_s1   (cpu_0_data_master_read_data_valid_timer_0_s1),
      .cpu_0_data_master_requests_timer_0_s1          (cpu_0_data_master_requests_timer_0_s1),
      .cpu_0_data_master_waitrequest                  (cpu_0_data_master_waitrequest),
      .cpu_0_data_master_write                        (cpu_0_data_master_write),
      .cpu_0_data_master_writedata                    (cpu_0_data_master_writedata),
      .d1_timer_0_s1_end_xfer                         (d1_timer_0_s1_end_xfer),
      .reset_n                                        (clk_0_reset_n),
      .timer_0_s1_address                             (timer_0_s1_address),
      .timer_0_s1_chipselect                          (timer_0_s1_chipselect),
      .timer_0_s1_irq                                 (timer_0_s1_irq),
      .timer_0_s1_irq_from_sa                         (timer_0_s1_irq_from_sa),
      .timer_0_s1_readdata                            (timer_0_s1_readdata),
      .timer_0_s1_readdata_from_sa                    (timer_0_s1_readdata_from_sa),
      .timer_0_s1_reset_n                             (timer_0_s1_reset_n),
      .timer_0_s1_write_n                             (timer_0_s1_write_n),
      .timer_0_s1_writedata                           (timer_0_s1_writedata)
    );

  timer_0 the_timer_0
    (
      .address    (timer_0_s1_address),
      .chipselect (timer_0_s1_chipselect),
      .clk        (clk_0),
      .irq        (timer_0_s1_irq),
      .readdata   (timer_0_s1_readdata),
      .reset_n    (timer_0_s1_reset_n),
      .write_n    (timer_0_s1_write_n),
      .writedata  (timer_0_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  niosSystemCamControl_reset_clk_0_domain_synch_module niosSystemCamControl_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_0_jtag_debug_module_resetrequest_from_sa |
    cpu_0_jtag_debug_module_resetrequest_from_sa);

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/11.0sp1/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/11.0sp1/quartus/eda/sim_lib/220model.v"
`include "c:/altera/11.0sp1/quartus/eda/sim_lib/sgate.v"
`include "C:/altera/11.0sp1/ip/altera/nios2_ip/altera_nios_custom_instr_floating_point_qsys/fpoint_wrapper.v"
`include "C:/altera/11.0sp1/ip/altera/nios2_ip/altera_nios_custom_instr_floating_point_qsys/fpoint_qsys.v"
`include "C:/altera/11.0sp1/ip/altera/nios2_ip/altera_nios_custom_instr_floating_point_qsys/fpoint_hw_qsys.v"
`include "cpu_0_altera_nios_custom_instr_floating_point_inst.v"
`include "hdl/SRAM_16Bit_512K.v"
`include "sram_16bit_512k_0.v"
`include "sdram_0.v"
`include "timer_0.v"
`include "sysid.v"
`include "cpu_0_test_bench.v"
`include "cpu_0_oci_test_bench.v"
`include "cpu_0_jtag_debug_module_tck.v"
`include "cpu_0_jtag_debug_module_sysclk.v"
`include "cpu_0_jtag_debug_module_wrapper.v"
`include "cpu_0.v"
`include "jtag_uart_0.v"
`include "onchip_memory2_0.v"
`include "procHasControl.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire    [ 17: 0] SRAM_ADDR_from_the_sram_16bit_512k_0;
  wire             SRAM_CE_N_from_the_sram_16bit_512k_0;
  wire    [ 15: 0] SRAM_DQ_to_and_from_the_sram_16bit_512k_0;
  wire             SRAM_LB_N_from_the_sram_16bit_512k_0;
  wire             SRAM_OE_N_from_the_sram_16bit_512k_0;
  wire             SRAM_UB_N_from_the_sram_16bit_512k_0;
  wire             SRAM_WE_N_from_the_sram_16bit_512k_0;
  wire             clk;
  reg              clk_0;
  wire    [  4: 0] cpu_0_custom_instruction_master_a;
  wire    [  4: 0] cpu_0_custom_instruction_master_b;
  wire    [  4: 0] cpu_0_custom_instruction_master_c;
  wire             cpu_0_custom_instruction_master_estatus;
  wire    [ 31: 0] cpu_0_custom_instruction_master_ipending;
  wire             cpu_0_custom_instruction_master_multi_clk;
  wire             cpu_0_custom_instruction_master_multi_reset;
  wire             cpu_0_custom_instruction_master_readra;
  wire             cpu_0_custom_instruction_master_readrb;
  wire             cpu_0_custom_instruction_master_status;
  wire             cpu_0_custom_instruction_master_writerc;
  wire             jtag_uart_0_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_0_avalon_jtag_slave_readyfordata_from_sa;
  wire             out_port_from_the_procHasControl;
  reg              reset_n;
  wire             sysid_control_slave_clock;
  wire    [ 11: 0] zs_addr_from_the_sdram_0;
  wire    [  1: 0] zs_ba_from_the_sdram_0;
  wire             zs_cas_n_from_the_sdram_0;
  wire             zs_cke_from_the_sdram_0;
  wire             zs_cs_n_from_the_sdram_0;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram_0;
  wire    [  1: 0] zs_dqm_from_the_sdram_0;
  wire             zs_ras_n_from_the_sdram_0;
  wire             zs_we_n_from_the_sdram_0;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  niosSystemCamControl DUT
    (
      .SRAM_ADDR_from_the_sram_16bit_512k_0      (SRAM_ADDR_from_the_sram_16bit_512k_0),
      .SRAM_CE_N_from_the_sram_16bit_512k_0      (SRAM_CE_N_from_the_sram_16bit_512k_0),
      .SRAM_DQ_to_and_from_the_sram_16bit_512k_0 (SRAM_DQ_to_and_from_the_sram_16bit_512k_0),
      .SRAM_LB_N_from_the_sram_16bit_512k_0      (SRAM_LB_N_from_the_sram_16bit_512k_0),
      .SRAM_OE_N_from_the_sram_16bit_512k_0      (SRAM_OE_N_from_the_sram_16bit_512k_0),
      .SRAM_UB_N_from_the_sram_16bit_512k_0      (SRAM_UB_N_from_the_sram_16bit_512k_0),
      .SRAM_WE_N_from_the_sram_16bit_512k_0      (SRAM_WE_N_from_the_sram_16bit_512k_0),
      .clk_0                                     (clk_0),
      .out_port_from_the_procHasControl          (out_port_from_the_procHasControl),
      .reset_n                                   (reset_n),
      .zs_addr_from_the_sdram_0                  (zs_addr_from_the_sdram_0),
      .zs_ba_from_the_sdram_0                    (zs_ba_from_the_sdram_0),
      .zs_cas_n_from_the_sdram_0                 (zs_cas_n_from_the_sdram_0),
      .zs_cke_from_the_sdram_0                   (zs_cke_from_the_sdram_0),
      .zs_cs_n_from_the_sdram_0                  (zs_cs_n_from_the_sdram_0),
      .zs_dq_to_and_from_the_sdram_0             (zs_dq_to_and_from_the_sdram_0),
      .zs_dqm_from_the_sdram_0                   (zs_dqm_from_the_sdram_0),
      .zs_ras_n_from_the_sdram_0                 (zs_ras_n_from_the_sdram_0),
      .zs_we_n_from_the_sdram_0                  (zs_we_n_from_the_sdram_0)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on