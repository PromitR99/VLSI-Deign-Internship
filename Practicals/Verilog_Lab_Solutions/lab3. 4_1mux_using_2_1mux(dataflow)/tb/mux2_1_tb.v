module mux2_1_tb();

// Declaration of the variables required for testbench

  reg sel;
  reg [1:0]a;
  wire y ;

// Declaration of internal variables required for testbench 
  integer i,j;

// Step 1. Instantiate the Design 

  mux2_1 DUT(.a(a),.sel(sel),.y(y));


// Step 2. Define the body for the initialize task to initialize the variables of DUT to 0 

  task initialize;
  begin 
    a=0;
    sel=0;
  end
  endtask

// Step 3. Declare  tasks with arguments for driving stimulus to DUT 

  task select(input s);
  begin
   sel=s;
  end
  endtask



  task inps(input [1:0] data);
  begin
    a=data;
  end
  endtask


// Step 4. Call the tasks from procedural block  

  initial
  begin
    initialize;
    #10;
    for(i=0;i<2;i=i+1)
    begin
      select(i);
      for(j=0;j<4;j=j+1)
      begin
  	inps(j);
  	#10;
      end
    end
  end

// Step 5. Use $monitor task in a parallel initial block to display inputs and outputs

  initial
    $monitor("a[1:0]=%b--select=%b--y=%d\n",a,sel,y);
  
// Step 6. Use $finish task to finish the simulation in a parallel initial
// block with appropriate delay

  initial
    #400 $finish;

endmodule