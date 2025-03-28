import SwiftUI
import SpriteKit

struct BallonMenuView: View {
    @StateObject var ballonMenuModel = BallonMenuViewModel()
    @State var isDone = false
    @State private var showCloseButton = false
    @State private var scale: CGFloat = 1.0
    @State private var showVictoryAnimation = false
    @State private var selectedBalloon: BallModel? = nil
    @State var model = BallModel(id: UUID().uuidString,
                                 image: "",
                                 name: "",
                                 cost: "",
                                 desc: "")
    @State private var coinCount: Int = 0
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.topMenu)
                    .resizable()
                    .frame(width: geometry.size.width, height: 131)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.0045)
                
                Text("Home")
                    .PlusBold(size: 26,
                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 21)
                
                Image(.ball)
                    .resizable()
                    .frame(width: geometry.size.width, height: 760)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                
                Image(.shadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: 760)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.75)
                
                ZStack {
                    Image(.whiteRectnagle)
                        .resizable()
                        .frame(width: 137, height: 35)
                    
                    HStack {
                        Button(action: {
                            UserDefaultsManager().addCoin()
                            coinCount = UserDefaults.standard.integer(forKey: "coin")
                        }) {
                            Image(.plus)
                                .resizable()
                                .frame(width: 41, height: 41)
                        }
                        
                        TextField("0", text: Binding(
                             get: { String(coinCount) },
                             set: { newValue in
                                 guard let number = Int(newValue) else {
                                     coinCount = UserDefaults.standard.integer(forKey: "coin")
                                     return
                                 }
                                 UserDefaultsManager().saveCoin(number)
                                 coinCount = number
                             }
                         ))
                        .font(.custom("PlusJakartaSans-Regular", size: 20))
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(Color(red: 253/255, green: 190/255, blue: 67/255))
                        .frame(width: 50)
                        .offset(x: 5)
                        
                        Image(.coin)
                            .resizable()
                            .frame(width: 49, height: 52)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 6.5)
                
                if isDone {
                    BallView(isDoneModel: $isDone, model: model, model2: $model, coinCount: $coinCount) {
                        
                    }
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 1), value: scale)
                    .onAppear {
                        showVictoryAnimation = true
                        scale = 1.5
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showCloseButton = true
                        }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    if showVictoryAnimation {
                        VictoryParticlesView()
                            .ignoresSafeArea()
                    }
                    
                    if showCloseButton {
                        Button(action: {
                            UserDefaultsManager().removeBallon(with: model.id)
                            isDone = false
                            showVictoryAnimation = false
                            showCloseButton = false
                        }) {
                            Image(.close1)
                                .resizable()
                                .frame(
                                    width: geometry.size.width * 0.52,
                                    height: geometry.size.height * 0.069
                                )
                        }
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 200)
                    }
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(ballonMenuModel.savedBalloons.indices, id: \.self) { index in
                                if index % 3 == 0 {
                                    if let balloon = ballonMenuModel.savedBalloons[safe: index] {
                                        BallView(isDoneModel: $isDone, model: balloon, model2: $model, coinCount: $coinCount) {
                                            selectedBalloon = balloon
                                        }
                                    }
                                } else if index % 3 == 1 {
                                    LazyVGrid(columns: [
                                        GridItem(.flexible(), spacing: 0),
                                        GridItem(.flexible(), spacing: 0)
                                    ], spacing: 20) {
                                        if let balloon = ballonMenuModel.savedBalloons[safe: index] {
                                            BallView(isDoneModel: $isDone, model: balloon, model2: $model, coinCount: $coinCount) {
                                                selectedBalloon = balloon
                                            }
                                        }
                                        if index + 1 < ballonMenuModel.savedBalloons.count {
                                            if let balloon = ballonMenuModel.savedBalloons[safe: index + 1] {
                                                BallView(isDoneModel: $isDone, model: balloon, model2: $model, coinCount: $coinCount) {
                                                    selectedBalloon = balloon
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Color(.clear)
                                .frame(height: 60)
                        }
                    }
                    .frame(height: geometry.size.height * 0.8)
                    .padding(.top, geometry.size.height * 0.22)
                }
            }
            .onAppear {
                coinCount = UserDefaults.standard.integer(forKey: "coin")
            }
            .onReceive(NotificationCenter.default.publisher(for: .ballUpdated)) { _ in
                ballonMenuModel.loadSavedBalloons()
            }
            
            .fullScreenCover(item: $selectedBalloon) { balloon in
                BallonDescriptionView(model: balloon)
            }
            .environmentObject(UserDefaultsManager())
        }
    }
}

#Preview {
    BallonMenuView()
}

struct BallView: View {
    @Binding var isDoneModel: Bool
    @State private var isTapped = false
    @State private var plusOnes: [PlusEffect] = []
    let model: BallModel
    @Binding var model2: BallModel
    @State private var isVictory = false
    @Binding  var coinCount: Int
    var action: (() -> ())
    var body: some View {
        ZStack {
            Image(model.image)
                .resizable()
                .frame(width: 135, height: 179)
                .opacity(isTapped ? 0.7 : 1.0)
                .opacity(isTapped ? 0.7 : 1.0)
                .scaleEffect(isVictory ? 1.2 : 1.0)
                .onTapGesture {
                    if coinCount >= 1  {
                        UserDefaultsManager().incrementCount(for: model)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isTapped = true
                            UserDefaultsManager().minusCoin()
                            coinCount = UserDefaults.standard.integer(forKey: "coin")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isTapped = false
                                }
                            }
                        }
                        addPlusOne()
                    }
                }
            
            VStack(spacing: 125) {
                ZStack {
                    Image(.whiteRectnagle)
                        .resizable()
                        .frame(width: 113, height: 28)
                    
                    Text(model.name)
                        .PlusBold(size: 15,
                                  color: Color(red: 253/255, green: 190/255, blue: 67/255))
                        .frame(width: 90, height: 30)
                }
                
                ZStack {
                    Image(.whiteRectnagle)
                        .resizable()
                        .frame(width: 113, height: 28)
                    
                    HStack {
                        Button(action: {
                            action()
                        }) {
                            Image(.settings)
                                .resizable()
                                .frame(width: 33, height: 33)
                        }
                        
                        if isDoneModel {
                            Text("\(model.cost)/\(model.cost)")
                                .PlusBold(size: 15,
                                          color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                .frame(width: 50, height: 30)
                        } else {
                            Text("\(model.currentCount)/\(model.cost)")
                                .PlusBold(size: 15,
                                          color: Color(red: 253/255, green: 190/255, blue: 67/255))
                                .frame(width: 50, height: 30)
                        }
                        
                        
                        Image(.coin)
                            .resizable()
                            .frame(width: 40, height: 43)
                    }
                }
            }
            
            ForEach(plusOnes) { effect in
                Text("+1")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .offset(effect.offset)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: 1).delay(Double(effect.delay)), value: effect.offset)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                plusOnes.removeAll(where: { $0.id == effect.id })
                            }
                        }
                    }
            }
        }
        .onAppear {
            coinCount = UserDefaults.standard.integer(forKey: "coin")
        }
        .onChange(of: model.currentCount) { newValue in
            if newValue >= Int(model.cost) ?? 0 {
                isVictory = true
                isDoneModel = true
                model2 = model
            }
        }
    }
    
    private func addPlusOne() {
        let x = CGFloat.random(in: -50...50)
        let y = CGFloat.random(in: -50...50)
        let effect = PlusEffect(
            offset: CGSize(width: x, height: y),
            delay: Double.random(in: 0...0.3)
        )
        plusOnes.append(effect)
    }
}
