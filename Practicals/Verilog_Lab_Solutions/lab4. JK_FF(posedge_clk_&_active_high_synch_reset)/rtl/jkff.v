module jkff(clk,
           reset,
           j,
           k,
           q,
           qb);

// Step1 : Declare Port Directions

  input clk,reset,j,k;	 
  output reg q;
  output qb;

// Step2 : Write the behavioral logic for D flip-flop functionality.

  always@(posedge clk)
  begin
    if(reset)
      q=0;
    else if((j == 0) && (k == 1))
      q=0;
    else if((j == 1) && (k == 0))
      q=1;
    else if((j == 1) && (k == 1))
      q=qb;
  end

//Step3. Assign complement of q to qb.

  assign qb=~q;       

endmodule         