// Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    func loadImage(with url: String, placeHolder: UIImage? = nil) {
//        guard url != nil else { return }
        image = nil
        let iconUrl = "https://image.tmdb.org/t/p/w500\(url)"
        if let url = URL(string: iconUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async {
                    if let data = data {
                        if let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }
            }.resume()
        }
    }
}

extension NSMutableAttributedString {
    var fontSize: CGFloat {
        13
    }

    var boldFont: UIFont {
        UIFont.boldSystemFont(ofSize: fontSize)
    }

    var normalFont: UIFont {
        UIFont.systemFont(ofSize: fontSize)
    }

    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: UIColor.label
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir-Heavy", size: 24) as Any,
            .foregroundColor: UIColor.label
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normalGray(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Avenir-Heavy", size: 24) as Any,
            .foregroundColor: UIColor.secondaryLabel
        ]
        append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
