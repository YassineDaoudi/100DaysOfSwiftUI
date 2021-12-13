//
//  ContentView.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 20/11/2021.
//

import SwiftUI


class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name = "Yassine Daoudi"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct CodablePublished: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct CodablePublished_Previews: PreviewProvider {
    static var previews: some View {
        CodablePublished()
    }
}
