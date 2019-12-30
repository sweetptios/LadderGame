
import UIKit
import LadderGameLibrary

/**
 * @brief iOS 앱은 viper로 구현. viper에서 Clean Architecture를 따르지 않은 부분을 개선했다(컴포넌트 레벨에 DIP 적용)
 * @details
 * @param
 * @return
 */

//MARK: - Interface Adapter layer

public protocol LadderGamePresenterProtocol: LadderMakerOutputBoundary {
    func set(_ view: LadderGameView, _ inputBoundary: LadderMakerInputBoundary)
    func set(_ wireframe: LadderGameWireframe)
    
    func buildLadderMatrix(height: String, names: String)
}

public class LadderGamePresenter: LadderGamePresenterProtocol {
    private weak var view: LadderGameView!
    private var inputBoundary: LadderMakerInputBoundary!
    private var wireframe: LadderGameWireframe!
    
    public func set(_ view: LadderGameView, _ inputBoundary: LadderMakerInputBoundary) {
        self.view = view
        self.inputBoundary = inputBoundary
    }
    public func set(_ wireframe: LadderGameWireframe) {
        self.wireframe = wireframe
    }
    
    // Interactor -> view
    public func displayLadderMatrix(_ data: LadderMatrix) {
        view.displayLadderMatrix(data)
    }
    
    // view -> interactor
    public func buildLadderMatrix(height: String, names: String) {
        let _height = Int(height) ?? 0
        let list = names.split(separator: ",").map{String($0)}
        let players = list.map({LadderPlayer(name:$0)})
        inputBoundary.buildLadderMatrix(height: _height, players: players)
    }
}

public protocol LadderGameView: AnyObject {
    func set(_ presenter: LadderGamePresenterProtocol)
    
    func displayLadderMatrix(_ ladder: LadderMatrix?)
}

struct DisplayedLadderMatrix {

    private static let room = CGSize(width: 60, height: 30)
    private static let start = CGPoint(x: 40, y: 40)
    
    static func build(from matrix: LadderMatrix) -> UIBezierPath {
        return makeLadderPath(matrix)
    }
    
    private static func makeLadderPath(_ matrix: LadderMatrix) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = 1.0
        let size = matrix.size()
        for i in 0 ..< size.height {
            let from = CGPoint(x:start.x,y:start.y + CGFloat(i)*room.height)
            for j in 0 ..< size.width {
                let value = matrix[i,j]
                addRoom(from: CGPoint(x:from.x + CGFloat(j)*room.width, y:from.y), in:path, using: value)
            }
            addRoom(from: CGPoint(x:from.x + CGFloat(size.width)*room.width, y:from.y), in: path, using: false)
        }
        path.close()
        return path
    }
    
    private static func addRoom(from: CGPoint, in path: UIBezierPath, using value: Bool) {
        path.move(to: from)
        path.addLine(to: CGPoint(x:from.x, y: from.y + room.height))
        if value {
            let mid: CGFloat = room.height / 2.0
            path.move(to: CGPoint(x: from.x, y: from.y + mid))
            path.addLine(to: CGPoint(x:from.x + room.width, y: from.y + mid))
        }
    }
}

public protocol LadderGameWireframe: AnyObject {
    func set(_ view: LadderGameView)
    static func createModule() -> UIViewController
}


//MARK: - Main Component

class UILadderGameWireframe: LadderGameWireframe {
    weak var view: LadderGameView!
    
    func set(_ view: LadderGameView) {
        self.view = view
    }
    
    static func createModule() -> UIViewController {
        let view = LadderGameViewController()
        let wireframe = UILadderGameWireframe()
        let presenter = LadderGamePresenter()
        let interactor = LadderMakerInteractor()
        
        presenter.set(view,interactor)
        presenter.set(wireframe)
        wireframe.set(view)
        view.set(presenter)
        interactor.set(presenter)
        return view
    }
}
    
