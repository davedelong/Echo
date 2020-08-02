//
//  StoredPropertyIteration.swift
//  Echo
//
//  Created by Alejandro Alonso
//  Copyright © 2020 Alejandro Alonso. All rights reserved.
//

import Echo

public enum Reflection {}

extension Reflection {
  public static func allStoredPropertyKeyPaths<T>(for type: T.Type)
    -> [PartialKeyPath<T>]
  {
    guard let metadata = reflect(type) as? TypeMetadata,
      metadata.kind == .struct || metadata.kind == .class
    else {
      return []
    }

    var result = [PartialKeyPath<T>]()

    for i in 0..<metadata.contextDescriptor.fields.records.count {
      let kp = createKeyPath(root: metadata, leaf: i) as! PartialKeyPath<T>
      result.append(kp)
    }

    return result
  }

  public static func allNamedStoredPropertyKeyPaths<T>(
    for type: T.Type
  ) -> [(name: String, keyPath: PartialKeyPath<T>)] {
    guard let metadata = reflect(type) as? TypeMetadata,
      metadata.kind == .struct || metadata.kind == .class
    else {
      return []
    }

    var result = [(name: String, keyPath: PartialKeyPath<T>)]()

    for i in 0..<metadata.contextDescriptor.fields.records.count {
      let kp = createKeyPath(root: metadata, leaf: i) as! PartialKeyPath<T>
      result.append((metadata.contextDescriptor.fields.records[i].name, kp))
    }

    return result
  }
    
    @_disfavoredOverload
  public static func allNamedStoredPropertyKeyPaths(
    for type: Any.Type
  ) -> [(name: String, keyPath: AnyKeyPath)] {
    guard let metadata = reflect(type) as? TypeMetadata,
      metadata.kind == .struct || metadata.kind == .class
    else {
      return []
    }

    var result = [(name: String, keyPath: AnyKeyPath)]()

    for i in 0..<metadata.contextDescriptor.fields.records.count {
      let kp = createKeyPath(root: metadata, leaf: i)
      result.append((metadata.contextDescriptor.fields.records[i].name, kp))
    }

    return result
  }
}
