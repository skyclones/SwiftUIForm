//
//  ContentView.swift
//  FormExamples
//
//  Created by Mits on 11/03/20.
//  Copyright © 2020 Ubrain. All rights reserved.
//

import SwiftUI
import Combine

class Order: ObservableObject {
     
    var didChange  = PassthroughSubject<Void , Never> ()
    static let types = ["Venila" , "Chocolate", "Stroberry" , "Rainbow"]
    
    var type = 0 { didSet{ update() } }
    var quanity = 3 { didSet{ update()}}
    
    var specialRequestEnable = false { didSet{ update()}}
    var extraFrosting = false { didSet{ update()}}
    var addSprinkles = false { didSet{ update()}}
    
    var name = "" { didSet{ update()}}
    var address = "" { didSet{ update()}}
    var city = "" { didSet{ update()}}
    var zip = "" { didSet{ update()}}
    
    var isValid : Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    func update()
    {
        didChange.send(())
    }
}

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker(selection: $order.type, label: Text("Select your cake type")) {
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0]).tag($0)
                        }
                    }
                    Stepper(value: $order.quanity, in: 3...20) {
                        Text("Number of cakes \(order.quanity)")
                    }
                }
                Section {
                    
                    Toggle(isOn: $order.specialRequestEnable) {
                        Text("Any special request?")
                    }
                    
                    if order.specialRequestEnable {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    TextField( "Name" , text: $order.name)
                    TextField( "Address" , text: $order.address)
                    TextField( "City" , text: $order.city)
                    TextField( "Zip" , text: $order.zip)
                }
                
                Section {
                    
                    Button(action: {
                        
                        self.placeOrder()
                        
                    }) {
                        Text("Place Order")
                    }//.disabled(!$order.isValid)
                    
                }
            }
            .navigationBarTitle("Place Order")
        }
    }
    
    func placeOrder()
    {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
