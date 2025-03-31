import SwiftUI

struct BallonDescriptionView: View {
    @StateObject var ballonDescriptionModel =  BallonDescriptionViewModel()
    @Environment(\.presentationMode) var presentationMode
    var model: BallModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                    .frame(width: geometry.size.width, height: 131)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.0045)
                    .overlay {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(.white, lineWidth: 4)
                            .frame(width: geometry.size.width, height: 131)
                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.0045)
                    }
                
                Image(.balls)
                    .resizable()
                    .frame(width: geometry.size.width, height: 760)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                    .overlay {
                        Color(red: 2/255, green: 74/255, blue: 92/255)
                            .frame(width: geometry.size.width, height: 760)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                            .opacity(0.97)
                            .overlay {
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(.white, lineWidth: 2)
                                    .frame(width: geometry.size.width, height: 760)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                            }
                    }
                
                Rectangle()
                    .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.554)
                    .cornerRadius(40)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                    .overlay {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.554)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.3)
                    }
                
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
                            
                            Text("Description")
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
                                
                                Text("\(UserDefaults.standard.object(forKey: "coin") ?? 0)")
                                    .Plus(size: 25,
                                          color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                    .lineLimit(1)
                                    .frame(width: 50)
                                Image(.coin)
                                    .resizable()
                                    .frame(width: 49, height: 52)
                            }
                        }
                       
                        Spacer(minLength: 30)
                        
                        Image(model.image)
                            .resizable()
                            .frame(width: 135, height: 178)
                        
                        Spacer(minLength: 70)
                        
                        VStack(spacing: 20) {
                            VStack {
                                Text("NAME")
                                    .PlusBold(size: 15,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 46)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    HStack {
                                        Text(model.name)
                                            .Plus(size: 14)
                                            .lineLimit(1)
                                            .padding(.horizontal, 40)
                                        
                                        Spacer()
                                    }
                                }
                                .frame(height: 46)
                                .padding(.horizontal, 20)
                            }
                            
                            VStack {
                                HStack(spacing: 5) {
                                    Text("Cost")
                                        .PlusBold(size: 15,
                                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                    Image(.coin)
                                        .resizable()
                                        .frame(width: 22, height: 23)
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 46)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    HStack {
                                        Text(model.cost)
                                            .Plus(size: 14)
                                            .lineLimit(1)
                                            .padding(.horizontal, 40)
                                        Spacer()
                                    }
                                }
                                .frame(height: 46)
                                .padding(.horizontal, 20)
                            }
                            
                            VStack {
                                Text("Description")
                                    .PlusBold(size: 15,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 135)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    VStack {
                                        HStack {
                                            Text(model.desc)
                                                .Plus(size: 14)
                                                .padding(.horizontal, 40)
                                                .padding(.top)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(height: 135)
                                .padding(.horizontal, 20)
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    BallonDescriptionView(model: BallModel(id: UUID().uuidString, image: "", name: "", cost: "", desc: "", currentCount: 3))
}

