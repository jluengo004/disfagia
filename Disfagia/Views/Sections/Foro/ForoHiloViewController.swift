import UIKit

struct ForoMensaje {
    let alias: String?
    let texto: String
    let usuario: Usuario
}

enum Usuario {
    case paciente
    case doctor
    case usuario
}

class ForoHiloViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mensajes: [ForoMensaje] = [
        ForoMensaje(alias: "Paciente A", texto: "Hola a todos, me cuesta mucho comer, noto que se me queda la comida a medio camino, ¿qué podría hacer para mejorar?", usuario: .paciente),
        ForoMensaje(alias: "Doctor C", texto: "Resulta beneficioso seguir las pautas ergonómicas recomendadas por el fisioterapeuta, así como realizar los ejercicios del logopeda con asiduidad.", usuario: .doctor),
        ForoMensaje(alias: "Paciente B", texto: "A mi ayuda tomar pequeños sorbos de agua entre bocados.", usuario: .paciente)
    ]
    
    private let inputContainer = UIView()
    private let inputTextField = UITextField()
    private let sendButton = UIButton(type: .system)
    let tableView = UITableView()

    init(topicTitle: String) {
        super.init(nibName: nil, bundle: nil)
        title = topicTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MensajeCell.self, forCellReuseIdentifier: "MensajeCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupInputArea()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mensajes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mensaje = mensajes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MensajeCell", for: indexPath) as! MensajeCell
        cell.configure(with: mensaje)
        return cell
    }
    
    private func setupInputArea() {
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.backgroundColor = .secondarySystemBackground

        inputTextField.placeholder = "Escribe un mensaje..."
        inputTextField.borderStyle = .roundedRect
        inputTextField.translatesAutoresizingMaskIntoConstraints = false

        sendButton.setTitle("Enviar", for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        inputContainer.addSubview(inputTextField)
        inputContainer.addSubview(sendButton)
        view.addSubview(inputContainer)

        NSLayoutConstraint.activate([
            inputContainer.heightAnchor.constraint(equalToConstant: 60),
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            inputTextField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 12),
            inputTextField.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -12),

            sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -12),
            sendButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor)
        ])
    }

    @objc private func sendMessage() {
        guard let text = inputTextField.text, !text.isEmpty else { return }
        let mensaje = ForoMensaje(alias: nil, texto: text, usuario: .usuario)
        mensajes.append(mensaje)
        inputTextField.text = nil
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: mensajes.count - 1, section: 0), at: .bottom, animated: true)
    }
}

