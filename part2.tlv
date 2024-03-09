
   $imm[31:0]  =  $is_i_instr ?  { { 21 { $instr[31] } }, $instr[30:20] }                                  :
                  $is_s_instr ?  { { 21 { $instr[31] } }, $instr[30:25], $instr[11:7] }                    :
                  $is_b_instr ?  { { 20 { $instr[31] } }, $instr[7], $instr[30:25], $instr[11:8], 1'b0 }   :
                  $is_u_instr ?  { $instr[31:12], 12'b0 }                                                  :
                  $is_j_instr ?  { { 12 { $instr[31] } }, $instr[19:12], $instr[20], $instr[30:21], 1'b0 } :
                                 32'b0 ;
   `BOGUS_USE($is_beq $is_bne $is_blt $is_bge $is_bltu $is_bgeu $is_addi $is_add)
   //decoder logic:field
   $dec_bits[10:0] = {$instr[30],$funct3,$opcode};  // concatenating all the relevant fields together
   
   $is_beq = $dec_bits ==? 11'bx_000_1100011;
   $is_bne = $dec_bits ==? 11'bx_001_1100011;
   $is_blt = $dec_bits ==? 11'bx_100_1100011;
   $is_bge = $dec_bits ==? 11'bx_101_1100011;
   
   $is_bltu = $dec_bits ==? 11'bx_110_1100011;
   $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
   
   $is_addi = $dec_bits ==? 11'bx_000_0010011;
   
   $is_add = $dec_bits ==? 11'b0_000_0110011;
   // Register File Read
   //$wr_en           =   $rd_valid
   //$wr_index[4:0]   =   $rd[4:0]
   //$wr_data[31:0]   =   $wr_data[31:0] = $result_write
   //$rd1_en          =   $rs1_valid
   //$rd1_index[4:0]  =   $rs1[4:0]
   //$rd1_data        =   $src1_value
   //$rd2_en          =   $rs2_valid
   //$rd2_index[4:0]  =   $rs2[4:0]
   //$rd2_data        =   $src2_value
   // Modified:
   // m4+rf(32, 32, $reset, $rd_valid, $rd[4:0], $wr_data[31:0] = $result_write, $rs1_valid, $rs1[4:0], $src1_value, $rs2_valid, $rs2[4:0], $src2_value)
   // Original :
   // m4+rf(32, 32, $reset, $wr_en, $wr_index[4:0], $wr_data[31:0] = $result_write, $rd1_en, $rd1_index[4:0], $rd1_data, $rd2_en, $rd2_index[4:0], $rd2_data)
    //--------------------------------------------------------------------------------------------------------------
   //arithmatic logic
   $result[31:0] = $is_addi ?  $src1_value + $imm :
                   $is_add  ?  $src1_value + $src2_value :
                               32'b0;
   //........................................................................
   // Register File Write
   $result_write[31:0] = $result;
   
   // Branch Logic
   $taken_br = $is_beq  ? $src1_value == $src2_value :
               $is_bne  ? $src1_value != $src2_value :
               $is_blt  ? ($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
               $is_bge  ? ($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
               $is_bltu ? $src1_value < $src2_value :
               $is_bgeu ? $src1_value >= $src2_value :
                          1'b0;
   
   $br_tgt_pc[31:0]  =  $pc[31:0] + $imm;
   
   
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = 1'b0;
   *failed = *cyc_cnt > M4_MAX_CYC;
   
   m4+tb()  // This macro enbles to test the design, and compile *passed = 1'b0;
   m4+rf( 32, 32, $reset, $rd_valid, $rd[4:0], $result_write[31:0], $rs1_valid, $rs1[4:0], $src1_value, $rs2_valid, $rs2[4:0], $src2_value )
   //m4+dmem(32, 32, $reset, $addr[4:0], $wr_en, $wr_data[31:0], $rd_en, $rd_data)
   m4+cpu_viz()
\SV
   endmodule
