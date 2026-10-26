import json

class TopologyAdapter:
    """
    Phase E — Topology Adapter
    Ingests map_topology.json → zone geometry + Laplacian bleed.
    Altitude Band: A4–A6
    """

    def __init__(self, topology_json):
        self.data = json.loads(topology_json)

    def get_zone(self, node_id):
        return self.data["nodes"][node_id]

    def adjacency(self):
        return self.data["adjacency_edges"]
