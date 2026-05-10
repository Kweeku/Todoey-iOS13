//
//  Category.swift
//  Todoey
//
//  Created by Benedict Adu on 10/05/2026.
//  Copyright © 2026 App Brewery. All rights reserved.
//
// This is for Realm

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
