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
        let ball = self.ballSP!
        let hotdog = self.hotdogSP!
        self.rightWall?.physicsBody?.collisionBitMask = 0x1
        
        
        
        ball.physicsBody = SKPhysicsBody(texture: ballTexture, alphaThreshold: 50, size: CGSize(width: ball.size.width, height: ball.size.height))
        hotdog.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 250, height: 30))
        
        
        self.leftWall!.physicsBody?.categoryBitMask = wallVal
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
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ballVal | dogVal {
            self.ballSP!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        }
            
    }
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
        
    }
        
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
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
                hotdog.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
            }
        }
        

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let hotdog = self.hotdogSP!
        if hotdog.position.x > 625{
            hotdog.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        } else if hotdog.position.x < 110 {
            hotdog.physicsBody?.velocity = CGVector(dx: 300, dy: 0)
           }
    }
}

