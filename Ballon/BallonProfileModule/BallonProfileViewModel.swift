import SwiftUI

class BallonProfileViewModel: ObservableObject {
    let contact = BallonProfileModel()
    @Published var isLogOut = false
    @Published var isTog: Bool {
           didSet {
               UserDefaults.standard.set(isTog, forKey: "isTog")
           }
       }
       
       init() {
           self.isTog = UserDefaults.standard.bool(forKey: "isTog")
       }
}
