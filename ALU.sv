module ALU (
    input logic [31:0] operandA,
    input logic [31:0] operandB,
    input logic [2:0] opcode,
    output logic [31:0] result,
    output logic errorTypeInfty
);
    
always_comb begin
    case(opcode)
        3'b000: result = operandA + operandB;  
        3'b001: result = operandA - operandB; 
        3'b010: result = operandA * operandB;  
        3'b011: begin
            if (operandB != 0) 
                result = operandA / operandB; 
            else
                errorTypeInfty <= 1'b1;
        end
        default: result = 32'b0;
    endcase
end
endmodule
