//
//  ImageDownloader.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import Foundation
import UIKit

//MARK:  Image Downloader Class Declaration
/// Used to Download image from given url and save the image in cache for further use
class ImgDownloader {
    
    var task : URLSessionDataTask? = URLSessionDataTask()
    var session : URLSession? = URLSession.shared
    var cache : NSCache<NSString, UIImage>? = NSCache()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    ///get image data for path
    func getDownloadImage(path: String, completion: @escaping ((Data?) -> ())) {
        guard let url = URL(string: path) else {completion(nil);return}
        task = session?.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                completion(data)
            }
        })
        task?.resume()
    }
    /// get image from cache if available else  download
    func getImageForPath(path: String, completion: @escaping ((UIImage?) -> ())) {
        if let image = self.cache?.object(forKey: path as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            getDownloadImage(path: path, completion: { (data) in
                guard let imageData = data else {completion(nil);return}
                guard let image = UIImage(data: imageData) else {completion(nil);return}
                self.cache?.setObject(image, forKey: path as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            })
            
        }
    }
}
