//
//  ViewController.swift
//  SwiftTest
//
//  Created by dongjl on 15/10/8.
//  Copyright © 2015年 djl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

@IBOutlet var numberButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "beginDragged:")
        self.view.addGestureRecognizer(panGestureRecognizer)
       
        basicTest()
        collectionTest()
        catchErrorTest()
    }
    
  @objc  private func beginDragged(gestureRecognizer: UIPanGestureRecognizer) {
        // ....
    }
    
    private func selectorTest() {
       print("test")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func basicTest() {
        /* 这是一个,
        多行注释 */
        var friendlyWelcome = "Hello!"
        friendlyWelcome = "Bonjour!"
        print("The current value of friendlyWelcome is \(friendlyWelcome)")
        let cat = "🐱"; print(cat)
        
        typealias AudioSample = UInt16
        let maxAmplitudeFound = AudioSample.min
         print("The current value of maxAmplitudeFound is \(maxAmplitudeFound)")
        
        
        let http404Error = (404, "Not Found")
         print("The current value of http404Error is \(http404Error)")
        
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")
        // 输出 "The status code is 404"
        print("The status message is \(statusMessage)")
        // 输出 "The status message is Not Found"
        let (justTheStatusCode, _) = http404Error
        print("The status code is \(justTheStatusCode)")
        // 输出 "The status code is 404"
        print("The status code is \(http404Error.0)")
        // 输出 "The status code is 404"
        print("The status message is \(http404Error.1)")
        // 输出 "The status message is Not Found"
        let http200Status = (statusCode: 200, description: "OK")
        print("The status code is \(http200Status.statusCode)")
        // 输出 "The status code is 200"
        print("The status message is \(http200Status.description)")
        // 输出 "The status message is OK"
        
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        // convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"
        
        var serverResponseCode: Int? = 404
        // serverResponseCode 包含一个可选的 Int 值 404
        serverResponseCode = nil
        // serverResponseCode 现在不包含值
        
        var surveyAnswer: String?
        // surveyAnswer 被自动设置为 nil
        //Swift 的nil和 Objective-C 中的nil并不一样。在 Objective-C 中，nil是一个指向不存在对象的指针。在 Swift 中，nil不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为nil，不只是对象类型。
        
        if convertedNumber != nil {
            print("convertedNumber contains some integer value.")
        }
        // 输出 "convertedNumber contains some integer value."
        
        //当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析（forced unwrapping）：
        
        if convertedNumber != nil {
            print("convertedNumber has an integer value of \(convertedNumber!).")
        }
        // 输出 "convertedNumber has an integer value of 123."
        
//        if let constantName = someOptional {
//            statements
//        }
        
        if let actualNumber = Int(possibleNumber) {
            print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
        } else {
            print("\'\(possibleNumber)\' could not be converted to an integer")
        }
        // 输出 "'123' has an integer value of 123"
        
        
        if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
            print("\(firstNumber) < \(secondNumber)")
        }
        // prints "4 < 42"
        
        
       // let defaultColorName = "red"
        //var userDefinedColorName: String?   //默认值为 nil
        
      //  var colorNameToUse = userDefinedColorName ?? defaultColorName
        // userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"
        
        for index in 1...5 {
            print("\(index) * 5 = \(index * 5)")
        }
        // 1 * 5 = 5
        // 2 * 5 = 10
        // 3 * 5 = 15
        // 4 * 5 = 20
        // 5 * 5 = 25
        
        //半开区间（a..<b）定义一个从a到b但不包括b的区间。
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            print("第 \(i + 1) 个人叫 \(names[i])")
        }
        // 第 1 个人叫 Anna
        // 第 2 个人叫 Alex
        // 第 3 个人叫 Brian
        // 第 4 个人叫 Jack
    }

    
    func stringTest() {
        let emptyString = ""               // 空字符串字面量
        var anotherEmptyString = String()  // 初始化方法
        // 两个字符串均为空并等价。
        
        
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        // 打印输出："Nothing to see here"
        
        
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString 现在为 "Horse and carriage"
        
//        let constantString = "Highlander"
//        constantString += " and another Highlander"
        // 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改。
        
        //Swift 的String类型是值类型
        
        for character in "Dog!🐶".characters {
            print(character)
        }
        // D
        // o
        // g
        // !
        // 🐶
        
       // let exclamationMark: Character = "!"
        
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        // 打印输出："Cat!🐱"
        
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2

        // welcome 现在等于 "hello there"
        var instruction = "look over"
        instruction += string2
        // instruction 现在等于 "look over there"
        
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)
        // welcome 现在等于 "hello there!"
        
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
//        
//        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
//        // "Imageination is more important than knowledge" - Enistein
//        let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
//        let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
//        let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496
        
        var word = "cafe"
        print("the number of characters in \(word) is \(word.characters.count)")
        // 打印输出 "the number of characters in cafe is 4"
        
        word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
        
        print("the number of characters in \(word) is \(word.characters.count)")
        // 打印输出 "the number of characters in café is 4"
        
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex]
        // G
        greeting[greeting.endIndex.predecessor()]//使用endIndex属性可以获取最后一个Character的后一个位置的索引
        // !
        greeting[greeting.startIndex.successor()]
        // u
        let index = greeting.startIndex.advancedBy(7)
        greeting[index]
        // a
        
        for index in greeting.characters.indices {
            print("\(greeting[index]) ", terminator: " ")
        }
        // 打印输出 "G u t e n   T a g !"
        
        var welcome1 = "hello"
        welcome1.insert("!", atIndex: welcome1.endIndex)
        // welcome now 现在等于 "hello!"
        welcome1.insertContentsOf(" there".characters, at: welcome1.endIndex.predecessor())
        // welcome 现在等于 "hello there!"
        
        welcome1.removeAtIndex(welcome.endIndex.predecessor())
        // welcome 现在等于 "hello there"
        
        let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
        welcome.removeRange(range)
        // welcome 现在等于 "hello"
        
        // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        
        // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal")
        }
        // 打印输出 "These two strings are considered equal"
        
       // 相反，英语中的LATIN CAPITAL LETTER A(U+0041，或者A)不等于俄语中的CYRILLIC CAPITAL LETTER A(U+0410，或者A)。两个字符看着是一样的，但却有不同的语言意义：
        
        let latinCapitalLetterA: Character = "\u{41}"
        
        let cyrillicCapitalLetterA: Character = "\u{0410}"
        
        if latinCapitalLetterA != cyrillicCapitalLetterA {
            print("These two characters are not equivalent")
        }
        // 打印 "These two characters are not equivalent"
        
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                ++act1SceneCount
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        // 打印输出 "There are 5 scenes in Act 1"
        
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion") {
                ++mansionCount
            } else if scene.hasSuffix("Friar Lawrence's cell") {
                ++cellCount
            }
        }
        print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
        // 打印输出 "6 mansion scenes; 2 cell scenes"
    }
    
    func collectionTest() {
        var someInts = [Int]()
        print("someInts is of type [Int] with \(someInts.count) items.")
        // 打印 "someInts is of type [Int] with 0 items."
        someInts.append(3)
        // someInts 现在包含一个 Int 值
        someInts = []
        // someInts 现在是空数组，但是仍然是 [Int] 类型的。
        
        let threeDoubles = [Double](count: 3, repeatedValue:0.0)
        // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
        
        let anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
        // anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
        
        var sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        
        var shoppingList: [String] = ["Eggs", "Milk"]
        // shoppingList 已经被构造并且拥有两个初始项。
        
        print("The shopping list contains \(shoppingList.count) items.")
        // 输出 "The shopping list contains 2 items."（这个数组有2个项）
        
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        // 打印 "The shopping list is not empty."（shoppinglist 不是空的）
        
        shoppingList.append("Flour")
        // shoppingList 现在有3个数据项，有人在摊煎饼
        
        shoppingList += ["Baking Powder"]
        // shoppingList 现在有四项了
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList 现在有七项了
        
       // var firstItem = shoppingList[0]
        // 第一项是 "Eggs"
        
        shoppingList[0] = "Six eggs"
        // 其中的第一项现在是 "Six eggs" 而不是 "Eggs"
        
        shoppingList[4...6] = ["Bananas", "Apples"]
        // shoppingList 现在有6项
        
        shoppingList.insert("Maple Syrup", atIndex: 0)
        // shoppingList 现在有7项
        // "Maple Syrup" 现在是这个列表中的第一项
        
        for (index, value) in shoppingList.enumerate() {
            print("Item \(String(index + 1)): \(value)")//// Item 1: Six eggs
        }
        
        var letters = Set<Character>()
        letters.insert("a")
        // letters 现在含有1个 Character 类型的值
        letters = []
        // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
        
       // var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        // favoriteGenres 被构造成含有三个初始值的集合
        
        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
        favoriteGenres.insert("Jazz")
        // favoriteGenres 现在包含4个元素
        
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // 打印 "Rock? I'm over it."
        
        for genre in favoriteGenres.sort() {
            print("\(genre)")
        }
        // prints "Classical"
        // prints "Hip hop"
        // prints "Jazz
        
        
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        houseAnimals.isSubsetOf(farmAnimals)
        // true
        farmAnimals.isSupersetOf(houseAnimals)
        // true
        farmAnimals.isDisjointWith(cityAnimals)
        // true
        
        var namesOfIntegers = [Int: String]()
        // namesOfIntegers 是一个空的 [Int: String] 字典
        
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        
        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        airports["LHR"] = "London"
        // airports 字典现在有三个数据项
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // 输出 "The old value for DUB was Dublin."
        
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        // 打印 "The name of the airport is Dublin Airport."
        
        airports["APL"] = "Apple Internation"
        // "Apple Internation" 不是真的 APL 机场, 删除它
        airports["APL"] = nil
        // APL 现在被移除了
        
        
        if let removedValue = airports.removeValueForKey("DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // prints "The removed airport's name is Dublin Airport."
        
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        // YYZ: Toronto Pearson
        // LHR: London Heathrow
        
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        // Airport code: YYZ
        // Airport code: LHR
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
        // Airport name: Toronto Pearson
        // Airport name: London Heathrow
        
       // let airportCodes = [String](airports.keys)
        // airportCodes 是 ["YYZ", "LHR"]
        
       // let airportNames = [String](airports.values)
        // airportNames 是 ["Toronto Pearson", "London Heathrow"]
    }
    
    func controlFlowTest() {
        let base = 3
        let power = 10
        var answer = 1
        //如果你不需要知道区间内每一项的值，你可以使用下划线（_）替代变量名来忽略对值的访问：
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // 输出 "3 to the power of 10 is 59049"
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        // Hello, Anna!
        // Hello, Alex!
        // Hello, Brian!
        // Hello, Jack!
        
        let someCharacter: Character = "e"
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        // 输出 "e is a vowel"
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        // 输出 "There are dozens of moons orbiting Saturn."
        
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        // 输出 "(1, 1) is inside the box"
        
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        // 输出 "on the x-axis with an x value of 2"
        
        
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        // 输出 "(1, -1) is on the line x == -y"
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough //fallthrough关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough简单地使代码执行继续连接到下一个 case 中的执行代码，这和 C 语言标准中的switch语句特性是一样的。
        default:
            description += " an integer."
        }
        print(description)
        // 输出 "The number 5 is a prime number, and also an integer."
        
        
        greet(["name": "John"])
        // prints "Hello John!"
        // prints "I hope the weather is nice near you."
        greet(["name": "Jane", "location": "Cupertino"])
        // prints "Hello Jane!"
        // prints "I hope the weather is nice in Cupertino."
        
        
        if #available(OSX 10.10, *) {
            // 在 iOS 使用 iOS 9 APIs , 并且在 OS X 使用 OS X v10.10 APIs
        } else {
            // 回滚至早前 iOS and OS X 的API
        }
    }
    
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        print("Hello \(name)")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        print("I hope the weather is nice in \(location).")
    }
    
    func funcTest() {
        let mathFunction: (Int, Int) -> Int = addTwoInts//定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数”。
        print(mathFunction(3, 5));
        printMathResult(addTwoInts, a: 3, b: 5)
        // prints "Result: 8"
        
        arithmeticMean(1, 2, 3, 4, 5)
        // returns 3.0, which is the arithmetic mean of these five numbers
        arithmeticMean(3, 8.25, 18.75)
        // returns 10.0, which is the arithmetic mean of these three numbers
        
        someFunction(6) // parameterWithDefault is 6
        someFunction() // parameterWithDefault is 12

        
        let bounds1 = minMax([8, -6, 2, 109, 3, 71])
        print("min is \(bounds1!.min) and max is \(bounds1!.max)")
        // prints "min is -6 and max is 109"
        
        print(sayHello(to: "Bill", and: "Ted"))
        // prints "Hello Bill and Ted!"
        
        let originalString = "hello"
        let paddedString = alignRight(originalString, totalLength: 10, pad: "-")
        // paddedString is equal to "-----hello"
        // originalString is still equal to "hello"
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        // prints "someInt is now 107, and anotherInt is now 3"
        
        someFunction2(1, 2)
        someFunction3(1, secondParameterName: 2)
    }
    
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
        return backwards ? stepBackward : stepForward
    }
    
    func addTwoInts(a: Int, _ b: Int) -> Int {
        return a + b
    }
    func multiplyTwoInts(a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    func printMathResult(mathFunction: (Int, Int) -> Int,  a: Int, b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    
    func arithmeticMean(numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func someFunction(parameterWithDefault: Int = 12) {
        // function body goes here
        // if no arguments are passed to the function call,
        // value of parameterWithDefault is 12
    }
    
//    func minMax(array: [Int]) -> (min: Int, max: Int) {
//        var currentMin = array[0]
//        var currentMax = array[0]
//        for value in array[1..<array.count] {
//            if value < currentMin {
//                currentMin = value
//            } else if value > currentMax {
//                currentMax = value
//            }
//        }
//        return (currentMin, currentMax)
//    }
    
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    func sayHello(to person: String, and anotherPerson: String) -> String {
        return "Hello \(person) and \(anotherPerson)!"
    }
    
    func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
        let amountToPad = totalLength - string.characters.count
        if amountToPad < 1 {
            return string
        }
        let padString = String(pad)
        for _ in 1...amountToPad {
            string = padString + string
        }
        return string
    }
    //如果你不想为第二个及后续的参数设置参数名，用一个下划线(_)代替一个明确地参数名。
    func someFunction2(firstParameterName: Int, _ secondParameterName: Int) {
        // function body goes here
        // firstParameterName and secondParameterName refer to
        // the argument values for the first and second parameters
    }
    
    
    func someFunction3(firstParameterName: Int, secondParameterName: Int) {
        // function body goes here
        // firstParameterName and secondParameterName refer to
        // the argument values for the first and second parameters
    }


    
    func swapTwoInts(inout a: Int, inout _ b: Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    ///////CLOSURE
    
//    { (parameters) -> returnType in
//    statements
//    }
    func closureTest() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var reversed = names.sort(backwards)
        // reversed 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
        print("\(reversed)");
        
        reversed = names.sort({ (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        
        reversed = names.sort( { s1, s2 in return s1 > s2 } )
        reversed = names.sort( { s1, s2 in s1 > s2 } )
        reversed = names.sort( { $0 > $1 } )
        reversed = names.sort(>)
        
    }
    func backwards(s1: String, s2: String) -> Bool {
        return s1 > s2
    }

    
    ////enum 
    func enumTest() {
        let somePlanet = Planet.Earth
        switch somePlanet {
        case .Earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
        // 输出 "Mostly harmless”
        
        var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
        
        switch productBarcode {
        case .UPCA(let numberSystem, let manufacturer, let product, let check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .QRCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
        
//        而在Swift中，要求枚举项的rawValue是唯一的，如果像下面这样写，则编译器会报错：
//        enum Type: UInt {
//            case In         = 0
//            case Out        = 1
//            case InOut      = 2
//            case Default    = 0      // Error: Raw value for enum case is not unique
//        }
        
        enum Type: UInt {
            case In         = 0
            case Out        = 1
            case InOut      = 2
            
            static var Default: Type {
                get {
                    return .In
                }
            }
        }
    }
    
    enum CompassPoint {
        case North
        case South
        case East
        case West
    }
    
    enum Planet {
        case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
    }
    
    enum Barcode {
        case UPCA(Int, Int, Int, Int)
        case QRCode(String)
    }
    
    enum VendingMachineError: ErrorType {
        case InvalidSelection
        case InsufficientFunds(required: Double)
        case OutOfStock
    }
    
    
    func catchErrorTest() {
        
        func willOnlyThrowIfTrue(value: Bool) throws {
            if value { throw VendingMachineError.InvalidSelection }
        }
        
        do {
            try willOnlyThrowIfTrue(false)
        } catch {
            print("Handle Error")
        }
        
        //try! willOnlyThrowIfTrue(true) //崩溃
    }
    
    
   
}

