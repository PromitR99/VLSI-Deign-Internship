module bridge_top(hclk,
                  hresetn,
                  hwrite,
                  hready_in,
                  htrans,
                  hwdata,
                  haddr,
                  pwrite,
                  penable,
                  psel,
                  paddr,
                  pwdata,
                  prdata,
                  hrdata,
                  hresp,
                  hready_out);

  input hclk, hresetn, hwrite, hready_in;
  input [1:0] htrans;
  input [31:0] hwdata, haddr;
  output pwrite, penable;
  output [2:0] psel;
  output [31:0] paddr, pwdata;
  input [31:0] prdata;
  output [31:0] hrdata;
  output [1:0] hresp;
  output hready_out;

  wire hwrite_reg, valid;
  wire [31:0] hwdata_0, hwdata_1, haddr_0, haddr_1;
  wire [2:0] temp_sel;

  ahb_slave M1(.hclk(hclk), .hresetn(hresetn), .hwrite(hwrite), 
               .hready_in(hready_in),
               .htrans(htrans),
               .hwdata(hwdata), .haddr(haddr),
               .hwrite_reg(hwrite_reg), .valid(valid),
               .hwdata_0(hwdata_0), .hwdata_1(hwdata_1), .haddr_0(haddr_0), .haddr_1(haddr_1), 
               .temp_sel(temp_sel));

  apb_fsm M2(.hclk(hclk), .hresetn(hresetn), .hwrite(hwrite),
             .valid(valid), .hwrite_reg(hwrite_reg),
             .hwdata_0(hwdata_0), .hwdata_1(hwdata_1), .haddr_0(haddr_0), .haddr_1(haddr_1),
             .temp_sel(temp_sel), 
             .pwrite(pwrite), .penable(penable),
             .psel(psel),
             .paddr(paddr), .pwdata(pwdata),
             .prdata(prdata),
             .hrdata(hrdata), .hresp(hresp), .hready_out(hready_out));

endmodule