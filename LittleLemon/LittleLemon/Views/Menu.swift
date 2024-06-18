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
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(.bottom, 4)
            ZStack{
                Color(red: 0.286, green: 0.373, blue: 0.345)
                    .ignoresSafeArea()
                VStack(alignment:.leading){
                    Text("Little Lemon")
                        .font(.largeTitle)
                        .foregroundStyle(Color.yellow)
                    Text("Chicago")
                        .font(.title)
                        .foregroundStyle(Color.white)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .foregroundStyle(Color.white)
                        }
                        VStack {
                            Image("food-image")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
                                .shadow(radius: 5)
                        }
                    }
                    TextField("Search menu", text: $searchText)
                        .padding()
                        .background(.white)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                .padding()
            }
            .frame(height: 300)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("order for delivery!")
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                    .font(.headline)
                HStack {
                    badge(title: "Starters")
                        .frame(width: 80, height: 40)
                    badge(title: "Mains")
                        .frame(width: 80, height: 40)
                    badge(title: "Desserts")
                        .frame(width: 80, height: 40)
                    badge(title: "Drinks")
                        .frame(width: 80, height: 40)
                }
            }
            .padding(.horizontal)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: [buildSortDescriptors()]) { (dishes: [Dish]) in
                List(dishes) { dish in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(dish.title ?? "")")
                                .font(.headline)
                            Text("$\(dish.price ?? "")")
                                .font(.subheadline)
                        }
                        Spacer()
                        AsyncImage(url: URL(string: dish.image ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear{
            print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            getMenuData()
        }
    }
    
    private func badge(title: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray)
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
        }
        
    }
}

#Preview {
    Menu()
}
