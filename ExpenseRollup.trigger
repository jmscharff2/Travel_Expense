trigger ExpenseRollup on Expense__c (before delete, after insert, after undelete, after update, before update) 
{
	public Id exp_reportId;
	public Id exp_Id;
	public Id exp_reportId_new;
	public Id exp_Id_new;
	
	//After Trigger
	if(trigger.isAfter)
	{
		//Will call if there is an insert or update to the expense object
	    if(trigger.isInsert || trigger.isUpdate)
	    {
	    	for(Expense__c exp : Trigger.New)
	    	{
	    		exp_reportId = exp.Travel_Expenses__c;
	    		exp_Id = exp.Id;
	    	}
	    	//pulls the expense report and expenses from the salesforce database
	    	List<Travel_Expenses__c> expense_report = [Select t.Total_Expense_Amount__c, t.Id, t.Notes__c, t.Total_Corporate_Airline__c, t.Total_Corporate_Auto_Rental__c, t.Total_Auto_Exp_Company_Car__c, t.Trade_Show_Expense__c, t.Trade_Show_Expense_Give_Away__c, t.Co_op_Advertising__c, t.Travel_Expense_Other__c, t.Auto_Expense_Repairs_Co_Owned_Car__c, t.Auto_Expense_Fuel_Co_Owned_Car__c, t.Transportation_Expense__c, t.Communication_Expense_Internet__c, t.Communication_Expense_Cell_Phone__c, t.Express_Mail__c, t.Postage__c, t.Office_Expense__c, t.Office_Supplies__c, t.Office_Equipment_Under_500__c, t.Office_Equipment_Computer_Supplies__c, t.Dues_Subscription_Membership_Dues__c, t.Dues_Subscription_Subscription__c, t.Seminar__c From Travel_Expenses__c t Where Id =:exp_reportId];
	    	List<Expense__c> expense = [Select e.Travel_Expenses__c, e.Id, e.Amount__c, e.Description__c, e.Expense_Type__c From Expense__c e WHERE Id=:exp_Id];
	    	List<Travel_Expenses__c> update_travel_expense = new List<Travel_Expenses__c>();
	    	//goes through the expense report and the expenses and adds the amount to the total amount saved in the expense report object
	    	for(Travel_Expenses__c texp : expense_report)
	    	{
	    		for(Expense__c amount : expense)
	    		{		
	    			texp.Total_Expense_Amount__c += amount.Amount__c;
	    			
	    			if(amount.Expense_Type__c == 'Corporate Rental Car')
	    			{
	    				texp.Total_Corporate_Auto_Rental__c +=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Corporate Airline')
	    			{
	    				texp.Total_Corporate_Airline__c +=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Exp-Company Car')
	    			{
	    				texp.Total_Auto_Exp_Company_Car__c +=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense')
	    			{
	    				texp.Trade_Show_Expense__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense - Give Away')
	    			{
	    				texp.Trade_Show_Expense_Give_Away__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Co-op Advertising')
	    			{
	    				texp.Co_op_Advertising__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Travel Expense-Other' || amount.Expense_Type__c == 'Travel Expense - Other')
	    			{
	    				texp.Travel_Expense_Other__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Repairs- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Repairs_Co_Owned_Car__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Fuel- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Fuel_Co_Owned_Car__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Transportation Expense')
	    			{
	    				texp.Transportation_Expense__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Internet')
	    			{
	    				texp.Communication_Expense_Internet__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Cell Phone')
	    			{
	    				texp.Communication_Expense_Cell_Phone__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Express Mail')
	    			{
	    				texp.Express_Mail__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Postage')
	    			{
	    				texp.Postage__c += amount.Amount__c;	
	    			}
	    			if(amount.Expense_Type__c == 'Office Expense')
	    			{
	    				texp.Office_Expense__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Supplies')
	    			{
	    				texp.Office_Supplies__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Under $500.00')
	    			{
	    				texp.Office_Equipment_Under_500__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Computer Supplies')
	    			{
	    				texp.Office_Equipment_Computer_Supplies__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Membership Dues')
	    			{
	    				texp.Dues_Subscription_Membership_Dues__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Subscription')
	    			{
	    				texp.Dues_Subscription_Subscription__c += amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Seminar')
	    			{
	    				texp.Seminar__c += amount.Amount__c;
	    			}
	    			
	    			
	    			texp.Total_Amount_Approved__c = texp.Total_Expense_Amount__c - (texp.Total_Corporate_Auto_Rental__c + texp.Total_Corporate_Airline__c);
	    			
	    			
	    			//texp.Notes__c = 'Trigger has been here!';
	    			//amount.Description__c = 'Blah';
	    			//update amount;
	    			update_travel_expense.add(texp);
	    		}
	    		//updates the expense report object
	    		//update texp;
	    	}
	    	if(!update_travel_expense.isEmpty())
			{
				update update_travel_expense;
			}
	    } 
		
	   
	}
	//Before Trigger
	if(trigger.isBefore)
	{
		//checks if you are deleting the expense
		if(trigger.isDelete)
		{
			for(Expense__c exp: Trigger.Old)
			{
				exp_reportId = exp.Travel_Expenses__c;
				exp_Id = exp.Id;
			}
			//gets a list of the expenses that you are going to delete
		    List<Travel_Expenses__c> expense_report = [Select t.Total_Expense_Amount__c, t.Id, t.Notes__c, t.Total_Corporate_Airline__c, t.Total_Corporate_Auto_Rental__c, t.Total_Auto_Exp_Company_Car__c, t.Trade_Show_Expense__c, t.Trade_Show_Expense_Give_Away__c, t.Co_op_Advertising__c, t.Travel_Expense_Other__c, t.Auto_Expense_Repairs_Co_Owned_Car__c, t.Auto_Expense_Fuel_Co_Owned_Car__c, t.Transportation_Expense__c, t.Communication_Expense_Internet__c, t.Communication_Expense_Cell_Phone__c, t.Express_Mail__c, t.Postage__c, t.Office_Expense__c, t.Office_Supplies__c, t.Office_Equipment_Under_500__c, t.Office_Equipment_Computer_Supplies__c, t.Dues_Subscription_Membership_Dues__c, t.Dues_Subscription_Subscription__c, t.Seminar__c From Travel_Expenses__c t Where Id =:exp_reportId];
	    	List<Expense__c> expense = [Select e.Travel_Expenses__c, e.Id, e.Amount__c, e.Description__c, e.Expense_Type__c From Expense__c e WHERE Id=:exp_Id];
	    	List<Travel_Expenses__c> update_travel_expense = new List<Travel_Expenses__c>();
		    
		    //goes through the expenses that you are deleting and subtracts them from the total expense field
		    for(Travel_Expenses__c texp : expense_report)
		    {
		    	for(Expense__c amount : expense)
		    	{
		    		texp.Total_Expense_Amount__c -= amount.Amount__c;
		    		//texp.Total_Amount_Approved__c -= amount.Amount__c;
		    		
		    		if(amount.Expense_Type__c == 'Corporate Rental Car')
	    			{
	    				texp.Total_Corporate_Auto_Rental__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Corporate Airline')
	    			{
	    				texp.Total_Corporate_Airline__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Exp-Company Car')
	    			{
	    				texp.Total_Auto_Exp_Company_Car__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense')
	    			{
	    				texp.Trade_Show_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense - Give Away')
	    			{
	    				texp.Trade_Show_Expense_Give_Away__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Co-op Advertising')
	    			{
	    				texp.Co_op_Advertising__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Travel Expense-Other' || amount.Expense_Type__c == 'Travel Expense - Other')
	    			{
	    				texp.Travel_Expense_Other__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Repairs- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Repairs_Co_Owned_Car__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Fuel- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Fuel_Co_Owned_Car__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Transportation Expense')
	    			{
	    				texp.Transportation_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Internet')
	    			{
	    				texp.Communication_Expense_Internet__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Cell Phone')
	    			{
	    				texp.Communication_Expense_Cell_Phone__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Express Mail')
	    			{
	    				texp.Express_Mail__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Postage')
	    			{
	    				texp.Postage__c -= amount.Amount__c;	
	    			}
	    			if(amount.Expense_Type__c == 'Office Expense')
	    			{
	    				texp.Office_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Supplies')
	    			{
	    				texp.Office_Supplies__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Under $500.00')
	    			{
	    				texp.Office_Equipment_Under_500__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Computer Supplies')
	    			{
	    				texp.Office_Equipment_Computer_Supplies__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Membership Dues')
	    			{
	    				texp.Dues_Subscription_Membership_Dues__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Subscription')
	    			{
	    				texp.Dues_Subscription_Subscription__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Seminar')
	    			{
	    				texp.Seminar__c -= amount.Amount__c;
	    			}
		    		
		    		
		    		update_travel_expense.add(texp);
		    	}
		    	//update texp;
		    }	
		    if(!update_travel_expense.isEmpty())
		    {
		    	update update_travel_expense;
		    }
		}
		
		//checks to see if you are doing a before update, this does the same thing as the delete but on an update you want to remove the values that you had saved for the amount and then you will update them after you click save so you will have the most up to date information
		if(trigger.isUpdate)
		{
			for(Expense__c exp : Trigger.Old)
			{
				exp_reportId = exp.Travel_Expenses__c;
				exp_Id = exp.Id;
			}
					    
		    List<Travel_Expenses__c> expense_report = [Select t.Total_Expense_Amount__c, t.Id, t.Notes__c, t.Total_Corporate_Airline__c, t.Total_Corporate_Auto_Rental__c, t.Total_Auto_Exp_Company_Car__c, t.Trade_Show_Expense__c, t.Trade_Show_Expense_Give_Away__c, t.Co_op_Advertising__c, t.Travel_Expense_Other__c, t.Auto_Expense_Repairs_Co_Owned_Car__c, t.Auto_Expense_Fuel_Co_Owned_Car__c, t.Transportation_Expense__c, t.Communication_Expense_Internet__c, t.Communication_Expense_Cell_Phone__c, t.Express_Mail__c, t.Postage__c, t.Office_Expense__c, t.Office_Supplies__c, t.Office_Equipment_Under_500__c, t.Office_Equipment_Computer_Supplies__c, t.Dues_Subscription_Membership_Dues__c, t.Dues_Subscription_Subscription__c, t.Seminar__c From Travel_Expenses__c t Where Id =:exp_reportId];
	    	List<Expense__c> expense = [Select e.Travel_Expenses__c, e.Id, e.Amount__c, e.Description__c, e.Expense_Type__c From Expense__c e WHERE Id=:exp_Id];
	    	List<Travel_Expenses__c> update_travel_expense = new List<Travel_Expenses__c>();
		   
		    
		     
		    for(Travel_Expenses__c texp : expense_report)
		    {
		    	for(Expense__c amount : expense)
		    	{
		    		texp.Total_Expense_Amount__c -= amount.Amount__c;
		    		
		    		
		    		if(amount.Expense_Type__c == 'Corporate Rental Car')
	    			{
	    				texp.Total_Corporate_Auto_Rental__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Corporate Airline')
	    			{
	    				texp.Total_Corporate_Airline__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Exp-Company Car')
	    			{
	    				texp.Total_Auto_Exp_Company_Car__c -=amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense')
	    			{
	    				texp.Trade_Show_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Trade Show Expense - Give Away')
	    			{
	    				texp.Trade_Show_Expense_Give_Away__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Co-op Advertising')
	    			{
	    				texp.Co_op_Advertising__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Travel Expense-Other' || amount.Expense_Type__c == 'Travel Expense - Other')
	    			{
	    				texp.Travel_Expense_Other__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Repairs- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Repairs_Co_Owned_Car__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Auto Expense Fuel- Co. Owned Car')
	    			{
	    				texp.Auto_Expense_Fuel_Co_Owned_Car__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Transportation Expense')
	    			{
	    				texp.Transportation_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Internet')
	    			{
	    				texp.Communication_Expense_Internet__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Communication Expense - Cell Phone')
	    			{
	    				texp.Communication_Expense_Cell_Phone__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Express Mail')
	    			{
	    				texp.Express_Mail__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Postage')
	    			{
	    				texp.Postage__c -= amount.Amount__c;	
	    			}
	    			if(amount.Expense_Type__c == 'Office Expense')
	    			{
	    				texp.Office_Expense__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Supplies')
	    			{
	    				texp.Office_Supplies__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Under $500.00')
	    			{
	    				texp.Office_Equipment_Under_500__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Office Equipment - Computer Supplies')
	    			{
	    				texp.Office_Equipment_Computer_Supplies__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Membership Dues')
	    			{
	    				texp.Dues_Subscription_Membership_Dues__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Dues & Subscription - Subscription')
	    			{
	    				texp.Dues_Subscription_Subscription__c -= amount.Amount__c;
	    			}
	    			if(amount.Expense_Type__c == 'Seminar')
	    			{
	    				texp.Seminar__c -= amount.Amount__c;
	    			}
		    		
		    		
		    		
		    		
		    		update_travel_expense.add(texp);
		    	}
		    	//update texp;
		    }
		    if(!update_travel_expense.isEmpty())
		    {
		    	update update_travel_expense;
		    }
		}
	}
}