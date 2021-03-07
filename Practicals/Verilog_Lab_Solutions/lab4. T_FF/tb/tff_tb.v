module t_ff_tb();

// Step 1. Define a parameter with name "cycle" which is equal to 10  
  parameter cycle=10;		

  reg clk,
      reset,
      t;
  wire q,
       qb;

// Step 2. Instantiate the dff design       

  t_ff DUT (.clk(clk),.reset(reset),.t(t),.q(q),.qb(qb));


// Step 3. Understand the clock generation logic

  initial
  begin
    clk = 1'b0;
  end

  always
  begin
    #(cycle/2);
      clk=~clk;
  end

//Step4. Understand the various tasks used and also how to use tasks in testbench.

  task rst_dut();
  begin
    reset=1'b1;
    #10;
    reset=1'b0;
  end
  endtask

  task tin(input i);
  begin
    @(negedge clk);
    t=i;
  end
  endtask
           
  initial 
  begin
    rst_dut;
    tin(0);
    tin(1);
    tin(0);
    tin(1);
    tin(1);
    rst_dut;
    tin(0);
    tin(1);
    #10;
    $finish;
  end

// Step 5. Use $monitor task in a parallel initial block to display inputs and outputs

  initial
    $monitor("t=%d--q=%d--qb=%d",t,q,qb);

endmodule