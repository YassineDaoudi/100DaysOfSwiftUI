//
//  DetailView.swift
//  Bookworm
//
//  Created by Yassine DAOUDI on 30/11/2021.
//

import SwiftUI

struct DetailView: View {
    
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            
            ZStack{
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 390, height: 200)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 40, x: 0, y: 20)
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
//                        .padding(.horizontal, 10)
                        .offset(x: 0, y: -145)
                    
                    HStack(spacing: 30) {
                        Text(book.author ?? "Unknown author")
                            .font(.title)
                            .foregroundColor(.secondary)
                        
                        RatingView(rating: .constant(Int(book.rating)))
                            .font(.subheadline)
                    }
                    .offset(x: 0, y: -190)
                    
                    Text(book.review ?? "No review")
                        .padding()
                        .frame(width: 400, height: 500, alignment: .leading)
                        .offset(x: 10, y: -130)
                    
                    if let date = book.date?.dateFormat() {
                        Text("\(date)")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .offset(x: 90, y: -60)
                    }
                }
                .offset(x: 0, y: 210)
                
                ZStack {
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .frame(width: 420, height: 250, alignment: .center)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 40, x: 0, y: -10)
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: -1)
                        .padding(.top, 50)
                        .padding(.horizontal, 5)
                    
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                .offset(x: 0, y: -150)

            }
        }
        .navigationTitle(book.title ?? "Unknown  book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
    
    
}

extension Date {
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        return dateFormatter.string(from: self)
    }
}
