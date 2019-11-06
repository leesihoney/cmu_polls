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
    return FirebaseDataHandler.db.collection(collection.rawValue)
  }
  
  static func docRef(collection: Collection, documentId: String) -> DocumentReference {
    return colRef(collection: collection).document(documentId)
  }

  // CREATE
  static func add(colRef: CollectionReference, data: FirebaseData, completion: @escaping (String) -> ()) {
    var ref: DocumentReference? = nil
    ref = colRef.addDocument(data: data) { err in
      if let err = err {
        print("Error adding document: \(err)")
      } else {
        print("Document added with ID: \(ref!.documentID)")
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
  static func get(colRef: CollectionReference, completion: @escaping (FirebaseData) -> ()) {
    var data: FirebaseData = [:]
    
    colRef.getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          data[document.documentID] = document.data()
        }
      }
      completion(data)
    }
  }
  
  static func get(query: Query, completion: @escaping (FirebaseData) -> ()) {
    var data: FirebaseData = [:]
    
    query.getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          data[document.documentID] = document.data()
        }
      }
      completion(data)
    }
  }

  // UPDATE
  static func update(docRef: DocumentReference, data: FirebaseData) {
    docRef.updateData(data) { err in
      if let err = err {
        print("Error updating document: \(err)")
      } else {
        print("Document successfully updated")
      }
    }
  }

  // DELETE
  static func delete(docRef: DocumentReference) {
    docRef.delete() { err in
      if let err = err {
        print("Error removing document: \(err)")
      } else {
        print("Document successfully removed!")
      }
    }
  }
}
