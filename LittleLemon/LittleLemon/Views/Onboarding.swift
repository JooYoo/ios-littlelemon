//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-12.
//

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"

import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.bottom)
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
                    }
                }
                .frame(height: 300)
                .padding(.bottom)
                TextField("First Name", text: $firstName)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                TextField("Last Name", text: $lastName)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                TextField("Email", text: $email)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                Spacer()
                Button("Register") {
                    if(!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty){
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        isLoggedIn = true
                        UserDefaults.standard.setValue(isLoggedIn, forKey: kIsLoggedIn)
                    }
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .safeAreaPadding(.all)
            .onAppear{
                // Read from UserDefualts to check if User already logged in
                if(UserDefaults.standard.bool(forKey: "kIsLoggedIn")) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
