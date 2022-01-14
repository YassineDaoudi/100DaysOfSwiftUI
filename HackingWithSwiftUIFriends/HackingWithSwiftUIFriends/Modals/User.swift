//
//  User.swift
//  HackingWithSwiftUIFriends
//
//  Created by Yassine DAOUDI on 14/1/2022.
//

import Foundation

struct User: Codable, Hashable {    
    struct Friend: Codable, Hashable {
        let id: String
        let name: String
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

//class Users: ObservableObject {
//    @Published var user = User()
//}
