`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2021 03:50:49 PM
// Design Name: 
// Module Name: serial_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module serial_receive_testbench(
    );

reg clock;
reg txLine;
reg dataReadyClear;

wire [7:0]data;
wire dataReady;
wire breakReceived;

SerialRead reader(clock, txLine, data, dataReady, dataReadyClear, breakReceived);

initial
begin
    // Clock
    clock <= 0;
    dataReadyClear <= 0;
    
    forever begin
        #10 clock <= 1;
        #10 clock <= 0;
    end
end

initial
begin
    txLine <= 1;
    #10000 txLine <= 0;
    #8681 txLine <= 1;
    #17361 txLine <= 0;
    #17361 txLine <= 1;
    #8680 txLine <= 0;
    #8681 txLine <= 1;
    #8680 txLine <= 0;
    #8681 txLine <= 1;
end

endmodule
