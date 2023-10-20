module instructionMemory (
    input [width-1:0] instructionAddress,
    input writeEnable,
    input fetchEnable,
    input [width-1:0] instructionInput,
    output reg [width-1:0] instructionOutput,
    input clk
);
parameter width=32;
parameter address=16;

reg [width-1:0] memory [address-1:0];

integer a;

initial begin
    for (a = 0; a < address; a = a + 1) begin
        memory[a] = 32'h00000000;
    end
end

always @(posedge clk) begin
    if (writeEnable && !fetchEnable) begin
        memory[instructionAddress] <= instructionInput;
    end
    if (fetchEnable && !writeEnable) begin
        instructionOutput <= memory[instructionAddress];
    end
end

endmodule
