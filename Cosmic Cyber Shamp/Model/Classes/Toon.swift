
import SpriteKit

class Toon {
    enum Character: String {
        case Jupiter_2 = "Jupiter_2"
        case Normandy = "Normandy"
        case Thunderbolt = "Thunderbolt"
    }
    
    private var size: CGSize
    private var node: SKSpriteNode
    private var bullet: Projectile?
    private var description: [String] = []
    private var experience: CGFloat = 0
    private var title: String = "None"
    private var level: Int = 1 // For future use
    
    // Initialize
    private var charType: Character
    
    init(char:Character) {
        var localMainTexture:SKTexture!
        var localWingTexture:SKTexture!
        var cw:CGFloat!
        var ch:CGFloat!
        var ww:CGFloat!
        var wh:CGFloat!
        switch char {
        case .Jupiter_2:
            cw = screenSize.width * 0.150
            ch = screenSize.height * 0.177
            ww = screenSize.width * 0.150
            wh = screenSize.height * 0.177
            localMainTexture = Global.sharedInstance.getMainTexture(main: .Character_Alpha)
            localWingTexture = Global.sharedInstance.getMainTexture(main: .Character_Alpha_Wing)
        case .Normandy:
             cw = screenSize.width * 0.150
            ch = screenSize.height * 0.177
            ww = screenSize.width * 0.186
            wh = screenSize.height * 0.081
            localMainTexture = Global.sharedInstance.getMainTexture(main: .Character_Beta)
            localWingTexture = Global.sharedInstance.getMainTexture(main: .Character_Beta_Wing)
        case .Thunderbolt:
            cw = screenSize.width * 0.150
            ch = screenSize.height * 0.177
            ww = screenSize.width * 0.186
            wh = screenSize.height * 0.081
            localMainTexture = Global.sharedInstance.getMainTexture(main: .Character_Celta)
            localWingTexture = Global.sharedInstance.getMainTexture(main: .Character_Celta_Wing)
        }
        
        self.charType = char
        self.size = CGSize(width: cw, height: ch)
        
        node = SKSpriteNode(texture: localMainTexture)
        node.name = "toon"
        node.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 9)
        node.size = self.size
        node.run(SKAction.scale(to: 0.7, duration: 0.0))
        
        let l_wing = SKSpriteNode()
        l_wing.texture = localWingTexture
        l_wing.size = CGSize(width: ww / 3, height: wh)
        l_wing.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        l_wing.position = CGPoint(x: 0.0, y: (-node.size.height / 2) )
        l_wing.xScale = 1.0
        l_wing.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.resize(toWidth: screenSize.width * 0.035,
                            height: -screenSize.height * 0.058, duration: 0.25),
            SKAction.resize(toWidth: screenSize.width * 0.045,
                            height: -screenSize.height * 0.021, duration: 0.3),
            SKAction.resize(toWidth: screenSize.width * 0.035,
                            height: -screenSize.height * 0.021, duration: 0.25),
            SKAction.resize(toWidth: screenSize.width * 0.045,
                            height: -screenSize.height * 0.058, duration: 0.3),
        ])))
        
        node.addChild(l_wing)
        
        let r_wing = SKSpriteNode()
        r_wing.texture = localWingTexture
        r_wing.size = CGSize(width: ww / 3, height: wh)
        r_wing.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        r_wing.position = CGPoint(x: 0.0, y: (-node.size.height / 2) )
        r_wing.xScale = -1.0
        r_wing.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.resize(toWidth: screenSize.width * 0.035,
                            height: -screenSize.height * 0.021, duration: 0.25),
            SKAction.resize(toWidth: screenSize.width * 0.045,
                            height: -screenSize.height * 0.058, duration: 0.3),
            SKAction.resize(toWidth: screenSize.width * 0.035,
                            height: -screenSize.height * 0.058, duration: 0.25),
            SKAction.resize(toWidth: screenSize.width * 0.045,
                            height: -screenSize.height * 0.021, duration: 0.3),

        ])))
        
        node.addChild(r_wing)
    }
    
    func load(infoDict:NSDictionary) {
        //Level lv: Int, Experience exp: CGFloat, Description description:[String]
        self.level = infoDict.value(forKey: "Level") as! Int
        self.experience = infoDict.value(forKey: "Experience") as! CGFloat
        self.description = infoDict.value(forKey: "Description") as! [String]
        self.title = infoDict.value(forKey: "Title") as! String
        let bulletLevel = infoDict.value(forKey: "BulletLevel") as! Int
        
        bullet = Projectile(posX: node.position.x, posY: node.position.y, char: self.charType, bulletLevel: bulletLevel)
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width/4, height: node.size.height/2))
        node.physicsBody!.isDynamic = true // allow physic simulation to move it
        node.physicsBody!.affectedByGravity = false
        node.physicsBody!.allowsRotation = false // not allow it to rotate
        node.physicsBody!.collisionBitMask = 0
        node.physicsBody!.categoryBitMask = PhysicsCategory.Player
        node.physicsBody!.contactTestBitMask = PhysicsCategory.Enemy
        
        // Apply Magnetic Field
        let mfield = SKFieldNode.radialGravityField()
        mfield.region = SKRegion(radius: Float(node.size.width))
        mfield.strength = 120.0
        mfield.categoryBitMask = GravityCategory.Player
        node.addChild(mfield)
        
    }
    
    func getNode() -> SKSpriteNode{
        return node
    }
    
    func updateProjectile(){
        bullet!.setPosX(x: node.position.x)
    }
    
    func getBullet() -> Projectile{
        return bullet!
    }
    
    func getToonDescription() -> [String]{
        return description
    }
    
    func getToonName() -> String{
        return charType.rawValue
    }
    
    func getToonTitle() -> String{
        return title
    }
    
    func getBulletLevel() -> Int{
        //return bulletLevel
        return bullet!.getBulletLevel()
    }
    
    func getLevel() -> Int{
        return level
    }
    
    func advanceBulletLevel() -> Bool{
        return bullet!.upgrade()
    }
    
    // Remove below function later on. Combine it with getToonName
    func getCharacter() -> Character{
        return charType
    }
}
