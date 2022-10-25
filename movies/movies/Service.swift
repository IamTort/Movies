// Service.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// enum
enum MovieRequestTypes: String {
    case popular = "/3/movie/popular"
    case topRated = "/3/movie/top_rated"
    case upcoming = "/3/movie/upcoming"
}

/// Класс, отвечающий за загрузку даннных с сервера на контроллер "Фильмы"
final class Service {
    // создаем сессию, выполняется только при вызове
    private lazy var session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()

    private let apiKey = "a5b0bb6ebe58602d88ccf2463076122b"
    private var category = MovieRequestTypes.popular

    func loadFilms(page: Int, completion: @escaping (Result) -> Void) {
        loadFilms(page: page, api: category, completion: completion)
    }

    // метод для загрузки данных, с замыканием
    func loadFilms(page: Int, api: MovieRequestTypes, completion: @escaping (Result) -> Void) {
        category = api

        let queryItemKey = URLQueryItem(name: "api_key", value: apiKey)
        let queryItemLanguage = URLQueryItem(name: "language", value: "ru-Ru")
        let queryItemPage = URLQueryItem(name: "page", value: "\(page)")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = api.rawValue
        components.queryItems = [queryItemKey, queryItemLanguage, queryItemPage]
        guard let url = components.url else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            // десериализируем данные и закидываем в модель
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
