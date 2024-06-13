//
//  Menu.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-12.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var title = ""
    @State var lastName = ""
    @State var email = ""
    
    
    func getMenuData()  {
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else {
            print("url error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let safeData = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // 3. decode
                let menuList = try JSONDecoder().decode(MenuList.self, from: safeData)
                
                DispatchQueue.main.async {
                    for item in menuList.menu {
//                        let dish =
                    }
                }
            } catch {
                print("decode error: \(error)")
            }
        }
        
        task.resume()
    }
    
    var body: some View {
        VStack{
            Text("Title")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("Chicago")
                .padding(.bottom)
            Text("loremloremloremloremloremloremloremloremloremloremloremloremlorem")
            
            
            List {
                
            }
        }
        .onAppear{
            getMenuData()
        }
    }
}

#Preview {
    Menu()
}
