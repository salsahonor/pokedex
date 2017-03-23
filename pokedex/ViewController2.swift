//
//  ViewController2.swift
//  pokedex
//
//  Created by Sarah on 10/9/16.
//  Copyright © 2016 Sarah. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class ViewController2: UIViewController {

    //sprite image for pokemans
    @IBOutlet weak var sprite: UIImageView!
    //label for returned pokestats
    @IBOutlet weak var pagelabel: UILabel!
    //JSON type format
    typealias JSONStandard = [String : AnyObject]
    
    
    /******ONLOAD******/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generate a random pokeID for randoURL
        let pokeNum = String(arc4random_uniform(151)+1) //"151+1" generates num between 1-151
        let requesturl = "https://pokeapi.co/api/v1/pokemon/" + pokeNum
        
        //variables for printing
        var pokename = ""
        var height = ""
        var weight = ""
        //var type1: Array = [AnyObject]()
        //var type2 = ""
        
        
        /*****PARSE JSON DATA*****/
        func parseData(JSONData : Data){
            do {
                
                //parse the json
                var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
                
                pokename = readableJSON["name"]! as! String //as? JSONStandard
                print("**************"+pokename)
                height = readableJSON["height"]! as! String
                weight = readableJSON["weight"]! as! String
                //type1 = readableJSON["types"] as! [AnyObject] //as! Array//[0]["name"] as? String
                
                //print("***************type1: ")
                //print(type1)
            }
            catch{
                print(error)
            }
        }
        
        /*****GET REQUEST*****/
        Alamofire.request(requesturl).responseJSON { response in
            
            //parse the returned data into readable format
            parseData(JSONData : response.data!)
            print(pokename)
            
            /*************DISPLAY**************/
            
            //sprite (loaded locally)
            self.sprite.image = UIImage(named: pokeNum)
            
            //label (loaded from json elements)
            self.pagelabel.text = "Name: "+pokename+"\nPokedex ID: "+pokeNum+"\nHeight: "+height+"\nWeight: "+weight;

            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
