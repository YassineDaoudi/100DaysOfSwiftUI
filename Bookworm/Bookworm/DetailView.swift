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
                        .frame(width: 400, height: 300)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 40, x: 0, y: 20)
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
                        .padding(.horizontal, 10)
                        .offset(x: 0, y: -100)
                    
                    HStack(spacing: 20) {
                        Text(book.author ?? "Unknown author")
                            .font(.title)
                            .foregroundColor(.secondary)
                        
                        RatingView(rating: .constant(Int(book.rating)))
                            .font(.title3)
                    }
                    .offset(x: 0, y: -200)
                    
                    Text(book.review ?? "No review")
                        .padding()
                        .frame(width: 400, height: 500, alignment: .center)
                        .offset(x: 10, y: -130)
                    
                    if let date = book.date?.dateFormat() {
                        Text("\(date)")
                            .padding()
                            .offset(x: 90, y: 20)
                    }
                }
                .offset(x: 0, y: 210)
                
                ZStack {
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 40, x: 0, y: -20)
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
