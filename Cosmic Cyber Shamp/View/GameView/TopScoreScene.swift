//
//  TopScoreScene.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class TopScoreScene: SKScene {
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadBackground()
    }
    
    private func loadBackground(){
        let bg = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .Character_Menu_Background))
        bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        bg.zPosition = -10
        self.addChild(bg)
    }
}
