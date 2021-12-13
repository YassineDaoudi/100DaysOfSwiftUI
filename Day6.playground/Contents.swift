import UIKit

//MARK:- Creating basic closures
let driving = {
    print("I'm driving in my car")
}

driving()

//MARK:- Accepting parameters in a closure
let driving2 = { (place: String) in
    print("I'm going to \(place) in my car")
}
driving2("Meknes")

//MARK:- Returning values from a closure
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

let message = drivingWithReturn("Meknes")
print(message)

//MARK:- Closures as parameters
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)

//MARK:- Trailing closure syntax
travel {
    print("I'm driving in my car")
}
