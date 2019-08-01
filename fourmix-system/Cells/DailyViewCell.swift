//
//  DailyViewCell.swift
//  fourmix-system
//
//  Created by 森雄大 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class DailyViewCell: UITableViewCell {

    @IBOutlet weak var dailyCardView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dailyCardView.layer.borderWidth = 1
        dailyCardView.layer.borderColor = UIColor(named: "brand")?.cgColor
        dailyCardView.layer.cornerRadius = 8
        dailyCardView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(daily: Daily) {
        dateLabel.text = Date.createFromFormat(string: daily.attributes.date, format: "yyyy-MM-dd HH:mm:ss")?.format("yyyy年MM月dd日")
        projectNameLabel.text = daily.relationships.project.attributes.name
        customerNameLabel.text = daily.relationships.project.relationships.customer.attributes.name
        workTypeLabel.text = daily.relationships.workType.attributes.name
        workTimeLabel.text = daily.attributes.time.description
        userNameLabel.text = daily.relationships.user.attributes.name
        costLabel.text = daily.attributes.cost.description
    }

}
