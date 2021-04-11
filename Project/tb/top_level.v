module top_level();

  parameter cycle = 10;

  reg hclk;
  reg hresetn;

  wire hready_out;
  wire [1:0] hresp;
  wire [31:0] hrdata;
 
  wire hwrite, hready_in;
  wire [1:0] htrans;
  wire [31:0] haddr, hwdata;

  wire pwrite, penable;
  wire [2:0] psel;
  wire [31:0] paddr, pwdata;

  wire pwrite_out, penable_out;
  wire [2:0] psel_out;
  wire [31:0] paddr_out, pwdata_out, prdata;

  ahb_master DUT1(.hclk(hclk), .hresetn(hresetn), 
                  .hrdata(hrdata),
                  .hresp(hresp),
                  .hready_out(hready_out),
                  .hwrite(hwrite), .hready_in(hready_in),
                  .htrans(htrans),
                  .haddr(haddr), .hwdata(hwdata));
  
  bridge_top DUT2(.hclk(hclk), .hresetn(hresetn),
                  .hwrite(hwrite), .hready_in(hready_in),
                  .htrans(htrans),
                  .hwdata(hwdata), .haddr(haddr),
                  .pwrite(pwrite), .penable(penable),
                  .psel(psel),
                  .paddr(paddr), .pwdata(pwdata),
                  .prdata(prdata),
                  .hrdata(hrdata),
                  .hresp(hresp),
                  .hready_out(hready_out));

  apb_interface DUT3(.pwrite(pwrite), .penable(penable),
                     .psel(psel),
                     .paddr(paddr), .pwdata(pwdata),
                     .pwrite_out(pwrite_out), .penable_out(penable_out),
                     .psel_out(psel_out),
                     .paddr_out(paddr_out), .pwdata_out(pwdata_out), .prdata(prdata));

  initial
  begin
    hclk = 0;
    forever
    #(cycle/2)
    hclk = ~hclk;
  end

  initial
  begin
    hresetn = 1;
    #cycle;
    hresetn = 0;

  end

endmodule
