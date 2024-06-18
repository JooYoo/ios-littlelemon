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
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
                .padding(.bottom)
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            textField(title: "First name", value: firstName)
            textField(title: "Last name", value: lastName)
            textField(title: "Email", value: email)
            Text("We're glad you're already logged in. For your security, the personal information displayed above is in read-only mode. This means you can view but not edit these details directly here")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding()
            Spacer()
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
        }
        .padding(.all)
    }
    
    private func textField(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            TextField(title, text: .constant(value))
                .padding()
                .disabled(true)
                .textFieldStyle(.plain)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }.padding(.bottom)
    }
}

#Preview {
    UserProfile()
}
