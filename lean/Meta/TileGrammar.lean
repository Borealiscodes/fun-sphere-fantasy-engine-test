import HallucinationGuard
import FSFE.Meta.AltitudeMap

namespace FSFE

open HallucinationGuard

/-
  A5 Formal Verification Layer: Tile Grammar
  ------------------------------------------
  This module defines the formal grammar for FSFE documentation tiles. Tiles
  represent structured units of explanation, each assigned an altitude. The
  grammar ensures that tiles compose in altitude-stable ways and that tile
  sequences follow strict structural rules.
-/

-- Tile types used in FSFE documentation
inductive Tile
  | Concept
  | Operator
  | Invariant
  | Transition
  | Algebra
  | Geometry
  | Runtime
  | Telemetry
  | Meta

-- Altitude assignment for each tile type
def TileAltitude : Tile → Altitude
  | Tile.Concept    => Altitude.A3
  | Tile.Operator   => Altitude.A5
  | Tile.Invariant  => Altitude.A5
  | Tile.Transition => Altitude.A5
  | Tile.Algebra    => Altitude.A5
  | Tile.Geometry   => Altitude.A5
  | Tile.Runtime    => Altitude.A9
  | Tile.Telemetry  => Altitude.A7
  | Tile.Meta       => Altitude.A5

-- Tile compatibility predicate
def TileCompatible (t₁ t₂ : Tile) : Prop :=
  AltitudeCompatible (TileAltitude t₁) (TileAltitude t₂)

-- Tile sequence (list of tiles)
def TileSeq := List Tile

-- Predicate: a tile sequence is altitude-stable
def TileSeqStable : TileSeq → Prop
  | []        => True
  | [t]       => True
  | t₁ :: t₂ :: rest =>
      TileCompatible t₁ t₂ ∧ TileSeqStable (t₂ :: rest)

-- Theorem: any single tile is stable
theorem TileSeqStable_single (t : Tile) :
  TileSeqStable [t] :=
by simp [TileSeqStable]

-- Theorem: concept tiles cannot follow operator tiles
theorem Concept_not_after_operator :
  ¬ TileCompatible Tile.Concept Tile.Operator :=
by
  unfold TileCompatible TileAltitude AltitudeCompatible AltitudeLe
  simp

-- Theorem: operator tiles may follow invariant tiles
theorem Operator_after_invariant :
  TileCompatible Tile.Operator Tile.Invariant :=
by
  unfold TileCompatible TileAltitude AltitudeCompatible AltitudeLe
  simp

-- Theorem: meta tiles are compatible with all A5 tiles
theorem Meta_compatible_A5 (t : Tile)
  (h : TileAltitude t = Altitude.A5) :
  TileCompatible Tile.Meta t :=
by
  unfold TileCompatible TileAltitude AltitudeCompatible AltitudeLe
  simp [h]

end FSFE
