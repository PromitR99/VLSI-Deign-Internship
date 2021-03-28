module apb_interface(pwrite,
                     penable,
                     psel,
                     paddr,
                     pwdata,
                     pwrite_out,
                     penable_out,
                     psel_out,
                     paddr_out,
                     pwdata_out,
                     prdata);

  input pwrite, penable;
  input [2:0] psel;
  input [31:0] paddr, pwdata;
  output pwrite_out, penable_out;
  output [2:0] psel_out;
  output [31:0] paddr_out, pwdata_out, prdata;

  assign pwrite_out = pwrite;
  assign penable_out = penable;
  assign psel_out = psel;
  assign paddr_out = paddr;
  assign pwdata_out = pwdata;
  assign prdata = (!pwrite && penable) ? {$random}:32'hzz;

endmodule
