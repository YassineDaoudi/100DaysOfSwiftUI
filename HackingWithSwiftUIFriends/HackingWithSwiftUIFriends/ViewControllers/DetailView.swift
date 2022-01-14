//
//  DetailView.swift
//  HackingWithSwiftUIFriends
//
//  Created by Yassine DAOUDI on 14/1/2022.
//

import SwiftUI

struct DetailView: View {
    var user: User
    let images = ["man1", "man2", "man3", "man4", "man5", "man6", "man7", "man8", "man9", "man10", "man11"].shuffled()
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center, spacing: 20.0) {
                    Image(images[Int.random(in: 0...10)])
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 54, height: 54)
                        .foregroundColor(.black)
                    
                    VStack(alignment: .leading, spacing: 3.0) {
                        Text(user.name)
                        Text("Age: \(user.age)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Company: \(user.company)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Contact: \(user.email)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Circle()
                        .frame(width: 14, height: 14)
                        .foregroundColor(user.isActive ? .green : .gray)
                }
                .padding(.horizontal)
                
                Text(user.about)
                    .padding()
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text("Friends")
                    .padding(.horizontal)
                    .font(.title)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                            ForEach(user.friends, id: \.self) { friend in
                                VStack(alignment: .center) {
                                    Image(images[Int.random(in: 0...10)])
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.blue)
                                    Text("\(friend.name )")
                                        .font(.subheadline)
                                }
                                .padding(.leading)
                            }
                    }
                    .padding(.bottom)
                }
            
                Text("Member since: \(user.registered)")
                    .bold()
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .padding([.horizontal, .top])
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var user = User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: true, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: Date(),
        tags: ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"],
        friends: [
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
            User.Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")
        ])
    static var previews: some View {
        DetailView(user: user)
    }
}
