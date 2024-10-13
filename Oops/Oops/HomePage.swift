//
//  ContentView.swift
//  Oops
//
//  Created by Barak Edry on 05/11/2023.
//

import SwiftUI
import Foundation

struct HomePage: View {
    
    @State private var isActive_AddEvent: Bool = false
    @State private var isActive_LastEvents: Bool = false
    @State private var showAlertMessage = false
    
    var body: some View {
        ZStack {
            Image("background-image")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text(getTimeOfDay())
                    .font(.system(size: UIScreen.main.bounds.width / 6.5))
                    .fontWeight(.bold)
                    .underline()
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.white, .brown],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                    .minimumScaleFactor(0.5)
                    
                Spacer()
                
                Button(action: {
                    isActive_AddEvent = true
                    },
                    label: {
                    Label("הוספת תאונה", systemImage: "car.rear.and.tire.marks")
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 5)
                        )
                        .cornerRadius(8)
                    })
                .fullScreenCover(isPresented: $isActive_AddEvent, content: { AddEvent() })
                
                Spacer()
                
                Button(action: {
                    let isEmpty = DatabaseManager().isAccidentsTableEmpty()
                    if !isEmpty{
                        isActive_LastEvents = true
                    }
                    else{
                        isActive_LastEvents = false
                        showAlertMessage = true
                    }
                },
                    label: {
                    Label("אירועים קודמים", systemImage: "steeringwheel")
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 5)
                        )
                        .cornerRadius(8)
                })
                .fullScreenCover(isPresented: $isActive_LastEvents, content: { LastEvents() })
                .alert(isPresented: $showAlertMessage) {
                    Alert(
                        title: Text("הערה"),
                        message: Text("אין אירועים קודמים"),
                        dismissButton: .default(Text("אישור"))
                    )}
                    
                
                Spacer()
                
                Image(systemName: "car.2")
                    .foregroundColor(.secondary)
                    .font(.system(size: UIScreen.main.bounds.width / 4))
            
                Spacer()
            }
        }
    }
    
    func getTimeOfDay() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour >= 6 && hour < 12 {
            return "בוקר טוב !"
        }
        else if hour >= 12 && hour < 17 {
            return "צהריים טובים !"
        }
        else {
            return "ערב טוב !"
        }
    }
}

#Preview {
    HomePage()
}
