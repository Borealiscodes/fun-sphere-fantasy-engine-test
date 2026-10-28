import json
import numpy as np

class SaveStateSigmaLambdaAdapter:
    """
    A11 Altitude • Runtime Geometry Adapter
    Loads and normalizes the 80D Σ/Λ reversible snapshot embedding.
    """

    def __init__(self, path):
        self.path = path
        self.embedding = None
        self.vector = None

    def load(self):
        with open(self.path, "r") as f:
            data = json.load(f)
        self.embedding = np.array(data["embedding"], dtype=float)
        return self.embedding

    def normalize(self):
        if self.embedding is None:
            raise RuntimeError("Embedding not loaded.")
        norm = np.linalg.norm(self.embedding)
        self.vector = self.embedding / norm
        return self.vector

    def fuse_with_constellation(self, constellation_vec):
        """
        Fuses Σ/Λ embedding with constellation embeddings.
        Produces reversible operator-ready geometry.
        """
        if self.vector is None:
            raise RuntimeError("Embedding not normalized.")
        return np.concatenate([self.vector, constellation_vec])

    def get_operator(self):
        """
        Returns Σ/Λ reversible operator geometry.
        """
        if self.vector is None:
            raise RuntimeError("Embedding not normalized.")
        return self.vector
