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
    
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .white
        return indicatorView
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        return button
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
    
    let dateLabel: MediumLabel = {
        let label = MediumLabel(alignment: .natural)
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
        animateView(views: [weatherInfoStackView, dateLabel])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHirearchy() {
        
        [countryInfoStackView, weatherInfoStackView, dateLabel, searchBar, indicatorView].forEach { subView in
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
        setupIndicatorViewConstraints()
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
    
    private func setupIndicatorViewConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 50),
            indicatorView.heightAnchor.constraint(equalToConstant: 50),
            indicatorView.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -25)
        ])
    }
    
    private func animateView(views: [UIView]) {
        views.forEach { subView in
            subView.animateView(duration: 0.4)
        }
    }
    
}

extension WeatherView {
    func insertSegmentControl(titles: [String]) {
        if  segmentControl == nil {
            segmentControl = UISegmentedControl(items: titles)
            styleSegmentControl(segmentControl: segmentControl)
            segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
            weatherInfoStackView.insertArrangedSubview(segmentControl, at: 0)
        }
    }
    
    fileprivate func styleSegmentControl(segmentControl: UISegmentedControl) {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentTintColor = CoreColor.mySecondaryColor.color
        segmentControl.backgroundColor = .white
        segmentControl.backgroundColor = CoreColor.myPrimaryColor.color
        segmentControl.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        segmentControl.layer.shadowOffset = .init(width: 3, height: 3)
        segmentControl.layer.shadowOpacity = 0.4
        segmentControl.layer.shadowRadius = 10
        segmentControl.clipsToBounds = false
        segmentControl.layer.borderColor = UIColor.white.cgColor
        segmentControl.layer.borderWidth = 0.2
    }
}


