use serde::Deserialize;
use std::fs::File;
use std::io::BufReader;

#[derive(Deserialize)]
struct EmbeddingData {
    embedding: Vec<f64>,
}

pub struct SaveStateSigmaLambda {
    vector: Vec<f64>,
}

impl SaveStateSigmaLambda {
    pub fn load(path: &str) -> Self {
        let file = File::open(path).expect("Unable to open Σ/Λ embedding file.");
        let reader = BufReader::new(file);
        let data: EmbeddingData =
            serde_json::from_reader(reader).expect("Invalid Σ/Λ JSON structure.");

        SaveStateSigmaLambda { vector: data.embedding }
    }

    pub fn normalize(&mut self) {
        let norm: f64 = self.vector.iter().map(|x| x * x).sum::<f64>().sqrt();
        for x in &mut self.vector {
            *x /= norm;
        }
    }

    pub fn operator(&self) -> &[f64] {
        &self.vector
    }

    pub fn apply_to_world_state(&self, world_state: &mut [f64]) {
        // Reversible Σ/Λ operator application
        for (ws, op) in world_state.iter_mut().zip(self.vector.iter()) {
            *ws += op * 0.0001; // reversible micro-shift
        }
    }
}
