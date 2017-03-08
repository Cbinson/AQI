//
//  AddViewController.swift
//  AlamofireTest
//
//  Created by binsonchang on 2016/12/21.
//  Copyright © 2016年 binsonchang. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let todoItem = textField.text else {
            return
        }
        
        print("todoItem:\(todoItem)")
//        Alamofire.request("https://agile-beyond-33241.herokuapp.com/todo", method:.post)
        Alamofire.request("https://agile-beyond-33241.herokuapp.com/todo", method: .post, parameters: ["name": todoItem], encoding: JSONEncoding.default, headers: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
