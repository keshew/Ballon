import SwiftUI
import SpriteKit

struct VictoryParticlesView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = VictoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {}
}

class VictoryScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.clear
        view.allowsTransparency = true
        let textures = (1...10).map { SKTexture(imageNamed: "it\($0)") }
        let addParticleAction = SKAction.run {
            self.addParticle(texture: textures.randomElement()!)
        }
        let sequence = SKAction.sequence([
            addParticleAction,
            SKAction.wait(forDuration: 0.1)
        ])
        run(SKAction.repeatForever(sequence))
    }
    
    private func addParticle(texture: SKTexture) {
        let spriteNode = SKSpriteNode(texture: texture)
        spriteNode.position = CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: size.height + 190
        )
        spriteNode.setScale(0.3)
        spriteNode.zRotation = CGFloat.random(in: -CGFloat.pi/2...CGFloat.pi/2)
        addChild(spriteNode)
        let moveAction = SKAction.move(
            to: CGPoint(x: spriteNode.position.x, y: -spriteNode.size.height),
            duration: 5
        )
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi, duration: 5)
        let removeAction = SKAction.removeFromParent()
        spriteNode.run(SKAction.sequence([
            SKAction.group([moveAction, rotateAction]),
            removeAction
        ]))
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    @FocusState private var isTextFocused: Bool
    @State private var isSecure = true
    
    var geometry: GeometryProxy
    var placeholder: String
    var image: String
    var isImage = true
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                .frame(height: 46)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 1)
                        .padding(.horizontal, 20)
                }
            
            if isSecure {
                SecureField("", text: $text)
                    .padding(.horizontal, 16)
                    .frame(height: geometry.size.height * 0.07)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .cornerRadius(9)
                    .foregroundStyle(.white)
                    .focused($isTextFocused)
                    .padding(.horizontal, 20)
            } else {
                TextField("", text: $text)
                    .padding(.horizontal, 16)
                    .frame(height: geometry.size.height * 0.07)
                    .font(.custom("PlusJakartaSans-Regular", size: 14))
                    .cornerRadius(9)
                    .foregroundStyle(.white)
                    .focused($isTextFocused)
                    .padding(.horizontal, 20)
            }
            
            HStack(spacing: 20) {
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Plus(size: 14)
                }
                
                Spacer()
                
                if isImage {
                    Button(action: {
                        withAnimation {
                            isSecure.toggle()
                        }
                    }) {
                        Image(isSecure ? "eye" : "closeEye")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 40)
                }
            }
            .padding(.leading, 35)
            .onTapGesture {
                isTextFocused = true
            }
        }
    }
}

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var isImage = true
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                .frame(height: 46)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 1)
                        .padding(.horizontal, 20)
                }
            
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: geometry.size.height * 0.07)
            .font(.custom("PlusJakartaSans-Regular", size: 14))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 20)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Plus(size: 14)
                    .padding(.leading, 35)
                    .onTapGesture {
                        isTextFocused = true
                    }
                
            }
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 253/255, green: 190/255, blue: 67/255) : Color(red: 84/255, green: 88/255, blue: 91/255))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color(red: 2/255, green: 74/255, blue: 92/255))
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 8 : -8)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var isImage = true

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                .frame(height: 90)
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white, lineWidth: 1)
                        .padding(.horizontal, 20)
                }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .background(Color(red: 128/255, green: 79/255, blue: 0/255))
                .padding(.horizontal, 30)
                .frame(height: 89)
                .font(.custom("PlusJakartaSans-Regular", size: 14))
                .foregroundColor(.white)
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .font(.custom("PlusJakartaSans-Regular", size: 14))
                        .foregroundStyle(.white)
                        .padding(.leading, 35)
                        .padding(.top)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}



struct PlusEffect: Identifiable {
    var id = UUID().uuidString
    let offset: CGSize
    let delay: Double
}


struct BallListModel: View {
    var model: BallModel
    var body: some View {
        VStack {
            Image(model.image)
                .resizable()
                .frame(width: 105, height: 138)
            
            Spacer(minLength: 20)
            
            VStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                        .frame(height: 46)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 1)
                                .padding(.horizontal, 20)
                        }
                    
                    HStack {
                        Text(model.name)
                            .Plus(size: 14)
                            .padding(.leading, 40)
                        Spacer()
                    }
                }
                .frame(height: 46)
                .padding(.horizontal, 20)
                
                ZStack {
                    Rectangle()
                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                        .frame(height: 46)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 1)
                                .padding(.horizontal, 20)
                        }
                    
                    HStack {
                        Text(model.cost)
                            .Plus(size: 14)
                            .padding(.leading, 40)
                        Spacer()
                    }
                }
                .frame(height: 46)
                .padding(.horizontal, 20)
                
                ZStack {
                    Rectangle()
                        .fill(Color(red: 128/255, green: 79/255, blue: 0/255))
                        .frame(height: 105)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 1)
                                .frame(height: 105)
                                .padding(.horizontal, 20)
                        }
                    
                    VStack {
                        HStack {
                            Text(model.desc)
                                .Plus(size: 14)
                                .padding(.horizontal, 40)
                                .padding(.top)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .frame(height: 107)
                .padding(.horizontal, 20)
            }
        }
    }
}
