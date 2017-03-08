//
//  MapViewController.swift
//  AlamofireTest
//
//  Created by binsonchang on 2016/12/30.
//  Copyright © 2016年 binsonchang. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mainMapView: MKMapView!
    
    
    var areaArry = [Dictionary<String,String>]()
    
    var animationArry = [MKPointAnnotation]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.areaArry = [["SiteName","基隆","lat":"25.1276033","lng":"121.7391833"]]
        self.areaArry = [["SiteName":"基隆", "lat":"25.1276033", "lng":"121.7391833"],
                         ["SiteName":"汐止", "lat":"25.0616059", "lng":"121.6397184"],
                         ["SiteName":"萬里", "lat":"25.1676024", "lng":"121.6397184"],
                         ["SiteName":"新店", "lat":"24.978282", "lng":"121.5394822"],
                         ["SiteName":"土城", "lat":"24.968371", "lng":"121.438034"],
                         ["SiteName":"板橋", "lat":"25.0114095", "lng":"121.4618415"],
                         ["SiteName":"新莊", "lat":"25.0265985", "lng":"121.4178347"],
                         ["SiteName":"菜寮", "lat":"25.060274", "lng":"121.492156"],
                         ["SiteName":"林口", "lat":"25.1276033", "lng":"121.7391833"],
                         ["SiteName":"淡水", "lat":"25.1719805", "lng":"121.4433706"],
                         ["SiteName":"士林", "lat":"25.0950492", "lng":"121.5246077"],
                         ["SiteName":"中山", "lat":"25.0792018", "lng":"121.5427093"],
                         ["SiteName":"萬華", "lat":"25.0262857", "lng":"121.4970294"],
                         ["SiteName":"古亭", "lat":"25.0261342", "lng":"121.522922"],
                         ["SiteName":"松山", "lat":"25.0541591", "lng":"121.5638621"],
                         ["SiteName":"大同", "lat":"25.0627243", "lng":"121.5113064"],
                         ["SiteName":"桃園", "lat":"24.9936281", "lng":"121.3009798"],
                         ["SiteName":"大園", "lat":"25.0492632", "lng":"121.193945"],
                         ["SiteName":"觀音", "lat":"25.0359365", "lng":"121.1137544"],
                         ["SiteName":"平鎮", "lat":"24.9296022", "lng":"121.2053963"],
                         ["SiteName":"龍潭", "lat":"24.8444927", "lng":"121.2053963"],
                         ["SiteName":"湖口", "lat":"24.8814458", "lng":"121.0449768"],
                         ["SiteName":"竹東", "lat":"24.774922", "lng":"121.0449768"],
                         ["SiteName":"新竹", "lat":"24.8387226", "lng":"121.0177246"],
                         ["SiteName":"頭份", "lat":"24.6884438", "lng":"120.9024836"],
                         ["SiteName":"苗栗", "lat":"24.560159", "lng":"120.8214265"],
                         ["SiteName":"三義", "lat":"24.3892633", "lng":"120.769476"],
                         ["SiteName":"豐原", "lat":"24.2521156", "lng":"120.7223572"],
                         ["SiteName":"沙鹿", "lat":"24.2377939", "lng":"120.5854674"],
                         ["SiteName":"大里", "lat":"24.1046899", "lng":"120.6812114"],
                         ["SiteName":"忠明", "lat":"24.1430604", "lng":"120.6631289"],
                         ["SiteName":"西屯", "lat":"24.1769764", "lng":"120.6424333"],
                         ["SiteName":"彰化", "lat":"24.0517963", "lng":"120.5161352"],
                         ["SiteName":"線西", "lat":"24.1331612", "lng":"120.4530456"],
                         ["SiteName":"二林", "lat":"23.9141358", "lng":"120.4011911"],
                         ["SiteName":"南投", "lat":"23.9609981", "lng":"120.9718638"],
                         ["SiteName":"斗六", "lat":"23.7077947", "lng":"120.5409089"],
                         ["SiteName":"崙背", "lat":"23.7790296", "lng":"120.3320195"],
                         ["SiteName":"新港", "lat":"23.538123", "lng":"120.3550808"],
                         ["SiteName":"朴子", "lat":"23.4464152", "lng":"120.2570421"],
                         ["SiteName":"臺西", "lat":"23.7229714", "lng":"120.1935663"],
                         ["SiteName":"嘉義", "lat":"23.4518428", "lng":"120.2554615"],
                         ["SiteName":"新營", "lat":"23.3119567", "lng":"120.3089541"],
                         ["SiteName":"善化", "lat":"23.1402613", "lng":"120.3089541"],
                         ["SiteName":"安南", "lat":"23.0585336", "lng":"120.1358346"],
                         ["SiteName":"臺南", "lat":"22.9998999", "lng":"120.2268758"],
                         ["SiteName":"美濃", "lat":"22.885385", "lng":"120.5509358"],
                         ["SiteName":"橋頭", "lat":"22.7539012", "lng":"120.3089541"],
                         ["SiteName":"仁武", "lat":"22.6947932", "lng":"120.3608455"],
                         ["SiteName":"鳳山", "lat":"22.6113591", "lng":"120.3493158"],
                         ["SiteName":"大寮", "lat":"22.584481", "lng":"120.4011911"],
                         ["SiteName":"林園", "lat":"22.4986756", "lng":"120.4011911"],
                         ["SiteName":"楠梓", "lat":"22.7175372", "lng":"120.3031871"],
                         ["SiteName":"左營", "lat":"22.6877358", "lng":"120.2916524"],
                         ["SiteName":"前金", "lat":"22.6254162", "lng":"120.2945362"],
                         ["SiteName":"前鎮", "lat":"22.5970794", "lng":"120.3147208"],
                         ["SiteName":"小港", "lat":"22.5553185", "lng":"120.3608455"],
                         ["SiteName":"屏東", "lat":"22.5519759", "lng":"120.5487597"],
                         ["SiteName":"潮州", "lat":"22.5294168", "lng":"120.5624474"],
                         ["SiteName":"恆春", "lat":"22.0008277", "lng":"120.7447638"],
                         ["SiteName":"臺東", "lat":"22.7972447", "lng":"121.0713702"],
                         ["SiteName":"花蓮", "lat":"23.9871589", "lng":"121.6015714"],
                         ["SiteName":"陽明", "lat":"25.1942462", "lng":"121.5609363"],
                         ["SiteName":"宜蘭", "lat":"24.7021073", "lng":"121.7377502"],
                         ["SiteName":"冬山", "lat":"24.6550376", "lng":"121.7641363"],
                         ["SiteName":"三重", "lat":"25.0614534", "lng":"121.4867114"],
                         ["SiteName":"中壢", "lat":"24.9721514", "lng":"121.2053963"],
                         ["SiteName":"竹山", "lat":"23.712201", "lng":"120.6890055"],
                         ["SiteName":"永和", "lat":"25.0103251", "lng":"121.5145353"],
                         ["SiteName":"復興", "lat":"24.709089", "lng":"121.3770336"],
                         ["SiteName":"埔里", "lat":"23.9651371", "lng":"120.9673768"],
                         ["SiteName":"馬祖", "lat":"26.15", "lng":"119.9333333"],
                         ["SiteName":"金門", "lat":"24.4458333", "lng":"118.3761111"],
                         ["SiteName":"馬公", "lat":"23.5661218", "lng":"119.5861581"],
                         ["SiteName":"關山", "lat":"23.0495603", "lng":"121.1646339"],
                         ["SiteName":"麥寮", "lat":"23.7774603", "lng":"120.2397336"],
                         ["SiteName":"南投(鹿谷)", "lat":"23.7348372", "lng":"120.7809676"],
                         ["SiteName":"雲林(麥寮)", "lat":"23.7774603", "lng":"120.2397336"],
                         ["SiteName":"嘉義(大林)", "lat":"23.6040709", "lng":"120.4542004"],
                         ["SiteName":"臺南(白河)", "lat":"23.3336369", "lng":"120.4588059"]]
//        print("areaArrty:\(self.areaArry)")
        
        
        self.initMapSetting()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.downLoadAQIData()
    }
    
    func initMapSetting() {
        self.mainMapView.showsUserLocation = false//true
        self.mainMapView.mapType = .standard
        self.mainMapView.isZoomEnabled = true
        self.mainMapView.isScrollEnabled = true
    }
    
    //get AQI data
    func downLoadAQIData() {
        Alamofire.request("https://airpm25.herokuapp.com/pm").responseJSON { response in
//            print(response.request)  // 原始的 URL 要求
//            print(response.response) // URL 回應
//            print(response.data)     // 伺服器資料
//            print(response.result)   // 回應的序列化結果
            
            if response.response?.statusCode == 200 {
                let pm25DataArry:NSArray = response.result.value as! NSArray
                
                for tmpDic in pm25DataArry {
                    
                    let aqiDic:Dictionary<String, AnyObject> = tmpDic as! Dictionary<String, AnyObject>
                    let siteName:String = aqiDic["SiteName"] as! String
//                    print("siteName:\(siteName)")
                    let aqiStr:String = aqiDic["AQI"] as! String
                    
                    for tmplocalArea in self.areaArry {
                        let dic:Dictionary<String, String> = tmplocalArea as Dictionary<String, String>
                        let tmpLocalSiteName:String = dic["SiteName"]! as String
                        let lat:CLLocationDegrees = Double(dic["lat"]! as String)!
                        let lng:CLLocationDegrees = Double(dic["lng"]! as String)!
                        
                        if siteName == tmpLocalSiteName{
                            let point:MKPointAnnotation = MKPointAnnotation();
                            point.coordinate = CLLocationCoordinate2DMake(lat, lng)
                            point.title = tmpLocalSiteName
                            point.subtitle = self.detectAQIvalue(aqiValue: aqiStr, point: point)
//                            print("name:\(point.title), subtitle:\(point.subtitle)");
                            
                            self.mainMapView.addAnnotation(point)
                        }
//                        print("dic\(dic)")
                    }
                    
                }
                
            }
        }
        
    }
    
    
    //AQI method
    func detectAQIvalue(aqiValue:String,point:MKPointAnnotation) -> String {
        var currentValue:Int = 0
        
        if aqiValue != "" {
            currentValue = Int(aqiValue)!
        }
        
//        let currentValue:Int = Int(aqiValue)!
        var currentLevel:String!
        
        switch currentValue {
        case 1...50:
            currentLevel = "良好"
        case 51...100:
            currentLevel = "普通"
        case 101...150:
            currentLevel = "對敏感族群不健康"
        case 151...200:
            currentLevel = "對所有族群不健康"
        case 201...300:
            currentLevel = "非常不健康"
        case 301...500:
            currentLevel = "危害"
        default:
            currentLevel = "設備維護"
        }
        
        return currentLevel
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        var pointView : MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "CustomerPoint") as?MKPinAnnotationView;
        
        if(pointView == nil){
            pointView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomerPoint");
            //因為已經改寫了Annotation View,所以要將canShowCallout改成true,否則點擊大頭針不會跑出來我們剛剛指定的title跟subtitle
            pointView?.canShowCallout = true;
        }
        
        let tmpTitle:String = annotation.title!!
        let tmpStr:String = annotation.subtitle!!
//        print("title:\(annotation.title), sub_title:\(annotation.subtitle)")
        
        if tmpTitle != "My Location" {
            if tmpStr.contains("良好") {
                pointView?.pinTintColor = UIColor.green
            }else if tmpStr.contains("普通"){
                pointView?.pinTintColor = UIColor.yellow
            }else if tmpStr.contains("對敏感族群不健康"){
                pointView?.pinTintColor = UIColor.orange
            }else if tmpStr.contains("對所有族群不健康"){
                pointView?.pinTintColor = UIColor.red
            }else if tmpStr.contains("非常不健康"){
                pointView?.pinTintColor = UIColor.purple
            }else if tmpStr.contains("危害"){
                pointView?.pinTintColor = UIColor.brown
            }else{
                pointView?.pinTintColor = UIColor.white
            }
        }
        
        
        return pointView;
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
