//
//  ContentView.swift
//  NextFocusApp
//
//  Created by Developer on 12/7/21.
//

import SwiftUI

struct FocusObject: Identifiable, Equatable {
    public let id = UUID()
    public var name: String
    public var value: String
}

class FocusViewModel: ObservableObject {

    @Published var focusObjects: [FocusObject]
    
    init(_ objects: [FocusObject]) {
        focusObjects = objects
    }
}


struct ContentView: View {
    @StateObject var viewModel = FocusViewModel([
        FocusObject(name: "aa", value: "1"),
        FocusObject(name: "bb", value: "2"),
        FocusObject(name: "cc", value: "3"),
        FocusObject(name: "dd", value: "4")
    ])

    @State var focus: UUID?
    
    var body: some View {
        VStack {
            Form {
                ForEach($viewModel.focusObjects) { $obj in
                    FocusField(object: $obj, focus: $focus, nextFocus: {
                        guard let index = viewModel.focusObjects.map( { $0.id }).firstIndex(of: obj.id) else {
                            return
                        }
                        focus = viewModel.focusObjects.indices.contains(index + 1) ? viewModel.focusObjects[index + 1].id : viewModel.focusObjects.first?.id
                    })
                }
            }
        }
    }
}

struct FocusField: View {
    
    @Binding var object: FocusObject
    @Binding var focus: UUID?
    var nextFocus: () -> Void
    
    @FocusState var isFocused: UUID?

    var body: some View {
        HStack {
            Text("\(object.name): ")
        TextField("Test", text: $object.value)
            .onChange(of: focus, perform: { newValue in
                self.isFocused = newValue
            })
            .focused(self.$isFocused, equals: object.id)
            .onSubmit {
                self.nextFocus()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
