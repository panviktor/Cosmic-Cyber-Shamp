import SpriteKit

class EndGameScene: SKScene {
    weak var scoreManager = ScoreManager.shared
    let sceneManager = SceneManager.shared
    var collectedCoins: Int = 0
    
    override func didMove(to view: SKView) {
        loadBackground()
        
        let userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let fullPath = userPath.appendingPathComponent("userinfo.plist")
        
        guard let virtualPlist = NSDictionary(contentsOfFile: fullPath) else{
            print ("ERROR000: EndGame failed to load virtualPlist")
            return
        }
        
        guard let dataCoin:Int = virtualPlist.value(forKey: "Coin") as? Int else{
            print ("ERROR001: EndGame error")
            return
        }
        
        let newCoinAmount = collectedCoins + dataCoin
        scoreManager?.appendNewScore(collectedCoins)
        virtualPlist.setValue(newCoinAmount, forKey: "Coin")
        
        if !virtualPlist.write(toFile: fullPath, atomically: false){
            print("Error002: FILE FAILED TO SAVE THE CHANGES ---- PLEASE FIX IT IN EndGame")
        }
        
        let label = SKLabelNode(fontNamed: "PingFangSC-Medium")
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        label.text = String("Your score is \(collectedCoins)!")
        label.fontSize = screenSize.width / 10
        label.fontColor = .black
        self.addChild(label)
    }
    
    private func loadBackground() {
        let bg = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .EndGameScene_Background_1))
        bg.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        bg.zPosition = -10
        self.addChild(bg)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneManager.gameScene = nil
        let scene = MainScene(size: self.size)
        self.view?.presentScene(scene)
    }
}
