import SwiftUI

class BallonSignUpViewModel: ObservableObject {
    let contact = BallonSignUpModel()
    @Published var name: String = ""
    @Published var surename: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var showEmptyFieldsAlert = false
    @Published var alertMessage = ""
    @Published var isLog = false
    @Published var isGuest = false
    @Published var isOnb = false
    
    func validateFields() -> Bool {
        if name.isEmpty {
            alertMessage = "Please enter your name"
            showEmptyFieldsAlert = true
            return false
        }
        if surename.isEmpty {
            alertMessage = "Please enter your surname"
            showEmptyFieldsAlert = true
            return false
        }
        if password.isEmpty {
            alertMessage = "Please enter password"
            showEmptyFieldsAlert = true
            return false
        }
        if email.isEmpty {
            alertMessage = "Please enter email"
            showEmptyFieldsAlert = true
            return false
        }
        return true
    }
}
