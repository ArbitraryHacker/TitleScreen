//
//  GameViewController.swift
//  Dino App FTW 2
//
//  Created by JEexplanations on 12/6/14.
//  Copyright (c) 2014 JEexplanations. All rights reserved.
//

import UIKit
import SpriteKit

let alectrosaurus:Dinosaur = Dinosaur(attack: 60, HP: 500, speed: 240, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let tuojiangosaurus:Dinosaur = Dinosaur(attack: 90, HP: 900, speed: 160, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let dilophosaurus:Dinosaur = Dinosaur(attack: 20, HP: 200, speed: 320, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let pinacosaurus:Dinosaur = Dinosaur(attack: 40, HP: 400, speed: 240, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let yunnanoraurus:Dinosaur = Dinosaur(attack: 20, HP: 300, speed: 280, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let psittacosaurus:Dinosaur = Dinosaur(attack: 40, HP: 150, speed: 240, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let opisthocoelicaudia:Dinosaur = Dinosaur(attack: 40, HP: 1000, speed: 120, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let agilisaurus:Dinosaur = Dinosaur(attack: 20, HP: 150, speed: 280, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

let sarcosuchus:Dinosaur = Dinosaur(attack: 100, HP: 1000, speed: 100, state:.none, turn:true, description: "was up", image:UIImage(named:"DinoImage")!)

var battle:Battle = Battle(dino1:alectrosaurus, dino2:sarcosuchus)

class GameViewController: UIViewController
{
    @IBOutlet var dinoImg1: UIImageView!
    @IBOutlet var dinoImg2: UIImageView!
    @IBOutlet var dinoHealth1: UILabel!
    @IBOutlet var dinoHealth2: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dinoImg1.image = UIImage(named:"DinoImage")
        dinoImg2.image = UIImage(named:"DinoImage")
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @IBAction func attack()
    {
        battle.setDinoState(dinoNum:1, state:getRandomNumber(range:0...1) == 0 ? .defend : .dodge)
        if battle.attack(atkDinoNum:0, defDinoHealthLabel: &dinoHealth2)
        {
            battle.win()
        }
    }
    
    @IBAction func defend()
    {
        battle.setDinoState(dinoNum:0, state:.defend)
        battle.attack(atkDinoNum:1, defDinoHealthLabel: &dinoHealth1)
    }
    
    @IBAction func dodge()
    {
        battle.setDinoState(dinoNum:0, state:.dodge)
        battle.attack(atkDinoNum:1, defDinoHealthLabel: &dinoHealth1)
    }
}

enum states
{
    case defend
    
    case dodge
    
    case none
}

struct Dinosaur
{
    var attack:Double, HP:Double, speed:Int, state:states, turn:Bool, description:String, image:UIImage
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
    
    func attack(#atkDinoNum:Int, inout defDinoHealthLabel:UILabel!) -> Bool
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
        
        if atkDino.turn
        {
            switch defDino.state
            {
                case .defend :
                    multiplier *= 0.75
                    break
                
                case .dodge :
                    multiplier *= getRandomNumber(range:0...100) <= defDino.speed / 4 ? 0 : 1
                    break
                
                default :
                    break
            }
            
            defDino.HP -= atkDino.attack * multiplier
            defDinoHealthLabel.text = String(format:"%.1f", defDino.HP)
            atkDino.turn = false
            defDino.turn = true
            switch atkDinoNum
            {
                case 0 :
                    dino1 = atkDino
                    dino2 = defDino
                    break
                
                case 1 :
                    dino2 = atkDino
                    dino1 = defDino
                    break
                
                default :
                    break
            }
            return defDino.HP <= 0 ? true : false
        }
        return false
    }
    
    func setDinoState(#dinoNum:Int, state:states)
    {
        switch dinoNum
        {
        case 0 :
            self.dino1.state = state
            break
            
        case 1 :
            self.dino2.state = state
            break
            
        default :
            break
        }
    }
    
    func win()
    {
        dino1.HP = dino1.HP < 0 ? 0 : dino1.HP
        dino2.HP = dino2.HP < 0 ? 0 : dino2.HP
        dino1.turn = false
        dino2.turn = false
    }
}