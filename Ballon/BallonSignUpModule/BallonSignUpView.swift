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
                
                Image(.loginRectangle)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.717)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.46)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Spacer(minLength: geometry.size.height * 0.36)
                        
                        VStack(spacing: 35) {
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
                                                }
                                            }
                                        case .failure(let error):
                                            DispatchQueue.main.async {
                                                switch error {
                                                case .invalidStatusCode(let code):
                                                    ballonSignUpModel.alertMessage = "Ошибка \(code): Сервер недоступен"
                                                case .decodingFailed:
                                                    ballonSignUpModel.alertMessage = "Ошибка обработки данных"
                                                default:
                                                    ballonSignUpModel.alertMessage = "Ошибка сети"
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
                                        .Plus(size: 14)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonSignUpModel.isLog) {
                                BallonLoginView()
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
            .alert("All fields must be filled", isPresented: $ballonSignUpModel.showEmptyFieldsAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    BallonSignUpView()
}
