//
//  ContentView.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import SwiftUI

class NewTextViewModel: NSObject {
    let textNumber: Int = 1
}

class OtherTextViewModel: NSObject {
    let textNumber: Int = 2
}

struct NavigationTestView: View {
    @State var path = NavigationPath()
    @State var selected: String
    var items = ["1","2","3","4","5"]
    
    var body: some View {
        NavigationStack(path: $path) {
            Picker("", selection: $selected) {
                ForEach(items, id: \.self) {
                    Text("Number \($0)")
                }
            }
            .pickerStyle(.wheel)

//            Button {
//                path.append(NewTextViewModel())
//            } label: {
//                Text("Tap Here 1")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(.blue)
//                    .cornerRadius(25)
//            }
//
//            Button {
//                path.append(OtherTextViewModel())
//            } label: {
//                Text("Tap Here 2")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(.blue)
//                    .cornerRadius(25)
//            }
            .navigationDestination(for: String.self) {
                Text("Voce selecionou o Numero \($0)")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView(selected: "1")
    }
}
