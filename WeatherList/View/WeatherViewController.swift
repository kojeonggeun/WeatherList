//
//  ViewController.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/18.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
  
    private let weatherTableView: UITableView = UITableView()
    private let viewModel = WeatherViewModel()
    private let disposeBag = DisposeBag()
    
    private let weatherManager: WeatherManager = WeatherManager()
    
    lazy var activityView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(frame: CGRect(x: 110, y: 35, width: view.frame.width, height: view.frame.height))
        loading.hidesWhenStopped = true
        loading.style = UIActivityIndicatorView.Style.large
        loading.center = self.view.center
        loading.backgroundColor = .white
        loading.alpha = 0.9
        view.addSubview(loading)
        return loading
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initConstraint()
    
        
        viewModel.inputs.requestWeatherApi()
        
        viewModel.activated
            .map{ $0 }
            .subscribe(onNext: { result in
                result ? self.activityView.startAnimating() : self.activityView.stopAnimating()
            }).disposed(by: disposeBag)
                
        viewModel.outputs.weathers
            .subscribe(onNext:{ [weak self] result in
                
                self?.weatherManager.add(weather: result)
                
                if self!.weatherManager.isRequestCompleted() {
                    self?.weatherManager.descOrdering()
                    self?.weatherManager.updateApplicationDate()
                    self?.weatherTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func initView(){
        self.weatherTableView.dataSource = self
        self.weatherTableView.rowHeight = UITableView.automaticDimension
        self.weatherTableView.estimatedRowHeight = UITableView.automaticDimension
        self.view.addSubview(weatherTableView)
        
        self.weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
    }
    
    func initConstraint(){
        
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
        return viewModel.cities.count

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.weatherManager.isRequestCompleted() {
            return self.weatherManager.weathers[section].consolidatedWeather.count
        } else {
            return 6
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.cities[section]
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier) as? WeatherTableViewCell else { return UITableViewCell()}
        
        if self.weatherManager.isRequestCompleted() {
            cell.updateUI(weather: self.weatherManager.weathers[indexPath.section].consolidatedWeather[indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
          header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          header.textLabel?.frame = header.bounds

    }
}
