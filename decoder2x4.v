// Jacob Bender
//
// decoder2x4.v, 2x4 decoder, gate synthesis

module DecoderMod(s, o); // module definition
   input [0:1] s;
   output [0:3] o;
   wire [0:1] s_inv;

   not(s_inv[1], s[1]);
   not(s_inv[0], s[0]);
   

   and(o[0], s_inv[0], s_inv[1]);
   and(o[1], s_inv[1], s[0]);
   and(o[2], s_inv[0], s[1]);
   and(o[3], s[0], s[1]);    
endmodule

module TestMod;
   reg [0:1] s;
   wire [0:3] o;

   DecoderMod my_decoder(s, o); // create instance

   initial begin
      $monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b", $time, s[1], s[0], o[0], o[1], o[2], o[3]);
      $display("Time\ts1\ts0\to0\to1\to2\to3");
      $display("--------------------------------------------------");
   end

   initial begin
      s[1] = 0; 
      s[0] = 0;       
      #1;           
      s[1] = 0; 
      s[0] = 1;       
      #1;           
      s[1] = 1; 
      s[0] = 0;       
      #1;           
      s[1] = 1; 
      s[0] = 1;
   end
endmodule
