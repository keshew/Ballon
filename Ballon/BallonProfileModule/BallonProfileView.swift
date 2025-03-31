import SwiftUI
import WebKit

struct BallonProfileView: View {
    @StateObject var ballonProfileModel =  BallonProfileViewModel()
    @State private var showTermsOfUse = false
    @State private var showPrivacyPolicy = false
    
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
                
                Text("Profile")
                    .PlusBold(size: 26,
                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 21)
                
                Rectangle()
                    .fill(Color(red: 14/255, green: 71/255, blue: 95/255))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.97)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.74)
                    .overlay {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.97)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 1.74)
                    }
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(spacing: 10) {
                            if UserDefaultsManager().isGuest() {
                                Text("Guest")
                                    .PlusBold(size: 30,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                Text("Guest")
                                    .Plus(size: 20,
                                          color: Color(red: 182/255, green: 180/255, blue: 193/255))
                            } else {
                                Text("\(UserDefaultsManager().getName(for: UserDefaultsManager().getEmail() ?? "NAME") ?? "") \(UserDefaultsManager().getSurename(for: UserDefaultsManager().getEmail() ?? "") ?? "")")
                                    .PlusBold(size: 30,
                                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                
                                Text("\(UserDefaultsManager().getEmail() ?? "")")
                                    .Plus(size: 20,
                                          color: Color(red: 182/255, green: 180/255, blue: 193/255))
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.064)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                                .frame(height: geometry.size.height * 0.127)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white, lineWidth: 1)
                                        .padding(.horizontal, 20)
                                }
                            
                            VStack(spacing: -5) {
                                HStack {
                                    Text("Notification")
                                        .PlusBold(size: 16,
                                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                        .padding(.leading, 40)
                                        .padding(.top)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Image(.notif)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(.leading, 40)
                                    
                                    Text("Pop-up Notification")
                                        .Plus(size: 14,
                                              color: Color(red: 182/255, green: 180/255, blue: 193/255))
                                    
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $ballonProfileModel.isTog)
                                        .toggleStyle(CustomToggleStyle())
                                        .padding(.trailing, 30)
                                }
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                                .frame(height: geometry.size.height * 0.166)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white, lineWidth: 1)
                                        .padding(.horizontal, 20)
                                }
                            
                            VStack(spacing: 20) {
                                HStack {
                                    Text("Other")
                                        .PlusBold(size: 16,
                                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                        .padding(.leading, 40)
                                    
                                    Spacer()
                                }
                                
                                VStack(spacing: 12) {
                                    Button {
                                        showTermsOfUse = true
                                    } label: {
                                        HStack {
                                            Image(.contact)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .padding(.leading, 40)
                                            
                                            Text("Term of use")
                                                .Plus(size: 12,
                                                      color: Color(red: 182/255, green: 180/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            Image(.chevronRight)
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .padding(.trailing, 40)
                                        }
                                    }
                                    .sheet(isPresented: $showTermsOfUse) {
                                        WebView(url: URL(string: "https://docs.google.com/document/d/118uiSk8vy4coglJJP4gQbrWFTO7VQozvVdxXxVtTfYk/edit?usp=sharing")!)
                                    }
                                    
                                    Button {
                                        showPrivacyPolicy = true
                                    } label: {
                                        HStack {
                                            Image(.privacy)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                                .padding(.leading, 40)
                                            
                                            Text("Privacy Policy")
                                                .Plus(size: 12,
                                                      color: Color(red: 182/255, green: 180/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            Image(.chevronRight)
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .padding(.trailing, 40)
                                        }
                                    }
                                    .sheet(isPresented: $showPrivacyPolicy) {
                                        WebView(url: URL(string: "https://www.freeprivacypolicy.com/live/94670fe3-85d3-4fd9-85c4-06c7cd7e2a66")!)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        
                        Spacer(minLength: 30)
                        
                        Button(action: {
                            UserDefaultsManager().saveLoginStatus(false)
                            ballonProfileModel.isLogOut = true
                            UserDefaultsManager().quitQuest()
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                                    .cornerRadius(12)
                                    .padding(.horizontal, 20)
                                    .frame(height: 50)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.white, lineWidth: 1)
                                            .padding(.horizontal, 20)
                                    }
                                
                                HStack {
                                    Text("Log out")
                                        .PlusBold(size: 16,
                                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                    Spacer()
                                    
                                    Image(.chevronRight)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }
                                .padding(.horizontal, 40)
                            }
                        }
                        .fullScreenCover(isPresented: $ballonProfileModel.isLogOut) {
                            BallonSignUpView()
                        }
                        
                        Spacer(minLength: 20)
                        
                        if !UserDefaultsManager().isGuest() {
                            Button(action: {
                                NetworkManager().deleteUser(email: UserDefaultsManager().getEmail()!) { result in
                                    switch result {
                                    case .success(let response):
                                        if response.status == "success" {
                                            DispatchQueue.main.async {
                                                ballonProfileModel.isLogOut = true
                                            }
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                        .frame(height: 50)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.white, lineWidth: 1)
                                                .padding(.horizontal, 20)
                                        }
                                    
                                    HStack {
                                        Text("Delete account")
                                            .PlusBold(size: 16,
                                                      color: Color(red: 234/255, green: 32/255, blue: 62/255))
                                        Spacer()
                                        
                                        Image(.chevronRight)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(.horizontal, 40)
                                }
                            }
                            .fullScreenCover(isPresented: $ballonProfileModel.isLogOut) {
                                BallonSignUpView()
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top, geometry.size.height * 0.141)
                }
            }
        }
    }
}

#Preview {
    BallonProfileView()
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
