import UIKit

//MARK:- Creating your own classes
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    
    func makeNoise() {
        print("Woof!")
    }
}

var poppy = Dog(name: "Poppy", breed: "Poodle")

//MARK:- Class inheritance
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
    override func makeNoise() {
        print("Yip!")
    }
}

//MARK:- Overriding methods
let poodle = Poodle(name: "Poppy")
poodle.makeNoise()

//MARK:- Final classes
//Add finale keyword before class name in order to prevent inheretence

//MARK:- Copying objects
class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Eminem"
print(singer.name)

//MARK:- Deinitializers
class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

//MARK:- Mutability
let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
