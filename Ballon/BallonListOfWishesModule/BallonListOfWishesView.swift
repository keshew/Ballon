import SwiftUI

struct BallonListOfWishesView: View {
    @StateObject var ballonListOfWishesModel =  BallonListOfWishesViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.topMenu)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.168)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.0045)
                
                Text("List of all wishes")
                    .PlusBold(size: 26,
                              color: Color(red: 253/255, green: 190/255, blue: 67/255))
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 21)
                
                Image(.wishes)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 1.041)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.74)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 40) {
                                ForEach(ballonListOfWishesModel.savedBalloons.indices, id: \.self) { index in
                                    BallListModel(model: ballonListOfWishesModel.savedBalloons[index])
                                }
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 70)
                    }
                }
                .frame(height: geometry.size.height * 0.9)
                .padding(.top, geometry.size.height * 0.12)
            }
        }
    }
}

#Preview {
    BallonListOfWishesView()
}
