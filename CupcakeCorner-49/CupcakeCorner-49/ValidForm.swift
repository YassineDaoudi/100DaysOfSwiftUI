//
//  ValidForm.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 20/11/2021.
//

import SwiftUI

struct ValidForm: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Button") {
                    print("Creating a button...")
                }
            }
            //.disabled(username.isEmpty || email.isEmpty)
            .disabled(disabledForm)
        }
    }
    
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ValidForm_Previews: PreviewProvider {
    static var previews: some View {
        ValidForm()
    }
}
