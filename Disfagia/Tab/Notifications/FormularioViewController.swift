import UIKit

protocol FormularioDelegate: AnyObject {
    func didSubmitFormulario()
}

class FormularioViewController: UIViewController {

    weak var delegate: FormularioDelegate?

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var respuestas: [Int] = Array(repeating: 0, count: 10)

    let preguntas = [
        "1. ¿Tiene usted dificultad para tragar sólidos?",
        "2. ¿Tiene usted dificultad para tragar líquidos?",
        "3. ¿Tiene usted dificultad para tragar alimentos blandos?",
        "4. ¿Se siente atascado al tragar?",
        "5. ¿Siente dolor al tragar?",
        "6. ¿Siente que necesita toser o atragantarse al tragar?",
        "7. ¿Evita comidas debido a la dificultad para tragar?",
        "8. ¿Se siente acomplejado por la forma en que traga?",
        "9. ¿Siente que su dificultad para tragar interfiere con su vida social?",
        "10. ¿Siente que su problema para tragar le afecta emocionalmente?"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Test EAT-10"
        view.backgroundColor = .systemBackground
        configurarScrollView()
        agregarTitulo()
        agregarPreguntas()
        agregarBotonEnviar()
    }

    private func configurarScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func agregarTitulo() {
        let tituloLabel = UILabel()
        tituloLabel.text = "Cuestionario"
        tituloLabel.font = UIFont.boldSystemFont(ofSize: 24)
        tituloLabel.textAlignment = .center
        stackView.addArrangedSubview(tituloLabel)
    }

    private func agregarPreguntas() {
        for (index, pregunta) in preguntas.enumerated() {
            let label = UILabel()
            label.text = pregunta
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 16)

            let control = UISegmentedControl(items: ["0", "1", "2", "3", "4"])
            control.selectedSegmentIndex = 0
            control.tag = index
            control.addTarget(self, action: #selector(valorSeleccionado(_:)), for: .valueChanged)

            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(control)
        }
    }

    private func agregarBotonEnviar() {
        let boton = UIButton(type: .system)
        boton.setTitle("Enviar", for: .normal)
        boton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        boton.addTarget(self, action: #selector(enviarFormulario), for: .touchUpInside)
        stackView.addArrangedSubview(boton)
    }

    @objc private func valorSeleccionado(_ sender: UISegmentedControl) {
        let index = sender.tag
        respuestas[index] = sender.selectedSegmentIndex
    }

    @objc private func enviarFormulario() {
        let total = respuestas.reduce(0, +)
        let mensaje = """
Formulario rellenado con éxito.
En breve recibirá los resultados mediante una notificación
"""

        let alerta = UIAlertController(title: "Resultado del Test", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            self.delegate?.didSubmitFormulario()
            self.dismiss(animated: true)
        }))

        present(alerta, animated: true)
    }
}
