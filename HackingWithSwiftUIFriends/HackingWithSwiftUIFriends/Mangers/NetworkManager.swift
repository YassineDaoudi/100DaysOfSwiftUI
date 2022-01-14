//
//  NetworkManager.swift
//  HackingWithSwiftUIFriends
//
//  Created by Yassine DAOUDI on 14/1/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let stringURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: stringURL) else { throw FErrors.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw FErrors.invalidResponse }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([User].self, from: data)
        } catch {
            throw FErrors.invalidData
        }
    }
}

enum FErrors: String, Error {
    case invalidURL = "Couldn't retrieve url"
    case invalidData = "Invalid Data"
    case invalidResponse = "Invalid Response"
}
