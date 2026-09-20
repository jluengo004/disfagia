import UIKit

// MARK: - Tab Bar
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Inicio", image: UIImage(systemName: "house"), tag: 0)

        let treatmentsVC = UINavigationController(rootViewController: TreatmentsViewController())
        treatmentsVC.tabBarItem = UITabBarItem(title: "Tratamientos", image: UIImage(systemName: "pills"), tag: 1)

        let notificationsVC = UINavigationController(rootViewController: NotificacionesViewController())
        let nofiticationTab = UITabBarItem(title: "Notificaciones", image: UIImage(systemName: "bell"), tag: 2)
        nofiticationTab.badgeValue = "2"
        nofiticationTab.badgeColor = .red
        notificationsVC.tabBarItem = nofiticationTab    

        let newAppointmentVC = UINavigationController(rootViewController: PlaceholderViewController(title: "Nueva Cita"))
        newAppointmentVC.tabBarItem = UITabBarItem(title: "Nueva Cita", image: UIImage(systemName: "calendar.badge.plus"), tag: 3)

        viewControllers = [homeVC, treatmentsVC, notificationsVC, newAppointmentVC]
//        addTopBorderToTabBar()
    }
    
    func addTopBorderToTabBar() {
        let topLine = UIView(frame: CGRect(x: 0, y: -10, width: tabBar.frame.width, height: 1))
        topLine.backgroundColor = UIColor.gray
        topLine.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.addSubview(topLine)
    }
}

