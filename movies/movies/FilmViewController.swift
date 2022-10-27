// FilmViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// rjynhjkkth
class FilmViewController: UIViewController {
    var filmIndex: Int?
    private let service = Service()
    private var filmInfo: Film?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.clipsToBounds = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.font = UIFont(name: "Avenir-Oblique", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptinLabel: UILabel = {
        let label = UILabel()
        label.text = "Обзор"
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var webViewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(goWebViewAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var rightImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "right"))
        image.image?.withTintColor(.black, renderingMode: .alwaysTemplate)
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var trailerLabel: UIButton = {
        let label = UIButton(type: .custom)
        label.setTitle("Посмотреть трейлер", for: .normal)
        label.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 22)
        label.titleLabel?.textColor = .white
        label.addTarget(self, action: #selector(goWebViewAction), for: .touchUpInside)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(filmImageView)
        view.addSubview(scrollView)
        filmImageView.addSubview(webViewButton)
        filmImageView.addSubview(trailerLabel)
        scrollView.addSubview(boxView)
        boxView.addSubview(titleLabel)
        boxView.addSubview(starImageView)
        boxView.addSubview(rateLabel)
        boxView.addSubview(taglineLabel)
        boxView.addSubview(descriptinLabel)
        boxView.addSubview(descriptionLabel)
        boxView.addSubview(genresLabel)
        webViewButton.addSubview(rightImageView)
        createConstraint()
        guard let index = filmIndex else { return }
        service.loadFilm(index: index) { [weak self] result in
            self?.filmInfo = result
            DispatchQueue.main.async {
                self?.setupData(data: result)
            }
        }
    }

    private func createConstraint() {
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            filmImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            filmImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            filmImageView.heightAnchor.constraint(equalToConstant: 450),

            scrollView.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: -150),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            boxView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            boxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            boxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            boxView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
//            boxView.heightAnchor.constraint(equalToConstant: 1000),

            titleLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 80),

            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genresLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            genresLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),

            starImageView.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 15),
            starImageView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),

            rateLabel.bottomAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 2),
            rateLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 10),

            taglineLabel.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 15),
            taglineLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            taglineLabel.widthAnchor.constraint(equalTo: boxView.widthAnchor, constant: -40),

            descriptinLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 8),
            descriptinLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: descriptinLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -20),

            webViewButton.leadingAnchor.constraint(equalTo: filmImageView.leadingAnchor, constant: 10),
            webViewButton.topAnchor.constraint(equalTo: filmImageView.topAnchor, constant: 250),
            webViewButton.heightAnchor.constraint(equalToConstant: 40),
            webViewButton.widthAnchor.constraint(equalToConstant: 40),

            rightImageView.heightAnchor.constraint(equalToConstant: 20),
            rightImageView.widthAnchor.constraint(equalToConstant: 20),
            rightImageView.topAnchor.constraint(equalTo: webViewButton.topAnchor, constant: 10),
            rightImageView.leadingAnchor.constraint(equalTo: webViewButton.leadingAnchor, constant: 12),

            trailerLabel.leadingAnchor.constraint(equalTo: webViewButton.trailingAnchor, constant: 10),
            trailerLabel.bottomAnchor.constraint(equalTo: webViewButton.bottomAnchor, constant: 2)

        ])
    }

    private func setupData(data: Film) {
        filmImageView.loadImage(with: data.poster)
        titleLabel.attributedText = NSMutableAttributedString().normal("\(data.title) ")
            .normalGray("(\(data.release.prefix(4)))")
        rateLabel.text = "\(data.rate)/10 IMDb"
        taglineLabel.text = "\(data.tagline)"
        descriptionLabel.text = data.overview
        genresLabel.text = data.genres.map(\.name)
            .joined(separator: ", ") + " \u{2022} " + "\((data.runtime) / 60) ч \((data.runtime) % 60) мин"
    }

    @objc private func goWebViewAction() {
        let fvc = WebViewController()
        fvc.filmIndex = filmIndex
        present(fvc, animated: true)
    }
}
