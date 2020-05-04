module stimulus;
  
reg clk, reset ;
reg[9:0] in_money ;
wire[9:0] out_money ;
reg[3:0] choose ;
wire canbuy_A, canbuy_B, canbuy_C, canbuy_D ;
wire[2:0] giveDrink ;
reg notbuy ;
seller seller( clk, reset, in_money, out_money, choose, canbuy_A, canbuy_B, canbuy_C, canbuy_D, giveDrink, notbuy ) ;

initial clk = 1'b1 ;
initial reset = 1'b0 ;
initial in_money = 10'd0 ;
initial choose = 4'b0000 ;
initial notbuy = 1'b0 ;


always #5 clk = ~clk ;

initial 
begin
  #5 reset = 1'b1 ; // set all

  #10               // 20����A������  �ѩ�w���@�Ӥ@�ӧ�J�|�ɭP�ɶ��L��) ;
  reset = 1'b0 ;    // �ҥH�w���@�Ӥ@�ӧ�J�����p�C�b�̫᭱ ;
  in_money = 10'd20 ;
  choose = 4'b0001 ;

  #45               // reset
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  #10               // 25����B������ ;
  reset = 1'b0 ;
  in_money = 10'd25 ;
  #5
  choose = 4'b0010 ;

  #45               // reset
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  #10               // 30����C������ ;
  reset = 1'b0 ;
  in_money = 10'd30 ;
  #5
  choose = 4'b0011 ;

  #45               // reset
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  #10               // 35����D������ ;
  reset = 1'b0 ;
  in_money = 10'd35 ;
  #5
  choose = 4'b0100 ;

  #45               // reset 
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  #10               // 5����A������->���� ;
  reset = 1'b0 ;  
  in_money = 10'd5 ;
  #5
  choose = 4'b0001 ;

  #45               // reset
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  #10               // ��20�����ܤ��R �h�X�w��(S0->S3)
  reset = 1'b0 ;
  in_money = 10'd20 ;
  #5
  notbuy = 1'b1 ;
  choose = 4'b0010 ; 

  #45               // reset
  reset = 1'b1 ;
  in_money = 10'b0 ;
  choose = 4'b0000 ;
  notbuy = 1'b0 ;
  #10               // ��10���A��5����RA(�@�ӵw���@�ӵw���B�@)
  reset = 1'b0 ;
  in_money = 10'd10 ;

  #20
  in_money = 10'd5  ;
  #5
  choose = 4'b0001 ;

  #45
  
  $stop() ;

end
	
endmodule


  