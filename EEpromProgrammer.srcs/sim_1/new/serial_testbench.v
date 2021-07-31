`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2021 02:41:57 PM
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


module serial_testbench(

    );

reg clock;
reg [7:0]data;
reg strobe;

wire txLine;
wire serialReady;

SerialWrite writer( clock, txLine,  data, strobe, serialReady );

initial
begin
    strobe = 0;
    data = "S";
end

always@(posedge clock)
begin
    strobe <= serialReady;
end

initial
begin
    clock <= 0;
    forever begin
        #10 clock <= 1;
        #10 clock <= 0;
    end
end
endmodule
