import UIKit

//MARK:- Creating your own structs
struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an olympic sport."
        } else {
            return "\(name) is not an olympic sport."
        }
    }
}

var tennis = Sport(name: "Tennis", isOlympicSport: false)
print(tennis.name)
tennis.name = "Soccer"

//MARK:- Computed properties
let chessBoxing = Sport(name: "ChessBoxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//MARK:- Property observers
struct Progress {
    var task: String
    var ammount: Int {
        didSet {
            print("\(task) is now \(ammount)% complete.")
        }
    }
}

var progress = Progress(task: "Loading Data", ammount: 0)
progress.ammount = 30
progress.ammount = 80
progress.ammount = 100

//MARK:- Methods
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

//MARK:- Mutating methods
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
var person = Person(name: "Ed")
person.makeAnonymous()

//MARK:- Properties and methods of strings
let string = "To be or not to be, that's the question."
print(string.count)
print(string.uppercased())
print(string.sorted())

