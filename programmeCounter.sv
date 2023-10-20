module programmeCounter(
    input logic clk,
    input logic [31:0] newPC,
    output logic [31:0] PC,
    input logic branchEnable
);
    logic [31:0] value;
    
    always_ff @(posedge clk) begin
        if (branchEnable)
            value <= newPC;
        else begin
            if (value == 32'hFFFFFFFF)
                value <= 32'h00000000;
            else
                value <= value + 1;
        end
    end
    
    assign PC = value;
endmodule
