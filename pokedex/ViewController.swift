//
//  ViewController.swift
//  pokedex
//
//  Created by Sarah on 10/8/16.
//  Copyright © 2016 Sarah. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    //JSON type format
    typealias JSONStandard = [String : AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let requesturl = "https://pokeapi.co/api/v2/pokemon/"
        
        var count = 0
        
        /*****PARSE JSON DATA*****/
        func parseData(JSONData : Data){
            do {
                
                //parse the json
                var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
                
                count = readableJSON["count"] as! Int
                
            }
            catch{
                print(error)
            }
        }
        
        /*****GET REQUEST*****/
        Alamofire.request(requesturl).responseJSON { response in
            
            //parse the returned data into readable format
            parseData(JSONData : response.data!)
            
            print("**************************")
            print(response.data!)
            print("**************************")
            /*************DISPLAY**************/
            
            //label (loaded from json elements)
            //self.label1.text = String(count)+" total Pokemon"
            
            
        }
        
        
    }

    //@IBOutlet weak var sprite: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getPokemon(_ sender: UIButton) {
        print("we made it")
        
        //navigate to second view
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let page2: UIViewController = storyboard.instantiateViewController(withIdentifier: "page2") as UIViewController
        
        self.present(page2, animated: true, completion: nil)
    }
    

}

