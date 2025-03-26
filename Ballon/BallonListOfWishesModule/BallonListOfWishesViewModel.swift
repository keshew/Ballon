import SwiftUI

class BallonListOfWishesViewModel: ObservableObject {
    let contact = BallonListOfWishesModel()
    @Published var savedBalloons: [BallModel] = []
    private let userDefaultsManager = UserDefaultsManager()
    
    init() {
        loadSavedBalloons()
    }
    
    func loadSavedBalloons() {
        savedBalloons = userDefaultsManager.getBalloons()
    }
}
