import UIKit


//MARK:- Using closures as parameters when they accept parameters
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("Meknes")
    print("I arrived !")
}

travel { (place: String) in
    print("I'm going to \(place) in my car.")
}

//MARK:- Using closures as parameters when they return values
func travel2(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived !")
}

travel2 { (place: String) -> String in
    return "I'm going to \(place) in my car."
}

//MARK:- Shorthand parameter names
travel2 {
    "I'm going to \($0) in my car."
}

//MARK:- Closures with multiple parameters

func travel3(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("Meknes", 120)
    print(description)
    print("Arrived !")
}

travel3 { city, speed in
    "I'm going to \(city) at \(speed) km per hour. "
}

//MARK:- Returning closures from functions
func travel4() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel4()
result("London")

//MARK:- Capturing values
func travel() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
let result2 = travel()
result("London")
