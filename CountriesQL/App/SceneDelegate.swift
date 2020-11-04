import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        
        let router = AppRouter(navigationController: navigationController)
        
        let appCoordinator = AppCoordinator(router: router)
        self.appCoordinator = appCoordinator
        
        appCoordinator.start()

        window.makeKeyAndVisible()
    }
}

