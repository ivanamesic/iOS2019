//
//  QuizCD+CoreDataProperties.swift
//  Quiz
//
//  Created by five on 14/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//
//

import Foundation
import CoreData


extension QuizCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizCD> {
        return NSFetchRequest<QuizCD>(entityName: "QuizCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var quiz_description: String?
    @NSManaged public var questions: [QuestionCD]
    @NSManaged public var image: String?
    @NSManaged public var level: Int32
    @NSManaged public var category: String?

}
