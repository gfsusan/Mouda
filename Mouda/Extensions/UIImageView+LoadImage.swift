//
//  UIImageView+LoadImage.swift
//  Mouda
//
//  Created by Susan Kim on 01/07/2019.
//  Copyright © 2019 cauadc. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingUrlString(imageUrl: String) {
        guard let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                
                guard let imageToChache = UIImage(data: data!) else { return }
                
                imageCache.setObject(imageToChache, forKey: urlString as AnyObject)
                
                self.image = imageToChache
            }
            }.resume()
    }
}
