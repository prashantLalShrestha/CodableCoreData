//
//  GetPosts.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/16/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation


public struct GetPosts: APIRequest {
    public typealias Response = [Posts]
    
    public var requestName: String {
        return WebService.posts
    }
}
