use serde::Deserialize;
use std::fs::File;
use std::io::BufReader;

#[derive(Deserialize)]
struct EmbeddingData {
    embedding: Vec<f64>,
}

pub struct QuestAlgebra {
    vector: Vec<f64>,
}

impl QuestAlgebra {
    pub fn load(path: &str) -> Self {
        let file = File::open(path).expect("Unable to open Quest Algebra embedding file.");
        let reader = BufReader::new(file);
        let data: EmbeddingData =
            serde_json::from_reader(reader).expect("Invalid Quest Algebra JSON structure.");

        QuestAlgebra { vector: data.embedding }
    }

    pub fn normalize(&mut self) {
        let norm: f64 = self.vector.iter().map(|x| x * x).sum::<f64>().sqrt();
        for x in &mut self.vector {
            *x /= norm;
        }
    }

    pub fn operator_chain(&self) -> &[f64] {
        &self.vector
    }

    pub fn apply_operator_chain(
        &self,
        world_state: &mut [f64],
        combat: &[f64],
        inventory: &[f64],
        rasa: &[f64],
    ) {
        // Reversible operator-chain execution
        for (ws, op) in world_state.iter_mut().zip(self.vector.iter()) {
            *ws += op * 0.0002; // reversible micro-shift
        }

        // Tensor coupling
        for (ws, c) in world_state.iter_mut().zip(combat.iter()) {
            *ws += c * 0.00005;
        }
        for (ws, i) in world_state.iter_mut().zip(inventory.iter()) {
            *ws += i * 0.00003;
        }
        for (ws, r) in world_state.iter_mut().zip(rasa.iter()) {
            *ws += r * 0.00004;
        }
    }
}
