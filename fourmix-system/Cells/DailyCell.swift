//
//  DailyCell.swift
//  fourmix-system
//
//  Created by 石原比希 on 2019/07/30.
//  Copyright © 2019 Fourmix. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    
    @IBOutlet weak var dailyCardView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var workTypeLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dailyCardView.layer.borderWidth = 1
        dailyCardView.layer.borderColor = UIColor(named: "brand-blue")?.cgColor
        dailyCardView.layer.cornerRadius = 8
        dailyCardView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(daily: Daily) {
        dateLabel.text = daily.attributes.date
        projectNameLabel.text = daily.relationships.project.attributes.name
        workTypeLabel.text = daily.relationships.workType.attributes.name
        workTimeLabel.text = "\(daily.attributes.start)~\(daily.attributes.end)"
        restTimeLabel.text = "\(daily.attributes.rest ?? 0)分"
        jobTypeLabel.text = daily.relationships.jobType.attributes.name
        noteLabel.text = daily.attributes.note
    }
}
