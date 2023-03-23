//
//  HomeController.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class HomeController: ParentController {
    
    let viewModel: WeatherViewModel
    let customView: WeatherView
    
    init(viewModel: WeatherViewModel,
         customView: WeatherView) {
        self.viewModel = viewModel
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.customView.searchBar.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButtonItem()
        bindInputs(viewModel.inputs)
        bindOutputs(viewModel.outputs)
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    private func addLeftBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView.refreshButton)
    }
    
    private func bindInputs(_ inputs: WeatherViewModelInput) {
        inputs.load()
    }
    
    private func bindOutputs(_ outputs: WeatherViewModelOutput) {
        navigationItem.title = outputs.navigationTitle
        customView.iconLocationImageView.image = outputs.iconLocation
        customView.countryLabel.text = outputs.country
        customView.dateLabel.text = outputs.currentDate
        customView.iconWeatherImageView.image = outputs.iconWeather
        customView.humidityLabel.text = outputs.humidity
        customView.windSpeedLabel.text = outputs.windSpeed
        customView.tempretureLabel.text = outputs.tempreture
        customView.insertSegmentControl(titles: outputs.weatherUnits)
        customView.segmentControl.selectedSegmentIndex = outputs.selectedSegmentIndex
        customView.refreshButton.setImage(outputs.iconRefreshButton, for: .normal)
        addTargetSegmentControl()
        addTargetRefreshButton()
    }
    
}


extension HomeController: WeatherViewModelDelegate {
    
    func finishWithError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(title: self.viewModel.errorTitle, message: self.viewModel.errorMessage) {
                // Do something here if you want
            }
        }
    }
    
    func FinishWithSuccess() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.bindOutputs(self.viewModel.outputs)
        }
    }
    
}

extension HomeController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getWeatherByCountry(searchBar.text ?? "")
        view.endEditing(true)
    }
    
}
