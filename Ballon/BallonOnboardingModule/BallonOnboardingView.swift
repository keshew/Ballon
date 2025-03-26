import SwiftUI

struct BallonOnboardingView: View {
    @StateObject var ballonOnboardingModel =  BallonOnboardingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(ballonOnboardingModel.contact.arrayOfImage[ballonOnboardingModel.currentIndex])
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.57)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4.9)
                
                Image(.loginRectangle)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.63)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.31)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                if ballonOnboardingModel.currentIndex > 0 {
                                    ballonOnboardingModel.currentIndex -= 1
                                } else {
                                    ballonOnboardingModel.isBack = true
                                }
                            }) {
                                HStack {
                                    Image(.backButton)
                                        .resizable()
                                        .frame(width: 14, height: 12)
                                        .padding(.leading)
                                    
                                    Image(.dividerOb)
                                        .resizable()
                                        .frame(width: 2, height: 20)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonOnboardingModel.isBack) {
                                BallonLoginView()
                            }
                            
                            Text("Welcome")
                                .PlusBold(size: 20, color: Color(red: 253/255, green: 190/255, blue: 67/255))
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.0385)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 13/255, green: 106/255, blue: 160/255))
                                .frame(
                                    width: geometry.size.width * 0.816,
                                    height: geometry.size.height * 0.0077
                                )
                                .cornerRadius(3)
                            
                            Rectangle()
                                .fill(Color(red: 253/255, green: 190/255, blue: 67/255))
                                .frame(width: ballonOnboardingModel.contact.arrayOfSize[ballonOnboardingModel.currentIndex], height: 7)
                                .cornerRadius(3)
                                .offset(x: ballonOnboardingModel.contact.arrayOfOffset[ballonOnboardingModel.currentIndex])
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.411)
                        
                        VStack(spacing: 60) {
                            Text(ballonOnboardingModel.contact.arrayOfLabel[ballonOnboardingModel.currentIndex])
                                .PlusBold(size: 26)
                                .frame(width: geometry.size.width * 0.9, height: 70)
                                .multilineTextAlignment(.center)
                            
                            Text(ballonOnboardingModel.contact.arrayOfLabel2[ballonOnboardingModel.currentIndex])
                                .Plus(size: 26)
                                .frame(width: geometry.size.width * 0.9, height: 100)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                if ballonOnboardingModel.currentIndex < 6 {
                                    ballonOnboardingModel.currentIndex += 1
                                } else {
                                    ballonOnboardingModel.isTab = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 54)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 125)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 169/255, green: 160/255, blue: 160/255), lineWidth: 2.5)
                                                .padding(.horizontal, 125)
                                        }
                                    
                                    Text("Continue")
                                        .Plus(size: 14)
                                }
                            }
                            .padding(.bottom)
                                
                            .fullScreenCover(isPresented: $ballonOnboardingModel.isTab) {
                                BallonTabBarView()
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    BallonOnboardingView()
}

