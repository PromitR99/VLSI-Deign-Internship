module t_ff(clk,
           reset,
           t,
           q,
           qb);

// Step1 : Declare Port Directions

  input clk,reset,t;	 
  output reg q;
  output qb;

// Step2 : Write the behavioral logic for D flip-flop functionality.

  always@(posedge clk)
  begin
    if(reset)
      q=0;
    else if(t == 1)
      q=qb;
  end

//Step3. Assign complement of q to qb.

  assign qb=~q;       

endmodule         