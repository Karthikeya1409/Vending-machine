`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2023 01:45:50 PM
// Design Name: 
// Module Name: Vending_machine
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


module Vending_machine(
input clk,
input rst,
input five,
input ten,
input [3:0] select,
input buy ,
input [3:0] load,
output reg [11:0] money=0,
output reg[3:0] products=0,
output reg [3:0] out_of_stock=0
);
reg five_prev,ten_prev;
reg buy_prev;
reg [3:0] stock0=4'b1111;
reg [3:0] stock1=4'b1111;
reg [3:0] stock2=4'b1111;
reg [3:0] stock3=4'b1111;
always@(posedge clk)
begin
five_prev<=five;
ten_prev<=ten;
buy_prev<=buy;
if(rst==1)
money<=1'b0;
else if (five_prev==1'b0&&five==1'b1)
money<=money+12'd5;
else if (ten_prev==1'b0&&ten==1'b1)
money<=money+12'd10;
else if (buy_prev==1'b0&&buy==1'b1)
case(select)
4'b0000: if(money>=12'd5 && stock0>0)
begin
products[0]<=1'b1;
stock0<=stock0-1'b1;
money<=money-12'd5;
end
4'b0010: if(money>=12'd20 && stock1>0)
begin
products[1]<=1'b1;
stock1<=stock1-1'b1;
money<=money-12'd20;
end
4'b0100: if(money>=12'd10 && stock2>0)
begin
products[2]<=1'b1;
stock2<=stock2-1'b1;
money<=money-12'd10;
end
4'b1000: if(money>=12'd10 && stock3>0)
begin
products[3]<=1'b1;
stock3<=stock3-1'b1;
money<=money-12'd10;
end
endcase
else if (buy_prev==1'b1 && buy==1'b0)
begin
products [0]<=1'b0;
products [1]<=1'b0;
products [2]<=1'b0;
products [3]<=1'b0;
end
else begin
if(stock0==4'b0000)
out_of_stock[0]<=1'b1;
else out_of_stock[0]<=1'b0;
if(stock1==4'b0000)
out_of_stock[1]<=1'b1;
else out_of_stock[1]<=1'b0;
if(stock2==4'b0000)
out_of_stock[2]<=1'b1;
else out_of_stock[2]<=1'b0;
if(stock3==4'b0000)
out_of_stock[3]<=1'b1;
else out_of_stock[3]<=1'b0;
case(load)
4'b0001:stock0<=4'b1111;
4'b0010:stock1<=4'b1111;
4'b0100:stock2<=4'b1111;
4'b1000:stock3<=4'b1111;
endcase
end
end
endmodule