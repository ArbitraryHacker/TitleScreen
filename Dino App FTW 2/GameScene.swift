//
//  GameScene.swift
//  Dino App FTW 2
//
//  Created by JEexplanations on 12/6/14.
//  Copyright (c) 2014 JEexplanations. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
            }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
               }
    enum states
    {
        case defend
        
        case dodge
        
    }
    
    struct Dinosaur
    {
        var attack:Int, HP:Double, speed:Int, addAttack:Int, addHP:Int, addSpeed:Int, state:states, description:String, image:UIImage
    }
    
    
    func getRandomNumber(#range:Range<UInt32>) -> Int
    {
        return Int(range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1))
    }
    
    class Battle
    {
        var dino1:Dinosaur
        var dino2:Dinosaur
        init(dino1:Dinosaur, dino2:Dinosaur)
        {
            self.dino1 = dino1
            self.dino2 = dino2
        }
        
        func attack(#atkDinoNum:Int) -> Bool
        {
            var atkDino:Dinosaur = dino1
            var defDino:Dinosaur = dino2
            var multiplier:Double = 1
            switch atkDinoNum
            {
            case 0 :
                atkDino = dino1
                defDino = dino2
                break
                
            case 1 :
                atkDino = dino2
                defDino = dino1
                break
                
            default :
                break
            }
            
            switch defDino.state
            {
            case .defend :
                multiplier *= 0.75
                
            case .dodge :
                multiplier *= getRandomNumber(range:0...100) <= defDino.speed + defDino.addSpeed ? 0 : 1
                //being a bawse
            default :
                break
            }
            
            defDino.HP = defDino.HP - (Double)(atkDino.attack + atkDino.addAttack) * multiplier
            return defDino.HP <= 0 ? true : false
        }

    }
   
   
}