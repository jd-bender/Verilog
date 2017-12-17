//Jacob Bender
//AddSub.v, 137 Verilog Programming Assignment #4

module TestMod;                    
   parameter STDIN = 32'h8000_0000;

   reg [7:0] str [1:3];
   reg [4:0] X,Y;
   reg C0;     
   wire [4:0] S;        
   wire C5;           
   wire E;

   BigAdder bigAdder(X,Y,C0,S,C5,E);

   initial begin
      $display("Enter X (range 00 ~ 15): ");
      str[1]=$fgetc(STDIN); 
      str[2]=$fgetc(STDIN); 
      str[3]=$fgetc(STDIN);
      X = (str[1]-48)*10+(str[2]-48);

      $display("Enter Y (range 00 ~ 15): ");
      str[1] = $fgetc(STDIN);
      str[2] = $fgetc(STDIN);
      str[3] = $fgetc(STDIN);
      Y = (str[1]-48)*10+(str[2]-48);

      $display("Enter either '+' or '-': ");
      if ($fgetc(STDIN) == "+") 
         C0 = 0;
      else
         C0 = 1;

      #1;
      $display("X=%b (%d) Y=%b (%d) C0=%b", X, X, Y, Y, C0);
      $display("Result=%b (as unsigned %d)", S, S);
      $display("C5=%b E=%b", C5, E);   
   end
endmodule

module BigAdder(X, Y, C0, S, C5, E);
   input [4:0] X, Y;   
   input C0;
   output [4:0] S;     
   output C5;          
   output E;          

   wire C1, C2, C3, C4;        
   wire xory0, xory1, xory2, xory3, xory4;

   xor(xory0, Y[0], C0);
   xor(xory1, Y[1], C0);
   xor(xory2, Y[2], C0);
   xor(xory3, Y[3], C0);
   xor(xory4, Y[4], C0);

   FullAdderMod fam0(X[0], xory0, C0, S[0], C1);
   FullAdderMod fam1(X[1], xory1, C1, S[1], C2);
   FullAdderMod fam2(X[2], xory2, C2, S[2], C3);
   FullAdderMod fam3(X[3], xory3, C3, S[3], C4);
   FullAdderMod fam4(X[4], xory4, C4, S[4], C5);

   xor(E, C5, C4);
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