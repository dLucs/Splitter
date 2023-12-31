//
//  ContentView.swift
//  Splitter
//
//  Created by Lucas on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    let tipPercentages =  [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = total / peopleCount
    
        return amountPerPerson
        
    }
    
    var total: Double{
     
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let total = checkAmount + tipValue
        
        return total
        
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Add check amount & number of people"){
                    TextField("Amount", value: $checkAmount, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                Section("How much do you want to tip?"){
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount"){
                    Text(total, format: .currency(code:Locale.current.currency?.identifier ?? "USD"))
                    
                    
                }
            }
            .navigationTitle("Splitter")
            .toolbar {
                    if amountIsFocused{
                        Button("Done"){amountIsFocused = false}                   }
                }
        }
    }
}

#Preview {
    ContentView()
}
