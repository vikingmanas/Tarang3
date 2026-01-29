import SwiftUI

struct Chakra: Identifiable {
    let id = UUID()
    let name: String
    let sanskritName: String
    let target: String
    let feeling: String
    let frequency: String
    let color: Color
    let icon: String
    let roleInBody: String
    let position: String      // The "Listening Posture"
    let medicalFact: String
    let audioFileName: String
}

let chakraList = [
    Chakra(
        name: "Root",
        sanskritName: "Muladhara",
        target: "Panic & Safety",
        feeling: "I feel overwhelmed and unsafe.",
        frequency: "396 Hz",
        color: Color(red: 0.8, green: 0.2, blue: 0.2),
        icon: "shield.fill",
        roleInBody: "Controls your 'Fight or Flight' response.",
        position: "Stand barefoot. Feel gravity pulling your heels down.",
        medicalFact: "Low frequencies (396Hz) mimic natural grounding sounds, signaling 'safety' to the nervous system.",
        audioFileName: "root"
    ),
    Chakra(
        name: "Sacral",
        sanskritName: "Svadhisthana",
        target: "Emotional Block",
        feeling: "I feel stuck and uninspired.",
        frequency: "417 Hz",
        color: Color(red: 1.0, green: 0.6, blue: 0.2),
        icon: "drop.fill",
        roleInBody: "Governs emotional processing and fluidity.",
        position: "Lie flat on back. Place hands on lower belly.",
        medicalFact: "Resonates with the 'Flow State', helping to unstuck rigid emotional patterns.",
        audioFileName: "sacral"
    ),
    Chakra(
        name: "Solar Plexus",
        sanskritName: "Manipura",
        target: "Low Confidence",
        feeling: "I feel powerless or nervous.",
        frequency: "528 Hz",
        color: Color(red: 1.0, green: 0.8, blue: 0.0),
        icon: "sun.max.fill",
        roleInBody: "The engine of willpower and self-esteem.",
        position: "Sit upright. Chest open, shoulders back.",
        medicalFact: "The 528Hz 'Miracle Tone' is linked to cortisol reduction and increased energy.",
        audioFileName: "solar"
    ),
    Chakra(
        name: "Heart",
        sanskritName: "Anahata",
        target: "Loneliness",
        feeling: "I feel isolated and heavy.",
        frequency: "639 Hz",
        color: Color(red: 0.2, green: 0.8, blue: 0.4),
        icon: "heart.fill",
        roleInBody: "Controls empathy and circulation.",
        position: "Sit comfortably. Right hand over heart center.",
        medicalFact: "Harmonics in this range stimulate oxytocin release, fostering self-compassion.",
        audioFileName: "heart"
    ),
    Chakra(
        name: "Throat",
        sanskritName: "Vishuddha",
        target: "Communication",
        feeling: "I can't speak my truth.",
        frequency: "741 Hz",
        color: Color(red: 0.2, green: 0.7, blue: 1.0),
        icon: "mic.fill",
        roleInBody: "Controls the vocal cords and self-expression.",
        position: "Sit upright. Relax jaw and neck muscles.",
        medicalFact: "Vibration in the throat relaxes the Vagus Nerve, lowering heart rate.",
        audioFileName: "throat"
    ),
    Chakra(
        name: "Third Eye",
        sanskritName: "Ajna",
        target: "Overthinking",
        feeling: "My mind won't stop racing.",
        frequency: "852 Hz",
        color: Color(red: 0.3, green: 0.0, blue: 0.6),
        icon: "eye.fill",
        roleInBody: "The center for focus and pattern recognition.",
        position: "Headphones ON. Eyes fixed on the screen dot.",
        medicalFact: "Staring at a fixed point (Trataka) forces the brain to switch networks.",
        audioFileName: "third_eye"
    ),
    Chakra(
        name: "Crown",
        sanskritName: "Sahasrara",
        target: "Insomnia",
        feeling: "I need total mental silence.",
        frequency: "963 Hz",
        color: Color(red: 0.9, green: 0.8, blue: 1.0),
        icon: "sparkles",
        roleInBody: "Connects you to the state of rest.",
        position: "Lie down in darkness. Palms facing up.",
        medicalFact: "Acts as 'Sonic White Space', drowning out internal noise.",
        audioFileName: "crown"
    )
]
