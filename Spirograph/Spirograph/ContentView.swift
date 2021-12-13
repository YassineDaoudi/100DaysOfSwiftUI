//
//  ContentView.swift
//  Spirograph
//
//  Created by Yassine DAOUDI on 22/10/2021.
//

import SwiftUI

struct Spirograph: Shape {
    var innerRadius: Int
    var outerRadius: Int
    var distance: Int
    var amount: CGFloat
    
    public var animatableData: AnimatablePair<Double, AnimatablePair<Double, AnimatablePair<Double,Double>>> {
        get { AnimatablePair(Double(innerRadius),AnimatablePair(Double(outerRadius),AnimatablePair(Double(distance), Double(amount)))) }
        set {
            self.innerRadius = Int(newValue.first)
            self.outerRadius = Int(newValue.second.first)
            self.distance = Int(newValue.second.second.first)
            self.amount = CGFloat(newValue.second.second.second)
        }
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b

        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }

        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
}

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        self.innerRadius = Double.random(in: 10...150)
                        self.outerRadius = Double.random(in: 10...150)
                        self.distance = Double.random(in: 1...150)
//                        self.amount = Double.random(in: 0.1...1 )
                        self.hue = Double.random(in: 0...1)
                    }
                }


            Spacer()

            Group {
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Amount: \(amount, specifier: "%.2f")")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])

                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
