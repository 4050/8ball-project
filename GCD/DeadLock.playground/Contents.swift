import Foundation

let firstQueue = DispatchQueue(label: "com.deadlock.firstQueue")
let secondQueue = DispatchQueue(label: "com.deadlock.secondQueue")

firstQueue.async {
    print("Первый поток - пошел")
        secondQueue.sync {
            print("Второй поток - пошел")
                print("Дедлок близко")
                    firstQueue.sync {
                        print("АААА ДЕДЛОК АААА")
        }
    }
}
