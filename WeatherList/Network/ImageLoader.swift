//
//  ImageLoader.swift
//  WeatherList
//
//  Created by 고정근 on 2022/04/19.
//

import Foundation
import UIKit

enum ImageLoaderError: Error {
    case unknown
    case invalidURL
}

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

struct ImageLoader {
    let url: String
    
    func load(completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void) {
        
        let cacheKey = NSString(string: self.url)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            completion(.success(cachedImage))
        }
        
        if let url = URL(string: self.url) {

            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.global().async {
                    guard (response as? HTTPURLResponse)?.statusCode == 200,
                          error == nil,
                          let data = data,
                          let image = UIImage(data: data) else {
                        completion(.failure(.unknown))
                        return
                    }
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        completion(.success(image))
                    }
                }
            }.resume()
        } else {
            completion(.failure(.invalidURL))
        }
    }
}
