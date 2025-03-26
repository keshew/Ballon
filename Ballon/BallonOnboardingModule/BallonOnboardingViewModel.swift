import SwiftUI

class BallonOnboardingViewModel: ObservableObject {
    let contact = BallonOnboardingModel()
    @Published var currentIndex = 0
    @Published var isBack = false
    @Published var isTab = false
}
