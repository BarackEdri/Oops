//
//  LastEvents.swift
//  Oops
//
//  Created by Barak Edry on 06/11/2023.
//

import SwiftUI
import Foundation

struct LastEvents: View {
    
    @State private var isActive_Back: Bool = false
    @State private var view_EventData: Bool = false
    @State private var lastEventRows: [(Int, String, String, String, String, String, String, String, String, String, String, String, String, String, Data?, Data?, Data?, Data?, Data?, Data?, Data?, Data?, Data?, Data?, Data?, Data?, String)] = []
    @State private var showAlert = false
    @State private var deletionIndexSet: IndexSet?
    @State private var deletionOrdinalNum: Int?
    @State private var selectedEventID: Int = 0
    
    func deleteRow(at offsets: IndexSet, in index: Int) {
        lastEventRows.remove(atOffsets: offsets)
        DatabaseManager().deleteEvent(byOrdinalNum: index)
    }
    
    var body: some View {
        
        ZStack {
            Image("pages-background-image")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Spacer()
                    
                    Button(action: {
                        isActive_Back = true
                    },
                           label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .font(.title)
                            .foregroundColor(Color.black)
                    })
                    .fullScreenCover(isPresented: $isActive_Back, content: { HomePage() })
                    
                    Spacer()
                    
                    Text("אירועים קודמים")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .underline()
                        .frame(maxWidth: UIScreen.main.bounds.width)
                    
                    Spacer()
                    
                    Image(systemName: "arrowshape.turn.up.backward")
                        .foregroundColor(.clear)
                        .font(.title)
                    
                    Spacer()
                }

                Spacer(minLength: 20)
                
                List {
                    ForEach(lastEventRows, id: \.0) { rowData in
                        Button(action: {
                            view_EventData = true
                            selectedEventID = rowData.0
                        },
                        label: {
                            VStack(alignment: .trailing) {
                                HStack{
                                    Text("\(rowData.26)").bold(true)
                                    Text("תאריך התאונה :").bold(true)
                                    
                                }.font(.system(size: UIScreen.main.bounds.width / 23))
                               /* HStack{
                                    Text("\(rowData.2)")
                                    Text("שם הנהג :").bold(true)
                                }
                                HStack{
                                    Text("\(rowData.11)")
                                    Text("מספר הרכב :").bold(true)
                                }
                                HStack{
                                    Text("\(rowData.12)")
                                    Text("סוג הרכב :").bold(true)
                                }
                                HStack{
                                    Text("\(rowData.13)")
                                    Text("צבע הרכב :").bold(true)
                                } */
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 40)
                            .padding(10)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        })
                        .listRowBackground(Color.clear)
                        .fullScreenCover(isPresented: $view_EventData) {
                            DataEvent(eventId: $selectedEventID)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        showAlert = true
                        deletionIndexSet = indexSet
                        if let firstIndex = indexSet.first {
                            deletionOrdinalNum = lastEventRows[firstIndex].0
                        }
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("אישור מחיקה"),
                            message: Text("האם ברצונך למחוק אירוע זה?"),
                            primaryButton: .destructive(Text("מחיקה")) {
                                if let indexSet = deletionIndexSet {
                                    deleteRow(at: indexSet, in: deletionOrdinalNum!)
                                }
                            },
                            secondaryButton: .default(Text("לא")) {
                                deletionIndexSet = nil
                            }
                        )
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .onAppear {
                    let userID = getUniqueDeviceIdentifier()
                    lastEventRows = DatabaseManager().fetchLastEvents(forUserID: userID!)
                }
            }
        }
    }
}

#Preview {
    LastEvents()
}
