//
//  HTTPDownloader.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/7/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation


class HttpDownloader {
    
    class func loadFileSync(_ name:String, url: URL, completion:( _ path:String, _ error:NSError?) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let destinationUrl = documentsUrl.appendingPathComponent(name)
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("file already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        } else if let dataFromURL = try? Data(contentsOf: url){
            if (try? dataFromURL.write(to: destinationUrl, options: [.atomic])) != nil {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            } else {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        } else {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    
    class func loadFileAsync(_ name:String,url: URL, completion:@escaping (_ path:String, _ error:NSError?) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        let destinationUrl = documentsUrl.appendingPathComponent(name)
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("file already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        } else {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if (error == nil) {
                    if let response = response as? HTTPURLResponse {
                        print("response=\(response)")
                        if response.statusCode == 200 {
                            if (try? data!.write(to: destinationUrl, options: [.atomic])) != nil {
                                print("file saved [\(destinationUrl.path)]")
                                completion(destinationUrl.path, error as NSError?)
                            } else {
                                print("error saving file")
                                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else {
                    print("Failure: \(error!.localizedDescription)");
                    completion(destinationUrl.path, error as NSError?)
                }
            })
            
            
            task.resume()
        }
    }
}
