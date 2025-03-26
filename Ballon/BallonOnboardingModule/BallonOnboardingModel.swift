import SwiftUI

struct BallonOnboardingModel {
    let arrayOfImage = [BallonImageName.ob1.rawValue,
                        BallonImageName.ob2.rawValue,
                        BallonImageName.ob3.rawValue,
                        BallonImageName.ob4.rawValue,
                        BallonImageName.ob5.rawValue,
                        BallonImageName.ob6.rawValue,
                        BallonImageName.ob7.rawValue]
    
    let arrayOfSize: [CGFloat] = [46, 92, 138, 184, 230, 276, 328]
    let arrayOfOffset: [CGFloat] = [-140, -117, -94, -71, -48, -25, 0]
    
    let arrayOfLabel = ["Start Tracking Your Savings",
                        "Your Path to Financial Freedom",
                        "Save and Grow",
                        "Financial Control at Your Fingertips",
                        "Save and Dream",
                        "Build Your Financial Cushion",
                        "Your Money Under Control"]
    
    let arrayOfLabel2 = ["Monitor your finances and achieve your goals faster with our app.",
                         "Manage your savings and start living debt-free.",
                         "Track every penny and watch your savings flourish.",
                         "Manage your money easily and efficiently.",
                         "Save money for your dreams and achieve them faster.",
                         "Be confident about tomorrow by starting to save today.",
                         "Keep track of your expenses and savings to always stay informed."]
}


