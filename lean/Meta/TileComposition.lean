import HallucinationGuard
import FSFE.Meta.TileGrammar
import FSFE.Meta.AltitudeMap
import FSFE.Meta.AltitudeInvariants

namespace FSFE

open HallucinationGuard

/-
  A5 Formal Verification Layer: Tile Composition
  ----------------------------------------------
  This module defines formal rules for composing tile sequences into full FSFE
  documents. Composition rules ensure altitude stability, conceptual coherence,
  and structural correctness across documentation layers.
-/

-- A composed document is simply a list of tiles
structure Document :=
  (tiles : TileSeq)

-- Predicate: a document is structurally valid
def DocumentValid (d : Document) : Prop :=
  TileSeqStable d.tiles ∧
  ∀ t : Tile, t ∈ d.tiles → TileAltitudeInvariant t

-- Composition operator: append two documents
def ComposeDocs (d₁ d₂ : Document) : Document :=
  { tiles := d₁.tiles ++ d₂.tiles }

-- Predicate: composition is altitude-stable
def CompositionStable (d₁ d₂ : Document) : Prop :=
  TileSeqStable (d₁.tiles ++ d₂.tiles)

-- Theorem: composing two valid documents yields a valid document
theorem Compose_valid (d₁ d₂ : Document)
  (h₁ : DocumentValid d₁)
  (h₂ : DocumentValid d₂) :
  DocumentValid (ComposeDocs d₁ d₂) :=
by
  unfold DocumentValid ComposeDocs at *
  constructor
  · -- altitude stability
    unfold TileSeqStable at *
    induction d₁.tiles generalizing d₂.tiles
    · simp
    · cases d₁.tiles
      · simp [h₂.left]
      · simp [h₁.left, h₂.left]
  · -- tile altitude invariants
    intro t ht
    have ht₁ : t ∈ d₁.tiles ∨ t ∈ d₂.tiles := by
      simpa using ht
    cases ht₁ with
    | inl h₁t => exact h₁.right t h₁t
    | inr h₂t => exact h₂.right t h₂t

-- Theorem: meta tiles may wrap any A5 tile
theorem Meta_wrap_A5 (t : Tile)
  (h : TileAltitude t = Altitude.A5) :
  TileCompatible Tile.Meta t :=
by
  unfold TileCompatible TileAltitude AltitudeCompatible AltitudeLe
  simp [h]

-- Theorem: concept tiles cannot appear after operator tiles
theorem Concept_not_after_operator_comp (d₁ d₂ : Document)
  (h₁ : Tile.Operator ∈ d₁.tiles)
  (h₂ : Tile.Concept ∈ d₂.tiles) :
  ¬ CompositionStable d₁ d₂ :=
by
  unfold CompositionStable
  unfold TileSeqStable
  intro h
  cases d₁.tiles with
  | nil =>
      simp at h₁
  | cons t₁ rest₁ =>
      cases d₂.tiles with
      | nil =>
          simp at h₂
      | cons t₂ rest₂ =>
          have : ¬ TileCompatible Tile.Operator Tile.Concept := by
            unfold TileCompatible TileAltitude AltitudeCompatible AltitudeLe
            simp
          exact this (by
            have := h
            simp at this
            exact this)

end FSFE
