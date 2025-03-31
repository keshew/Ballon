import SwiftUI

struct BallonLoginView: View {
    @StateObject var ballonLoginModel =  BallonLoginViewModel()
    @State var isImage = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.ballon)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.57)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 4.9)
                
                Rectangle()
                    .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                    .cornerRadius(40)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.31)
                    .overlay {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.31)
                    }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 290)
                        VStack(spacing: 20) {
                            VStack(spacing: 15) {
                                Text("Login")
                                    .PlusBold(size: 26)
                                
                                Text("Welcome back! Please enter your details.")
                                    .Plus(size: 14)
                            }
                            
                            VStack(spacing: 20) {
                                CustomTextFiled(text: $ballonLoginModel.email,
                                                geometry: geometry,
                                                placeholder: "Email")
                             
                                CustomSecureField(text: $ballonLoginModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Password",
                                                  image: BallonImageName.eye.rawValue)
                                
                            }
                            
                            HStack(spacing: -5) {
                                Button(action: {
                                    isImage.toggle()
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                            .frame(width: 16, height: 16)
                                            .cornerRadius(5)
                                            .padding(.horizontal, 20)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color(red: 169/255, green: 160/255, blue: 160/255), lineWidth: 0.5)
                                                    .padding(.horizontal, 20)
                                            }
                                        
                                        if isImage {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.white)
                                                .font(.custom("PlusJakartaSans-Regular", size: 12))
                                        }
                                    }
                                }
                                
                                Text("Remember information")
                                    .Plus(size: 14)
                                
                                Spacer()
                            }
                            .padding(.leading, 5)
                            
                            Button(action: {
                                if ballonLoginModel.validateFields() {
                                    NetworkManager().loginUser(
                                        email: ballonLoginModel.email,
                                        password: ballonLoginModel.password
                                    ) { result in
                                        switch result {
                                        case .success(let response):
                                            if response.status == "success" {
                                                if UserDefaultsManager().login(
                                                    email: ballonLoginModel.email,
                                                    password: ballonLoginModel.password
                                                ) {
                                                    DispatchQueue.main.async {
                                                        if UserDefaultsManager().isFirstLaunch() {
                                                            ballonLoginModel.isOnb = true
                                                        } else {
                                                            ballonLoginModel.isTab = true
                                                        }
                                                    }
                                                } else {
                                                    DispatchQueue.main.async {
                                                        ballonLoginModel.showEmptyFieldsAlert = true
                                                    }
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    ballonLoginModel.alertMessage = "Incorrect email or password"
                                                    ballonLoginModel.showEmptyFieldsAlert = true
                                                }
                                            }
                                        case .failure(let error):
                                            DispatchQueue.main.async {
                                                switch error {
                                                case .invalidStatusCode(let code):
                                                    ballonLoginModel.alertMessage = "Error \(code): Server is busy"
                                                case .decodingFailed:
                                                    ballonLoginModel.alertMessage = "Data error"
                                                default:
                                                    ballonLoginModel.alertMessage = "Network error"
                                                }
                                                ballonLoginModel.showEmptyFieldsAlert = true
                                            }
                                        }
                                    }
                                } else {
                                    ballonLoginModel.showEmptyFieldsAlert = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 54)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 25)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 169/255, green: 160/255, blue: 160/255), lineWidth: 2)
                                                .padding(.horizontal, 25)
                                        }
                                    
                                    Text("Join now")
                                        .PlusBold(size: 14)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonLoginModel.isOnb) {
                                BallonOnboardingView()
                            }
                            .fullScreenCover(isPresented: $ballonLoginModel.isTab) {
                                BallonTabBarView()
                            }
                            
                            Button(action: {
                                UserDefaultsManager().enterAsGuest()
                                if UserDefaultsManager().isFirstLaunch() {
                                    ballonLoginModel.isOnb = true
                                } else {
                                    ballonLoginModel.isTab = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 54)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 100)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 100)
                                        }
                                    
                                    Text("Log in as guest")
                                        .PlusBold(size: 14)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonLoginModel.isTab) {
                                BallonTabBarView()
                            }
                            .fullScreenCover(isPresented: $ballonLoginModel.isOnb) {
                                BallonOnboardingView()
                            }
                            
                            Button(action: {
                                ballonLoginModel.isSign = true
                            }) {
                                Text("Forget password?")
                                    .PlusBold(size: 14)
                            }
                            .fullScreenCover(isPresented: $ballonLoginModel.isSign) {
                                BallonSignUpView()
                            }
                            
                            HStack {
                                Text("First time here?")
                                    .Plus(size: 14, color: Color(red: 217/255, green: 223/255, blue: 229/255))
                                
                                Button(action: {
                                    ballonLoginModel.isSign = true
                                }) {
                                    Text("Sign up for free")
                                        .PlusBold(size: 14)
                                }
                                .fullScreenCover(isPresented: $ballonLoginModel.isSign) {
                                    BallonSignUpView()
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }
            }
            .alert(ballonLoginModel.alertMessage, isPresented: $ballonLoginModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    BallonLoginView()
}

