import SwiftUI

struct BallonTabBarView: View {
    @StateObject var BallonTabBarModel =  BallonTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Home
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
       
            VStack {
                if selectedTab == .Home {
                    BallonMenuView()
                } else if selectedTab == .History {
                    BallonListOfWishesView()
                } else if selectedTab == .Profile {
                    BallonProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BallonTabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    @State private var isActionSheetPresented = false
    
    enum TabType: Int {
        case Home
        case History
        case Profile
        case Action
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .cornerRadius(32)
                .offset(y: 35)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(.white, lineWidth: 1)
                        .offset(y: 35)
                )
            
            HStack {
                Spacer()
                TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                Spacer()
                TabBarItem(imageName: "tab2", tab: .History, selectedTab: $selectedTab)
                Spacer()
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
                Spacer()
                Button(action: {
                    isActionSheetPresented = true
                }) {
                    VStack(spacing: 5) {
                        Image(.addSrt)
                            .resizable()
                            .frame(width: 106, height: 48)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.trailing)
                Spacer()
            }
            .padding(.top, 5)
            .frame(height: 60)
            .fullScreenCover(isPresented: $isActionSheetPresented) {
                BallonAddView()
            }
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 5) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                if selectedTab == tab {
                    Circle()
                        .fill(Color(red: 255/255, green: 188/255, blue: 6/255) )
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
