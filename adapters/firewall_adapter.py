class FirewallAdapter:
    """
    Phase E — Firewall Adapter
    Maps safety membrane states → conductor glyphs (⛨ / ⛯).
    Altitude Band: A4–A6
    """

    def __init__(self, grammar):
        self.grammar = grammar["conductor_layer"]

    def translate(self, safety_tripped):
        key = "vfe_breaker" if safety_tripped else "h_safe_valve"
        return self.grammar.get(key, "⛨")
