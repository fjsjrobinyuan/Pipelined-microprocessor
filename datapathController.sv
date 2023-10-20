module datapathController (
    input [width-1:0] dataIn,
    output reg [width-1:0] dataNextStage,
    output reg [width-1:0] dataNextPipeline,
    input clk,
    input control
);

parameter width = 32;
always @(posedge clk) begin
   if (!control) begin
       dataNextStage <= dataIn;
   end
   if (control) begin
       dataNextPipeline <= dataIn;
   end
end

endmodule
