//
//  GameScene.swift
//  MyGame
//
//  Created by Mobile Apps on 10/25/19.
//  Copyright © 2019 Mobile Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class Loser: SKScene, SKPhysicsContactDelegate {
    
   
    private var startButton : SKSpriteNode?
  

    
    override func didMove(to view: SKView) {
        

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            
            let nodesArr = self.nodes(at: location)
            if nodesArr.first?.name == "StartButton"{
            
                let fade = SKTransition.fade(withDuration: 1)
                let game = SKScene(fileNamed: "GameScene")
                self.view?.presentScene(game!, transition: fade)
                
                let skView = self.view! as SKView

                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true

                /* Set the scale mode to scale to fit the window */
                game!.scaleMode = .aspectFill
                game!.size = skView.bounds.size
                
                self.view?.presentScene(game!, transition: fade)
                
            }
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
    }
}

