//
//  Post+CoreDataClass.swift
//  CoreDatabestPractices
//
//  Created by Inficare Pvt. Ltd. on 18/06/2018.
//  Copyright © 2018 Prashant. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject, Codable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case body
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context else { fatalError() }
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Post", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)!
        self.userId = try container.decodeIfPresent(Int64.self, forKey: .userId)!
        self.title = try container.decodeIfPresent(String.self, forKey: .title)!
        self.body = try container.decodeIfPresent(String.self, forKey: .body)!
    }
    
    // Encodable requirement
    public func encode(to encoder: Encoder) throws {
        
        // We only encode id... excludedBool knows what it did....
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
    }
}


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
