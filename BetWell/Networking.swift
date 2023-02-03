//
//  Networking.swift
//  BetWell
//
//  Created by David Mann on 2/3/23.
//

import Foundation

class Networking {
    
    
    func getTodaysGame() {
        let headers = [
            "X-RapidAPI-Key": "c9a3999ce2msh1deb5d6547573bep1ae92ejsn3a046fff7ce0",
            "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api-nba-v1.p.rapidapi.com/seasons")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
}

