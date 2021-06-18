//
//  ContentView.swift
//  WeSplit
//
//  Created by Soumyattam Dey on 17/06/21.
//

import SwiftUI

struct ContentView: View {
    
    //State Properties
    @State private var checkAmount=""
    @State private var numberofPeople=2
    @State private var tipPercentage=2
    
    //Array of Tips
    let tipPercentages=[10,15,20,25,0]
    
    //Computed property to get the per person amount
    var totalPerPerson:Double{
        let peopleCount=Double(numberofPeople+2)                                   //Since the index is of by two as it starts from 2 and not from 0,hence we update it accordingly
        let tipSelection=Double(tipPercentages[tipPercentage])
        let orderAmount=Double(checkAmount) ?? 0                                   //Since checkAmount is a string we must put it as an optional if anything except a number is inputed
        let grandAmount=orderAmount + (orderAmount/100 * tipSelection)
        let amountPerPerson=grandAmount/peopleCount
        return amountPerPerson
    }
    
    //Computed property to get the total amount
    var grandAmount:Double{
        let tipSelection=Double(tipPercentages[tipPercentage])
        let orderAmount=Double(checkAmount) ?? 0
        let grand_amount=orderAmount + (orderAmount/100 * tipSelection)
        return grand_amount
    }
    
    var body: some View {
        
        //NavigationView to allow picker to navigate to a new page whare number of people are displayed
        NavigationView{
            
            //Form view to take input from user
            //Section view to create section for all the fields
            Form{
                Section{
                    TextField("Enter Amount", text: $checkAmount )                 //TextField must be a binding property to update the value
                        .keyboardType(.decimalPad)                                 //Specific keypad to enter numbers
                    
                    Picker("Number of People",selection: $numberofPeople){         //Whatever value we choose in the picker their index value gets stored rather than actual value
                        ForEach(2..<100){
                            Text("\($0) people")                                   //ForEach creates a picler section to choose
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")){       //header property of the Section view to provide a subtle headline to the section
                    Picker("Tip Percentage",selection : $tipPercentage){           //Whatever value is selected, the index value gets stored not the actual value
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])")                     //ForEach creates a picler section to which contains the values from thw array
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())                           //This property allows the value to be displayed on the same page rather than on a different page
                }
                
                Section(header:Text("Total Amount :")){
                    Text("₹\(grandAmount,specifier: "%.2f")")                      //grandAmount computed property gets called,the specifier aloows only two places after the decimal
                }
                
                Section(header:Text("Amount per person :")){
                    Text("₹\(totalPerPerson,specifier: "%.2f")")                   //totalPerPerson computed property gets called,the specifier aloows only two places after the decimal
                }
                
            }
            .navigationBarTitle("WeSplit")                                         //NavigationBarTitle allows contents of the app to be within the safe area
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
