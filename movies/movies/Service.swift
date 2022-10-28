// Service.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// enum
enum PurchaseEndPoint: String {
    case popular = "/3/movie/popular"
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
}

/// Класс, отвечающий за загрузку даннных с сервера
final class Service {
    // MARK: - Private Enum

    private enum Constants {
        static let queryItemKeyName = "api_key"
        static let apiValueKeyName = "apiKey"
        static let queryItemLanguageName = "language"
        static let queryItemLanguageValue = "ru-Ru"
        static let queryItemPageName = "page"
        static let componentScheme = "https"
        static let componentsHost = "api.themoviedb.org"
        static let componentsPath = "/3/movie/"
        static let videos = "/videos"
    }

    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()

    private let queryItemKey = URLQueryItem(
        name: Constants.queryItemKeyName,
        value: UserDefaults.standard.string(forKey: Constants.apiValueKeyName)
    )
    private let queryItemLanguage = URLQueryItem(
        name: Constants.queryItemLanguageName,
        value: Constants.queryItemLanguageValue
    )
    private var category = PurchaseEndPoint.popular

    func loadFilms(page: Int, completion: @escaping (Result) -> Void) {
        loadFilms(page: page, api: category, completion: completion)
    }

    func loadFilms(page: Int, api: PurchaseEndPoint, completion: @escaping (Result) -> Void) {
        category = api

        let queryItemPage = URLQueryItem(name: Constants.queryItemPageName, value: "\(page)")

        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = api.rawValue
        components.queryItems = [queryItemKey, queryItemLanguage, queryItemPage]
        guard let url = components.url else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func loadFilm(index: Int, completion: @escaping (Film) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = Constants.componentsPath + "\(index)"
        components.queryItems = [queryItemKey, queryItemLanguage]

        guard let url = components.url else { return }
        print(url)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Film.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func loadVideos(index: Int, completion: @escaping ([VideoId]) -> Void) {
        var components = URLComponents()
        components.scheme = Constants.componentScheme
        components.host = Constants.componentsHost
        components.path = Constants.componentsPath + "\(index)" + Constants.videos
        components.queryItems = [queryItemKey, queryItemLanguage]

        guard let url = components.url else { return }
        print(url)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(ResultVideos.self, from: data)
                completion(result.results)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
