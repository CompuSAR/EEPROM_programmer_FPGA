`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2021 12:02:08 PM
// Design Name: 
// Module Name: top_programmer
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


module top_programmer(
    input sys_clk,
    output [14:0] eeprom_address,
    inout [7:0] eeprom_data,
    output eeprom_nWE,
    output eeprom_nOE,
    output eeprom_nCE,
    output serial_tx,
    input serial_rx
    );

reg [7:0]data;
reg nWE;
assign eeprom_nWE = nWE;
assign eeprom_data = nWE ? 8'bz : data;
assign eeprom_nCE = 0;
assign eeprom_nOE = 0;

reg senderStrobe;
wire senderReady;

SerialWrite sender(sys_clk, serial_tx, /* data */ "S", /* senderStrobe */ 1, senderReady);

initial
begin
    nWE = 1;
end

endmodule
