import Foundation

let backgroundQueue = DispatchQueue(label: "com.dispatchworkitem.backgroundQueue", qos: .background, attributes: .concurrent)

var infinitePrintZero: DispatchWorkItem!

infinitePrintZero = DispatchWorkItem {
    while(true) {
        if infinitePrintZero.isCancelled { break }
        print(0)
    }
}
backgroundQueue.async(execute: infinitePrintZero)

backgroundQueue.asyncAfter(deadline: DispatchTime.now() + 2.0) {
    print("Была отмена")
    infinitePrintZero.cancel()
}
