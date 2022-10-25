// FilmTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фильма экрана первого
final class FilmTableViewCell: UITableViewCell {
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var rateView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGreen
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var boxView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = UITableViewCell.SelectionStyle.none
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(data: FilmInfo) {
        nameLabel.text = data.title
        descriptionLabel.text = data.overview
        rateLabel.text = "\(data.rate)"
        filmImageView.loadImage(with: data.poster)
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(boxView)
        boxView.addSubview(nameLabel)
        boxView.addSubview(descriptionLabel)
        boxView.addSubview(filmImageView)
        filmImageView.addSubview(rateView)
        rateView.addSubview(rateLabel)
        createImageConstraint()
        createBoxViewConstraint()
        createNameLabelConstraint()
        createDescriptinConstraint()
        createRateViewConstraint()
        createRateLabelConstraint()
    }

    private func createBoxViewConstraint() {
        boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        boxView.heightAnchor.constraint(equalToConstant: filmImageView.bounds.height + 20).isActive = true
    }

    private func createImageConstraint() {
        filmImageView.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 0).isActive = true
        filmImageView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 0).isActive = true
        filmImageView.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 0).isActive = true
        filmImageView.widthAnchor.constraint(equalTo: filmImageView.heightAnchor, multiplier: 0.7).isActive = true
    }

    private func createNameLabelConstraint() {
        nameLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -20).isActive = true
    }

    private func createDescriptinConstraint() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -10).isActive = true
    }

    private func createRateViewConstraint() {
        rateView.leadingAnchor.constraint(equalTo: filmImageView.leadingAnchor, constant: -5).isActive = true
        rateView.topAnchor.constraint(equalTo: filmImageView.topAnchor, constant: -5).isActive = true
        rateView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        rateView.heightAnchor.constraint(equalTo: rateView.widthAnchor, multiplier: 0.8).isActive = true
    }

    private func createRateLabelConstraint() {
        rateLabel.centerYAnchor.constraint(equalTo: rateView.centerYAnchor, constant: 2.5).isActive = true
        rateLabel.centerXAnchor.constraint(equalTo: rateView.centerXAnchor, constant: 2.5).isActive = true
        rateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
