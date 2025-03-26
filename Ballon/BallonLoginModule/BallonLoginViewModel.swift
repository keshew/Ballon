import SwiftUI

class BallonLoginViewModel: ObservableObject {
    let contact = BallonLoginModel()
    @Published var password = ""
    @Published var email = ""
    @Published var isSign = false
    @Published var showEmptyFieldsAlert = false
    @Published var alertMessage = ""
    @Published var isOnb = false
    @Published var isTab = false
    
    func validateFields() -> Bool {
        if email.isEmpty {
            alertMessage = "Please enter your name"
            showEmptyFieldsAlert = true
            return false
        }
        if password.isEmpty {
            alertMessage = "Please enter your surname"
            showEmptyFieldsAlert = true
            return false
        }
        return true
    }
}
