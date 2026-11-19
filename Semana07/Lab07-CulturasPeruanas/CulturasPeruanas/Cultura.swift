struct Cultura {
    let nombre: String
    let region: String
    let descripcion: String
    let nombreImagen: String
    let textoAlternativo: String
}

let culturas = [
    Cultura(
        nombre: "Chavín",
        region: "Áncash",
        descripcion: "Chavín de Huántar fue un centro ceremonial y de peregrinación en los Andes peruanos. Su arquitectura de piedra reúne plazas, terrazas y galerías internas con representaciones de animales y figuras humanas.",
        nombreImagen: "chavin",
        textoAlternativo: "Sitio arqueológico de Chavín de Huántar"
    ),
    Cultura(
        nombre: "Nasca",
        region: "Ica",
        descripcion: "En las pampas de Nasca y Palpa se conservan grandes geoglifos trazados sobre el desierto. Entre sus figuras de animales destaca el colibrí. El paisaje también conserva líneas rectas y formas geométricas.",
        nombreImagen: "nasca",
        textoAlternativo: "Geoglifo del colibrí visto desde el aire"
    ),
    Cultura(
        nombre: "Chimú",
        region: "La Libertad",
        descripcion: "Chan Chan fue la capital del reino chimú, cerca de la actual ciudad de Trujillo. Sus conjuntos amurallados de tierra se organizaron en espacios para distintas actividades. Algunos muros conservan relieves inspirados en el mar.",
        nombreImagen: "chimu",
        textoAlternativo: "Relieves de peces en un muro de Chan Chan"
    )
]
