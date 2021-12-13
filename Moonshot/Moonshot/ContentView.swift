//
//  ContentView.swift
//  Moonshot
//
//  Created by Yassine DAOUDI on 30/8/2021.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var switchDateMembers = false
    @State private var astronautsNames = [String]()
    @State private var animationTimer = 0.0
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .animation(.easeOut)
                    
                    VStack(alignment: .leading) {
                        
                        Text(mission.displayName)
                            .font(.headline)
                            .animation(.easeOut)
                        
                        if switchDateMembers {
                            Text(mission.formattedLaunchDate)
                                .animation(.easeIn)
                        } else {
                            ForEach(mission.crew, id: \.role) { member in
                                HStack {
                                    Text(member.name + ", ")
                                        .animation(.easeIn)
//                                        .rotation3DEffect(.degrees(animationTimer), axis: (0, 1, 0))
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
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.switchDateMembers.toggle()
            }) {
                Image(systemName: "switch.2")
                    .resizable()
                    .frame(width: 22, height: 22)
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
