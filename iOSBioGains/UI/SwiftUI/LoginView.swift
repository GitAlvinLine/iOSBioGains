//
//  LoginView.swift
//  iOSBioGains
//
//  Created by Alvin Escobar on 9/6/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    let tappedLogin: () -> Void = {}
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                    )
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                    )
            }
            .font(.title3)
            
            Spacer()
            
            Button {
                tappedLogin()
            } label: {
                Text("Login")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }

        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
