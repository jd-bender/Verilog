// Jacob Bender
// Adder.v, 137 Verilog Programming Assignment #3

module TestMod;                    
   parameter STDIN = 32'h8000_0000;

   reg [7:0] str [1:3];
   reg [4:0] X,Y;      
   wire [4:0] S;        
   wire C5;             

   BigAdder bigAdder(X,Y,S,C5);

   initial begin
      $display("Enter X value: ");
      str[1]=$fgetc(STDIN);
      str[2]=$fgetc(STDIN);
      str[3]=$fgetc(STDIN);
      X = (str[1]-48)*10+(str[2]-48);

      $display("Enter Y value: ");
      str[1] = $fgetc(STDIN);
      str[2] = $fgetc(STDIN);
      str[3] = $fgetc(STDIN);
      Y = (str[1]-48)*10+(str[2]-48);

      #1;  
      $display("X=%d (%b) Y=%d (%b)", X, X, Y, Y);
      $display("Result=%d (%b) C5=%b", S, S, C5);
   end
endmodule

module BigAdder(X, Y, S, C5);
   input [4:0] X, Y;   
   output [4:0] S;    
   output C5;  

   wire C1, C2, C3, C4;

   FullAdderMod fam0(X[0], Y[0], 0, S[0], C1);
   FullAdderMod fam1(X[1], Y[1], C1, S[1], C2);
   FullAdderMod fam2(X[2], Y[2], C2, S[2], C3);
   FullAdderMod fam3(X[3], Y[3], C3, S[3], C4);
   FullAdderMod fam4(X[4], Y[4], C4, S[4], C5);
endmodule

module FullAdderMod(x,y,cin,s,cout);
   input x, y, cin;
   output s, cout;

   wire and0, and1, xor0;

   and(and0, x, y);
   and(and1, cin, xor0);

   xor(xor0, x, y);
   xor(s, xor0, cin);

   or(cout, and1, and0);
endmodule