//
//  Apod.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 31/08/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import Foundation

// MARK: - Apod
struct Apod: Codable {
    let date, explanation: String
    // Tive que tirar a hdurl por causa do vídeo, que não tem
    // let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        // case hdurl
        case date, explanation
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
