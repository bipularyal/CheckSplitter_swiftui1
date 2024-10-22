//
//  ContentView.swift
//  CheckSplitter
//
//  Created by Bipul Aryal on 10/22/24.
//

import SwiftUI


struct ContentView: View {
    private let tipPercentages  = [0,5,15,20,25]
    @State private var amount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 0
    var totalPerPerson: Double {
        // calculate the total per person here
        return (amount + amount * Double(tipPercentage) / 100) / Double(numberOfPeople)
    }
    @FocusState private var amountIsFocused: Bool

    var body: some View {
        VStack {
            NavigationStack{
                Form {
                    Section(header:  Text("Amount")){
                        TextField("Enter the amount of the check", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($amountIsFocused)
                        
                    }
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(1..<101, id: \.self){
                            Text("\($0)")
                        }
                    }
                    Section("How much tip do you want to leave?") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                }.navigationTitle("Check Splitter")
                Section (header: Text("Total per Person")){
                    Text("Total: \(totalPerPerson, format: .currency(code: "USD"))")
                }
                Section (header: Text("Total amount")){
                    Text("Total: \(Int(totalPerPerson * Double(numberOfPeople)), format: .currency(code: "USD"))")
                }
            }
                .padding()
                
        }
        
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
