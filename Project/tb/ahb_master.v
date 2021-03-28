module ahb_master(hclk,
                  hresetn,
                  hrdata,
                  hresp,
                  hready_out,
                  hwrite,
                  hready_in,
                  htrans,
                  haddr,
                  hwdata);

  input hclk, hresetn, hready_out;
  input [1:0] hresp;
  input [31:0] hrdata;
  output reg hwrite, hready_in;
  output reg [1:0] htrans;
  output reg [31:0] haddr, hwdata;

  parameter cycle = 10;

  task single_write(input [31:0] addr, data);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 1;
      haddr = addr;
      hready_in = 1;
    end
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd0;
      hwdata = data;
    end
  end
  endtask

  task single_read(input [31:0] addr);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 0;
      haddr = addr;
      hready_in = 1;
    end
    @(posedge hclk);
    #(cycle/10);
      htrans = 2'd0;
  end
  endtask

  initial
  begin
    single_write(32'h8842_c0a6,{$random});
    #cycle;
    single_read(32'h8400_b866);
    #(3*cycle);
    $finish;
  end

endmodule
