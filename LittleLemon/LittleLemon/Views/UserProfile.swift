//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Yu on 2024-06-12.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "kFirstName") ?? "-"
    let lastName = UserDefaults.standard.string(forKey: "kLastName") ?? "-"
    let email = UserDefaults.standard.string(forKey: "kEmail") ?? "-"

    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            Spacer()
            Text("Personal information")
                .padding()
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Text(firstName)
            Text(lastName)
            Text(email)
            Spacer()
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
        }
        .padding(.all)
    }
}

#Preview {
    UserProfile()
}
