//
//  FirebaseDataHandler.swift
//  CMUPoll
//
//  Created by Sung on 10/24/19.
//  Copyright © 2019 67442. All rights reserved.
//
import Foundation
import Firebase

typealias FirebaseData = [String:Any]

class FirebaseDataHandler {
  static let db = Firestore.firestore()
  
  static func colRef(collection: Collection) -> CollectionReference {
    return db.collection(collection.rawValue)
  }
  
  static func docRef(collection: Collection, documentId: String) -> DocumentReference {
    return colRef(collection: collection).document(documentId)
  }

  // CREATE
  static func add(colRef: CollectionReference, data: FirebaseData, completion: @escaping (String) -> ()) {
    var ref: DocumentReference? = nil
    ref = colRef.addDocument(data: data) { err in
      if let err = err {
        return
      } else {
        completion(ref!.documentID)
      }
    }
  }
  
  // READ
//  Usage(1): Normal get
//  let colRef = FirebaseDataHandler.colRef(collection: .poll)
//    FirebaseDataHandler.get(colRef: colRef, completion: { data in
//    print(data)
//  })
  
//  Usage(2): Conditional get
//  let query = FirebaseDataHandler.colRef(collection: .like).whereField("poll_id", isEqualTo: id)
//  FirebaseDataHandler.get(query: query, completion: { data in
//    let instances = ModelParser.parse(collection: .like, data: data)
//    print(instances.count)
//  })
  static func get(colRef: CollectionReference, completion: @escaping ([FirebaseData]) -> ()) {
    var data: [FirebaseData] = []
    
    colRef.getDocuments() { (querySnapshot, err) in
      if let err = err {
        completion(data)
      } else {
        for document in querySnapshot!.documents {
          // Include document ID as "id" in document data
          var documentData: FirebaseData = document.data()
          documentData["id"] = document.documentID
          data.append(documentData)
        }
        completion(data)
      }
    }
  }
  
  static func get(docRef: DocumentReference, completion: @escaping ([FirebaseData]) -> ()) {
    var data: [FirebaseData] = []
    
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        // Include document ID as "id" in document data
        var documentData: FirebaseData = document.data()!
        documentData["id"] = document.documentID
        data.append(documentData)
      }
      completion(data)
    }
  }
  
  static func get(query: Query, completion: @escaping ([FirebaseData]) -> ()) {
    var data: [FirebaseData] = []
    
    query.getDocuments() { (querySnapshot, err) in
      if let err = err {
        completion(data)
      } else {
        for document in querySnapshot!.documents {
          // Include document ID as "id" in document data
          var documentData: FirebaseData = document.data()
          documentData["id"] = document.documentID
          data.append(documentData)
        }
        completion(data)
      }
    }
  }

  // UPDATE
  static func update(docRef: DocumentReference, data: FirebaseData, completion: @escaping () -> Void) {
    docRef.updateData(data) { err in
      if let err = err {
        return
      } else {
        completion()
      }
    }
  }

  // DELETE
  static func delete(docRef: DocumentReference, completion: @escaping () -> Void) {
    docRef.delete() { err in
      if let err = err {
        return
      } else {
        completion()
      }
    }
  }
}
