import UIKit

class ForoTemasViewController: UIViewController {
    let searchBar = UISearchBar()
    private let tableView = UITableView()

    private let allTopics = [
        "Recomendaciones",
        "Ayuda en el ejercicio Mendelshon",
        "Ejercicios más útiles",
        "Duda sobre sintomas"
    ]
    
    let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()

    
    private var filteredTopics: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.searchTextField.text = nil
        filteredTopics = allTopics
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foro"
        view.backgroundColor = .systemBackground
        
        definesPresentationContext = true

        filteredTopics = allTopics
        setupSearchBar()
        setupTableView()
        setupFloatingButton()
    }
    func setupFloatingButton() {
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }

    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Buscar temas"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ForoTemaCell.self, forCellReuseIdentifier: "temaCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func floatingButtonTapped() {
        print("Botón flotante pulsado")
        // Aquí puedes navegar a un nuevo foro, abrir un formulario, etc.
    }
}

extension ForoTemasViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTopics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "temaCell", for: indexPath) as? ForoTemaCell else {
            return UITableViewCell()
        }
        let dates = [
            "27 MAY",
            "23 MAR",
            "18 FEB",
            "13 ENE"
        ]
        
        let pacientes = [
            "PacienteABC",
            "PacienteDEF",
            "PacienteGHI",
            "PacienteJKL"
        ]
        
        let topic = filteredTopics[indexPath.row]
        cell.configure(
            with: topic,
            author: pacientes[indexPath.row],
            date: dates[indexPath.row]
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTopic = filteredTopics[indexPath.row]
        let threadVC = ForoHiloViewController(topicTitle: selectedTopic)
        navigationController?.pushViewController(threadVC, animated: true)
    }
}

extension ForoTemasViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredTopics = allTopics
            } else {
                filteredTopics = allTopics.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
}
