//
//  Posts.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/16/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation

public struct Posts: Decodable {
    public let userId: Int?
    public let id: Int?
    public let title: String?
    public let body: String?
    
}
