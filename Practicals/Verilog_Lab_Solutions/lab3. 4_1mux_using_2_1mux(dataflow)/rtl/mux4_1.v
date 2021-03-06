module mux4_1(a,
              sel,
              y);

  input [3:0] a;	
  input [1:0] sel;
  output y;
  
  wire w1, w2;

  mux2_1 M1(.a(a[1:0]), .sel(sel[0]), .y(w1));
  mux2_1 M2(.a(a[3:2]), .sel(sel[0]), .y(w2));
  mux2_1 M3(.a({w2,w1}), .sel(sel[1]), .y(y));

endmodule