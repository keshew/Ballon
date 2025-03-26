import SwiftUI

class BallonMenuViewModel: ObservableObject {
    let contact = BallonMenuModel()
    @Published var savedBalloons: [BallModel] = []
    private let userDefaultsManager = UserDefaultsManager()
    
    init() {
        loadSavedBalloons()
    }
    
    func loadSavedBalloons() {
        savedBalloons = userDefaultsManager.getBalloons()
    }
      
    func incrementCount(for model: BallModel) {
        guard let index = savedBalloons.firstIndex(where: { $0.id == model.id }) else { return }
        
        var updatedBalloons = savedBalloons
        updatedBalloons[index].currentCount += 1
        savedBalloons = updatedBalloons
        userDefaultsManager.saveBalloons(savedBalloons)
    }
}
