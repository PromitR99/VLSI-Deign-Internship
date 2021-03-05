module full_subtractor(a,
                       b,
                       bin,
                       diff,
                       borrow);

  // Step 1. Write down the directions for the ports	     
  input a,b,bin;
  output diff, borrow;

  // Step 2. Declare the internal wires    
  wire w1, w2, w3;

  // Step 3. Instantiate two Half-Adders
  half_subtractor HS1(.a(a), .b(b), .diff(w1), .borrow(w2));
  half_subtractor HS2(.a(w1), .b(bin), .diff(diff), .borrow(w3));

  // Step 4. Instantiate the OR gate
  or or1(borrow, w2, w3);

endmodule