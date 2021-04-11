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

  integer i;

  //Single Transfer

  task single_write(input [31:0] addr, data);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 1;
      haddr = addr;
      hwdata = 0;
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
      hwdata = 0;
      hready_in = 1;
    end
    @(posedge hclk);
    #(cycle/10);
      htrans = 2'd0;
  end
  endtask

  //8-Bit Burst Transfer

  //INCR4

  task burst_write_8bit_INCR4(input [31:0] addr);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 1;
      haddr = addr;
      hwdata = 0;
      hready_in = 1;
    end
    for(i=0;i<3;i=i+1)
    begin
      @(posedge hclk);
      #(cycle/10);
      begin
        htrans = 2'd3;
        haddr = haddr[31:0]+1'b1;
        hwdata = {$random};
        #cycle;
      end
    end
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd0;
      hwdata = {$random};
      #cycle;
    end
  end
  endtask

  task burst_read_8bit_INCR4(input [31:0] addr);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 0;
      haddr = addr;
      hwdata = 0;
      hready_in = 1;
    end
    for(i=0;i<3;i=i+1)
    begin
      @(posedge hclk);
      #(cycle/10);
      begin
        htrans = 2'd3;
        haddr = haddr[31:0]+1'b1;
        #cycle;
      end
    end
    @(posedge hclk);
    #(cycle/10);
      htrans = 2'd0;
  end
  endtask

  //WRAP4

  task burst_write_8bit_WRAP4(input [31:0] addr);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 1;
      haddr = addr;
      hwdata = 0;
      hready_in = 1;
    end
    for(i=0;i<3;i=i+1)
    begin
      @(posedge hclk);
      #(cycle/10);
      begin
        htrans = 2'd3;
        {haddr[31:2],haddr[1:0]}={haddr[31:2],haddr[1:0]+1'b1};
        hwdata = {$random};
        #cycle;
      end
    end
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd0;
      hwdata = {$random};
      #cycle;
    end
  end
  endtask

  task burst_read_8bit_WRAP4(input [31:0] addr);
  begin
    @(posedge hclk);
    #(cycle/10);
    begin
      htrans = 2'd2;
      hwrite = 0;
      haddr = addr;
      hwdata = 0;
      hready_in = 1;
    end
    for(i=0;i<3;i=i+1)
    begin
      @(posedge hclk);
      #(cycle/10);
      begin
        htrans = 2'd3;
        {haddr[31:2],haddr[1:0]}={haddr[31:2],haddr[1:0]+1'b1};
        #cycle;
      end
    end
    @(posedge hclk);
    #(cycle/10);
      htrans = 2'd0;
  end
  endtask

  initial
  begin

//Single Transfer
/*
    single_write(32'h8842_c0a6,{$random});
    #(4*cycle);

    single_read(32'h8400_b866);
    #(3*cycle);
*/
//8-Bit Burst Transfer
//INCR4
/*
    burst_write_8bit_INCR4(32'h8842_c0a6);
    #(4*cycle);

    burst_read_8bit_INCR4(32'h8400_b866);
    #(3*cycle);
*/
//WRAP4
/*
    burst_write_8bit_WRAP4(32'h8842_c0a6);
    #(4*cycle);
*/
    burst_read_8bit_WRAP4(32'h8400_b866);
    #(3*cycle);

    $finish;

  end

endmodule
