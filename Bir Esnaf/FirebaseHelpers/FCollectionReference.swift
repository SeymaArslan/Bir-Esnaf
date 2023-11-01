//
//  FCollectionReference.swift
//  Bir Esnaf
//
//  Created by Seyma on 31.10.2023.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Recent
}

func FirebaseReference(_ collectionReference: String) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
