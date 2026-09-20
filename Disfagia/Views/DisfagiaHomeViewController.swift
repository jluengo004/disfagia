import UIKit
class DisfagiaHomeViewController: UIViewController {
    private let tableView = UITableView()

    struct Opcion {
        let icon: String
        let titulo: String
        let subtitulo: String?
        let habilitado: Bool
    }

    private let opciones: [Opcion] = [
        Opcion(icon: "info.circle", titulo: "Información", subtitulo: nil, habilitado: true),
        Opcion(icon: "figure.strengthtraining.traditional", titulo: "Ejercicios", subtitulo: nil, habilitado: true),
        Opcion(icon: "video.circle", titulo: "Videoconferencia", subtitulo: "Programada 18 JUN 2025", habilitado: false),
        Opcion(icon: "bubble.left.and.bubble.right", titulo: "Foro pacientes", subtitulo: nil, habilitado: true),
        Opcion(icon: "tray.and.arrow.down", titulo: "Buzón sugerencias", subtitulo: nil, habilitado: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Disfagia"
        view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = false

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        setupLayout()
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DisfagiaHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return opciones.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let opcion = opciones[indexPath.row]
            let cell = UITableViewCell(style: opcion.subtitulo != nil ? .subtitle : .default, reuseIdentifier: "cell")
            if indexPath.row == 2 {
                cell.imageView?.image = UIImage(systemName: opcion.icon)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            } else {
                cell.imageView?.image = UIImage(systemName: opcion.icon)
            }
            cell.textLabel?.text = opcion.titulo
            cell.detailTextLabel?.text = opcion.subtitulo
            cell.selectionStyle = opcion.habilitado ? .default : .none
            cell.textLabel?.textColor = opcion.habilitado ? .label : .gray
            cell.detailTextLabel?.textColor = .gray
            cell.accessoryType = opcion.habilitado ? .disclosureIndicator : .none
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let opcion = opciones[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            guard opcion.habilitado else { return }

            // Aquí puedes hacer la navegación dependiendo de la opción
            if indexPath.row == 0 {
                let viewController = DisfagiaInfoViewController()
                navigationController?.pushViewController(viewController, animated: true)
            } else if indexPath.row == 1 {
                let viewController = ExerciseViewController()
                navigationController?.pushViewController(viewController, animated: true)
            }  else if indexPath.row == 3 {
                let viewController = ForoTemasViewController()
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
}
