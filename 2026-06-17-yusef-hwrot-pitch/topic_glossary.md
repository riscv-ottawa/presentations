# HWRoT Topic Glossary

Concise definitions for the terms in the "...so many things to learn" slide,
grouped by area. Scoped to the OpenTitan/Pavona root-of-trust context.

## Boot and identity

- **secure boot**: each boot stage cryptographically verifies the next before
  handing off control, so only signed, authorized firmware runs.
- **measured boot**: each stage hashes the next into a running measurement
  (rather than gating on it), producing evidence of exactly what booted for later
  attestation.
- **attestation**: a device proving its identity and software state to a remote
  party by presenting signed measurements and certificates.
- **DICE** (Device Identifier Composition Engine): a layered key-derivation
  scheme where each boot layer derives the next layer's identity from its own
  secret plus the measurement of the code it loads.
- **root keys**: the bottom-most secrets a device's whole trust chain derives
  from, split into a Creator root (set at manufacture) and an Owner root.
- **key derivation**: producing per-stage or per-purpose keys from a root secret
  plus binding inputs (firmware measurement, version), so a key is valid only for
  a specific code/state.
- **certificate chains**: a sequence of certificates where each signs the next,
  letting a verifier trace a device certificate back to a trusted root.
- **signature verification**: checking a digital signature against a public key
  to confirm a payload (a firmware image, a certificate) is authentic and
  unmodified.

## Cryptography

- **post-quantum crypto** (PQC): algorithms designed to stay secure against
  quantum computers, now standardized by NIST and built into Pavona from the
  start.
- **ML-KEM** (FIPS 203): the standardized lattice-based key-encapsulation
  mechanism (formerly Kyber) for quantum-safe key exchange.
- **ML-DSA** (FIPS 204): the standardized lattice-based digital signature scheme
  (formerly Dilithium) for quantum-safe signing.
- **SPHINCS+** / SLH-DSA (FIPS 205): a stateless hash-based signature scheme,
  conservative and quantum-safe, used for secure-boot signing.
- **RSA / ECC**: the classical public-key families (RSA integer factoring,
  elliptic-curve discrete log) for signatures and key exchange, still used
  alongside PQC.
- **AES**: the standard symmetric block cipher for bulk encryption.
- **HMAC**: a keyed hash for message authentication and integrity.
- **KMAC**: a Keccak/SHA-3-based keyed MAC and key-derivation function;
  hardware-accelerated and used inside the key manager.
- **ASCON**: the NIST-selected lightweight authenticated encryption (AEAD)
  standard for constrained devices; carried by Pavona, not OpenTitan.

## Entropy and randomness

- **entropy source**: the hardware noise source that produces raw physical
  randomness for keys and nonces.
- **CSRNG**: a cryptographically secure random number generator built on a DRBG,
  seeded from the entropy source.
- **DRBG**: a deterministic random bit generator that stretches a seed into a
  long stream of unpredictable output (NIST SP 800-90A).
- **EDN** (Entropy Distribution Network): the block that fans randomness out from
  CSRNG to the many on-chip consumers (crypto blocks, key manager).

## Storage and memory

- **secure storage**: on-chip storage of secrets and state protected by
  scrambling, integrity checks, and access control.
- **OTP fuses** (one-time programmable): fuses holding root secrets, lifecycle
  state, and config; writable once, then permanent.
- **flash scrambling**: encrypting/scrambling flash contents and adding integrity
  protection so stored firmware and data resist readout and tampering.
- **SRAM scrambling**: address/data scrambling of on-chip SRAM so memory contents
  are not trivially readable or manipulable.
- **memory protection**: hardware enforcement of which code can access which
  memory regions and with what permissions.
- **ePMP** (enhanced Physical Memory Protection): the RISC-V mechanism the ROM
  uses to lock down memory regions (execute/read/write) early in boot.

## Lifecycle and provisioning

- **lifecycle**: the device's manufacturing-to-retirement state machine (raw,
  test, dev, prod, RMA, ...) that gates debug access and secret availability.
- **provisioning**: injecting identities, keys, and config into a device at
  manufacture so it leaves the line with a unique, trusted identity.
- **personalization**: the provisioning step that writes a device's unique
  secrets and certificates (Owner Personalization does the owner-side equivalent).
- **ownership transfer**: the protocol for handing a device from one owner to a
  new one, where the new owner trusts only the Silicon Creator, not the previous
  owner.
- **ECIES**: Elliptic Curve Integrated Encryption Scheme; used to encrypt secrets
  injected during provisioning so they are protected in transit to the device.

## Key and trust management

- **key manager**: the hardware block that derives, versions, and gates the
  sealing/attestation key hierarchy, binding keys to firmware identity and
  lifecycle state. Pavona's Dragonfly uses a DICE-aware variant (keymgr_dpe).
- **PKI** (public key infrastructure): the system of certificate authorities,
  certificates, and trust roots that binds public keys to identities.
- **rollback protection**: preventing a device from being downgraded to an older,
  vulnerable firmware version, typically via monotonic version counters.
- **hardened counters**: tamper- and glitch-resistant counters (redundant,
  self-checking) used for security-critical state like boot attempts and
  versions.

## Tamper, fault, and side-channel

- **threat modeling**: systematically enumerating adversaries, assets, and attack
  paths to decide what the design must defend against.
- **side-channel analysis** (SCA): extracting secrets by measuring physical
  leakage (power, timing, EM) during crypto operations; defended with
  constant-time and masked implementations.
- **fault injection**: actively glitching a chip (voltage, clock, laser) to skip
  checks or corrupt computation, then exploiting the result.
- **tamper detection**: sensors and logic that detect physical or environmental
  attacks and trigger a defensive response.
- **alert handler**: the block that aggregates fault and tamper alerts from across
  the chip and escalates them (interrupt, reset, wipe).
- **sensor control**: the interface to on-chip sensors (voltage, temperature,
  clock) feeding the tamper/alert logic.
- **AST** (Analog Sensor Top): the analog island holding clocks, regulators, and
  sensors, including the always-on domain.
- **redundancy**: duplicating logic or state (and comparing) so a single fault is
  detected rather than silently accepted.

## Cores, IP, and SoC plumbing

- **Ibex**: the small open-source RISC-V core (RV32) that runs the root-of-trust
  firmware; the CPU at the heart of OpenTitan/Pavona.
- **comportable IP**: OpenTitan's standardized peripheral interface and
  conventions (registers, interrupts, alerts) that let blocks plug into the SoC
  uniformly.
- **mailboxes**: register-based message channels (`mbx`) for passing requests
  between a host SoC and an integrated root of trust.
- **DMA**: direct memory access; a controller that moves data without tying up the
  CPU.

## Simulation, build, and verification

- **Verilator**: the open-source tool that compiles RTL into a fast cycle-accurate
  C++ model, the simulation-first substrate for this project.
- **Bazel**: the build system OpenTitan/Pavona use to build device software and
  images.
- **fusesoc**: the IP/package manager that collects RTL from `.core` files and
  drives simulator/FPGA builds.
- **DV / UVM**: design verification using the Universal Verification Methodology,
  the SystemVerilog framework for constrained-random, coverage-driven testbenches.
- **formal verification**: mathematically proving properties of a design (e.g. a
  state machine can never reach a bad state) rather than testing cases.
- **CDC / RDC**: clock-domain-crossing and reset-domain-crossing checks, static
  analyses that catch metastability and reset hazards between asynchronous
  domains.

## FPGA and silicon

- **FPGA bring-up**: getting the design running on a programmable board, the step
  between simulation and real silicon.
- **ChipWhisperer**: the CW310/CW340 FPGA boards (and toolset) used here; they
  carry power-measurement instrumentation that doubles as side-channel capture
  hardware.
- **tapeout**: finalizing a design and sending it to a foundry for fabrication.
- **OpenLane**: the open-source RTL-to-GDS ASIC flow (on OpenROAD) used to harden
  a block for fabrication.
- **GDS** (GDSII): the layout file format handed to a foundry; the final physical
  output of the ASIC flow.
- **Sky130**: SkyWater's open 130nm PDK, a common target for open-source tapeouts.
- **TinyTapeout**: a low-cost shuttle program that fits a small design onto a
  shared tile for real silicon at hobbyist prices.

## OS and firmware

- **Tock OS**: an embedded operating system written in Rust, used as the
  firmware/application layer on top of the root of trust.
- **embedded Rust**: using Rust for bare-metal/firmware development, for memory
  safety without a garbage collector.
- **firmware update**: securely replacing device firmware, here the Tock B-slot
  in-place update with signature checks and rollback protection.

## Certification

- **FIPS 140-3**: the US/Canada standard for cryptographic module security
  requirements.
- **Common Criteria**: an international framework for evaluating security
  assurance to a graded level (EAL).
- **CMVP** (Cryptographic Module Validation Program): the program that validates
  modules against FIPS 140-3, jointly run by Canada's CCCS and NIST.
- **NIST KATs** (Known Answer Tests): standardized test vectors with fixed
  expected outputs, used to confirm a crypto implementation is correct.

## Threat-context references

- **TPM vs HSM vs SE**: three trusted-hardware form factors. A TPM is a fixed-API
  platform trust chip; an HSM is a high-assurance crypto appliance/card; a Secure
  Element is a small tamper-resistant chip (smartcards, SIMs). A root of trust like
  OpenTitan can play the role of, or anchor, these.
