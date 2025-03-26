import SwiftUI

class BallonAddViewModel: ObservableObject {
    let contact = BallonAddModel()
    @Published var name = ""
    @Published var cost = ""
    @Published var desc = ""
    @Published var currentIndex = 0
    @Published var savedBalloons: [BallModel] = []
    @Published var showEmptyFieldsAlert = false
    @Published var alertMessage = ""
    @Published var isMenu = false
    
    init() {
        loadSavedBalloons()
    }
    
    func createBallon() -> BallModel {
        return BallModel(
            image: contact.arrayImage[currentIndex],
            name: name,
            cost: cost,
            desc: desc
        )
    }
    
    func loadSavedBalloons() {
        savedBalloons = UserDefaultsManager().getBalloons()
    }
    
    func saveNewBallon() {
        let newBallon = createBallon()
        UserDefaultsManager().addBallon(newBallon)
        loadSavedBalloons()
    }
    
    func validateCost() -> Bool {
        guard let _ = Int(cost) else {
            alertMessage = "Cost must contain numbers"
            return false
        }
        return true
    }
}
