//
//  Home.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-12.
//

import SwiftUI

struct Home: View {
    let persistenceController = PersistenceController.shared

    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }.navigationBarBackButtonHidden(true)
            .padding(.all)
        
    }
}

#Preview {
    Home()
}
