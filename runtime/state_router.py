class StateRouter:
    """
    Phase E — Runtime State Router
    Connects substrate → adapters → Godot UI.
    Altitude Band: A4–A7
    """

    def __init__(self, operator_adapter, firewall_adapter, haptics_adapter):
        self.op = operator_adapter
        self.fw = firewall_adapter
        self.hx = haptics_adapter

    def route(self, substrate_packet):
        dominant = substrate_packet["dominant_operator"]
        safety = substrate_packet["safety_tripped"]
        intensity = substrate_packet["intensity"]
        variance = substrate_packet["variance"]

        return {
            "glyph": self.op.translate(dominant),
            "firewall": self.fw.translate(safety),
            "haptics": self.hx.translate(intensity, variance)
        }
