//
//  TopScoreScene.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class TopScoreScene: SKScene {
    private enum State {
        case Select
    }
    
    fileprivate var scoreNode = SKSpriteNode()
    fileprivate var gameinfo = GameInfo()
    fileprivate let bulletMaker = BulletMaker()
    private var state:State = .Select
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadBackground()
        load()
    }
    
    private func loadBackground() {
        let bg = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .Character_Menu_Background))
        bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        bg.zPosition = -10
        self.addChild(bg)
    }
    
    private func load(){
        //GameInfo Load
        let check = gameinfo.load(scene: self)
        if(!check.0){
            print("LOADING ERROR: ", check.1)
            return
        } else {
            // Fix Inforbar Position
            let infobar = self.childNode(withName: "infobar")!
            infobar.position.y -= screenSize.size.height/2
            infobar.position.x -= screenSize.size.width/2
        }
        
        // Title
        let title = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .Character_Menu_TitleMenu))
        title.position.y = screenSize.width/2*1.3
        title.size = CGSize(width: screenSize.width*0.6, height: screenSize.height*0.1)
        
        let titleLabel = SKLabelNode(fontNamed: "Family Guy")
        titleLabel.text = "Your Top Score"
        titleLabel.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        titleLabel.fontSize = screenSize.width/28
        title.addChild(titleLabel.shadowNode(nodeName: "titleEffectNodeLabel"))
        
        self.addChild(title)
        
        // BackArrow
        let backarrow = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .Character_Menu_BackArrow))
        backarrow.name = Global.Main.Character_Menu_BackArrow.rawValue
        backarrow.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        backarrow.position = CGPoint(x: -title.size.width/2 - 10, y: title.position.y + 3)
        backarrow.size = CGSize(width: screenSize.width/8, height: screenSize.height*0.06)
        self.addChild(backarrow)
        
        
        
        // scoreNode
        scoreNode.texture = Global.sharedInstance.getMainTexture(main: .Character_Menu_TitleMenu)
        scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.1)
        scoreNode.size = CGSize(width: screenSize.width/1.5, height: screenSize.height / 2.55)
        scoreNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 20, duration: 1),
                                                                SKAction.moveBy(x: 0, y: -20, duration: 1.2)])))
        
        let goldScore = SKLabelNode(fontNamed: "Family Guy")
        goldScore.position.y = scoreNode.size.height / 1.5
        goldScore.text = "Your Top Score"
        goldScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        goldScore.fontSize = screenSize.width / 30
        scoreNode.addChild(goldScore.shadowNode(nodeName: "goldScoreLabel"))
        
        
        let silverScore = SKLabelNode(fontNamed: "Family Guy")
        silverScore.position.y = scoreNode.size.height / 2.5
        silverScore.text = "Your silver"
        silverScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        silverScore.fontSize = screenSize.width / 35
        scoreNode.addChild(silverScore.shadowNode(nodeName: "silverScoreLabel"))
        
        
        let bronzeScore = SKLabelNode(fontNamed: "Family Guy")
        bronzeScore.position.y = scoreNode.size.height / 8
        bronzeScore.text = "Your bronze"
        bronzeScore.fontColor = SKColor(red: 254/255, green: 189/255, blue: 62/255, alpha: 1)
        bronzeScore.fontSize = screenSize.width / 35
        scoreNode.addChild(bronzeScore.shadowNode(nodeName: "bronzeScoreLabel"))
        
        self.addChild(scoreNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var pos:CGPoint!
        for touch in touches{
            pos = touch.location(in: self)
        }
        
        switch state {
        case .Select:
            for c in nodes(at: pos){
                if c.name == Global.Main.Character_Menu_BackArrow.rawValue{
                    doTask(gb: .Character_Menu_BackArrow)
                }
            }
        }
    }
    private func doTask(gb:Global.Main){
        switch gb {
        case .Character_Menu_BackArrow:
            self.gameinfo.prepareToChangeScene()
            self.recursiveRemovingSKActions(sknodes: self.children)
            self.removeAllChildren()
            self.removeAllActions()
            let newScene = MainScene(size: self.size)
            self.view?.presentScene(newScene)
        default:
            print("Should not reach Here - doTask from CharacterMenuScene")
        }
    }
}
