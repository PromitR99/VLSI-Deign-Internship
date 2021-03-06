module pe4_2(a,
             y,
             valid);

  input [3:0] a;
  output reg [1:0] y;
  output reg valid;

  always@(*)
  begin
    if(a == 4'd1)
        begin
        valid = 1;
        y = 2'b00;
      end
    else if(a[3:1] == 3'd1)
        begin
          valid = 1;
          y = 2'b01;
        end 
    else if(a[3:2] == 2'd1)
        begin
          valid = 1;
          y = 2'b10;
        end
    else if(a[3] == 1'd1)
        begin
          valid = 1;
          y = 2'b11;
        end  
    else
      begin
        valid = 0;
        y = 2'bxx;
      end
  end

endmodule
