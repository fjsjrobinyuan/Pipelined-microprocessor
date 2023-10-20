module programmeCounter(
    input logic clk,          // Clock input
    input logic reset,        // Reset signal
    input logic beq,          // BEQ control signal
    input logic [31:0] pc_in, // New program counter value
    input logic [31:0] branch_target, // Target address for the branch
    output logic [31:0] pc    // Current program counter value
);

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            pc <= 32'b0; // Reset to address 0
        end else if (beq && (pc == branch_target)) begin
            pc <= pc_in; // Branch taken, update PC with new value
        end else begin
            pc <= pc + 32'h1; // Increment PC by 1
        end
    end

endmodule
