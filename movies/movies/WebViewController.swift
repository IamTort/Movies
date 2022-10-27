// WebViewController.swift
// Copyright © RoadMap. All rights reserved.

//
//  WebViewController.swift
//  movies
//
//  Created by angelina on 27.10.2022.
//
import UIKit
import WebKit

/// Экран вебвью
class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.uiDelegate = self
        wv.navigationDelegate = self
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()

    private let service = Service()
    private var filmInfo: [VideoId]?
    var filmIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let index = filmIndex else { return }
        service.loadVideos(index: index) { result in

            guard result.count != 0,
                  let url = URL(string: "https://www.themoviedb.org/movie/\(index)#play=\(result[0].key)")
            else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
                return
            }
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))
            }
        }

        view.backgroundColor = .white

        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
