import json
import numpy as np

class QuestAlgebraAdapter:
    """
    A11 Altitude • Runtime Geometry Adapter
    Loads and normalizes the 80D Quest Algebra operator-chain embedding.
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

    def bind_tensors(self, combat, inventory, rasa):
        """
        Binds quest algebra geometry to FSFE tensors.
        Produces operator-chain-ready narrative physics.
        """
        if self.vector is None:
            raise RuntimeError("Embedding not normalized.")
        return np.concatenate([self.vector, combat, inventory, rasa])

    def get_operator_chain(self):
        """
        Returns reversible operator-chain geometry.
        """
        if self.vector is None:
            raise RuntimeError("Embedding not normalized.")
        return self.vector
