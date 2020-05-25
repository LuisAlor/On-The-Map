//
//  UdacityClient.swift
//  On The Map
//
//  Created by Luis Vazquez on 25.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

class UdacityClient {
    
    struct Auth {
        static var sessionId = ""
    }
    
    enum Endpoints {
        
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case login
        
        var stringURL: String {
            switch self {
            case .login:
                return Endpoints.base + "session"
            }
        }
        
        var url: URL {
            return URL(string: stringURL)!
        }
        
    }
    
    class func removeSecurityChars(_ data: Data) -> Data{
        let range = 5..<data.count
        let data = data.subdata(in: range)
        return data
    }
    
    class func sendPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, body: RequestType, response:ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?)-> Void ){
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        do{
            request.httpBody = try encoder.encode(body)
        }
        catch {
            completionHandler(nil, error)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            let filteredData = removeSecurityChars(data)
            
            let decoder = JSONDecoder()
            do {
                let responseAPI = try decoder.decode(ResponseType.self, from: filteredData)
                DispatchQueue.main.async {
                    completionHandler(responseAPI, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        
        let body = LoginRequest(udacity: Udacity(username: username, password: password))
        sendPOSTRequest(url: UdacityClient.Endpoints.login.url, body: body, response: LoginResponse.self) { (response, error) in
            if let response = response {
                Auth.sessionId = response.session.id
                completionHandler(true,nil)
            } else {
                completionHandler(false,error)
            }
        }
    }
    
}
