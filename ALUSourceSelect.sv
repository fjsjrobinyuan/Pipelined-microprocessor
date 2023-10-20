module ALU (
    input logic [31:0] immediate,
    input logic [31:0] operandA, 
    input logic [31:0] operandB, 
    input logic [1:0] sourceSelect,
    output logic [31:0] resultA, 
     output logic [31:0] resultB
);

always_comb begin
    case (sourceSelect)
        2'b00:begin
           resultA = immediate;
           resultB = immediate;
        end
        2'b01:begin
           resultA = immediate;
           resultB = operandB;
        end
        2'b10:begin
           resultA = operandA;
           resultB = immediate;
        end
        2'b11:begin
           resultA = operandA;
           resultB = operandB;
        end
      endcase
      end

endmodule
