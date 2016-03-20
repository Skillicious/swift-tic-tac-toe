//
//  ViewController.swift
//  Swift-Tac-Toe
//
//  Created by Arya Yavari on 3/18/16.
//  Copyright © 2016 Arya Yavari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ticTacimg1: UIImageView!
    @IBOutlet var ticTacimg2: UIImageView!
    @IBOutlet var ticTacimg3: UIImageView!
    @IBOutlet var ticTacimg4: UIImageView!
    @IBOutlet var ticTacimg5: UIImageView!
    @IBOutlet var ticTacimg6: UIImageView!
    @IBOutlet var ticTacimg7: UIImageView!
    @IBOutlet var ticTacimg8: UIImageView!
    @IBOutlet var ticTacimg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    @IBOutlet var resetBtn: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    //    @IBAction func UIButtonClicked(sender:UIButton){
    //        userMessage.hidden = true
    //        if !(plays[sender.tag])! && aiDeciding && !done  {
    //            setImageForSpot(sender.tag, player:1)
    //        }
    
    @IBAction func UIButtonClicked(sender:UIButton) {
        userMessage.hidden = true
        if plays[sender.tag] == nil && !aiDeciding && !done {
            setImageForSpot(sender.tag, player:1)
        }
        
        checkForWin()
        
        aiTurn()
    }
    
    func setImageForSpot(spot:Int,player:Int){
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            ticTacimg1.image = UIImage(named: playerMark)
        case 2:
            ticTacimg2.image = UIImage(named: playerMark)
        case 3:
            ticTacimg3.image = UIImage(named: playerMark)
        case 4:
            ticTacimg4.image = UIImage(named: playerMark)
        case 5:
            ticTacimg5.image = UIImage(named: playerMark)
        case 6:
            ticTacimg6.image = UIImage(named: playerMark)
        case 7:
            ticTacimg7.image = UIImage(named: playerMark)
        case 8:
            ticTacimg8.image = UIImage(named: playerMark)
        case 9:
            ticTacimg9.image = UIImage(named: playerMark)
        default:
            ticTacimg5.image = UIImage(named:playerMark)
            
        }
    }
    
    @IBAction func resetBtnClicked(sender:UIButton){
        done = false
        resetBtn.hidden = true
        userMessage.hidden = true
        reset()
    }
    
    func reset(){
        plays = [:]
        ticTacimg1.image = nil
        ticTacimg2.image = nil
        ticTacimg3.image = nil
        ticTacimg4.image = nil
        ticTacimg5.image = nil
        ticTacimg6.image = nil
        ticTacimg7.image = nil
        ticTacimg8.image = nil
        ticTacimg9.image = nil
    }
    
    func checkForWin(){
        let whoWon = ["I":0,"you":1]
        for(key,value) in whoWon {
            if (plays[7] == value && plays[8] == value && plays[9] == value) || // accross the bottom)
                (plays[4] == value && plays[5] == value && plays[6] == value) || // accross the middle)
                (plays[1] == value && plays[2] == value && plays[3] == value) || // accross the bottom)
                (plays[1] == value && plays[4] == value && plays[7] == value) || // down the left)
                (plays[2] == value && plays[5] == value && plays[8] == value) || // down the middle)
                (plays[3] == value && plays[6] == value && plays[9] == value) || // down the right)
                (plays[1] == value && plays[5] == value && plays[9] == value) || // diag left right)
                (plays[3] == value && plays[5] == value && plays[7] == value) { // diag right left)
                    userMessage.hidden = false
                    userMessage.text = "Looks Like \(key) won!"
                    resetBtn.hidden = false
                    done = true
            }
        }
    }
    
    func checkBottom(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[7,8,9]))
    }
    func checkMiddleAcross(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[4,5,6]))
    }
    func checkTop(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[1,2,3]))
    }
    func checkLeft(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[1,4,7]))
    }
    func checkMiddleDown(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[2,5,8]))
    }
    func checkRight(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[3,6,9]))
    }
    func checkDiagLeftRight(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[1,5,9]))
    }
    func checkDiagRightLeft(value:Int) -> (location:String,pattern:String){
        return ("bottom",checkFor(value, inList:[3,5,7]))
    }
    
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(value:Int) -> String? {
        var acceptableFinds = ["011","110","101"]
        var findFuncs = [checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross,checkMiddleDown,checkDiagLeftRight, checkDiagRightLeft]
        for algorthm in findFuncs {
            var algorthm = algorthm(value)
            if find(acceptableFinds,algorthmResults.patter){
                return algorthmResults
            }
        }
        return nil
    }
    
    func aiTurn(){
        if done{
            return
        }
        
        aiDeciding = true
        
        //We (the computer) have two in a row
        if let result = rowCheck(0) {
            var whereToPlayResult = whereToPlay(result.location,pattern:result.pattern)
            
        }
        
        aiDeciding = false
    }
    
    func whereToPlay(location:STring,pattern:string) ->Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlwPattern = "101"
        
        switch location {
            case "top":
                if pattern == leftPattern{
                    return 1
                }else if pattern == rightPattern{
                    return 3
                }else {
                    return 2
            }
            
            }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


