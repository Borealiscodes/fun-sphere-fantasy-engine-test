import HallucinationGuard

namespace FSFE

-- Activate hallucination guard for this module
open HallucinationGuard

/-
  A5 Formal Verification Layer: Core Types
  ----------------------------------------
  This module defines the foundational types used across the FSFE reversible
  physics system. These types must remain pure, altitude-stable, and free from
  UI or runtime contamination. All operators, invariants, and proofs depend on
  these definitions.
-/

-- Base reversible state type
structure RevState :=
  (Σ : Nat)        -- Snapshot index
  (Λ : Nat)        -- Load index
  (payload : Nat)  -- Placeholder for reversible payload (to be refined)

-- Quest Algebra branching state
structure QAState :=
  (branch : Nat)   -- Branch identifier
  (depth  : Nat)   -- Depth in operator chain

-- Tensor coupling state
structure TensorState :=
  (rank : Nat)
  (dim  : Nat)

-- Combined FSFE state (Σ/Λ + QA + Tensor)
structure FSFEState :=
  (rev    : RevState)
  (qa     : QAState)
  (tensor : TensorState)

end FSFE
