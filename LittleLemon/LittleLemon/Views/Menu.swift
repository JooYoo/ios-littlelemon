//
//  Menu.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-12.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var title = ""
    @State var lastName = ""
    @State var email = ""
    @State var searchText = ""
    
    func buildPredicate() -> NSPredicate {
        if !searchText.isEmpty {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        } else {
            return NSPredicate(value: true)
        }
    }
    
    func buildSortDescriptors() -> NSSortDescriptor {
        return NSSortDescriptor(key: "title", ascending: true, selector:  #selector(NSString.localizedStandardCompare))
    }
    
    func getMenuData()  {
        // removes all existing Dish entries
        PersistenceController.shared.clear()
        
        // http call
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
                
                // Save fetched data into DB
                DispatchQueue.main.async {
                    for item in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.price = item.price
                        dish.image = item.image
                    }
                    try? viewContext.save()
                }
            } catch {
                print("decode error: \(error)")
            }
        }
        
        task.resume()
    }
    
    var body: some View {
        VStack{
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: [buildSortDescriptors()]) { (dishes: [Dish]) in
                List(dishes) { dish in
                    HStack {
                        Text("\(dish.title ?? "") - \(dish.price ?? "")")
                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .onAppear{
            print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            
            getMenuData()
        }
    }
}

#Preview {
    Menu()
}
