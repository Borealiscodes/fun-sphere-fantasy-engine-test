extends Node

func _ready():
    print("Runtime Bridge Active — Phase E")

func update_runtime(packet):
    # packet = { "glyph": "...", "firewall": "...", "haptics": {...} }
    $GlyphLabel.text = packet.glyph
    $FirewallIndicator.text = packet.firewall
