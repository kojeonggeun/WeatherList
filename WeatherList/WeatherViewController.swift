//
//  ViewController.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import UIKit

class WeatherViewController: UIViewController {
  
    let weatherTableView: UITableView = UITableView()
    
    let cities = ["Seoul", "London", "Chicago"]
    let repository = WeatherRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherTableView.dataSource = self
        self.weatherTableView.delegate = self
        
        self.weatherTableView.rowHeight = UITableView.automaticDimension
        self.weatherTableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.view.addSubview(weatherTableView)
        
        self.weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        setConstraint()
        
        cities.forEach{  repository.woeIdList(city: $0) }
        
        
    }
    
    
    func setConstraint(){
        
        self.weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.weatherTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.weatherTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.weatherTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.weatherTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
}


extension WeatherViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cities.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cities[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier) as? WeatherTableViewCell else { return UITableViewCell() }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
          header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          header.textLabel?.frame = header.bounds
          
    }
}

extension WeatherViewController: UITableViewDelegate{
    
}