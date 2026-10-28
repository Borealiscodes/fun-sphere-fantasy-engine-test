import HallucinationGuard
import FSFE.Core.Types

namespace FSFE

open HallucinationGuard

/-
  A5 Formal Verification Layer: Core Predicates
  ---------------------------------------------
  This module defines pure logical predicates describing valid FSFE states.
  These predicates form the backbone of all invariants and operator proofs.
  They must remain altitude-stable, pure, and free from runtime/UI semantics.
-/

-- Predicate: Snapshot index must be non-negative
def ValidSigma (s : RevState) : Prop :=
  s.Σ ≥ 0

-- Predicate: Load index must be non-negative
def ValidLambda (s : RevState) : Prop :=
  s.Λ ≥ 0

-- Predicate: Branch depth must be non-negative
def ValidBranchDepth (q : QAState) : Prop :=
  q.depth ≥ 0

-- Predicate: Tensor rank and dimension must be positive
def ValidTensor (t : TensorState) : Prop :=
  t.rank > 0 ∧ t.dim > 0

-- Combined predicate: FSFEState is structurally valid
def ValidFSFEState (s : FSFEState) : Prop :=
  ValidSigma s.rev ∧
  ValidLambda s.rev ∧
  ValidBranchDepth s.qa ∧
  ValidTensor s.tensor

end FSFE
