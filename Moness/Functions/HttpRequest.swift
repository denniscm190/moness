//
//  HttpRequest.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import Foundation

// Network request
func httpRequest<T: Decodable>(url: String, model: T.Type, completion: @escaping (_ result: T) -> Void) {
    guard let url = URL(string: url) else {
        print("Invalid URL")
        return
    }
    
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            do {
                // Decode response with the model passed
                let decodedResponse = try JSONDecoder().decode(model, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse)
                }
                return
            } catch {
                // Return error regarding the escaping code
                print(error)
            }
        }
        // Error with the request
        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }
    .resume()
}
