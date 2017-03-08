//
//  ViewController.swift
//  AlamofireTest
//
//  Created by binsonchang on 2016/12/20.
//  Copyright © 2016年 binsonchang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonArray:NSMutableArray = []
    var newArray:Array<String> = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //response handle
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        if self.newArray.count != 0 {
            self.newArray.removeAll()
        }
        
        self.downloadAndUpdate()
    }
    
    
    
    
    func downloadAndUpdate() {
        Alamofire.request("https://agile-beyond-33241.herokuapp.com/todo").responseJSON { response in
            print(response.request)  // 原始的 URL 要求
            print(response.response) // URL 回應
            print(response.data)     // 伺服器資料
            print(response.result)   // 回應的序列化結果
            
            if response.response?.statusCode == 200 {
                let dataArry:NSArray = response.result.value as! NSArray
                
                for dic in dataArry {
                    self.jsonArray.add(dic)
                    
                    let tmpDic:Dictionary<String, AnyObject> = dic as! Dictionary<String, AnyObject>
                    
                    
                    if let name:String = tmpDic["name"] as? String {
//                        print("name:\(name)")
                        self.newArray.append(name)
                    }
                    
                }
                self.tableView.reloadData()
//                print("jsonArray:\(self.jsonArray)")
                
            }
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.newArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.newArray[indexPath.row]
        
        return cell
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

