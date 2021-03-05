module half_subtractor_tb();

  reg   a,b;
  wire  diff,borrow;
 
  integer i;

  //Instantiating the half adder
  half_subtractor DUT(.a(a), .b(b), .diff(diff), .borrow(borrow));

  initial 
  begin
    a   = 1'b0;
    b   = 1'b0;
  end

  initial
  begin 
    for (i=0;i<4;i=i+1)
    begin
      {a,b}=i;
      #10;
    end
  end

  initial $monitor("Input a=%b, b=%b, Output sum =%b, carry=%b",
                  a,b,diff,borrow);

  initial #100 $finish;

endmodule