module ahb_slave_tb ();

  parameter cycle = 10;

  reg hclk, hresetn, hwrite, hready_in;
  reg [1:0] htrans;
  reg [31:0] hwdata, haddr;
  wire hwrite_reg, valid;
  wire [31:0] hwdata_0, hwdata_1, haddr_0, haddr_1;
  wire [2:0] temp_sel;

  ahb_slave DUT (.hclk(hclk), .hresetn(hresetn), .hwrite(hwrite), .hready_in(hready_in), 
                 .htrans(htrans), 
                 .hwdata(hwdata), .haddr(haddr),
                 .hwrite_reg(hwrite_reg), .valid(valid), 
                 .hwdata_0(hwdata_0), .hwdata_1(hwdata_1), .haddr_0(haddr_0), .haddr_1(haddr_1), 
                 .temp_sel(temp_sel));

  initial
  begin
    hclk = 1'b0;
    forever
    #(cycle/2)
    hclk=~hclk;
  end

  task rst_dut();
  begin
    hresetn=1'b1;
    hready_in=1'b0;
    htrans = 2'b00;
    #cycle;
    hresetn=1'b0;
  end
  endtask

  task h_inps(input write, input [31:0] addr, data);
  begin
    @(negedge hclk);
    hwrite = write;
    haddr = addr;
    hwdata = data;
  end
  endtask
  
  task h_en();
  begin
    hready_in = 1'b1;
    htrans = 2'b11;
  end
  endtask

  initial
  begin
    rst_dut;
    h_inps(1'b1, 32'h8140_1C85, 32'h8140_1C85);
    h_inps(1'b0, 32'h8440_1C85, 32'h8440_1C85);
    h_inps(1'b1, 32'h8840_1C85, 32'h8840_1C85);
    h_inps(1'b1, 32'h8C40_1C85, 32'h8C40_1C85);
    h_inps(1'b0, 32'hBF14_1C85, 32'hBF14_1C85);
    rst_dut;
    h_en;
    h_inps(1'b1, 32'h8140_1C85, 32'h8140_1C85);
    h_inps(1'b1, 32'h8440_1C85, 32'h8440_1C85);
    h_inps(1'b1, 32'h8840_1C85, 32'h8840_1C85);
    h_inps(1'b0, 32'h8C40_1C85, 32'h8C40_1C85);
    #cycle;
    #cycle;
    #cycle;
    $finish;
  end

endmodule
