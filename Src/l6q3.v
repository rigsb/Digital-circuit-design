module l6q3 (output op,input ip,clk,rst);

wire opt1,opt2;

dff1 i1 (opt1,clk,rst,ip);
buf #(5) (t1,opt1);
dff2 i2 (opt2,clk,rst,t1);
xor2  i4 (opt2,t2,t1);
dff2 i3 (op,clk,rst,t2);
endmodule

//================= XOR ===============//
module xor2 (output op,input ip1,ip2);
wire t1, t2;
and #(4) (t1, ip1, ~ip2);
and #(4) (t2, ~ip1, ip2);
or #(3) (op, t1, t2);
endmodule

//================== DFF ==============//
module dff1 (output reg op,input clk,rst,ip);
always @ (posedge clk,posedge rst)
begin
if(rst)
op <= 0;
else
op <= ip;
end
endmodule
//================== Setup/Hold ==============//
module dff2 (output reg op, input clk,rst,ip);
always @ (posedge clk,posedge rst)
begin
if(rst)
op <= 0;
else
op <= ip;
end

specify
$setup (ip,posedge clk,3);
$hold (posedge clk,ip,4);
endspecify

endmodule

//================== TB ===================//
module tb;
wire top;
reg tip, tclk, trst;

l6q3 t1 (top,tip,tclk,trst);

always 
begin
tclk = 0; #8            
tclk = 1; #7;        
end					

initial
begin
trst = 1; tip = 1; #9
trst = 0; tip = 1; #1
trst = 0; tip = 0; #2
trst = 0; tip = 1; #3
trst = 0; tip = 0; #4
trst = 0; tip = 1; #5
trst = 0; tip = 0; #6
trst = 0; tip = 1; #7
trst = 0; tip = 0; #8
trst = 0; tip = 1; #9
trst = 0; tip = 0; #10
trst = 0; tip = 1; #11
trst = 0; tip = 0; #12
trst = 0; tip = 1; #13
trst = 0; tip = 0; #14;
end
endmodule
