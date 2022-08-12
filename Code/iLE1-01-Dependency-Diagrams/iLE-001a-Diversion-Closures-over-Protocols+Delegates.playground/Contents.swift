import UIKit

var aString: String = "something"


// ()
func doSomething() {
    aString = "something else"
}

doSomething()

print("\(aString)")

// () -> Void
func doSomethingDifferently() -> Void {}

let b: () -> Void = {
    aString = "something funky"
}

b()
 
print("\(aString)")

// (Int) -> String
func doSomethingElse(_ value: Int) -> String {
    return "\(value)"
}

// Type signature: (Int) -> String
let a = doSomethingElse

a(1)

// or

let z: (Int) -> String = { value in
    "\(value)"
}

z(1)



protocol ViewControllerDelegate {
    func doSomething() -> Void
}

class AdapterOne: ViewControllerDelegate {
    func doSomething() {
        
    }
}

class AdapterTwo: ViewControllerDelegate {
    func doSomething() {
        
    }
}

class ViewControllerUsingProtocolAdapter: UIViewController {
    var adapter: ViewControllerDelegate?
}

let prVC = ViewControllerUsingProtocolAdapter()
let prAdapter = AdapterOne()

prVC.adapter = prAdapter


// The closure way

class VoidController: UIViewController {
    var doSomething: (() -> Void)?
    
    override func viewDidLoad() {
        doSomething?()
    }
}

class ClosureAdapterOne {
    func doSomething () { }
}

// try it out the closure way

let adapter = AdapterOne()
let controller = VoidController()

controller.doSomething = adapter.doSomething

class DGViewController: UIViewController {
    var delegate: Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.doSomething()
        title = delegate?.doSomethingElse()
    }
}

let adapter1 = AdapterOne()

// Delegate as a typealias for a tuple
// typealias Delegate = (doSomething: () -> Void, doSomethingElse: () -> Void)

// Delegate as a struct
struct Delegate {
    let doSomething: () -> Void
    let doSomethingElse: () -> String
}
