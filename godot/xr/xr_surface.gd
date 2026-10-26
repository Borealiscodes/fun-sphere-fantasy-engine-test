extends MeshInstance3D

func apply_runtime(packet):
    var glyph = packet.glyph
    # Later: map glyph → XR shader overlay
    print("XR Surface Update: %s" % glyph)
