//
//  Character+CoreDataProperties.swift
//  prueba-ios
//
//  Created by Guille on 8/1/23.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var created: String?
    @NSManaged public var url: String?
    @NSManaged public var episode: [String]?
    @NSManaged public var image: String?
    @NSManaged public var gender: String?
    @NSManaged public var type: String?
    @NSManaged public var species: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var originName: String?
    @NSManaged public var locationName: String?
    @NSManaged public var status: String?
    @NSManaged public var originUrl: String?
    @NSManaged public var locationUrl: String?

}

extension Character : Identifiable {

}
