module ATM_TB();
reg        Clock_tb, Reset_tb, Cardless_tb, Language_tb, Money_Deposited_tb, Quick_List_tb, Manual_Withdraw_Value_tb, Currency_Deposited_tb, Service_Chosen_tb,Credit_Card_Inserted_tb, Receipt_tb, Another_Operation_tb;
reg [3:0]  Opcode_tb,User_Pass_tb;
reg [10:0] User_Mobile_No_tb;
reg [15:0] User_Account_No_tb;
reg [31:0] Withdraw_Value_tb,Transfer_Value_tb,Settlement_Amount_tb;
wire       ATM_Usage_Finished_tb, Balance_Shown_tb, Deposited_Successfully_tb, Withdrawed_Successfully_tb, Exchanged_Successfully_tb, Fawry_Service_Done_tb, Transferred_Successfully_tb, Bank_Statement_Produced_tb, Debt_Paid_Off_tb;
integer seed , j, i;


initial
	begin
		$dumpfile("ATM.vcd");
		$dumpvars;
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		
		//Directed Testing	
		#10
		Reset_tb = 1'b1;
		#10
		Reset_tb = 1'b0;
		#10
		
			
			//Withdraw using manual value test//
			Reset_tb 					= 1'b1;
			#10
			Cardless_tb 				= 1'b0;
			#10
			Credit_Card_Inserted_tb     = 1'b0;
			#10
			Language_tb 				= 1'b1;
			#10
			User_Pass_tb 				= 4'b1010;
			#10
			Opcode_tb 					= 4'b0010;
			#10
			Quick_List_tb 				= 1'b0;
			#10
			Withdraw_Value_tb 			= 32'h00000040;
			#10
			Manual_Withdraw_Value_tb	= 1'b1;
			#10
			Receipt_tb 					= 1'b1;
			#10
			Another_Operation_tb 		= 1'b0;
			#10
			//end of withdraw test
		
		
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10
		
		
			//View Balance
			Reset_tb 					= 1'b1;
			#10
			Cardless_tb 				= 1'b0;
			#10
			Credit_Card_Inserted_tb     = 1'b0;
			#10
			Language_tb 				= 1'b1;
			#10
			User_Pass_tb 				= 4'b1010;
			#10
			Opcode_tb 					= 4'b0001;
			#10
			Receipt_tb 					= 1'b1;
			#10
			Another_Operation_tb 		= 1'b0;
			#10
			//end of view balance test
		
		
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10


			//Deposit
			Reset_tb 					= 1'b1;
			#10
			Cardless_tb 				= 1'b0;
			#10
			Language_tb 				= 1'b1;
			#10
			User_Pass_tb 				= 4'b1010;
			#10
			Opcode_tb 					= 4'b0011;
			#10
			Money_Deposited_tb          = 1'b1;
			#10
			Receipt_tb 					= 1'b1;
			#10
			Another_Operation_tb 		= 1'b0;
			#10
			// end of deposit test
		
		
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10
		

			//Exchange Currency
			Reset_tb 					= 1'b1;
			#10
			Cardless_tb 				= 1'b1;
			#10
			Language_tb 				= 1'b1;
			#10
			User_Pass_tb 				= 4'b1010;
			#10
			Opcode_tb 					= 4'b0110;
			#10
			Currency_Deposited_tb 		= 1'b1;
			#10
			Receipt_tb 					= 1'b1;
			#10
			Another_Operation_tb 		= 1'b0;
			#10
			// end of Exchange Currency test
			
			
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10
		
		
			//Withdraw using quick list
			Reset_tb 					= 1'b1;
			#10
			Cardless_tb 				= 1'b0;
			#10
			Language_tb 				= 1'b1;
			#10
			User_Pass_tb 				= 4'b1010;
			#10
			Opcode_tb 					= 4'b0010;
			#10
			Quick_List_tb 				= 1'b0;
			#10
			Withdraw_Value_tb 			= 32'h00000040;
			#10
			Manual_Withdraw_Value_tb	= 1'b1;
			#10
			Receipt_tb 					= 1'b1;
			#10
			Another_Operation_tb 		= 1'b0;
			#10
			//end of withdraw using quick list
			
			
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10
		
			//Fawry Payments test
			Reset_tb				= 1'b1;
			#10
			Cardless_tb				= 1'b1;
			#10
			Language_tb				= 1'b1;
			#10
			Opcode_tb				= 4'b0111;
			#10
			Service_Chosen_tb		= 1'b1;
			#10
			Receipt_tb				= 1'b1;
			#10
			Another_Operation_tb	= 1'b0;
			#10
			//end of Fawry Payments test
			
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10
			//Mini-Bank Statement test
			Reset_tb				= 1'b1;
			#10
			Cardless_tb				= 1'b0;
			#10
			Language_tb				= 1'b1;
			#10
			User_Pass_tb			= 4'b1010;
			#10
			Opcode_tb				= 4'b0100;
			#10
			Receipt_tb				= 1'b1;
			#10
			Another_Operation_tb	= 1'b0;
			#10
			//End of Mini-Bank Statement test
			
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10	
		
			//Money Transfer test
			Reset_tb				= 1'b1;
			#10
			Cardless_tb				= 1'b0;
			#10
			Credit_Card_Inserted_tb     = 1'b0;
			#10
			User_Pass_tb			= 4'b1010;
			#10
			Language_tb				= 1'b1;
			#10
			Opcode_tb				= 4'b0101;
			#10
			User_Account_No_tb      = 16'hD903;
			#10
			Transfer_Value_tb		= 32'h00000001;
			#10
			Receipt_tb				= 1'b1;
			#10
			Another_Operation_tb	= 1'b0;
			#10
			//End of Money Transfer test
			
		Clock_tb 					= 1'b1;
		Reset_tb					= 1'b0;
		Cardless_tb                 = 1'b0;
		Language_tb					= 1'b0;
		Money_Deposited_tb			= 1'b0;
		Quick_List_tb				= 1'b0;
		Manual_Withdraw_Value_tb	= 1'b0;
		Currency_Deposited_tb		= 1'b0;
		Service_Chosen_tb           = 1'b0;
		Credit_Card_Inserted_tb     = 1'b0;
		Receipt_tb					= 1'b0;
		Another_Operation_tb		= 1'b0;
		Opcode_tb					= 4'b0000;
		User_Pass_tb				= 4'b0000;
		User_Mobile_No_tb           = 11'b00000000000;
		User_Account_No_tb          = 16'h0000;
		Withdraw_Value_tb			= 32'h00000000;
		Transfer_Value_tb			= 32'h00000000;
		Settlement_Amount_tb		= 32'h00000000;
		#10			
		
		
		#100
		
		Reset_tb                    = 1'b1;
		User_Pass_tb				= 4'b1010;
		User_Mobile_No_tb           = 11'b10000010111;
		User_Account_No_tb          = 16'hD903;
		#20
		


		//Randomized Testing
			for(j=0 ; j<70 ; j=j+1)
			begin
			
				seed =j;
				$display("seed is %d" , seed);

					for(i=0 ; i<99999 ; i=i+1)
					begin
					
						#10
						Reset_tb				  =$random(seed);
						Cardless_tb               =$random(seed);              
						Language_tb               =$random(seed);
						Money_Deposited_tb        =$random(seed);
						Quick_List_tb             =$random(seed);
						Manual_Withdraw_Value_tb  =$random(seed);
						Currency_Deposited_tb     =$random(seed);
						Service_Chosen_tb         =$random(seed);
						Credit_Card_Inserted_tb   =$random(seed);
						Receipt_tb                =$random(seed);
						Another_Operation_tb      =$random(seed);
						Opcode_tb                 =$random(seed);
						Withdraw_Value_tb         =$random(seed);
						Transfer_Value_tb         =$random(seed);
						Settlement_Amount_tb      =$random(seed);

		end
					end
					
		$finish;

	end									

initial 
	begin
	Clock_tb = 0;
	forever
		#5 Clock_tb = ~Clock_tb;
	end
	


ATM DUT(
.Clock(Clock_tb), 
.Reset(Reset_tb), 
.Cardless(Cardless_tb), 
.Language(Language_tb), 
.Money_Deposited(Money_Deposited_tb), 
.Quick_List(Quick_List_tb), 
.Manual_Withdraw_Value(Manual_Withdraw_Value_tb), 
.Currency_Deposited(Currency_Deposited_tb), 
.Service_Chosen(Service_Chosen_tb),
.Credit_Card_Inserted(Credit_Card_Inserted_tb), 
.Receipt(Receipt_tb), 
.Another_Operation(Another_Operation_tb),
.Opcode(Opcode_tb),
.User_Pass(User_Pass_tb),
.User_Mobile_No(User_Mobile_No_tb),
.User_Account_No(User_Account_No_tb),
.Withdraw_Value(Withdraw_Value_tb),
.Transfer_Value(Transfer_Value_tb),
.Settlement_Amount(Settlement_Amount_tb),
.ATM_Usage_Finished(ATM_Usage_Finished_tb),
.Balance_Shown(Balance_Shown_tb), 
.Deposited_Successfully(Deposited_Successfully_tb), 
.Withdrawed_Successfully(Withdrawed_Successfully_tb), 
.Exchanged_Successfully(Exchanged_Successfully_tb), 
.Fawry_Service_Done(Fawry_Service_Done_tb), 
.Transferred_Successfully(Transferred_Successfully_tb), 
.Bank_Statement_Produced(Bank_Statement_Produced_tb), 
.Debt_Paid_Off(Debt_Paid_Off_tb)
);


endmodule