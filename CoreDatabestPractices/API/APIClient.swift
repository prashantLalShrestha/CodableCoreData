//
//  APIClient.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/16/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation
import CoreData

public class APIClient {
    private let baseEndpoint = WebService.url + "/"
    private let session = URLSession(configuration: .default)
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        let endPoint = self.endPoint(for: request)
        
        let task = session.dataTask(with: URLRequest(url: endPoint)) { data, response, error in
            if let data = data {
                do {
                    
//                    guard let contextKey = CodingUserInfoKey.context else { fatalError() }
//                    let contexxt = CoreDataStack.sharedInstance.persistentContainer.viewContext
//                    let decoder = JSONDecoder()
//                    decoder.userInfo[contextKey] = contexxt
//
//
//
//                    let res = try decoder.decode(T.Response.self, from: data)
//
//                    try contexxt.save()
                    
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func endPoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        
        return URL(string: "\(baseEndpoint)\(request.requestName)?params=\(parameters)")!
    }
}
