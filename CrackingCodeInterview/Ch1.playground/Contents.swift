//: Playground - noun: a place where people can play

import UIKit
import Foundation

// HashTable

public struct HashTable<Key: Hashable, Value>{
    private typealias Element = (key: Key, value: Value)   //Element is a tuple with key and value
    private typealias Bucket = [Element]   //Each bucket contains several lists or Elements
    private var buckets: [Bucket] // The hash table in in fact an array of buckets
    
    private(set) public var count = 0   //create all properties of a HashTable
    public var isEmpty: Bool{ return count == 0}
    
    public init(capacity: Int){    //Constructor or initializer
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))  //Initialize all members with an empty array of Elements
    }
    
    
    //Helper methods for the HashTable
    
    //Find the index where it is contained a particular key
    private func index(forKey key: Key) -> Int{
        return abs(key.hashValue) % buckets.count
    }
    
    //Retrieve and object from the HashTable
    public func value(forKey key: Key) -> Value?{
        let index = self.index(forKey: key)   //get the index in array of buckets of where that specific key is stored
        for element in buckets[index]{
            if element.key == key{
                return element.value
            }
        }
        return nil
    }
    
    //update an element
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value?{
        let index = self.index(forKey: key)
        
        //DO we already have this key in the bucket?
        for (i, element) in buckets[index].enumerated(){
            if element.key == key{
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        
        //This key isn't in the bucket yet, then add it to the chain
        buckets[index].append(key: key, value: value)
        count += 1
        return nil
    }
    
    //Removing an element
    public mutating func removeValue(forKey key: Key) -> Value?{
        let index = self.index(forKey: key)
        
        //Find the element in the bucket's chain and remove it.
        for (i, element) in buckets[index].enumerated(){
            if element.key == key{
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        return nil
    }
    
    //Subscript function to perform the basic operations of a hash table, Insert, look up, update, remove
    
    public subscript(key: Key) -> Value? {
        get{
            return value(forKey: key)
        }
        set{
            if let value = newValue{
                updateValue(value, forKey: key)
            }else{
                removeValue(forKey: key)
            }
        }
    }
    
    
}


//Create HashTable with capacity of 5 buckets
var hashTable = HashTable<String, String>(capacity: 5)

hashTable["firstName"] = "Steve"  //insert
let x = hashTable["firstName"]    //lookup
hashTable["firstName"] = "Time"   //update
hashTable["firstName"] = nil      //remove


/***** QUESTIONS ********/

//1. Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

var givenString = "This"
var dict = [String:Int]()

for c in givenString.characters{
    
    
}





