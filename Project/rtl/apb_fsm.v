module apb_fsm(hclk,
               hresetn,
               hwrite,
               valid,
               hwrite_reg,
               hwdata_0,
               hwdata_1,
               haddr_0,
               haddr_1,
               temp_sel,
               pwrite,
               penable,
               psel,
               paddr,
               pwdata,
               prdata,
               hrdata,
               hresp,
               hready_out);

  input hclk, hresetn, valid, hwrite, hwrite_reg;
  input [31:0] hwdata_0, hwdata_1, haddr_0, haddr_1;
  input [2:0] temp_sel;
  output reg pwrite, penable;
  output reg [2:0] psel;
  output reg [31:0] paddr, pwdata;
  input [31:0] prdata;
  output [31:0] hrdata;
  output [1:0] hresp;
  output reg hready_out;

  parameter ST_IDLE = 3'b000,
            ST_WWAIT = 3'b001,
            ST_READ = 3'b010,
            ST_WRITE = 3'b011,
            ST_WRITEP = 3'b100,
            ST_RENABLE = 3'b101,
            ST_WENABLE = 3'b110,
            ST_WENABLEP = 3'b111;

  reg [2:0] present_state,
            next_state;

  always@(posedge hclk)
  begin
    if(hresetn)
      begin
      pwrite = 0;
      penable = 0;
      psel = 0;
      paddr = 0;
      pwdata = 0;
      hready_out = 0;
      present_state <= ST_IDLE;
      end
    else
      present_state <= next_state;
  end

  always@(*)
  begin
    case (present_state)
      ST_IDLE     : begin
                    penable = 0;
                    psel = temp_sel;
                    hready_out = 1;
                    if (valid==1 && hwrite==1) 
                      next_state=ST_WWAIT;
                    else if (valid==1 && hwrite==0)
                      next_state=ST_READ;
                    else if (valid==0)
                      next_state=ST_IDLE;
                    end
      ST_WWAIT    : begin
                    psel = temp_sel;
                    hready_out = 1;
                    if (valid==1) 
                      next_state=ST_WRITEP;
                    else if (valid==0)
                      next_state=ST_WRITE;
                    end
      ST_READ     : begin
                    pwrite = 0;
                    penable = 0;
                    psel = temp_sel;
                    paddr = haddr_0;
                    hready_out = 0;
                    next_state=ST_RENABLE;
                    end
      ST_WRITE    : begin
                    pwrite = 1;
                    penable = 0;
                    psel = temp_sel;
                    paddr = haddr_1;
                    pwdata = hwdata_0;
                    hready_out = 1;
                    if (valid==1) 
                      next_state=ST_WENABLEP;
                    else if (valid==0)
                      next_state=ST_WENABLE;
                    end
      ST_WRITEP   : begin
                    pwrite = 1;
                    penable = 0; 
                    psel = temp_sel;
                    paddr = haddr_1;
                    pwdata = hwdata_0;
                    hready_out = 1;
                    next_state=ST_WENABLEP;
                    end
      ST_RENABLE  : begin
                    penable = 1;
                    psel = temp_sel;
                    paddr = haddr_1;
                    hready_out = 1;
                    if (valid==1 && hwrite==1) 
                      next_state=ST_WWAIT;
                    else if (valid==1 && hwrite==0)
                      next_state=ST_READ;
                    else if (valid==0)
                      next_state=ST_IDLE;
                    end
      ST_WENABLE  : begin
                    pwrite = 1;
                    penable = 1;
                    psel = temp_sel;
                    paddr = haddr_1;
                    pwdata = hwdata_0;
                    hready_out = 1;
                    if (valid==1 && hwrite==1) 
                      next_state=ST_WWAIT;
                    else if (valid==1 && hwrite==0)
                      next_state=ST_READ;
                    else if (valid==0)
                      next_state=ST_IDLE;
                    end
      ST_WENABLEP : begin
                    pwrite = 1;
                    penable = 1;
                    psel = temp_sel;
                    hready_out = 1;
                    if (valid==1 && hwrite_reg==1) 
                      next_state=ST_WRITEP;
                    else if (valid==0 && hwrite_reg==1)
                      next_state=ST_WRITE;
                    else if (hwrite_reg==0)
                      next_state=ST_READ;
                    end
      default     : next_state=ST_IDLE;
    endcase
  end

  assign hrdata = prdata;
  assign hresp = 2'b00;

endmodule
