module datapathController (
                           input logic [63:0] instruction,
                           input logic [1:0] ALUCompare,
                           output logic resetRegisterFile,
                                        resetMemory,
                                        registerFileRead,
                                        registerFileWrite,
                                        memoryRead,
                                        memoryWrite,
                                        sourceSelectA,
                                        sourceSelectB,
                                        PCChangeEnable,
                           output logic [1:0] computationSelect,
                           output logic [7:0] target,
                           output logic [7:0] sourceA,
                           output logic [7:0] sourceB,
                           output logic [31:0] immediate
);
always_comb begin
target <= instruction[55:48];
sourceA <= instruction[47:40];
sourceB <= instruction[39:32];
immediate <= instruction[31:0];
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
sourceSelectA <= instruction[61];
sourceSelectB <= instruction[60];
if (instruction[57:56] !== 2'b11) begin
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
end else if (instruction[57:56] == 2'b11) begin
         computationSelect[1] <= instruction [59];
         computationSelect[0] <= instruction [58];
         PCChangeEnable = 1'b0;
end
end
endmodule
