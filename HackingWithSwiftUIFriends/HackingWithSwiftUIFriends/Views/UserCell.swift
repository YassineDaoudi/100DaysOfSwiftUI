//
//  UserCell.swift
//  HackingWithSwiftUIFriends
//
//  Created by Yassine DAOUDI on 14/1/2022.
//

import SwiftUI

struct UserCell: View {
    var user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.secondary)
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(user.tags, id: \.self) {
                            Text("\($0)")
                                .font(.caption)
                                .frame(width: 70, height: 20)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        }
                    }
                    .padding(.bottom)
                }
            }
            Spacer()
            Circle()
                .frame(width: 14, height: 14)
                .foregroundColor(user.isActive ? .green : .gray)
        }
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell(user: User())
//    }
//}
