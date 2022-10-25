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
