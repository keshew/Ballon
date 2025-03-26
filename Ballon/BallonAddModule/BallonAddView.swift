import SwiftUI

struct BallonAddView: View {
    @StateObject var ballonAddModel =  BallonAddViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.topMenu)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.168)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.0045)
                
                Image(.ball)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.976)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                
                Image(.shadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.976)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                
                Image(.loginRectangle)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.544)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                    
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.close)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            Text("Add new ballon!")
                                .PlusBold(size: 26,
                                          color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                .padding(.trailing, 40)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        ZStack {
                            Image(.whiteRectnagle)
                                .resizable()
                                .frame(width: 137, height: 35)
                            
                            HStack {
                                Image(.plus)
                                    .resizable()
                                    .frame(width: 41, height: 41)
                                
                                Text("\(UserDefaults.standard.object(forKey: "coin") as? Int ?? 0)")
                                    .Plus(size: 25,
                                          color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                    .lineLimit(1)
                                    .frame(width: 50)
                                Image(.coin)
                                    .resizable()
                                    .frame(width: 49, height: 52)
                            }
                        }
                        
                        Spacer(minLength: 10)
                        
                        Text("Select ballon")
                            .PlusBold(size: 20,
                                      color: Color(red: 253/255, green: 190/255, blue: 67/255))
                        
                        Spacer(minLength: 20)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                if ballonAddModel.currentIndex > 0 {
                                    ballonAddModel.currentIndex -= 1
                                }
                            }) {
                                Image(.leftBtn)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            
                            Image(ballonAddModel.contact.arrayImage[ballonAddModel.currentIndex])
                                .resizable()
                                .frame(width: 135, height: 178)
                            
                            Button(action: {
                                if ballonAddModel.currentIndex < 5 {
                                    ballonAddModel.currentIndex += 1
                                }
                            }) {
                                Image(.rightBtn)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        VStack(spacing: 15) {
                            VStack {
                                Text("Type here name")
                                    .PlusBold(size: 15,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                CustomTextFiled(text: $ballonAddModel.name,
                                                geometry: geometry,
                                                placeholder: "Name")
                            }
                            
                            VStack {
                                HStack(spacing: 5) {
                                    Text("Type here cost")
                                        .PlusBold(size: 15,
                                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                    
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                }
                                
                                CustomTextFiled(text: $ballonAddModel.cost,
                                                geometry: geometry,
                                                placeholder: "Cost")
                            }
                            
                            VStack {
                                Text("Type here description")
                                    .PlusBold(size: 15,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                
                                CustomTextView(text: $ballonAddModel.desc,
                                                geometry: geometry,
                                                placeholder: "Description")
                            }
                        }
                       
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            if !ballonAddModel.name.isEmpty && !ballonAddModel.cost.isEmpty && !ballonAddModel.desc.isEmpty {
                                if ballonAddModel.validateCost() {
                                    ballonAddModel.saveNewBallon()
                                    ballonAddModel.isMenu = true
                                } else {
                              
                                    ballonAddModel.showEmptyFieldsAlert = true
                                }
                            } else {
                                ballonAddModel.alertMessage = "All fields must be filled"
                                ballonAddModel.showEmptyFieldsAlert = true
                            }
                        }) {
                            Image(.addBallon)
                                .resizable()
                                .frame(width: 209, height: 54)
                        }
                        .padding(.bottom)
                        .fullScreenCover(isPresented: $ballonAddModel.isMenu) {
                            BallonTabBarView()
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(ballonAddModel.alertMessage, isPresented: $ballonAddModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    BallonAddView()
}
