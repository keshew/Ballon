import SwiftUI

struct BallonSignUpView: View {
    @StateObject var ballonSignUpModel =  BallonSignUpViewModel()
    
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
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.45)
                    .overlay {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.85)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.45)
                    }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Spacer(minLength: geometry.size.height * 0.29)
                        
                        VStack(spacing: 28) {
                            VStack(spacing: 10) {
                                Text("Sign up")
                                    .PlusBold(size: 26)
                                
                                Text("Hello there! Let’s create your account.")
                                    .Plus(size: 14)
                            }
                            
                            VStack(spacing: 10) {
                                CustomTextFiled(text: $ballonSignUpModel.name,
                                                geometry: geometry,
                                                placeholder: "Name")
                                
                                CustomTextFiled(text: $ballonSignUpModel.surename,
                                                geometry: geometry,
                                                placeholder: "Surname")
                                
                                CustomSecureField(text: $ballonSignUpModel.password,
                                                  geometry: geometry,
                                                  placeholder: "Password",
                                                  image: BallonImageName.eye.rawValue)
                                
                                CustomTextFiled(text: $ballonSignUpModel.email,
                                                geometry: geometry,
                                                placeholder: "Email addres")
                            }
                            
                            Button(action: {
                                if ballonSignUpModel.validateFields() {
                                    NetworkManager().registerUser(
                                        firstName: ballonSignUpModel.name,
                                        lastName: ballonSignUpModel.surename,
                                        email: ballonSignUpModel.email,
                                        password: ballonSignUpModel.password
                                    ) { result in
                                        switch result {
                                        case .success(let response):
                                            if response.status == "success" {
                                                if UserDefaultsManager().register(
                                                    email: ballonSignUpModel.email,
                                                    password: ballonSignUpModel.password,
                                                    name: ballonSignUpModel.name,
                                                    surename: ballonSignUpModel.surename
                                                ) {
                                                    DispatchQueue.main.async {
                                                        ballonSignUpModel.isLog = true
                                                    }
                                                } else {
                                                    DispatchQueue.main.async {
                                                        ballonSignUpModel.showEmptyFieldsAlert = true
                                                    }
                                                }
                                            } else {
                                                DispatchQueue.main.async {
                                                    ballonSignUpModel.showEmptyFieldsAlert = true
                                                    ballonSignUpModel.alertMessage = "This email is already registered"
                                                }
                                            }
                                        case .failure(let error):
                                            DispatchQueue.main.async {
                                                switch error {
                                                case .invalidStatusCode(let code):
                                                    ballonSignUpModel.alertMessage = "Error \(code): Server is busy"
                                                case .decodingFailed:
                                                    ballonSignUpModel.alertMessage = "Data error"
                                                default:
                                                    ballonSignUpModel.alertMessage = "Network error"
                                                }
                                                ballonSignUpModel.showEmptyFieldsAlert = true
                                            }
                                        }
                                    }
                                } else {
                                    ballonSignUpModel.showEmptyFieldsAlert = true
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                                        .frame(height: 54)
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    Text("Create account")
                                        .PlusBold(size: 14)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonSignUpModel.isLog) {
                                BallonLoginView()
                            }
                            
                            Button(action: {
                                UserDefaultsManager().enterAsGuest()
                                if UserDefaultsManager().isFirstLaunch() {
                                    ballonSignUpModel.isOnb = true
                                } else {
                                    ballonSignUpModel.isGuest = true
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
                            .fullScreenCover(isPresented: $ballonSignUpModel.isGuest) {
                                BallonTabBarView()
                            }
                            .fullScreenCover(isPresented: $ballonSignUpModel.isOnb) {
                                BallonOnboardingView()
                            }
                            
                            
                            HStack {
                                Text("Join us before?")
                                    .Plus(size: 14, color: Color(red: 217/255, green: 223/255, blue: 229/255))
                                
                                Button(action: {
                                    ballonSignUpModel.isLog = true
                                }) {
                                    Text("Login")
                                        .PlusBold(size: 14)
                                }
                                .fullScreenCover(isPresented: $ballonSignUpModel.isLog) {
                                    BallonLoginView()
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }
            }
            .alert(ballonSignUpModel.alertMessage, isPresented: $ballonSignUpModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    BallonSignUpView()
}
