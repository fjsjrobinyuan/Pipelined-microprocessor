module ALU (
    input logic [31:0] operandA, // Input operand A (32-bit)
    input logic [31:0] operandB, // Input operand B (32-bit)
    input logic [1:0] aluControl, // ALU control signals (e.g., 00000 for addition, 01010 for comparison)
    output logic [31:0] result, // ALU result (32-bit)
    output logic [1:0] compareResult, // Comparison result (00: equal, 10: A > B, 01: A < B)
    output logic overflow // Overflow flag (1 if overflow, 0 otherwise)
);

always_comb begin
    case (aluControl)
        2'b00: begin
            result = operandA + operandB;
            if ((operandA[31] == operandB[31]) && (result[31] != operandA[31]))
                overflow = 1'b1;
            else
                overflow = 1'b0;
            end
        2'b01: begin
            result = operandA - operandB;
            if ((operandA[31] != operandB[31]) && (result[31] != operandA[31]))
                overflow = 1'b1;
            else
                overflow = 1'b0;
            end
        2'b11: begin
           result = operandA * operandB;
           overflow = 1'b0;
           end
        2'b10: begin
           if (operandA > operandB) 
              compareResult = 2'b10;
           else if (operandA < operandB)
              compareResult = 2'b01;
           else if (operandA == operandB)
              compareResult = 2'b00;
           end       
    endcase
end

endmodule
