//
//  ContentView.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-10.
//

import SwiftUI

struct ContentView: View {
    @State var inputValue:String = "John Appleseed"

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField("Name", text:$inputValue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
