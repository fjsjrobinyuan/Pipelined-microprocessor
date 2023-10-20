module datapathController (
                           input logic [63:0] instruction,//directly from the user instruction
                           input logic [1:0] ALUCompare,//compared result at alu as a result of branch if equal/bigger/smaller
                           input logic [31:0] operandAReadRF,//read operand A from the register file
                           input logic [31:0] operandBReadRF,//read operand B from the register file
                           input logic [31:0] operandAReadMEM,//read operand A from the memory
                           input logic [31:0] operandBReadMEM,//read oeprand B from the memory
                           input logic [31:0] ALUResult,//came directly from alu
                           output logic resetRegisterFile,
                                        resetMemory,
                                        registerFileRead,
                                        registerFileWrite,
                                        memoryRead,
                                        memoryWrite,
                                        PCChangeEnable,//all enablling signals
                           output logic [1:0] computationSelect,//goes to alu to select operations
                           output logic [1:0] sourceSelect,//goes to alu source selector to select sources
                           output logic [7:0] targetRF,//target address in register file
                           output logic [7:0] targetMM,//target address in memory
                           output logic [7:0] sourceAAdd,//source a address
                           output logic [7:0] sourceBAdd,//source b address
                           output logic [7:0] sourceAAddMEM,//source a address that goes to memory
                           output logic [7:0] sourceBAddMEM,//source b address that goes to memory
                           output logic [31:0] immediate,
                           output logic [31:0] operandAtobeSelected,
                           output logic [31:0] operandBtobeSelected
);
always_comb begin
targetRF <= instruction[55:48];
targetMM <= instruction[55:48];
sourceAAdd <= instruction[47:40];
sourceBAdd <= instruction[39:32];
sourceAAddMEM <= instruction[47:40];
sourceBAddMEM <= instruction[39:32];
immediate <= instruction[31:0];
sourceSelect[1:0] <= instruction[61:60];
if (instruction[57:56] !== 2'b11) begin
   computationSelect[1] <= instruction [59];
   computationSelect[0] <= instruction [58];
   case(instruction[57:56])
   2'b00:begin
               computationSelect[1:0]  = 2'b10;
               case (ALUCompare [1:0]) 
                    2'b00: PCChangeEnable = 1'b1;
                    2'b10: PCChangeEnable = 1'b0;
                    2'b01: PCChangeEnable = 1'b0;
                    default: PCChangeEnable = 1'b0;
               endcase
         end
   2'b01:begin
               computationSelect[1:0]  = 2'b10;
               case (ALUCompare [1:0]) 
                    2'b00: PCChangeEnable = 1'b0;
                    2'b10: PCChangeEnable = 1'b1;
                    2'b01: PCChangeEnable = 1'b0;
                    default: PCChangeEnable = 1'b0;
               endcase
         end
   2'b10:begin
               computationSelect[1:0]  = 2'b10;
               case (ALUCompare [1:0]) 
                    2'b00: PCChangeEnable = 1'b0;
                    2'b10: PCChangeEnable = 1'b0;
                    2'b01: PCChangeEnable = 1'b1;
                    default: PCChangeEnable = 1'b0;
               endcase
         end
  endcase
end else if (instruction[57:56] == 2'b11 && instruction[59:58] !== 2'b10) begin
         computationSelect[1] <= instruction [59];
         computationSelect[0] <= instruction [58];
         PCChangeEnable = 1'b0;
         case(instruction[63:62])
   2'b00:begin
               resetRegisterFile       = 1'b1;
               resetMemory             = 1'b0;
               registerFileRead        = 1'b0;
               registerFileWrite       = 1'b0;
               memoryRead              = 1'b0;
               memoryWrite             = 1'b0;
         end
   2'b01:begin
               resetRegisterFile       = 1'b0;
               resetMemory             = 1'b0;
               registerFileRead        = 1'b0;
               registerFileWrite       = 1'b1;
               memoryRead              = 1'b1;
               memoryWrite             = 1'b0;
         end
   2'b10:begin
               resetRegisterFile       = 1'b0;
               resetMemory             = 1'b0;
               registerFileRead        = 1'b1;
               registerFileWrite       = 1'b0;
               memoryRead              = 1'b0;
               memoryWrite             = 1'b1;
         end
   2'b11:begin
               resetRegisterFile       = 1'b0;
               resetMemory             = 1'b1;
               registerFileRead        = 1'b0;
               registerFileWrite       = 1'b0;
               memoryRead              = 1'b0;
               memoryWrite             = 1'b0;
         end
endcase
end else if (instruction[59:58] == 2'b10) begin
               memoryRead              =1'b0;
               operandAtobeSelected = operandAReadMEM;
               operandBtobeSelected = operandBReadMEM;
end
end
endmodule
