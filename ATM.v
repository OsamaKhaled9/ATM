/////////////////////////////////////
///////////// ATM FSM /////////////// 
/////////////////////////////////////

module ATM (
input  wire        Clock, Reset, Cardless, Language, Money_Deposited, Quick_List, Manual_Withdraw_Value, Currency_Deposited, Service_Chosen,Credit_Card_Inserted, Receipt, Another_Operation,
input  wire [3:0]  Opcode,User_Pass,
input wire  [10:0] User_Mobile_No,
input wire  [15:0] User_Account_No,
input wire  [31:0] Withdraw_Value,Transfer_Value,Settlement_Amount,
output reg         ATM_Usage_Finished, Balance_Shown, Deposited_Successfully, Withdrawed_Successfully, Exchanged_Successfully, Fawry_Service_Done, Transferred_Successfully, Bank_Statement_Produced, Debt_Paid_Off
);

reg [3:0]  Correct_Pass = 4'b1010;
reg [10:0] Correct_Mobile_No = 11'b10000010111;
reg [15:0] Correct_Account_No = 16'hD903;
reg [31:0] Existing_Balance = 32'h000F4240;


localparam  [4:0]   Idle                              = 5'b00000,
					Insert_Card                       = 5'b00001,
					Cardless_Transaction              = 5'b00011,
					Choose_Language                   = 5'b00010,
					Enter_Pin_Or_OTP                  = 5'b00110,
					Choose_Transaction                = 5'b00111,
					View_Balance                      = 5'b00101,
					Deposit                           = 5'b00100,
					Confirm_Deposit                   = 5'b01100,
					Withdraw                          = 5'b01101,
					Enter_Value_Manually              = 5'b01111,
					Check_Sufficient_Funds            = 5'b01110,
					Confirm_Withdraw                  = 5'b01010,
					Exchange_Currency                 = 5'b01011,
					Confirm_Exchange                  = 5'b01001,
					Fawry_Payments                    = 5'b01000,
					Choose_Service                    = 5'b11000,
					Enter_Mobile_No                   = 5'b11001,
					Confirm_Service                   = 5'b11011,
					Money_Transfer                    = 5'b11010,
					Bank_Account_And_Transfer_Value   = 5'b11110,
					Confirm_Balance_Available         = 5'b11111,
					Confirm_Transfer                  = 5'b11101,
					Mini_Bank_Statement               = 5'b11100,
					Credit_Card_Settlement            = 5'b10100,
					Deposit_Desired_Settlement_Amount = 5'b10101,
					Confirm_Settlement                = 5'b10111,
					Print_Reciept                     = 5'b10110,
					One_More_Transaction              = 5'b10010,
					Eject_Card                        = 5'b10011;
					
					 
reg    [4:0]         current_state,
                     next_state;
		
// state transition 		
always @(posedge Clock or negedge Reset)
 begin
  if(!Reset)
   begin
     current_state <= Idle ;
   end
  else
   begin
     current_state <= next_state ;
   end
 end
 
// next_state logic
always @(*)
 begin
  case(current_state)
	  
Idle     						: begin
								if(Cardless == 1'b0)
									next_state = Insert_Card ;
								else if (Cardless == 1'b1)
									next_state = Cardless_Transaction ;
								else
									next_state = Idle ;			  
								end
				 
Insert_Card     				: begin
									next_state = Choose_Language ;			  
								end
				 
Cardless_Transaction			: begin
									next_state = Choose_Language ;			  
								end
				 
Choose_Language     			: begin
								if(Language == 1'b0)
									next_state = Choose_Language ;
								else if (Language == 1'b1)
									next_state = Enter_Pin_Or_OTP ;
								else
									next_state = Choose_Language ;			  
								end
				 
Enter_Pin_Or_OTP     			: begin
								if(User_Pass != Correct_Pass)
									next_state = Enter_Pin_Or_OTP ;
								else if (User_Pass == Correct_Pass)
									next_state = Choose_Transaction ;
								else
									next_state = Enter_Pin_Or_OTP ;			  
								end
				 
Choose_Transaction     			: begin
								if(Opcode == 4'b0000)
									next_state = Choose_Transaction ;
								else if ( (Opcode == 4'b0001) && (Cardless == 1'b0) )
									next_state = View_Balance ;
								else if ( (Opcode == 4'b0011) && (Cardless == 1'b0) )
									next_state = Deposit ;
								else if ( (Opcode == 4'b0010) && (Cardless == 1'b0) )
									next_state = Withdraw ;
								else if ( (Opcode == 4'b0110) && (Cardless == 1'b1) )
									next_state = Exchange_Currency ;
								else if ( (Opcode == 4'b0111) && (Cardless == 1'b1) )
									next_state = Fawry_Payments ;
								else if ( (Opcode == 4'b0101) && (Cardless == 1'b0) )
									next_state = Money_Transfer ;
								else if ( (Opcode == 4'b0100) && (Cardless == 1'b0) )
									next_state = Mini_Bank_Statement ;
								else if ( (Opcode == 4'b1100) && (Cardless == 1'b0) )
									next_state = Credit_Card_Settlement ;
								else
									next_state = Choose_Transaction ;			  
								end
				 
View_Balance     				: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = View_Balance ;			  
								end
				 
Deposit     					: begin
								if(Money_Deposited == 1'b0)
									next_state = Deposit ;
								else if (Money_Deposited == 1'b1)
									next_state = Confirm_Deposit ;
								else
									next_state = Deposit ;			  
								end
							
Confirm_Deposit     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Deposit ;			  
								end
				 
Withdraw     					: begin
								if(Quick_List == 1'b0)
									next_state = Enter_Value_Manually ;
								else if (Quick_List == 1'b1)
									next_state = Check_Sufficient_Funds ;
								else
									next_state = Withdraw ;			  
								end
							
Enter_Value_Manually     		: begin
								if(Manual_Withdraw_Value == 1'b0)
									next_state = Enter_Value_Manually ;
								else if (Manual_Withdraw_Value == 1'b1)
									next_state = Check_Sufficient_Funds ;
								else
									next_state = Enter_Value_Manually ;			  
								end
							
Check_Sufficient_Funds     		: begin
								if(Withdraw_Value > Existing_Balance)
									next_state = Withdraw ;
								else if (Withdraw_Value <= Existing_Balance)
									next_state = Confirm_Withdraw ;
								else
									next_state = Check_Sufficient_Funds ;			  
								end
							
Confirm_Withdraw     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Withdraw ;			  
								end
				 
Exchange_Currency     			: begin
								if(Currency_Deposited == 1'b0)
									next_state = Exchange_Currency ;
								else if (Currency_Deposited == 1'b1)
									next_state = Confirm_Exchange ;
								else
									next_state = Exchange_Currency ;			  
								end
				 
Confirm_Exchange     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Exchange ;			  
								end
							
Fawry_Payments	     			: begin
									next_state = Choose_Service ;			  
								end
							
Choose_Service     				: begin
								if(Service_Chosen == 1'b0)
									next_state = Choose_Service ;
								else if (Service_Chosen == 1'b1)
									next_state = Enter_Mobile_No ;
								else
									next_state = Choose_Service ;			  
								end
							
Enter_Mobile_No     			: begin
								if(User_Mobile_No != Correct_Mobile_No)
									next_state = Enter_Mobile_No ;
								else if (User_Mobile_No == Correct_Mobile_No)
									next_state = Confirm_Service ;
								else
									next_state = Enter_Mobile_No ;			  
								end
							
Confirm_Service     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Service ;			  
								end
							
Money_Transfer     				: begin
									next_state = Bank_Account_And_Transfer_Value ;			  
								end
							
Bank_Account_And_Transfer_Value : begin
								if(User_Account_No != Correct_Account_No)
									next_state = Bank_Account_And_Transfer_Value ;
								else if (User_Account_No == Correct_Account_No)
									next_state = Confirm_Balance_Available ;
								else
									next_state = Bank_Account_And_Transfer_Value ;			  
								end
							
Confirm_Balance_Available     	: begin
								if(Transfer_Value > Existing_Balance)
									next_state = Bank_Account_And_Transfer_Value ;
								else if (Transfer_Value <= Existing_Balance)
									next_state = Confirm_Transfer ;
								else
									next_state = Confirm_Balance_Available ;			  
								end
							
Confirm_Transfer     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Transfer ;			  
								end
							
Mini_Bank_Statement     		: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Mini_Bank_Statement ;			  
								end
							
Credit_Card_Settlement     		: begin
								if(Credit_Card_Inserted == 1'b0)
									next_state = Credit_Card_Settlement ;
								else if (Credit_Card_Inserted == 1'b1)
									next_state = Deposit_Desired_Settlement_Amount ;
								else
									next_state = Credit_Card_Settlement ;			  
								end
							
Deposit_Desired_Settlement_Amount : begin
								if(Settlement_Amount > 0)
									next_state = Confirm_Settlement;
								else
									next_state = Deposit_Desired_Settlement_Amount ;			  
								end
							
Confirm_Settlement     			: begin
								if(Receipt == 1'b0)
									next_state = One_More_Transaction ;
								else if (Receipt == 1'b1)
									next_state = Print_Reciept ;
								else
									next_state = Confirm_Settlement ;			  
								end
							
				 
Print_Reciept     				: begin
									next_state = One_More_Transaction ;			  
								end
				 
One_More_Transaction     		: begin
								if(Another_Operation == 1'b0)
									next_state = Eject_Card ;
								else if (Another_Operation == 1'b1)
									next_state = Choose_Transaction ;
								else
									next_state = One_More_Transaction ;			  
								end
				 
Eject_Card     					: begin
									next_state = Idle ;			  
								end
	
	
default :   next_state = Idle ;		 
  
  endcase
end	


// next_state logic
always @(*)
 begin
  case(current_state)
  
Idle     						: begin
									ATM_Usage_Finished        = 1'b0;   
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end 

Insert_Card     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end 

Cardless_Transaction     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Choose_Language     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Enter_Pin_Or_OTP     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Choose_Transaction     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
View_Balance     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b1;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Deposit     					: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Confirm_Deposit     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b1;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Withdraw     					: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Enter_Value_Manually     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Check_Sufficient_Funds     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Confirm_Withdraw     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b1;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Exchange_Currency     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end  
							
Confirm_Exchange     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b1;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end 
							
Fawry_Payments     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Choose_Service     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Enter_Mobile_No     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Confirm_Service     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b1;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Money_Transfer     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Bank_Account_And_Transfer_Value : begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Confirm_Balance_Available     	: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Confirm_Transfer     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b1;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Mini_Bank_Statement     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b1;
									Debt_Paid_Off             = 1'b0;
								end
							
Credit_Card_Settlement     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Deposit_Desired_Settlement_Amount: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off       = 1'b0;
								end
							
Confirm_Settlement     			: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b1;
								end
							
Print_Reciept     				: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
One_More_Transaction     		: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
Eject_Card     					: begin
									ATM_Usage_Finished        = 1'b1;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
							
default 						: begin
									ATM_Usage_Finished        = 1'b0;
									Balance_Shown             = 1'b0;
									Deposited_Successfully    = 1'b0;
									Withdrawed_Successfully   = 1'b0;
									Exchanged_Successfully    = 1'b0;
									Fawry_Service_Done        = 1'b0;
									Transferred_Successfully  = 1'b0;
									Bank_Statement_Produced   = 1'b0;
									Debt_Paid_Off             = 1'b0;
								end
			 
  endcase
 end	
 
 //psl assert always((((current_state==Enter_Value_Manually)&&Manual_Withdraw_Value)&&Reset) -> next (Check_Sufficient_Funds))@(posedge Clock);
 //psl assert always((((current_state==One_More_Transaction)&&Another_Operation)&&Reset) -> next (Choose_Transaction))@(posedge Clock);
 //psl assert always((((current_state==Withdraw)&&Quick_List)&&Reset) -> next (Check_Sufficient_Funds))@(posedge Clock);
 //psl assert always((((current_state==Enter_Pin_Or_OTP)&&(Correct_Pass==0)&&Reset)) -> next (Enter_Pin_Or_OTP))@(posedge Clock);
 
	 
		
endmodule					 