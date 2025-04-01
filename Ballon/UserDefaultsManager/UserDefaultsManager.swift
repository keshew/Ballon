import Foundation
import SwiftUI

class UserDefaultsManager: ObservableObject {
    
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func isFirstLaunch() -> Bool {
          let defaults = UserDefaults.standard
          let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
          
          if !isFirstLaunch {
              defaults.set(true, forKey: "isFirstLaunch")
              saveCoin(100)
              return true
          }
          
          return false
      }
    
    func register(email: String, password: String, name: String, surename: String) -> Bool {
        let userDefaults = UserDefaults.standard
        var storedUsers: [String: [String: String]] = [:]
        
        if let existingUsers = userDefaults.dictionary(forKey: "users") as? [String: [String: String]] {
            storedUsers = existingUsers
        }
        
        storedUsers[email] = ["password": password, "name": name, "surename": surename]
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        userDefaults.set(storedUsers, forKey: "users")
        userDefaults.set(dateFormatter.string(from: currentDate), forKey: "accountCreationDate")
        
        saveLoginStatus(true)
        return true
    }
    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func deleteAccount() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "users")
        defaults.removeObject(forKey: "savedBalloons")
        saveCoin(100)
        saveLoginStatus(false)
    }
    
    func getName(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            return storedUsers[email]?["name"]
        }
        return nil
    }
    
    func getSurename(for email: String) -> String? {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            return storedUsers[email]?["surename"]
        }
        return nil
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        saveLoginStatus(false)
        defaults.removeObject(forKey: "savedBalloons")
        saveCoin(100)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func saveCoin(_ coin: Int) {
        let defaults = UserDefaults.standard
        defaults.set(coin, forKey: "coin")
    }
    
    func addCoin() {
        let defaults = UserDefaults.standard
        let coin = defaults.object(forKey: "coin") as? Int ?? 0
        defaults.set(coin + 1, forKey: "coin")
    }
    
    func minusCoin() {
        let defaults = UserDefaults.standard
        let coin = defaults.object(forKey: "coin") as? Int ?? 0
        if coin != 0 {
            defaults.set(coin - 1, forKey: "coin")
        }
    }
    
    func login(email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        if let storedUsers = defaults.dictionary(forKey: "users") as? [String: [String: String]] {
            for (storedUsername, storedUser) in storedUsers {
                if email == storedUsername && password == storedUser["password"] {
                    saveLoginStatus(true)
                    saveCurrentEmail(email)
                    return true
                }
            }
        }
        return false
    }
    
    func saveBalloons(_ models: [BallModel]) {
         let encoder = JSONEncoder()
         guard let data = try? encoder.encode(models) else { return }
         let defaults = UserDefaults.standard
         defaults.set(data, forKey: "savedBalloons")
        NotificationCenter.default.post(name: .ballUpdated, object: nil)
     }
     
     func getBalloons() -> [BallModel] {
         let defaults = UserDefaults.standard
         guard let data = defaults.data(forKey: "savedBalloons") else { return [] }
         let decoder = JSONDecoder()
         return (try? decoder.decode([BallModel].self, from: data)) ?? []
     }
     
     func addBallon(_ model: BallModel) {
         var currentBalloons = getBalloons()
         currentBalloons.append(model)
         saveBalloons(currentBalloons)
     }
     
     func removeBallon(with id: String) {
         var currentBalloons = getBalloons()
         currentBalloons.removeAll(where: { $0.id == id })
         saveBalloons(currentBalloons)
     }
    
    func incrementCount(for model: BallModel) {
         guard let index = getBalloons().firstIndex(where: { $0.id == model.id }) else { return }
         
         var updatedBalloons = getBalloons()
         updatedBalloons[index].currentCount += 1
         saveBalloons(updatedBalloons)
     }
}
extension Notification.Name {
    static let ballUpdated = Notification.Name("ballUpdated")
}
