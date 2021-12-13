//
//  ChartView.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 22/11/2021.
//

import SwiftUI

struct ChartView: View {
    
    @ObservedObject var activities = Activities()
    @State var indexOfTappedSlice = -1
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<activities.items.count) { index in
                        Circle()
                            .trim(from: index == 0 ? 0.0 : activities.items[index-1].value/100,
                                  to: activities.items[index].value/100)
                            .stroke(Color(Color.RGBColorSpace.sRGB,
                                          red: activities.items[index].red,
                                          green: activities.items[index].green,
                                          blue: activities.items[index].blue,
                                          opacity: 1),lineWidth: 100)
                            .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                            .animation(.spring())
                    }
                }
                .frame(width: 100, height: 200)
                .onAppear() {
                    self.activities.calc()
                }
                            
                //MARK:- Description
                    ForEach(0..<activities.items.count) { index in
                        HStack {
                            Text("\(activities.items[index].title): "+String(format: "%.2f", Double(activities.items[index].percent))+"%")
                                .font(indexOfTappedSlice == index ? .headline : .subheadline)
                            
                            Circle()
                                .fill(Color(Color.RGBColorSpace.sRGB,
                                            red: activities.items[index].red,
                                            green: activities.items[index].green,
                                            blue: activities.items[index].blue,
                                            opacity: 1))
                                .frame(width: 15, height: 15)
                        }
                        .onTapGesture {
                            indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                        }
                    }
                    .padding(8)
                    .frame(width: 300, alignment: .trailing)
            }
            .navigationTitle("My Weekly Chart")
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
