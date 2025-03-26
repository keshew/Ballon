import SwiftUI

@main
struct BallonApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                BallonTabBarView()
            } else {
                BallonSignUpView()
            }
        }
    }
}
