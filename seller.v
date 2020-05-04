module seller( clk, reset, in_money, out_money, choose, canbuy_A, canbuy_B, canbuy_C, canbuy_D, giveDrink, notbuy );

input clk ;
input reset ;
input[9:0] in_money ;
input[3:0] choose ;
input notbuy ;
reg[9:0] nowTotalMoney ;

parameter S0 = 2'b00,   // in money
          S1 = 2'b01,   // view what drink can choose
          S2 = 2'b10,   // give drink 
          S3 = 2'b11,  // out money 
          A_price = 10'd10,
          B_price = 10'd15,
	  C_price = 10'd20,
          D_price = 10'd25;
output reg[9:0] out_money ;
output[2:0] giveDrink ; // 1 A, 2 B, 3 C, 4 D ;

output reg canbuy_A, canbuy_B, canbuy_C, canbuy_D ;

reg[1:0] state ;
reg[1:0] next_state ;

output reg[2:0] giveDrink ;

always @( posedge clk )
  begin 
    if ( reset )
      begin
      state = S3 ;
      canbuy_A = 1'b0 ;
      canbuy_B = 1'b0 ;
      canbuy_C = 1'b0 ;
      canbuy_D = 1'b0 ;
      out_money = 10'b0 ;
      giveDrink = 3'b0 ;
      nowTotalMoney  = 10'b0 ;
      end
    else
      state <= next_state ;

  end

always @( state )
  begin
  
    case(state)
      S0 :  
        begin
        // in money
	nowTotalMoney = nowTotalMoney + in_money ;
        end
      S1 :
        // show which can buy now
        begin
        if ( nowTotalMoney >= A_price )
	  canbuy_A = 1'b1 ;
        if ( nowTotalMoney >= B_price )
	  canbuy_B = 1'b1 ;
        if ( nowTotalMoney >= C_price )
	  canbuy_C = 1'b1 ;
        if ( nowTotalMoney >= D_price )
	  canbuy_D = 1'b1 ;
        end
      S2 :
        begin
        if ( choose == 4'b0001 )
          begin
	  giveDrink = 3'b001 ;
          nowTotalMoney = nowTotalMoney - A_price ;
          end
        else if ( choose == 4'b0010 )
          begin
          giveDrink = 3'b010 ;
	  nowTotalMoney = nowTotalMoney - B_price ;
          end
        else if ( choose == 4'b0011 )
          begin
          giveDrink = 3'b011 ;
          nowTotalMoney = nowTotalMoney - C_price ;
          end
        else if ( choose == 4'b0100 )
          begin
          giveDrink = 3'b100 ;
          nowTotalMoney = nowTotalMoney - D_price ;
          end
	else
          begin
          end
        end
      S3 :
        begin
        out_money = nowTotalMoney ;
	nowTotalMoney = 10'b0 ;
        end
      default :
        begin
        end

    endcase

  end 

always@( state or in_money or choose or notbuy )
  begin
    case (state)
      S0: 
        begin
        if( nowTotalMoney >= A_price )
          next_state = S1 ;
        else if ( notbuy == 1'b1 )
          next_state = S3 ;
        else 
          next_state = S0 ;
        end
      S1:
        begin
        if ( notbuy == 1'b1 )
          next_state = S3 ;
        else if ( choose == 4'b0000 )
          next_state = S0 ;
        else if ( choose == 4'b0001 && nowTotalMoney >= A_price )
          next_state = S2 ; 
        else if ( choose == 4'b0010 && nowTotalMoney >= B_price )
          next_state = S2 ;          
        else if ( choose == 4'b0011 && nowTotalMoney >= C_price )
          next_state = S2 ;
        else if ( choose == 4'b0100 && nowTotalMoney >= D_price )
          next_state = S2 ;
        end
      S2:
        next_state = S3 ;

      S3:
        next_state = S0 ;

      default :
      begin 
      end 

    endcase
  end


endmodule

