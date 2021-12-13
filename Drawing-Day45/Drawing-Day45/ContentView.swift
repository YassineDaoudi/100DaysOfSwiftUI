//
//  ContentView.swift
//  Drawing-Day45
//
//  Created by Yassine DAOUDI on 21/10/2021.
//

import SwiftUI

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(petalOffset, petalWidth) }
        
        set {
            self.petalOffset = newValue.first
            self.petalWidth = newValue.second
        }

    }

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

struct ContentView: View {
    
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var insetAmount: CGFloat = 50
    @State private var saturationAmount: CGFloat = 1.0
    @State private var blurAmount: CGFloat = 1.0
    @State private var colorID = 0.0
    @State private var blendMode = 0
    
    let colorArray: [Color] = [ .red, .blue, .green, .orange, .gray, .purple, .pink, .yellow]
    let blendModeArray: [String : SwiftUI.BlendMode] = ["Multiply": .multiply, "Screen": .screen, "Luminosity": .luminosity, "ColorBurn": .colorBurn, "Difference": .difference]
   
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header:
                            Text("Tap to animate : ↓ ")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.purple)
                ) {
                    Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                        .fill(colorArray[Int(colorID)], style: FillStyle(eoFill: true))
                        .padding(100)
                        .blendMode(.multiply)
                        .saturation(saturationAmount)
                        .blur(radius: (1 - blurAmount) * 20)
                        .onTapGesture {
                            withAnimation {
                                self.petalOffset = Double.random(in: -40...40)
                                self.petalWidth = Double.random(in: 0...100)
                                self.colorID = Double(Int.random(in: 0...7))
                            }
                    }
                }
                .textCase(.none)
                
                
                Section(header:
                            Text("Configuration")
                            .foregroundColor(.purple)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                ) {
                    
                    HStack(spacing: 10.0) {
                        Text("Saturation : ")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        HStack {
                            Slider(value: $saturationAmount)
                                .padding()
                            let formattedFloat = String(format: "%.3f", saturationAmount)
                            Text("\(formattedFloat)")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                    }
                    
                    
                    HStack(spacing: 30.0)  {
                        
                        Text("Blur : ")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        
                        HStack {
                            Slider(value: $blurAmount)
                                .padding()
                            let formattedFloat = String(format: "%.3f", blurAmount)
                            Text("\(formattedFloat)")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                    }
                    
                    
                    HStack(spacing: 30.0)  {
                        
                        Text("Multiply : ")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        
                        HStack {
                            Slider(value: $colorID, in: 0...7)
                                .padding()
                            Circle()
                                .fill(colorArray[Int(colorID)])
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .textCase(.none)
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
