//
//  DataEvent.swift
//  Oops
//
//  Created by Barak Edry on 24/12/2023.
//

import SwiftUI

struct DataEvent: SwiftUI.View {
    
    @State private var isActive_Back: Bool = false
    @Binding var eventId: Int
    @State private var selectedImageIndex: Int?
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var imageToShow: UIImage?
    
    @State private var selectedImage: UIImage?
    @State private var isShowingEnlargedImage = false

    @State private var d_name_after: String = ""
    @State private var d_addres_after: String = ""
    @State private var d_phone_after: String = ""
    @State private var d_driver_id_after: String = ""
    @State private var d_sure_company_after: String = ""
    @State private var d_policy_num_after: String = ""
    @State private var d_sure_name_after: String = ""
    @State private var d_sure_date_after: String = ""
    @State private var d_sure_agent_after: String = ""
    @State private var d_car_num_after: String = ""
    @State private var d_car_type_after: String = ""
    @State private var d_car_color_after: String = ""
    
    @State private var d_name_before: String = ""
    @State private var d_addres_before: String = ""
    @State private var d_phone_before: String = ""
    @State private var d_driver_id_before: String = ""
    @State private var d_sure_company_before: String = ""
    @State private var d_policy_num_before: String = ""
    @State private var d_sure_name_before: String = ""
    @State private var d_sure_date_before: String = ""
    @State private var d_sure_agent_before: String = ""
    @State private var d_car_num_before: String = ""
    @State private var d_car_type_before: String = ""
    @State private var d_car_color_before: String = ""
    
    @FocusState private var nameFocused: Bool
    @FocusState private var addressFocused: Bool
    @FocusState private var phoneFocused: Bool
    @FocusState private var driver_idFocused: Bool
    @FocusState private var sure_companyFocused: Bool
    @FocusState private var policy_numFocused: Bool
    @FocusState private var sure_nameFocused: Bool
    @FocusState private var sure_dateFocused: Bool
    @FocusState private var sure_agentFocused: Bool
    @FocusState private var car_numFocused: Bool
    @FocusState private var car_typeFocused: Bool
    @FocusState private var car_colorFocused: Bool
    
    private func fetchData() {
        let eventData = DatabaseManager().fetchEvent(forEventID: eventId)
        if !eventData.isEmpty {
            self.d_name_before = eventData.first?.2 ?? ""
            self.d_addres_before = eventData.first?.3 ?? ""
            self.d_phone_before = eventData.first?.4 ?? ""
            self.d_driver_id_before = eventData.first?.5 ?? ""
            self.d_sure_company_before = eventData.first?.6 ?? ""
            self.d_policy_num_before = eventData.first?.7 ?? ""
            self.d_sure_name_before = eventData.first?.8 ?? ""
            self.d_sure_date_before = eventData.first?.9 ?? ""
            self.d_sure_agent_before = eventData.first?.10 ?? ""
            self.d_car_num_before = eventData.first?.11 ?? ""
            self.d_car_type_before = eventData.first?.12 ?? ""
            self.d_car_color_before = eventData.first?.13 ?? ""
        } else {
            self.d_name_before = "No Event Data"
        }
    }
    
    private func dismissKeyboard() {
        // Set all @FocusState properties to false to dismiss the keyboard
        nameFocused = false
        addressFocused = false
        phoneFocused = false
        driver_idFocused = false
        sure_companyFocused = false
        policy_numFocused = false
        sure_nameFocused = false
        sure_dateFocused = false
        sure_agentFocused = false
        car_numFocused = false
        car_typeFocused = false
        car_colorFocused = false
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
                    .fullScreenCover(isPresented: $isActive_Back, content: { LastEvents() })
                    
                    Spacer()
                    
                    Text("דף אירוע")
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
                
                ScrollView {
                    ForEach(DatabaseManager().fetchEvent(forEventID: eventId), id: \.0) { rowData in
                        VStack(alignment: .trailing) {
                            Spacer(minLength: 10)
                                HStack {
                                    Spacer()
                                    TextField(d_name_before, text: $d_name_after)
                                        .focused($nameFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                        
                                    
                                    Spacer()
                                    Text("שם הנהג :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()

                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_addres_before, text: $d_addres_after)
                                        .focused($addressFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("כתובת הנהג :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_phone_before, text: $d_phone_after)
                                        .focused($phoneFocused)
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("טלפון הנהג :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_driver_id_before, text: $d_driver_id_after)
                                        .focused($driver_idFocused)
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("תעודת זהות :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_sure_company_before, text: $d_sure_company_after)
                                        .focused($sure_nameFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("שם חברת הביטוח :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_policy_num_before, text: $d_policy_num_after)
                                        .focused($policy_numFocused)
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("מספר הפוליסה :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_sure_name_before, text: $d_sure_name_after)
                                        .focused($sure_nameFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("שם המבוטח :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_sure_date_before, text: $d_sure_date_after)
                                        .focused($sure_dateFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("תוקף הביטוח :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_sure_agent_before, text: $d_sure_agent_after)
                                        .focused($sure_nameFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("שם סוכן הביטוח :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            
                                HStack {
                                    Spacer()
                                    TextField(d_car_num_before, text: $d_car_num_after)
                                        .focused($car_numFocused)
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("מספר הרכב :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)

                                HStack {
                                    Spacer()
                                    TextField(d_car_type_before, text: $d_car_type_after)
                                        .focused($car_typeFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("דגם הרכב :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)

                                HStack {
                                    Spacer()
                                    TextField(d_car_color_before, text: $d_car_color_after)
                                        .focused($car_colorFocused)
                                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 20)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                        .multilineTextAlignment(.trailing)
                                    
                                    Spacer()
                                    Text("צבע הרכב :")
                                        .frame(maxWidth: UIScreen.main.bounds.width/3, maxHeight: 20)
                                    Spacer()
                                }
                                Spacer(minLength: 10)
                            }
                        
                        Spacer(minLength: 10)
                        
                        VStack(alignment: .trailing) {
                            ScrollView(.horizontal) {
                                HStack {
                                    Spacer()
                                    if let imageData = rowData.14,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.15,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.16,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.17,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.18,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.19,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.20,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.21,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.22,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.23,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.24,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                    if let imageData = rowData.25,
                                       let uiImage = UIImage(data: imageData)?.fixedOrientation(),
                                       let cgImage = uiImage.cgImage {
                                        Image(uiImage: UIImage(cgImage: cgImage))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 400)
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedImage = uiImage
                                                self.isShowingEnlargedImage = true
                                            }
                                    }
                                    Spacer()
                                }
                            }
                            .sheet(isPresented: $isShowingEnlargedImage) {
                                ZStack {
                                    if let selectedImage = self.selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFit()
                                    } else {
                                        Text("No image selected") // This should now be less likely to appear erroneously
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 10)
                        
                    }
                    Spacer(minLength: 10)
                    VStack(alignment: .trailing){
                        Button(action: {
                            
                            let databaseManager = DatabaseManager()
      
                            if !(d_name_after != d_name_before && !d_name_after.isEmpty){
                                d_name_after = d_name_before
                            }
                            if !(d_addres_after != d_addres_before && !d_addres_after.isEmpty){
                                d_addres_after = d_addres_before
                            }
                            if !(d_phone_after != d_phone_before && !d_phone_after.isEmpty){
                                d_phone_after = d_phone_before
                            }
                            if !(d_driver_id_after != d_driver_id_before && !d_driver_id_after.isEmpty){
                                d_driver_id_after = d_driver_id_before
                            }
                            if !(d_sure_company_after != d_sure_company_before && !d_sure_company_after.isEmpty){
                                d_sure_company_after = d_sure_company_before
                            }
                            if !(d_policy_num_after != d_policy_num_before && !d_policy_num_after.isEmpty){
                                d_policy_num_after = d_policy_num_before
                            }
                            if !(d_sure_name_after != d_sure_name_before && !d_sure_name_after.isEmpty){
                                d_sure_name_after = d_sure_name_before
                            }
                            if !(d_sure_date_after != d_sure_date_before && !d_sure_date_after.isEmpty){
                                d_sure_date_after = d_sure_date_before
                            }
                            if !(d_sure_agent_after != d_sure_agent_before && !d_sure_agent_after.isEmpty){
                                d_sure_agent_after = d_sure_agent_before
                            }
                            if !(d_car_num_after != d_car_num_before && !d_car_num_after.isEmpty){
                                d_car_num_after = d_car_num_before
                            }
                            if !(d_car_type_after != d_car_type_before && !d_car_type_after.isEmpty){
                                d_car_type_after = d_car_type_before
                            }
                            if !(d_car_color_after != d_car_color_before && !d_car_color_after.isEmpty){
                                d_car_color_after = d_car_color_before
                            }
                            
                            databaseManager.updateAccident(
                                id: eventId,
                                name: d_name_after,
                                addres: d_addres_after,
                                phone: d_phone_after,
                                driver_id: d_driver_id_after,
                                sure_company: d_sure_company_after,
                                policy_num: d_policy_num_after,
                                sure_name: d_sure_name_after,
                                sure_date: d_sure_date_after,
                                sure_agent: d_sure_agent_after,
                                car_num: d_car_num_after,
                                car_type: d_car_type_after,
                                car_color: d_car_color_after)
                                
                            showAlert = true
                            alertTitle = "עודכן בהצלחה"
                            alertMessage = "פרטי התאונה עודכנו בהצלחה"
                            /*  press_Save = true
                                showAlert_Save = true*/

                                
                            },
                               label: {
                            Label("עדכון", systemImage: "square.and.arrow.down.fill")
                                .frame(width: 150 , height: 40)
                                .padding()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .background(Color.brown)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(alertTitle),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK")) {
                                }
                            )
                        }
                    }
                }
                
            }
            
        }
        .onAppear {
            fetchData()
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }

}

//#Preview {
//  DataEvent()
//}
