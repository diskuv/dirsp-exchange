# dirsp-exchange

"dirsp" is a short form for Diskuv Implementations of Research Security Protocols.

The intent of the [dirsp] libraries are to provide software engineers with auditable
source code that has some level of safety assurance (typically proofs) from security researchers.
By "auditable" we mean the ability to justify every line of source code when undergoing an audit
by a competent security engineer. No third-party vetting of the source code has been
conducted (unless noted explicitly), and the original authors at Diskuv did not have security
researchers or engineers on staff when the libraries were originally written.
Contact [security@diskuv.com](mailto:security@diskuv.com) to report any security issues, and feel
free to publicly shame the [Twitter handle @diskuv](https://twitter.com/diskuv) if Diskuv is not being
responsive.

The implementations in this library are licensed permissively to broaden use and scrutiny. Sometimes
that means / will mean writing an implementation from scratch based only on an academic paper.
Placing security sensitive libraries under restrictive licenses (ex. GPL and especially AGPL)
discourages scrutiny because many security engineers work for
companies which themselves discourage or [prohibit](https://opensource.google/docs/using/agpl-policy/)
restrictive licenses. Note this lack of scrutiny is
particular to _security sensitive libraries_ that are restrictively licensed; even the authors (Diskuv) will use GPL
and other copy-left licenses for applications and non-sensitive libraries.

## Programming Languages

TLDR: We don't expect you to run your code in OCaml. Embed it in your host language instead.

Most of the libraries are based in the programming language OCaml. Among other things OCaml is commonly used to
write domain-specific languages for proof analysis. [Coq](https://coq.inria.fr/about-coq) is one example of a
well-known DSL for developing proofs.

ProScript is another DSL. It is a restricted JavaScript language meant to be easily accessible to software engineers,
executed in production yet formally verifiable. The design fits well with the software engineering intent
of [dirsp]. The only soft spot is that the ProScript execution model is JavaScript which (at least for the authors of
[dirsp]) is not an ideal production language! So we built a tool `dirsp-ps2ocaml` to translate algorithms written
in ProScript into OCaml.

Let's be clear ... we don't think OCaml is an ideal production language either; we suspect many teams will find the OCaml ecosystem
to be too small. But we think there is a navigable path compared to JavaScript for OCaml to be embedded in several host
languages (Java, Objective-C, JavaScript, etc.) and able to run logic (security and privacy algorithms) on many
different host platforms (desktop, server, mobile, etc.).

## Libraries

This repository contains:

- `dirsp-ps2ocaml` -A ProScript to OCaml translator.
- `dirsp-exchange` - No-op as of May 2021.
- `dirsp-exchange-kbb2017` - The KBB2017 protocol for securing a two-party conversation. Similar to
  Signal Protocol v3 [[1]](https://signal.org/docs/specifications/x3dh) [[2]](https://signal.org/docs/specifications/doubleratchet)
- `dirsp-proscript` - The ProScript Cryptographic Library (PSCL) API interface.
- `dirsp-proscript-mirage` - A PSCL implementation based on `mirage-crypto` and related libraries

The online documentation is at:

- [Sphinx Documentation](https://diskuv.github.io/dirsp-exchange)
- [OCaml Libraries](https://diskuv.github.io/dirsp-exchange/ocaml)

## Contributions

We consider and encourage pull requests that have signed off with a [Developer Certificate of Origin](https://developercertificate.org).
