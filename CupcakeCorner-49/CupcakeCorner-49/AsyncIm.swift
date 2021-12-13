//
//  AsyncImage.swift
//  CupcakeCorner-49
//
//  Created by Yassine DAOUDI on 20/11/2021.
//

import SwiftUI

struct AsyncIm: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the Image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncIm_Previews: PreviewProvider {
    static var previews: some View {
        AsyncIm()
    }
}
