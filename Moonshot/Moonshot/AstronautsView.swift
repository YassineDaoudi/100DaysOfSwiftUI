//
//  AstronautsView.swift
//  Moonshot
//
//  Created by Yassine DAOUDI on 17/9/2021.
//

import SwiftUI

struct AstronautsView: View {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronaut: Astronaut
    @State private var animationTimer = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width - 20)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0.0)
                        .shadow(color: .black.opacity(0.3), radius: 30, x: 0.0, y: 20)
                    
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("Took part in : ")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        
                        ForEach(self.missions) { mission in
                            ForEach(mission.crew, id: \.role) { member in
                                if member.name == astronaut.id {
                                    HStack {
                                        Image(mission.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .animation(.easeIn(duration: .infinity))
                                            .rotation3DEffect(.degrees(animationTimer), axis: (0, 1, 0))
                                            
                                            
                                        
                                        Text(mission.displayName)
                                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    }
                                    .onAppear {
                                        withAnimation {
                                            animationTimer += 360
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    
                }
            }
        }
        .navigationBarTitle(self.astronaut.name, displayMode: .inline)
    }
}

struct AstronautsView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautsView(astronaut: astronauts[0])
    }
}
