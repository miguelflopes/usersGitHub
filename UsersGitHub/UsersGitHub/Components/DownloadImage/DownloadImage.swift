//
//  DownloadImage.swift
//  UsersGitHub
//
//  Created by Miguel on 16/05/23.
//

import UIKit

// MARK: - DownloadImage

class DownloadImage {
    func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }
            
            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }
                
                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )
                
                completion(nil)
            }
            catch _ {
                completion(error)
            }
        }
        task.resume()
    }
    
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        
        // load the image from the cache and exit
        if let data = try? Data(contentsOf: fileCachePath) {
            completion(data, nil)
            return
        }
        
        // download the image to the cache
        download(url: url, toFile: fileCachePath) { (error) in
            let data = try? Data(contentsOf: fileCachePath)
            completion(data, error)
        }
    }
}
