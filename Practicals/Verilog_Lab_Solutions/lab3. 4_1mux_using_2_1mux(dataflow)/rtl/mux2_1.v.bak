module mux2_1(a,
              sel,
              y);

// Step 1 : Define the port directions with proper datatypes and ranges. 
     
  input [1:0] a;	
  input sel;
  output reg y;


// Step 2 : Write the MUX behaviour as a parallel logic using case statement in behaviour modelling.


  always@(*)	
  begin
    case(sel)
      1'b0:y=a[0];
      1'b1:y=a[1];
    endcase
  end

endmodule