// Jacob Bender

module TestMod;

   reg CLK, RST;
   wire [6:0] ascii;
   wire [4:0] ripple;

   RippleMod my_ripple(CLK, RST, ripple);
   PatternEncoderMod my_pattern_encoder(ripple, ascii);

   initial begin
      $display("ASCII     Character"); 
      $monitor("%b = %c", ascii, ascii);
      RST = 1'b1;
      #3
      RST = 1'b0;
      #20
      $finish;
   end

   always begin
      CLK = 0;
      #2;
      CLK = 1;
      #2;
   end

endmodule

module PatternEncoderMod(input [4:0] ripple_out, output [6:0] ascii);

   reg [6:0] ascii;

   always @(*) begin
      case(ripple_out)
         5'b00001:
            begin
               ascii = 7'b1001010;   //J
            end
         5'b00010:
            begin
               ascii = 7'b1100001;   //a
            end
         5'b00100:
            begin
               ascii = 7'b1100011;   //c
            end
         5'b01000:
            begin
               ascii = 7'b1101111;   //o
            end
         5'b10000:
            begin
               ascii = 7'b1100010;   //b
            end
      endcase
   end
endmodule

module RippleMod(input CLK, RST, output [4:0] out2);

   reg [4:0] out1;
   reg [4:0] out2;

   always @(posedge CLK) begin
      case (RST)
         0:
            begin
               out1[1] <= out1[0];
               out1[2] <= out1[1];
               out1[3] <= out1[2];
               out1[4] <= out1[3];
               out1[0] <= out1[4];
            end
         1:
            begin
               out1[1] <= 1'b0;
               out1[2] <= 1'b0;
               out1[3] <= 1'b0;
               out1[4] <= 1'b0;
               out1[0] <= 1'b1;
            end
         default:
	    begin
               out1[1] <= 1'b0;
               out1[2] <= 1'b0;
               out1[3] <= 1'b0;
               out1[4] <= 1'b0;
               out1[0] <= 1'b1;
            end
      endcase
   end
   
   always @(*) begin
      out2 = out1;
   end
endmodule
