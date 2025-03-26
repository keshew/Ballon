import SwiftUI

struct BallModel: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    var image: String
    var name: String
    var cost: String
    var desc: String
    var currentCount: Int = 0 
}

struct BallonAddModel {
    let arrayImage = [BallonImageName.ballon1.rawValue,
                      BallonImageName.ballon2.rawValue,
                      BallonImageName.ballon3.rawValue,
                      BallonImageName.ballon4.rawValue,
                      BallonImageName.ballon5.rawValue,
                      BallonImageName.ballon6.rawValue,]
}


