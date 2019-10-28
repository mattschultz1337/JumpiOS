//
//  GameScene.swift
//  MyGame
//
//  Created by Mobile Apps on 10/25/19.
//  Copyright © 2019 Mobile Apps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var ballSP : SKSpriteNode?
    private var hotdogSP : SKSpriteNode?
    private var startButton : SKSpriteNode?
    private var rightWall : SKSpriteNode?
    private var leftWall : SKSpriteNode?
    private var bottomWall : SKSpriteNode?
    private var score : Int?
    private var scoreLabel : SKLabelNode?
    let wallVal:UInt32 = 0x1 << 2
    let ballVal:UInt32 = 0x1 << 1
    let dogVal:UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        let ballTexture = SKTexture(imageNamed: "ball")
        
        self.ballSP = self.childNode(withName: "ball") as? SKSpriteNode
        self.hotdogSP = self.childNode(withName: "hotdog") as? SKSpriteNode
        self.label = self.childNode(withName: "Title") as? SKLabelNode
        self.startButton = self.childNode(withName: "StartButton") as? SKSpriteNode
        self.leftWall = self.childNode(withName: "leftWall") as? SKSpriteNode
        self.rightWall = self.childNode(withName: "rightWall") as? SKSpriteNode
        self.bottomWall = self.childNode(withName: "bottomWall") as? SKSpriteNode
        let ball = self.ballSP!
        let hotdog = self.hotdogSP!
 
        self.score = 0
        self.scoreLabel = self.childNode(withName: "score") as? SKLabelNode
        self.scoreLabel?.text = "\(self.score!)"
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, alphaThreshold: 50, size: CGSize(width: ball.size.width, height: ball.size.height))
        hotdog.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 175, height: 30))
        
        
        self.leftWall!.physicsBody?.categoryBitMask = wallVal
        self.bottomWall!.physicsBody?.categoryBitMask = wallVal
        hotdog.physicsBody?.categoryBitMask = dogVal
        ball.physicsBody?.categoryBitMask = ballVal
        
        hotdog.physicsBody?.restitution = 0
        ball.physicsBody?.restitution = 1
        
        hotdog.physicsBody?.collisionBitMask = wallVal
        ball.physicsBody?.collisionBitMask = wallVal
        
        hotdog.physicsBody?.affectedByGravity = false
        hotdog.physicsBody?.allowsRotation = false
        ball.physicsBody?.angularDamping = 1
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.affectedByGravity = false
        
        
        ball.physicsBody?.contactTestBitMask = dogVal

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        self.ballSP!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
        self.score = self.score! + 1
            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            
            let nodesArr = self.nodes(at: location)
            if nodesArr.first?.name == "StartButton"{
                self.label!.run(SKAction.fadeOut(withDuration: 0.75))
                self.startButton!.run(SKAction.fadeOut(withDuration: 0.75))
                let ball = self.ballSP!
                let hotdog = self.hotdogSP!
                hotdog.physicsBody?.applyImpulse(CGVector(dx:5, dy: 0))
                ball.physicsBody?.affectedByGravity = true
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -9.8))
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                hotdog.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
            } else {
               self.ballSP!.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.ballSP!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
            }
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.scoreLabel?.text = "\(self.score!)"
        let hotdog = self.hotdogSP!
        if hotdog.position.x > 625{
            hotdog.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        } else if hotdog.position.x < 135 {
            hotdog.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
           }
    }
}

