import UIKit


//MARK:- Arithmetic operators
let firstScore = 14
let secondScore = 10

let total = firstScore + secondScore
let difference = firstScore - secondScore
let product = firstScore * secondScore
let devided = firstScore / secondScore
let remainder = 13 % firstScore


//MARK:- Operator overloading
let meaningOfLife = 42
let doubleMeaning = 42 + 42
let fakers = "Fakers gonna "
let action = fakers + "fake"
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

//MARK:- Compound assignment operators
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"

//MARK:- Comparison operators
firstScore == secondScore
firstScore != secondScore

firstScore > secondScore
firstScore <= secondScore

"Taylor" > "Swift"

//MARK:- Conditions
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("Aces, Lucky!")
} else if firstCard + secondCard == 21  {
    print("Blackjack!")
} else {
    print("Regular Cards")
}

//MARK:- Combining Conditions
let age1 = 24
let age2 = 16

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}

//MARK:- The ternary operator
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

//MARK:- Switch Statements
let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

//MARK:- Range operators
switch score {
case 0..<50:
    print("You failed badly.")
case 50..<81:
    print("You did OK.")
default:
    print("You did great!")
}
