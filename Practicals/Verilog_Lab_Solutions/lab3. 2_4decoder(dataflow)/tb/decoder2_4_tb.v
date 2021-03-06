module decoder2_4_tb();

  reg [1:0] a;
  wire [3:0] y;

  integer i;

  decoder2_4 DUT(.a(a), .y(y));

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

  task inps(input [1:0] data);
  begin
    a=data;
  end
  endtask

  initial
  begin
    initialize;
    delay;
    for(i=0;i<4;i=i+1)
    begin
      inps(i);
      delay;
    end
  end

  initial
    $monitor("a[1:0]=%b--y[3:0]=%b\n",a,y);

  initial
    #100 $finish;

endmodule
