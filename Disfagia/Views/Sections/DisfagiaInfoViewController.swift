import UIKit

import UIKit

class DisfagiaInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sobre la Disfagia"
        view.backgroundColor = .systemBackground
        setupScrollView()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 20
        contentView.alignment = .leading

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])

        addSection(title: "¿Qué es la Disfagia?", text: """
 La disfagia es un trastorno que se refiere a la dificultad para tragar alimentos, líquidos o incluso saliva.
 Esta condición puede variar en intensidad, desde una ligera sensación de incomodidad al tragar hasta una incapacidad total para hacerlo, lo que puede poner en riesgo la nutrición y la hidratación.
 La deglución es un proceso intrincado y coordinado que requiere un control neuronal. Este proceso implica la participación precisa de múltiples estructuras, como la lengua, la faringe, la laringe y el esófago. Cuando alguna de estas partes no funciona adecuadamente, la persona puede experimentar dificultades para tragar.
""", to: contentView)
        
        addSection(title: "Prevalencia", text: """
 La disfagia es un signo común en pacientes de 65 años o más, por lo que resulta interesante realizar cribados a partir de esa edad, además esta patología podría verse agravada en pacientes institucionalizados.
 Este trastorno puede ser causado por una variedad de factores, que se dividen principalmente en dos categorías: orofaríngeos (relacionados con la cavidad oral y la faringe) y esofágicos (relacionados con el esófago). Algunas de las causas más comunes incluyen:

• Trastornos neurológicos: ACV, Parkinson, esclerosis múltiple...
• Problemas estructurales: Tumores, hernias/estrechamientos en farienge o esófago...
• Enfermedades del esófago: ERGE, acalasia...
• Enfermedades musculares: Afecciones de músculos que afectan a la deglución (miastenia, distrofia muscular)
• Cirugías previas: Intervenciones que afectan a la región de cabeza y cuello
""", to: contentView)

        addSection(title: "Síntomas comunes", text: """
Pueden variar según su gravedad, pero algunos de los más comunes incluyen:

• Dificultad para gestionar las secreciones orales.
• La comida y la saliva salen por la boca.
• Asfixia, tos y respiración sibilante durante la alimentación.
• Sensación de comida atascada en la garganta.
• Retorno de los alimentos por la nariz.
• Voz húmeda.
• Pérdida de peso.
• Rechazo de los alimentos.
• Neumonía repetida y fiebre sin causa aparente.

""", to: contentView)

        addSection(title: "Recomendaciones", text: """
Detectar y tratar la disfagia a tiempo, venga provocada por el motivo que sea, es crucial para evitar complicaciones graves, como la desnutrición, la deshidratación y las infecciones respiratorias, como la neumonía por aspiración. Un diagnóstico adecuado no solo ayuda a identificar la causa subyacente, sino que también permite aplicar un tratamiento efectivo para mejorar la calidad de vida del paciente.

El tratamiento de la disfagia depende de la causa subyacente, y puede incluir:

• Detección, apoyo y supervisión de casos leves desde la enfermería de AP. Inculcar hábitos de vida saludables y reducir factores estresantes.

• Rehabilitación con el servicio de Logopedia: Terapia de deglución.

• Rehabilitación con el servicio de Fisioterapia: Enseñar al paciente a adoptar una postura que beneficie una deglución segura y eficaz: posición erguida con la cabeza-tronco alineados, trabajo de musculatura espiratoria, trabajo respiratorio. Inculcar hábitos de vida saludables y potenciación de la musculatura en general.

• Rehabilitación con el Terapeuta Ocupacional: Controlar del entorno, favorecer un buen posicionamiento para la alimentación, modificar de forma sensorial el alimento, y proveer productos de apoyo.

• Intervención con el Nutricionista: Para el manejo de la alimentación variada y equilibrada por diferentes vías de administración.

""", to: contentView)
    }

    private func addSection(title: String, text: String, to stack: UIStackView) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0

        let bodyLabel = UILabel()
        bodyLabel.text = text
        bodyLabel.font = .systemFont(ofSize: 16)
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.textAlignment = .justified

        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(bodyLabel)
    }
}

