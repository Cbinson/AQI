//
//  Pm25ViewController.swift
//  AlamofireTest
//
//  Created by binsonchang on 2016/12/27.
//  Copyright © 2016年 binsonchang. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class Pm25ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topImgV: UIImageView!
    
    @IBOutlet weak var BigAreaLabel: UILabel!
    @IBOutlet weak var SmallAreaLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    
    
    
    var administrative_area_level_1:String!
    var administrative_area_level_2:String!
    var administrative_area_level_3:String!
    var administrative_area_level_4:String!
    var location:CLLocation!
    var locationManager:CLLocationManager!
    
    
    var AQI_Dic:Dictionary<String, AnyObject>! //記錄正確AQI資料
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        self.BigAreaLabel.text = ""
        self.SmallAreaLabel.text = ""
        
        
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        self.mainTableView.estimatedRowHeight = 400.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initLocation()
    }
    
    func initLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.activityType = CLActivityType.fitness
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let tmpLocation:CLLocation = locations[0] as CLLocation
        
        if self.location == nil || (self.location.coordinate.longitude != tmpLocation.coordinate.longitude || self.location.coordinate.latitude != tmpLocation.coordinate.latitude) {
            
            self.locationManager.stopUpdatingLocation()
            
            self.location = locations[0] as CLLocation
            
            self.detectCurrentLocation(location: self.location)
            
//            self.latlon_label.text = String(format: "緯度:%f, 經度:%f",location.coordinate.longitude,location.coordinate.latitude)
        }
        
    }
    
    
    func detectCurrentLocation(location:CLLocation) /*-> String*/ {
        let locationUrl = URL(string: String("http://maps.googleapis.com/maps/api/geocode/json?latlng=\(location.coordinate.latitude),\(location.coordinate.longitude)&sensor=false&language=zh-tw"))! as URL
//        let locationUrl = URL(string: String("http://maps.googleapis.com/maps/api/geocode/json?latlng=24.9868972619111,121.533296877325&sensor=false&language=zh-tw"))! as URL
        
        Alamofire.request(locationUrl).responseJSON { (response) in
            print("request:\(response.request)")  // 原始的 URL 要求
            print("response:\(response.response)") // URL 回應
            print("response_data:\(response.data)")     // 伺服器資料
            print("response_result:\(response.result)")   // 回應的序列化結果
            
            if response.response?.statusCode == 200 {
                let dataDic:Dictionary<String, AnyObject> = response.result.value as! Dictionary<String, AnyObject>
                let resultArry:NSArray = dataDic["results"] as! NSArray
                let address_components:NSArray = (resultArry[0] as! Dictionary<String, AnyObject>)["address_components"] as! NSArray
                
                
                for tmpDic in address_components {
                    let dic:Dictionary<String, AnyObject> = tmpDic as! Dictionary<String, AnyObject>
                    let locationName:String = dic["short_name"] as! String
                    let typeArry:NSArray = dic["types"] as! NSArray
                    
                    for idx in 0..<typeArry.count {
                        let areaName:String = typeArry[idx] as! String
                        
                        if areaName == "administrative_area_level_1" {
                            self.administrative_area_level_1 = locationName
                        }
                        
                        if areaName == "administrative_area_level_2" {
                            self.administrative_area_level_2 = locationName
                        }
                        
                        if areaName == "administrative_area_level_3" {
                            self.administrative_area_level_3 = locationName
                        }
                        
                        if areaName == "administrative_area_level_4" {
                            self.administrative_area_level_4 = locationName
                        }
                        
                        
                    }
                }
                
                if  self.administrative_area_level_1 != nil{
                    if (self.administrative_area_level_1 as String) != ""{
                        self.BigAreaLabel.text = self.administrative_area_level_1 as String
                    }
                }
                
                if  self.administrative_area_level_2 != nil{
                    if (self.administrative_area_level_2 as String) != ""{
                        self.BigAreaLabel.text = self.administrative_area_level_2 as String
                    }
                }
                
                if  self.administrative_area_level_3 != nil{
                    if (self.administrative_area_level_3 as String) != ""{
                        self.SmallAreaLabel.text = self.administrative_area_level_3 as String
                    }
                }
                
                
                self.downLoadAQIData()
            }
        }
        
    }
    
    //get AQI data
    func downLoadAQIData() {
        let url:String = "https://airpm25.herokuapp.com/pm"
        Alamofire.request(url).responseJSON { response in
//            print(response.request)  // 原始的 URL 要求
//            print(response.response) // URL 回應
//            print(response.data)     // 伺服器資料
//            print(response.result)   // 回應的序列化結果
            
            if response.response?.statusCode == 200 {
                let dataArry:NSArray = response.result.value as! NSArray
//                print("AQI_data:\(dataArry)")
                
                for tmpDic in dataArry {
                    
                    let aqiDic:Dictionary<String, AnyObject> = tmpDic as! Dictionary<String, AnyObject>
                    let siteName:String = aqiDic["SiteName"] as! String

                    if self.administrative_area_level_2 != nil{
                        if self.administrative_area_level_2.contains(siteName) {
                            self.AQI_Dic = aqiDic
                            print("siteName:\(siteName)")
                        }
                    }
                    
                    if self.administrative_area_level_3 != nil{
                        if self.administrative_area_level_3.contains(siteName) {
                            self.AQI_Dic = aqiDic
                            print("siteName:\(siteName)")
                        }
                    }
                    
                    
                    
                }
                
                self.mainTableView.reloadData()
            }
        }
        
    }
    
    
    
    
    //tableview delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return self.topView
    }
    
    
    
    //tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cellID:String!
        var tmpCell:UITableViewCell = UITableViewCell()
        
        
        if indexPath.row == 0 {
            cellID = "AQICell"
            let cell:AQITableViewCell = self.mainTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath
            ) as! AQITableViewCell
            
            if self.AQI_Dic != nil {
                cell.location_Label.text = self.AQI_Dic["SiteName"] as? String
//                cell.detectLevelLabel.text = String(format: "(%@)",(self.AQI_Dic["MonobjName"] as? String)!)
                
                //AQI
                cell.aqiNumber.text = self.AQI_Dic["AQI"] as? String
                cell.aqiLevelLabel.text = self.detectAQIvalue(aqiValue: (self.AQI_Dic["AQI"] as? String)!, cell: cell)
                
                
                //O3
//                cell.o3_8avg_label.text = self.AQI_Dic["O3_8"] as? String
                cell.o3_avg_label.text = self.AQI_Dic["O3"] as? String
                
                //PM25
//                cell.pm25_moveAvg_label.text = self.AQI_Dic["PM25_AVG"] as? String
                cell.pm25_avg.text = self.AQI_Dic["PM25"] as? String
                
                //PM10
//                cell.pm10_moveAvg_label.text = self.AQI_Dic["PM10_AVG"] as? String
                cell.pm10_avg.text = self.AQI_Dic["PM10"] as? String
            }
            
            tmpCell = cell
            
        }else if indexPath.row == 1 {
            cellID = "HealthCell"
            let cell:HealthTableViewCell = self.mainTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath
            ) as! HealthTableViewCell
            
            //cell.textLabel?.text = "health"
            if self.AQI_Dic != nil {
                cell.healthLabel.text = self.getHealthAlert(aqiLevel: (self.AQI_Dic["AQI"] as? String)!)
            }
            
            
            tmpCell = cell
        }else if indexPath.row == 2 {
            cellID = "ActivityCell"
            let cell:ActivityTableViewCell = self.mainTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath
            ) as! ActivityTableViewCell
            
            //cell.textLabel?.text = "activity"
            
            if self.AQI_Dic != nil {
                cell.activityLabel.text = self.getActivityStr(aqiLevel: (self.AQI_Dic["AQI"] as? String)!)
            }
            
            tmpCell = cell
        }
        
        
        
        //cell.textLabel?.text = String(format: "\(indexPath.row)")
        
        return tmpCell
    }
    
    
    //AQI method
    func detectAQIvalue(aqiValue:String, cell:AQITableViewCell) -> String {
        let currentValue:Int = Int(aqiValue)!
//        print("[xxxx] current_AQI: \(currentValue)")
        var currentLevel:String!
        
        switch currentValue {
        case 0...50:
            currentLevel = "良好"
            cell.aqiView.backgroundColor = UIColor.green
        case 51...100:
            currentLevel = "普通"
            cell.aqiView.backgroundColor = UIColor.yellow
        case 101...150:
            currentLevel = "對敏感族群不健康"
            cell.aqiView.backgroundColor = UIColor(red: 255.0/255.0, green: 116.0/255.0, blue: 21.0/255.0, alpha: 1)
        case 151...200:
            currentLevel = "對所有族群不健康"
            cell.aqiView.backgroundColor = UIColor.red
        case 201...300:
            currentLevel = "非常不健康"
            cell.aqiView.backgroundColor = UIColor(red: 69.0/255.0, green: 0, blue: 68.0/255.0, alpha: 1)
        case 301...500:
            currentLevel = "危害"
            cell.aqiView.backgroundColor = UIColor(red: 128.0/255.0, green: 0, blue: 0, alpha: 1)
        default:
            currentLevel = "設備維護"
            cell.aqiView.backgroundColor = UIColor.white
        }
        
        return currentLevel
    }
    
    //健康影響
    func getHealthAlert(aqiLevel:String) -> String {
        
        let currentValue:Int = Int(aqiLevel)!
        var alertStr:String!
        
        
        switch currentValue {
        case 0...50:
            alertStr = "空氣品質為良好，污染程度低或無污染。"
        case 51...100:
            alertStr = "空氣品質普通；但對非常少數之極敏感族群產生輕微影響。"
        case 101...150:
            alertStr = "空氣污染物可能會對敏感族群的健康造成影響，但是對一般大眾的影響不明顯。"
        case 151...200:
            alertStr = "對所有人的健康開始產生影響，對於敏感族群可能產生較嚴重的健康影響。"
        case 201...300:
            alertStr = "健康警報：所有人都可能產生較嚴重的健康影響。"
        case 301...500:
            alertStr = "健康威脅達到緊急，所有人都可能受到影響。"
        default:
            alertStr = "設備維護"
        }
        
        return alertStr
    }
    
    //活動建議
    func getActivityStr(aqiLevel:String) -> String {
        let currentValue:Int = Int(aqiLevel)!
        var alertStr:String!
        
        
        switch currentValue {
        case 0...50:
            alertStr = String(format: "一般民眾:\n\t\t正常戶外活動。\n\n敏感性族群:\n\t\t正常戶外活動。")
        case 51...100:
            alertStr = String(format: "一般民眾:\n\t\t正常戶外活動。\n\n敏感性族群:\n\t\t極特殊敏感族群建議注意可能產生的咳嗽或呼吸急促症狀，但仍可正常戶外活動。")
        case 101...150:
            alertStr = String(format: "一般民眾:\n\t\t1.一般民眾如果有不適，如眼痛，咳嗽或喉嚨痛等，應該考慮減少戶外活動。\t\t2.學生仍可進行戶外活動，但建議減少長時間劇烈運動。\n\n敏感性族群:\n\t\t1.有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議留在室內並減少體力消耗活動，必要外出應配戴口罩。\t\t2.具有氣喘的人可能需增加使用吸入劑的頻率。")
        case 151...200:
            alertStr = String(format: "一般民眾:\n\t\t1.一般民眾應減少戶外活動。\t\t2.學生應立即停止戶外活動，並將課程調整於室內進行。\n\n敏感性族群:\n\t\t1.有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並減少體力消耗活動，必要外出應配戴口罩。\t\t2.具有氣喘的人應增加使用吸入劑的頻率。")
        case 201...300:
            alertStr = String(format: "一般民眾:\n\t\t1.一般民眾如果有不適，如眼痛，咳嗽或喉嚨痛等，應減少體力消耗，特別是減少戶外活動。\t\t2.學生應避免長時間劇烈運動，進行其他戶外活動時應增加休息時間。\n\n敏感性族群:\n\t\t1.有心臟、呼吸道及心血管疾病患者、孩童及老年人，建議留在室內並減少體力消耗活動，必要外出應配戴口罩。\t\t2.具有氣喘的人可能需增加使用吸入劑的頻率。")
        case 301...500:
            alertStr = String(format: "一般民眾:\n\t\t1.一般民眾應避免戶外活動，室內應緊閉門窗，必要外出應配戴口罩等防護用具。\t\t2.學生應立即停止戶外活動，並將課程調整於室內進行。\n\n敏感性族群:\n\t\t1.有心臟、呼吸道及心血管疾病患者、孩童及老年人應留在室內並避免體力消耗活動，必要外出應配戴口罩。\t\t2.具有氣喘的人可能需增加使用吸入劑的頻率。")
        default:
            alertStr = "設備維護"
        }
        
        return alertStr
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        var yOffset = scrollView.contentOffset.y
        
        if yOffset < 0 {
            yOffset = yOffset*(-1)
            
            if yOffset < 1 {
                self.topImgV.transform = CGAffineTransform(rotationAngle:0.0).scaledBy(x: 1, y: 1)
            }else{
                self.topImgV.transform = CGAffineTransform(rotationAngle:0.0).scaledBy(x: yOffset, y: yOffset)
            }
        }
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
