// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Контроллер экрана Фильмы
final class MoviesViewController: UIViewController {
    private enum Constants {
        static let popular = "Popular"
        static let topRated = "Top Rated"
        static let upcoming = "Upcoming"
        static let cellIdentifier = "cell"
        static let chevronLeftImageName = "chevron.left"
        static let chevronRightImageName = "chevron.right"
        static let movies = "Movies"
        static let page = "1"
    }

    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popular, for: .normal)
        button.backgroundColor = .systemGray
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 15
        button.tag = 0
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var topRatedButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.setTitle(Constants.topRated, for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var upcomingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upcoming, for: .normal)
        button.backgroundColor = .systemGray3
        button.tag = 2
        button.addTarget(self, action: #selector(updateTableView), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
    }()

    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.scalesLargeContentImage = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: Constants.chevronLeftImageName), for: .normal)
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.scalesLargeContentImage = true
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: Constants.chevronRightImageName), for: .normal)
        button.addTarget(self, action: #selector(changePage), for: .touchUpInside)
        return button
    }()

    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.text = "\(page)"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let service = Service()
    private var pageInfo: Int?
    private var films: [FilmInfo] = []
    private var page = 1

    lazy var closure: ((UIImage) -> ())? = { [weak self] image in
        self?.tableView.backgroundView = UIImageView(image: image)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.title = Constants.movies
        tableView.dataSource = self
        tableView.delegate = self
        service.loadFilms(page: 1, api: PurchaseEndPoint.popular) { [weak self] result in
            self?.films = result.results
            self?.pageInfo = result.pageCount
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(popularButton)
        view.addSubview(topRatedButton)
        view.addSubview(upcomingButton)
        view.addSubview(tableView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(pageLabel)
        createConstraint()
    }

    @objc private func changePage(sender: UIButton) {
        guard let pageInfo = pageInfo else { return }

        switch sender.tag {
        case 0:
            guard page > 1 else { return }
            page -= 1
        case 1:
            guard page < pageInfo else { return }
            page += 1
        default:
            break
        }
        pageLabel.text = "\(page)"
        service.loadFilms(page: page) { [weak self] result in
            self?.films = result.results
            self?.pageInfo = result.pageCount
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func createConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: popularButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),

            popularButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            popularButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            popularButton.heightAnchor.constraint(equalToConstant: 40),

            topRatedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topRatedButton.leadingAnchor.constraint(equalTo: popularButton.trailingAnchor, constant: 20),
            topRatedButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            topRatedButton.heightAnchor.constraint(equalToConstant: 40),

            upcomingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            upcomingButton.leadingAnchor.constraint(equalTo: topRatedButton.trailingAnchor, constant: 20),
            upcomingButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 80) / 3),
            upcomingButton.heightAnchor.constraint(equalToConstant: 40),

            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            leftButton.heightAnchor.constraint(equalToConstant: 40),

            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            rightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width - 160),
            rightButton.widthAnchor.constraint(equalToConstant: 40),
            rightButton.heightAnchor.constraint(equalToConstant: 40),

            pageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            pageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pageLabel.widthAnchor.constraint(equalToConstant: 40),
            pageLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func reloadButtons() {
        popularButton.backgroundColor = .systemGray3
        topRatedButton.backgroundColor = .systemGray3
        upcomingButton.backgroundColor = .systemGray3
    }

    @objc private func updateTableView(sender: UIButton) {
        reloadButtons()
        sender.backgroundColor = .systemGray
        var category: PurchaseEndPoint {
            switch sender.tag {
            case 0: return .popular
            case 1: return .topRated
            case 2: return .upcoming
            default:
                return .popular
            }
        }

        service.loadFilms(page: 1, api: category) { [weak self] result in
            self?.page = 1
            self?.pageInfo = result.pageCount
            self?.films = result.results
            DispatchQueue.main.async {
                self?.pageLabel.text = Constants.page
                self?.tableView.reloadData()
            }
        }
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? FilmTableViewCell {
            cell.setupData(data: films[indexPath.row])
//            cell.delegate = self
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let row = indexPath.row
        let fvc = FilmViewController()
        fvc.filmIndex = films[row].id
        navigationController?.pushViewController(fvc, animated: true)
    }
}

//
// extension MoviesViewController: ChangeBackgroundDelegate {
//    func changeBackground(image: UIImage) {
//        tableView.backgroundView = UIImageView(image: image)
//    }
// }
