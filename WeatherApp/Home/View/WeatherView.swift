//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Hamza Almass on 3/22/23.
//

import UIKit

class WeatherView: UIView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search by country"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = CoreColor.myPrimaryColor.color
        searchBar.searchTextField.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    var segmentControl: UISegmentedControl!
    
    let humidityLabel: NormalLabel = {
        let label = NormalLabel(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.textColor = .white
        return label
    }()
    
    let windSpeedLabel: NormalLabel = {
        let label = NormalLabel(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.textColor = .white
        return label
    }()
    
    let countryLabel: BodyLabel = {
        let label = BodyLabel(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let tempretureLabel: LargeLabel = {
        let label = LargeLabel(alignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.textColor = .white
        return label
    }()
    
    let dateLabel: BodyLabel = {
        let label = BodyLabel(alignment: .natural)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = CoreColor.mySecondaryColor.color
        return label
    }()
    
    let iconLocationImageView: IconImageView = {
        let imageView = IconImageView(imageTintColor: .white)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    let iconWeatherImageView: IconImageView = {
        let imageView = IconImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return imageView
    }()
    
    private let countryInfoStackView: WeatherStackView = {
        let stackView = WeatherStackView(distribution: .fill, alignment: .fill, axis: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let weatherInfoStackView: WeatherStackView = {
        let stackView = WeatherStackView(distribution: .fill, alignment: .fill, axis: .vertical, spacing: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupHirearchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHirearchy() {
        
        [countryInfoStackView, weatherInfoStackView, dateLabel, searchBar].forEach { subView in
            addSubview(subView)
        }
        
        [iconLocationImageView, countryLabel].forEach { subView in
            countryInfoStackView.addArrangedSubview(subView)
        }
        
        [iconWeatherImageView,tempretureLabel, humidityLabel, windSpeedLabel].forEach { subView in
            weatherInfoStackView.addArrangedSubview(subView)
        }

    }
    
    private func setupConstraints() {
        setupSearchBarConstraints()
        setupCountryInfoStackViewConstraints()
        setupWeatherInfoStackViewConstraints()
        setupDateLabelConstraints()
    }
    
    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 100)
        ])
    }
    
    private func setupCountryInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            countryInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            countryInfoStackView.heightAnchor.constraint(equalToConstant: 40),
            countryInfoStackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30)
        ])
    }
    
    private func setupWeatherInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            weatherInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherInfoStackView.topAnchor.constraint(equalTo: countryInfoStackView.bottomAnchor, constant: 20),
            weatherInfoStackView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupDateLabelConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension WeatherView {
    func insertSegmentControl(titles: [String]) {
        weatherInfoStackView.arrangedSubviews.forEach { subView in
            if subView is UISegmentedControl {
                subView.removeFromSuperview()
            }
        }
        
        segmentControl = UISegmentedControl(items: titles)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentTintColor = CoreColor.mySecondaryColor.color
        segmentControl.backgroundColor = .white
        weatherInfoStackView.insertArrangedSubview(segmentControl, at: 0)
    }
}


