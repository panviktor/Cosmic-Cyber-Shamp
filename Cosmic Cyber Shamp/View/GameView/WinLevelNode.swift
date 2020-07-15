//
//  WinLevelScene.swift
//  Cosmic Cyber Shamp
//
//  Created by Viktor on 14.07.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import SpriteKit

class WinLevelNode: SKScene {
    let sceneManager = SceneManager.shared
   
    override func didMove(to view: SKView) {
       loadBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let transition = SKTransition.crossFade(withDuration: 1.0)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        
    }
    
    private func loadBackground() {
        let bg = SKSpriteNode(texture: Global.sharedInstance.getMainTexture(main: .WinLevelScene_Background_1))
        bg.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        bg.size = CGSize(width: screenSize.width, height: screenSize.height)
        bg.zPosition = -10
        self.addChild(bg)
    }
}


