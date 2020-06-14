//
//  PersistenceService.swift
//  Quiz
//
//  Created by five on 13/06/2020.
//  Copyright © 2020 Ivana Mesic. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService{
    
    public init(){}
    
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QuizDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func saveQuizzes(quizzes: [Quiz?]){
        for q in quizzes{
            if !isQuizInCD(quiz: q!){
                saveOneQuizCD(q: q!)
            }
        }
        
    }
    
    static func isQuizInCD(quiz: Quiz)->Bool{
        
        var found=false
        let db = try PersistenceService.fetchQuizzes()
        db!.forEach{
            if Int32(quiz.id)==$0.id {
                found=true
            }
        }
        return found
    }
    
    static func saveOneQuizCD(q: Quiz){
        var questions: [QuestionCD] = []
        for j in q.questions{
            let qu = QuestionCD(j.id, j.questionText, j.correct_answer, j.answers[0], j.answers[1], j.answers[2], j.answers[3])
            questions.append(qu)
        }
        let quiz = QuizCD(context: PersistenceService.context)
        quiz.category = q.category.rawValue
        quiz.id = Int32(q.id)
        quiz.title = q.title
        quiz.quiz_description = q.description
        quiz.level = Int32(q.level)
        quiz.image = q.image
        quiz.questions = questions
        self.saveContext()
    }
    
    static func fetchQuizzes() -> [QuizCD]? {
        let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = PersistenceService.persistentContainer.viewContext
        let quizzes = try? context.fetch(request)
        return quizzes
    }
    
      
    static func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName=String(describing: objectType)
        let fetchRequest=NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchedObjects=try PersistenceService.context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }catch{
            return [T]()
        }
          
    }
    
    static func getQuizzesCD() -> [Quiz] {
        var quizzes=[Quiz]()
        let db=PersistenceService.fetchQuizzes()
        var qid: Int
        var qtitle: String
        var qdescription: String?
        var qcategory: String
        var qlevel: Int
        var qimage: String?
        var qquestions: [Question]=[]
        
        for quiz in db! {
            qid=Int(quiz.id)
            qimage=quiz.image
            qlevel=Int(quiz.level)
            qtitle=quiz.title!
            qdescription=quiz.quiz_description
            qcategory = quiz.category!
            for q in quiz.questions {
                qquestions.append(Question(id: Int(q.question_id), questionText: q.question_text, answers: [q.answer1,q.answer2,q.answer3,q.answer4], correctAnswer: Int(q.correct_question)))
            }
            print(qcategory)
            quizzes.append(Quiz(id: qid, title: qtitle, description: qdescription!, category: qcategory, level: qlevel, image: qimage!, questions: qquestions))
        }
        return quizzes
    }
}
