module TopLevel;
    parameter PARAM_TOP = 16; 
    wire [7:0] dataA, dataB; 
    instructionMemory #(.width(32),.address(16)) instrMem (
        .writeEnable(instrMemWE),
        .fetchEnable(instrMemFE),
        .instructionInput(instrMemIn),
        .instructionOutput(instrMemOut)
    );
    datapathController datapathcontrol (
        .dataIn(dataIn),
        .dataOut
    )
endmodule
