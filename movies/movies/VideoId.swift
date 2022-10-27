// VideoId.swift
// Copyright © RoadMap. All rights reserved.

import Foundation


/// Model
struct ResultVideos: Decodable {
    let results: [VideoId]
}

/// Model
struct VideoId: Decodable {
    let key: String
}
