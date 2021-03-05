module full_subtractor(a,
                       b,
                       b_in,
                       diff,
                       borrow);
     
  input a,b,b_in;
  output diff, borrow;

  assign diff = (a ^ b) ^ b_in;
  assign borrow = (~a & b) | (b & b_in) | (~a & b_in);

endmodule