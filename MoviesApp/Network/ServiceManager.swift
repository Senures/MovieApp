//
//  ServiceManager.swift
//  MoviesApp
//
//  Created by Süha Karakaya on 7.04.2023.
//

import Foundation
import Alamofire

final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    func fetch<T>(path: URL, onSuccess: @escaping (T) -> ()) where T: Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of : T.self) { response in
            guard let model = response.value else {print(response.error as? Any); return }
            onSuccess(model)
        }
    }
}
