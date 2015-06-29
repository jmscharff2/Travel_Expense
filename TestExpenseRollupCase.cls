@isTest
private class TestExpenseRollupCase 
{
	//a test method
    static testMethod void myExpenseTest() 
    {
    	//first we create a list of expenses and a list of expense reports.  The expenses are objects that reference the travel expense object
       List<Travel_Expenses__c> travel_expenses = new List<Travel_Expenses__c>{};
       List<Expense__c> expense = new List<Expense__c>{};
       //create two new travel expenses these are the overall reports
       for(Integer i = 0; i < 1; i++)
       {
	       	Travel_Expenses__c t = new Travel_Expenses__c(Notes__c = 'Test Expense Report ' + i);
	       	
	       	travel_expenses.add(t);
       } 
       //starts the test
       test.startTest();
       //insert the new travel expenses so that we have something that we can then reference when creating individual expenses
       insert travel_expenses;
       //pull the list of newly created expense reports so that we can take the ID for reference for the expenses
       List<Travel_Expenses__c> testExpense_Reports = [SELECT Id FROM Travel_Expenses__c WHERE Id IN :travel_expenses];
       //create new expenses with fake values referencing the two test expense reports
       //this tests the after insert portion of the trigger
       for(Travel_Expenses__c exp : testExpense_Reports)
       {
	       for(Integer j = 0; j < 1; j++)
	       {
	       		Expense__c e1 = new Expense__c(Description__c = 'Test Expense ' + j, Amount__c = 10.00, Travel_Expenses__c = exp.Id);
	       		Expense__c e2 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Corporate Airline', Amount__c = 10.00, Travel_Expenses__c = exp.Id);
	       		Expense__c e3 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Corporate Rental Car', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	       		Expense__c e4 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Dues & Subscription - Subscription', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	       		Expense__c e5 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Supplies', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	       		Expense__c e6 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Expense', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e7 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Auto Exp-Company Car', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
				Expense__c e8 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Trade Show Expense', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e9 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Trade Show Expense - Give Away', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e10 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Co-op Advertising', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e11 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Travel Expense-Other', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e12 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Auto Expense Repairs- Co. Owned Car', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e13 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Auto Expense Fuel- Co. Owned Car', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e14 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Transportation Expense', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e15 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Communication Expense - Internet', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e16 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Communication Expense - Cell Phone', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e17 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Express Mail', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e18 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Postage', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e19 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Expense', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e20 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Supplies', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e21 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Equipment - Under $500.00', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e22 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Office Equipment - Computer Supplies', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e23 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Dues & Subscriptions - Membership Dues', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e24 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Dues & Subscription - Subscription', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		Expense__c e25 = new Expense__c(Description__c = 'Test Expense ' + j, Expense_Type__c = 'Seminar', Amount__c = 200.00, Travel_Expenses__c = exp.Id);
	    		    		   		
	    	
	    		
	       		expense.add(e1);
	       		expense.add(e2);
	       		expense.add(e3);
	       		expense.add(e4);
	       		expense.add(e5);
	       		expense.add(e6);
	       		expense.add(e7);
	       		expense.add(e8);
	       		expense.add(e9);
	      		expense.add(e10);
	       		expense.add(e11);
	       		expense.add(e12);
	       		expense.add(e13);
	       		expense.add(e14);
	       		expense.add(e15);
	       		expense.add(e16);
	       		expense.add(e17);
	       		expense.add(e18);
	       		expense.add(e19);
	       		expense.add(e20);
	       		expense.add(e21);
	       		expense.add(e22);
	       		expense.add(e23);
	       		
	       		
	       		
	       }
       
       }
       //insert the expenses 
       insert expense;
       
       //Now we will test for the Update for the before Update and after Update portions of the trigger
       //pulls the list of created expenses, we then go through those and update the description so that the trigger is called for a test
       List<Expense__c>testExpense_Update = [SELECT Id,Description__c FROM Expense__c WHERE Id IN :expense];
       
       for(Expense__c expense_update : testExpense_Update)
       {
       		for(Integer k = 0; k < 1; k++)
       		{
				expense_update.Description__c = 'Test Update ' + k;
				update expense_update;//update into the expenses and the trigger is called
       		}
       }
        
       delete expense;
       
       //stops the test
       test.stopTest();
        
    }
}