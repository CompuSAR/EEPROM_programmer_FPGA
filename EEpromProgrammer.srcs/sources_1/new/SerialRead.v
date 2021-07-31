`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2021 04:00:40 PM
// Design Name: 
// Module Name: SerialRead
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


module SerialRead#(
    parameter ClockDivider = 434,
    parameter DataBits = 8,
    parameter StopBits = 1
)
(
    input sys_clk,
    input rx,
    output [DataBits-1:0] data,
    output dataReady,
    input dataReadyClear,
    output break
    );

localparam StartBits = 1;
localparam CounterBits = $clog2(ClockDivider);
localparam StartBitsOffset = StartBits;
localparam DataBitsOffset = StartBitsOffset + DataBits;
localparam StopBitsOffset = DataBitsOffset + StopBits; 
localparam TotalBits = StopBitsOffset;
localparam [TotalBits-1:0]IdlePattern = 'bx;
localparam [StartBits-1:0]ValidStart = 0;
localparam [StopBits-1:0]ValidStop = ~0;

reg [TotalBits-1:0]shiftRegister;
reg dataReadyReg;
reg [DataBits-1:0]dataOutput;
reg [CounterBits-1:0]divider;
reg breakReg;

assign data = dataOutput;
assign dataReady = dataReadyReg;
assign break = breakReg;

initial
begin
    shiftRegister = IdlePattern;
    dataReadyReg = 0;
    divider = 0;
    breakReg = 0;
end

wire idle = (shiftRegister === IdlePattern) && (divider == 0);

always@( posedge sys_clk )
begin
    if( dataReadyClear )
        dataReadyReg <= 0;
    
    if( !idle )
    begin
        if( divider==ClockDivider )
        begin
            divider <= 0;
            shiftRegister[TotalBits-2:0] <= shiftRegister[TotalBits-1:1]; // Shift down
            shiftRegister[TotalBits-1] <= rx;
            
            if( shiftRegister[0] == 0 )
            begin
                // We got enough symbols to construct a word
                if( shiftRegister[StartBitsOffset-1:0]==ValidStart && shiftRegister[StopBitsOffset-1:DataBitsOffset]==ValidStop )
                begin
                    // Valid word
                    dataOutput <= shiftRegister[DataBitsOffset-1:StartBitsOffset];
                    dataReadyReg <= 1;
                    shiftRegister <= IdlePattern;
                    breakReg <= 0;
                end else if( shiftRegister==0 ) begin
                    // Break
                    breakReg <= 1;
                end else begin
                    // Invalid. Ignore
                    shiftRegister <= IdlePattern;
                    breakReg <= 0;
                end
            end
        end else begin
            divider <= divider + 1;
        end
    end else begin
        if( rx==0 )
            divider = ClockDivider / 2;
    end
end

endmodule
