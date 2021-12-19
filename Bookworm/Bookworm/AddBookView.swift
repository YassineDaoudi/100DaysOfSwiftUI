//
//  AddBook.swift
//  Bookworm
//
//  Created by Yassine DAOUDI on 29/11/2021.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
   
    let genres = ["Fantasy 🧚‍♀️", "Horror 🧛‍♂️", "Kids 🧒", "Mystery 🕵️‍♂️", "Poetry 🧑‍🎨", "Romance ❤️‍🔥", "Thriller 🥷", "Psychology 🧠", "Political science 🏛", "Self-help 🧘‍♂️"]
    
    var formDisabled: Bool {
        if title.isEmpty || author.isEmpty || genre.isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Book title", text: $title)
                    TextField("Book Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(formDisabled == false)
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        dismiss()
                    } label: {
                        Label("", systemImage: "xmark.square")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
   
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
