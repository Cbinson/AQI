//
//  AQITableViewCell.swift
//  AlamofireTest
//
//  Created by binsonchang on 2016/12/28.
//  Copyright © 2016年 binsonchang. All rights reserved.
//

import UIKit

class AQITableViewCell: UITableViewCell {

    
    @IBOutlet weak var location_Label: UILabel!
    
    @IBOutlet weak var aqiView: UIView!
    @IBOutlet weak var aqiNumber: UILabel!
    @IBOutlet weak var aqiLevelLabel: UILabel!
    
    @IBOutlet weak var o3_8avg_label: UILabel!
    @IBOutlet weak var o3_avg_label: UILabel!
    
    @IBOutlet weak var pm25_moveAvg_label: UILabel!
    @IBOutlet weak var pm25_avg: UILabel!
    
    @IBOutlet weak var pm10_moveAvg_label: UILabel!
    @IBOutlet weak var pm10_avg: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
