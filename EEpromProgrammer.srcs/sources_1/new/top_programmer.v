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
reg seenSenderReady;
wire senderReady;
wire dataAvailable;
wire [7:0]receivedData;
wire receivedBreak;
reg clearReceived;

SerialWrite sender(sys_clk, serial_tx, data, senderStrobe, senderReady);
SerialRead receiver(sys_clk, serial_rx, receivedData, dataAvailable, clearReceived, receivedBreak);

initial
begin
    nWE = 1;
    
    senderStrobe = 0;
    seenSenderReady = 0;
end

always@( posedge sys_clk )
begin
    if( dataAvailable )
    begin
        data <= receivedData;
        clearReceived <= 1;
        senderStrobe <= 1;
        seenSenderReady <= senderReady;
    end else begin
        clearReceived <= 0;
        case( {seenSenderReady, senderReady} )
        2'b00: ;
        2'b01: seenSenderReady <= 1;
        2'b10: begin senderStrobe<=0; seenSenderReady<=0; end
        2'b11: ;
        endcase
    end
end

endmodule
