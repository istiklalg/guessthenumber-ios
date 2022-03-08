//
//  MachineNumberGenerator.swift
//  guessthenumber
//
//  Created by istiklal on 4.03.2022.
//


import Foundation

class MachineNumberGenerator {
    
    
    public static func pickNumber() -> [Int] {
        var numbers = [0,1,2,3,4,5,6,7,8,9]
        var generated_number = [Int]()
        
        func add_digit(digit : Int) {
            generated_number.append(digit)
            numbers.removeAll(where: { $0 == digit })
        }
        
        let first_digit = Int.random(in: 1...9)
        add_digit(digit: first_digit)
        
        for _ in 1...3 {
            let digit = numbers.randomElement()! as Int
            add_digit(digit: digit)
        }
        
        print("istiklal [MachineNumberGenerator.pickNumber] ", " \(generated_number) is picked by machine, you will be trying to guess that")
        return generated_number
        
    }
    
}
