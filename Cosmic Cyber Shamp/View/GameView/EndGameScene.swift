import SpriteKit

class EndGameScene: SKScene {
    var collectedCoins: Int = 0
    
    override func didMove(to view: SKView) {
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
        virtualPlist.setValue(newCoinAmount, forKey: "Coin")
        
        if !virtualPlist.write(toFile: fullPath, atomically: false){
            print("Error002: FILE FAILED TO SAVE THE CHANGES ---- PLEASE FIX IT IN EndGame")
        }
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        label.text = String("Your score is \(collectedCoins)!")
        label.fontSize = 35
        label.fontColor = .red
        self.addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = MainScene(size: self.size)
        self.view?.presentScene(scene)
    }
}
