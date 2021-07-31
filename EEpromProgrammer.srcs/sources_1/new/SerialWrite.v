`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2021 12:12:17 PM
// Design Name: 
// Module Name: SerialWrite
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


module SerialWrite#(
    parameter ClockDivider = 434,
    parameter DataBits = 8,
    parameter StopBits = 1
)
(
    input sys_clk,
    output tx,
    input [DataBits-1:0] data,
    input strobe,
    output ready
);

localparam StartBits = 1;
localparam CounterBits = $clog2(ClockDivider);
localparam SentBits = StartBits + DataBits;
localparam TotalBits = SentBits + StopBits;

reg [CounterBits-1:0]divider;
reg txLine;
reg readyLine;

assign tx = txLine;
assign ready = readyLine;

reg [SentBits-1:0]shiftRegister;
reg [$clog2(SentBits)-1:0]state;

initial
begin
    divider = 0;
    txLine = 1;
    
    readyLine = 1;
    state = TotalBits-1; // Indicates ready and sending out the stop bit
end

always@( posedge sys_clk )
begin
    if( divider==ClockDivider )
    begin
        divider <= 0;
        
        if( state<SentBits )
        begin
            state <= state + 1;
            readyLine <= 0;
            txLine <= shiftRegister[0];
            shiftRegister[SentBits-2:0] <= shiftRegister[SentBits-1:1]; // Shift the register
        end else begin
            txLine <= 1; // Stop bit
            if( state < TotalBits-1 )
            begin
                readyLine <= 0;
                state <= state+1;
            end else if( state == TotalBits-1 ) begin
                readyLine <= 1;
                state <= TotalBits;
            end else begin // state == TotalBits
                readyLine <= 1;
            end
        end
    end else begin
        divider <= divider + 1;
    end
end

endmodule
