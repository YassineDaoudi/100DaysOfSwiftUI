//
//  ContentView.swift
//  Drawing-46
//
//  Created by Yassine DAOUDI on 28/10/2021.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        return path
    }
}

struct WheelShape: Shape {
    let symbols : [String]
    
    init(_ symbols: [String]) {
        self.symbols = symbols
    }
    
    func path(in rect: CGRect) -> Path {
        // center of the shape we are drawing in
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        let radius = min(rect.size.width / 2, rect.size.height / 2)
        // each angle offset in radians
        let theta = CGFloat(2) * .pi / CGFloat(symbols.count)
        var path = Path()
        
        // enumerate the array so index is available
        symbols.enumerated().forEach({ (index, symbol) in
            let offset = theta * CGFloat(index)
            path.move(to: center)
            path.addLine(to: CGPoint(x: radius * cos(offset) + center.x, y: radius * sin(offset) + center.y))
        })
        
        return path
    }
}

struct ContentView: View {
    
    @State private var angle: Double = 0
    let symbols = ["umbrella", "hand.thumbsdown", "airpodspro", "hand.thumbsdown", "repeat.1", "book", "hand.thumbsdown","gamecontroller", "paintpalette", "logo.playstation", "macpro.gen3", "hand.thumbsdown", "homepodmini.and.appletv", "airtag"]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                WheelShape(symbols)
                    .stroke(.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 300)
                    .background(
                        Circle()
                            .stroke(.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    )
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                    .overlay(annotations.foregroundColor(.white))
                
                
                Arrow()
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 60, height: 80)
                    .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 0, z: 1))
                
                
                Button(action: {
                    withAnimation {
                        angle = Double.random(in: 0...360)
                    }
                }) {
                    Text("Spin")
                }
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                .offset(x: 6, y: 250)
                
            }
            .navigationTitle("La roulette")
        }
    }
    
    var annotations : some View {
        ZStack {
            let theta = CGFloat(2) * .pi / CGFloat(symbols.count)
            GeometryReader { geo in
                let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
                let radius = min(geo.size.width / 2, geo.size.height / 2) / 1.3
                ForEach(0..<symbols.count, id: \.self) { index in
                    let offset = theta * CGFloat(index) + theta / 2
                    // place SF Symbol, offset to center, then the radius
                    Image(systemName: symbols[index])
                        .offset(x: center.x, y: center.y)
                        .offset(x: radius * cos(offset), y: radius * sin(offset))
                        .frame(alignment: .center)
                        .offset(x: -10, y: -10) // fudge factor to center symbol in wedge
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
