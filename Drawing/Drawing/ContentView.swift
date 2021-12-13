//
//  ContentView.swift
//  Drawing
//
//  Created by Yassine DAOUDI on 4/10/2021.
//

import SwiftUI

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        
        VStack {
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .fill(Color.red, style: FillStyle(eoFill: true))

                Text("Offset")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                Slider(value: $petalOffset, in: -40...40)
                    .padding([.horizontal,.vertical])


                Text("Width")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                Slider(value: $petalWidth, in: 0...100)
                    .padding([.horizontal,.vertical])
        }
        
//        VStack {
//
//            ColorCyclingCircle(amount: self.colorCycle)
//                .frame(width: 300, height: 300)
//
//            VStack(alignment: .leading) {
//                Text("Color Cycle:")
//                    .font(.system(size: 20, weight: .medium, design: .rounded))
//
//                Slider(value: $colorCycle)
//            }
//            .padding([.horizontal,.vertical])
//
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
