//
//  WeatherTableViewCell.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeatherTableViewCell"
    
    private let weatherIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "sun.max")
        return imgView
    }()

    private let weatherState: UILabel = {
        let state = UILabel()
        state.text = "오늘날씨 좋네~~~~~~~~"
        state.font = UIFont.systemFont(ofSize:15)
        state.textColor = UIColor.gray
        return state
    }()
    
    private let day: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = UIColor.gray
        return label
    }()
    
    private let maxTemp: UILabel = {
        let max = UILabel()
        max.text = "Max: 9°C"
        max.font = UIFont.systemFont(ofSize:15)
        max.textColor = UIColor.gray
        return max
    }()
    
    private let minTemp: UILabel = {
        let min = UILabel()
        min.text = "Min: 1°C"
        min.font = UIFont.systemFont(ofSize:15)
        min.textColor = UIColor.gray
        return min
    }()
    
    private let stackView:UIStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        let temps = [maxTemp, minTemp]
        
        contentView.addSubview(weatherIcon)
        contentView.addSubview(weatherState)
        contentView.addSubview(day)
        contentView.addSubview(stackView)
                
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually

        for i in temps{
            stackView.addArrangedSubview(i)
        }
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherState.translatesAutoresizingMaskIntoConstraints = false
        day.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            day.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            day.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 30),
            day.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherIcon.topAnchor.constraint(equalTo: day.bottomAnchor, constant: 2),
            weatherIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            weatherIcon.widthAnchor.constraint(equalToConstant: 42),
            weatherIcon.heightAnchor.constraint(equalToConstant: 42),
                
            weatherState.leadingAnchor.constraint(equalTo: weatherIcon.trailingAnchor, constant: 5),
            weatherState.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: weatherState.trailingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
        ])
      
        
    }
    
}
