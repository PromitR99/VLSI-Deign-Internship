module ahb_slave (hclk,
                  hresetn,
                  hwrite,
                  hready_in,
                  htrans,
                  hwdata,
                  haddr,
                  hwrite_reg,
                  valid,
                  hwdata_0,
                  hwdata_1,
                  haddr_0,
                  haddr_1,
                  temp_sel);

  input hclk, hresetn, hwrite, hready_in;
  input [1:0] htrans;
  input [31:0] hwdata, haddr;
  output reg hwrite_reg, valid;
  output reg [31:0] hwdata_0, hwdata_1, haddr_0, haddr_1;
  output reg [2:0] temp_sel;

  always@(posedge hclk)
    begin
      if(hresetn)
        begin
          hwrite_reg <= 0;
          hwdata_0 <= 0;
          hwdata_1 <= 0;
          haddr_0 <= 0;
          haddr_1 <= 0;
        end
      else
        begin
          hwrite_reg <= hwrite;
          hwdata_0 <= hwdata;
          hwdata_1 <= hwdata_0;
          haddr_0 <= haddr;
          haddr_1 <= haddr_0;
        end
    end

  always@(*)
    begin
      valid = 0;
      temp_sel = 3'b000;
      if(hready_in && (htrans == 2'b10 || htrans == 2'b11) && haddr >= 32'h8000_0000 && haddr < 32'h8C00_0000)
        begin    
          valid = 1'b1;
          if(haddr >= 32'h8000_0000 && haddr < 32'h8400_0000)
            temp_sel = 3'b001;
          if(haddr >= 32'h8400_0000 && haddr < 32'h8800_0000)
            temp_sel = 3'b010;
          if(haddr >= 32'h8800_0000 && haddr < 32'h8C00_0000)
            temp_sel = 3'b100;
        end
    end

endmodule