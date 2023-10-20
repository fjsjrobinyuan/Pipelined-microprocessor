module TopLevel (
                  input logic [63:0] instruction,
                  input logic view,
                  input logic [7:0] viewAddress,
                  output logic [31:0] dataContents,
                  output logic overflow
);
datapathController dpct(.instruction(instruction),
                        .ALUCompare(alu.compareResult),
                        .resetRegisterFile,
                        .resetMemory,
                        .registerFileRead,
                        .registerFileWrite,
                        .memoryRead,
                        .memoryWrite,
                        .sourceSelect(aluss.sourceSelect),
                        .PCChangeEnable,
                        .computationSelect(alu.aluControl),
                        .target,
                        .sourceAAdd,
                        .operandAReadRF,
                        .sourceBAdd,
                        .operandBReadRF,
                        .immediate(aluss.immediate),
                        .operandAtobeSelected(aluss.operandA),
                        .operandBtobeSelected(aluss.operandB)
                        );
ALUSourceSelect aluss(.immediate(dpct.immediate),
                      .operandA(dpct.operandAtobeSelected),
                      .operandB(dpct.operandBtobeSelected),
                      .sourceSelect(dpct.sourceSelect),
                      .resultA(alu.operandA),
                      .resultB(alu.operandB)
                      );
ALU alu(.operandA(aluss.resultA),
        .operandB(aluss.resultB),
        .aluControl(dpct.computationSelect),
        .result,
        .compareResult(dpct.ALUCompare),
        .overflow(overflow)
        );                 

endmodule
