import UIKit

struct Notificacion {
    var fecha: String
    var texto: String
    var tieneAdjunto: Bool
    var visualizada: Bool
    var detalles: String?
    var detallesExtra: NSMutableAttributedString?
    var isExpanded: Bool = false
}

class NotificacionesViewController: UIViewController,
                                    UITableViewDataSource,
                                    UITableViewDelegate,
                                    FormularioDelegate,
                                    NotificacionCellDelegate {
    private let tableView = UITableView()
    
    private var notificaciones: [Notificacion] = []
    private var notiCuestionario = Notificacion(fecha: "09-JUN-2025", texto: "Recordatorio invitación al programa de cribado de disfagia", tieneAdjunto: true, visualizada: false, detalles: """
              El Departamento de Salud del Gobierno Vasco y Osakidetza le invita a participar en el Programa de Detección Precoz de Disfagia de Osakidetza que está dirigido a todas las personas mayores de 65 años.
              
              Detectar y tratar la disfagia a tiempo, es crucial para evitar complicaciones graves.

              No hay mejor herramienta a nuestra disposición en el cuidado de la salud que la prevención. Para ello, por favor, rellene el siguiente cuestionario.
              
              Confiamos que esta propuesta de su interés y considere su participación.
              
              Reciba un cordial saludo.
              """)
    private var notiPega = Notificacion(fecha: "02-JUN-2025", texto: "Invitación al programa de cribado de disfagia", tieneAdjunto: true, visualizada: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    func didSubmitFormulario() {
        let detalleExtra = """
            Desde el Programa de detección precoz de disfagia de Osakidetza le comunicamos que el resultado de la prueba de cribado ha sido de alto riesgo, por lo que procede realizarle un seguimiento y tratamiento a partir de ahora. 
            
            Para ello, se le ha añadido en el apartado de Tratamientos una sección dedicada a la disfagia en la que encontrará información relevante, ejercicios de ayuda, recomendaciones y podra exponer sus dudas ya que contará con la ayuda de expertosque le ayudarán durante su tratamiento.
            Además se le ha concertado una cita con su enfermero y una videconferencia posterior.
            
            Agradecemos su participación en este programa preventivo.
                          
            Reciba un cordial saludo.
            """
        let attributed = NSMutableAttributedString(string: detalleExtra)
        if let range = detalleExtra.range(of: "Tratamientos") {
            let nsRange = NSRange(range, in: detalleExtra)
            attributed.addAttribute(.link, value: "app://goToTratamientos", range: nsRange)
        }
        attributed.addAttributes([
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.darkGray
        ], range: NSRange(location: 0, length: detalleExtra.count))

        let nueva = Notificacion(
            fecha: "09-JUN-2025",
            texto: "Resultado de la prueba de cribado: Alto riesgo, tratamiento abierto y cita con el enfermero programada",
            tieneAdjunto: false,
            visualizada: false,
            detallesExtra: attributed
        )
        notificaciones.insert(nueva, at: 0)
        if let tabItems = tabBarController?.tabBar.items {
            let citasTabs = tabItems[3]
            citasTabs.badgeValue = "1"
            citasTabs.badgeColor = .systemRed
            let notisTab = tabItems[2]
            notisTab.badgeValue = "2"
            notisTab.badgeColor = .systemRed
        }

        tableView.reloadData()
    }

    
    private func setupView() {
        notificaciones = [notiCuestionario, notiPega]
        self.navigationController?.isNavigationBarHidden = true
        let navbar = createCustomNavbar(back: false)
        view.addSubview(navbar)
        navbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navbar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotificacionCell.self, forCellReuseIdentifier: "NotificacionCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "app://goToTratamientos" {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 1 // Índice del tab "Tratamientos"
            }
            return false // no abrir en Safari
        }
        return true
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificacionCell", for: indexPath) as! NotificacionCell
        let noti = notificaciones[indexPath.row]
        cell.configure(with: noti)
        cell.delegate = self
        if noti.texto == "Recordatorio invitación al programa de cribado de disfagia" {
            cell.infoAdicionalCallback = { [weak self] in
                let formularioVC = FormularioViewController()
                formularioVC.delegate = self
                let navVC = UINavigationController(rootViewController: formularioVC)
                self?.present(navVC, animated: true)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notificaciones[indexPath.row].visualizada = true
        let noti = notificaciones[indexPath.row]
        if let tabItems = tabBarController?.tabBar.items {
            let notiTabs = tabItems[2]
            notiTabs.badgeValue = "1"
            notiTabs.badgeColor = .systemRed
        }
        
        if noti.detalles != nil || noti.detallesExtra != nil {
            notificaciones[indexPath.row].isExpanded.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func navigateToTratamientos() {
        // Aquí haces la navegación
        self.tabBarController?.selectedIndex = 1
    }
}
