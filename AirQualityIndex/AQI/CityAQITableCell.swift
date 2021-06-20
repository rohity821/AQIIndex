//
//  CityAQITableCell.swift
//  AirQualityIndex
//
//  Created by Rohit Yadav on 20/06/21.
//

import UIKit

class CityAQITableCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var aqiIndexLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureContainerView()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.backgroundColor = UIColor(red: 74, green: 80, blue: 91, alpha: 1.0)
    }
    
    func configureContainerView() {
        containerView.layer.cornerRadius = 12.0
    }

    func update(city: String, aqiIndex: Double?, updatedAt: Date? = Date()) {
        cityNameLabel.text = city
        if let index = aqiIndex {
            aqiIndexLabel.text = "\(index.rounded(toPlaces: 2))"
            containerView.backgroundColor = ColorUtil.getColor(forAQI: index)
        } else {
            aqiIndexLabel.text = "NA"
        }
        if let updated = updatedAt {
            updatedAtLabel.text = getDifference(updatedTime: updated)
        }
    }
    
    private func getDifference(updatedTime: Date) -> String {
        let difference = Calendar.current.dateComponents([.second], from: updatedTime, to: Date())
        let secondString = secondsToString(seconds: difference.second ?? 0)
        return secondString
    }
    
    private func secondsToString(seconds: Int) -> String {
        func hourMinuteSeconds(seconds: Int) -> (minute: Int, second: Int)? {
            let minute: Int = seconds/60
            let seconds: Int = (seconds % 3600) % 60
            return (minute: minute, second: seconds)
        }

        let allComps = hourMinuteSeconds(seconds: seconds)
        var finalString: String = "Updated "
        if let minute = allComps?.minute,minute > 0 {
            finalString += "\(minute) min ago"
        }
        else {
            finalString += String(format: "%02d sec ago", allComps?.second ?? 0)
        }
        return finalString
        
    }
    
}
