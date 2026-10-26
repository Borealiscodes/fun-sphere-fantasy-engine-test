class OperatorAdapter:
    """
    Phase E — Operator Adapter
    Maps substrate operator states → canonical glyphs (visual_grammar.json).
    Altitude Band: A4–A6
    """

    def __init__(self, grammar):
        self.grammar = grammar["rasa_physics"]

    def translate(self, dominant_operator):
        """
        dominant_operator: string key from substrate (e.g., "karuna", "raudra")
        returns: glyph symbol (e.g., ❄ ⚡)
        """
        return self.grammar.get(dominant_operator, "〰")  # fallback: shanta_equilibrium
