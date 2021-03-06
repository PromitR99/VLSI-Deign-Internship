module pe4_2_tb();

  reg [3:0] a;
  wire [1:0] y;
  wire valid;

  integer i;

  pe4_2 DUT(.a(a), .y(y), .valid(valid));

  task initialize;
  begin 
    a=0;
  end
  endtask

  task delay;
  begin 
    #10;
  end
  endtask

  task inps(input [3:0] data);
  begin
    a=data;
  end
  endtask

  initial
  begin
    initialize;
    delay;
    for(i=0;i<16;i=i+1)
    begin
      inps(i);
      delay;
    end
  end

  initial
    $monitor("a[3:0]=%b--y[1:0]=%b\n",a,y);

  initial
    #200 $finish;

endmodule