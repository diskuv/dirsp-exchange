(** Tests **verbatim** from .mli documentation *)

(* ------------------------------------------------------------------- *)
(*                            BEGIN VERBATIM                           *)
(* ------------------------------------------------------------------- *)

(*  FIRST: Make some module shortcuts *)
module P = Dirsp_proscript_mirage.Make ()

module C = P.Crypto
module ED25519 = P.Crypto.ED25519
module E = P.Encoding
module K = Dirsp_exchange_kbb2017.Make (P)
module U = K.UTIL
module T = K.TOPLEVEL
module KEY = K.Type_key
module MSG = K.Type_msg

(* SECOND: Let Alice and Bob create their own long-term key pairs.

   Alice keeps her private keys hidden, and Bob keeps his private
   keys hidden. As an implementor of this algorithm, you need to
   make sure there is a secure storage area for each person and place
   the private keys in that storage area.

   Note: The strings (ex. "alice-identity") are documentation hints, and are
   only meaningful during unit testing or proof testing.
*)
let aliceIdentityKey = U.newIdentityKey (P.of_string "alice-identity")

let aliceSignedPreKey = U.newKeyPair (P.of_string "alice-signed-prekey")

let bobIdentityKey = U.newIdentityKey (P.of_string "bob-identity")

let bobSignedPreKey = U.newKeyPair (P.of_string "bob-signed-prekey")

(* At any point you can see the contents of a key, message, etc. with `P.hexdump` *)

;;
P.hexdump aliceIdentityKey.pub

(* THIRD: Alice and Bob exchange a set of long-term public keys.

   As an implementor, the exchange can be simply publishing the long-term keys
   once to a common location (ex. a server) and having each person download
   the other person's public keys.
*)
let aliceIdentityKeyPub = aliceIdentityKey.pub

let aliceIdentityDHKeyPub = U.getDHPublicKey aliceIdentityKey.priv

let aliceSignedPreKeyPub = aliceSignedPreKey.pub

let aliceSignedPreKeySignature =
  ED25519.signature
    (KEY.toBitstring aliceSignedPreKeyPub)
    aliceIdentityKey.priv
    aliceIdentityKeyPub


let bobIdentityKeyPub = bobIdentityKey.pub

let bobIdentityDHKeyPub = U.getDHPublicKey bobIdentityKey.priv

let bobSignedPreKeyPub = bobSignedPreKey.pub

let bobSignedPreKeySignature =
  ED25519.signature
    (KEY.toBitstring bobSignedPreKeyPub)
    bobIdentityKey.priv
    bobIdentityKeyPub


(* FOURTH: Alice and Bob create their own prekeys.

   Each prekey has an identifier [Id]. As an implementor of this algorithm, you need
   to make sure there is a secure storage area for each person's prekeys. This storage
   area needs to have lookup by an integer [Id].

   In this example, we create one prekey each person. As an implementator, you should create many.
*)
let alicePreKey = U.newKeyPair (P.of_string "alice-prekey")

let bobPreKey = U.newKeyPair (P.of_string "bob-prekey")

(* FIFTH: Alice consumes one of Bob's one-time prekeys. Bob consumes one of Alice's one-time prekeys.

   By "consume" we mean that once taken, the prekey can no longer be used. As an implementor, you
   need to have a common location (ex. a server) that lets:

   a) each person periodically post a large number of random prekeys
   b) each person consume prekeys that belongs to any other person

   {b CAUTION:} Be aware that "b" is an easy path to denial of service. Use standard anti-DOS
   techniques (ex. authentication, rate limiting on the consumer and the consumee) but inevitably
   that will not be enough. The solution from https://signal.org/docs/specifications/x3dh/#sending-the-initial-message
   is to fallback to an algorithm that uses only the signed prekey; KBB2017 however expects an infinite supply of
   prekeys. We suggest either letting each person post a "last resort" prekey that is used when all prekeys are
   exhausted -or- re-using the last prekey if all but the last prekey are exhausted.
*)
let alicePreKeyPub = alicePreKey.pub

let alicePreKeyId = 1 (* the Id of alicePreKey *)

let bobPreKeyPub = bobPreKey.pub

let bobPreKeyId = 1 (* the Id of bobPreKey   *)

(*  SIXTH: Alice establishes a session with Bob. *)
let aliceSessionWithBob =
  T.newSession
    aliceSignedPreKey
    alicePreKey
    (KEY.toBitstring bobIdentityKeyPub)
    (KEY.toBitstring bobIdentityDHKeyPub)
    (KEY.toBitstring bobSignedPreKeyPub)
    bobSignedPreKeySignature
    (KEY.toBitstring bobPreKeyPub)
    bobPreKeyId


(*  SEVENTH: Alice sends a message to Bob. *)
let aliceToBobMsg1 = P.of_string "Hi Bob!"

let aliceToBobSendOutput1 =
  T.send aliceIdentityKey aliceSessionWithBob aliceToBobMsg1


;;
Format.printf
  "Did Alice send successfully? %b\n"
  aliceToBobSendOutput1.output.valid

(*  EIGHTH: Bob establishes his own session with Alice. *)
let bobSessionWithAlice =
  T.newSession
    bobSignedPreKey
    bobPreKey
    (KEY.toBitstring aliceIdentityKeyPub)
    (KEY.toBitstring aliceIdentityDHKeyPub)
    (KEY.toBitstring aliceSignedPreKeyPub)
    aliceSignedPreKeySignature
    (KEY.toBitstring alicePreKeyPub)
    alicePreKeyId


(*  NINTH: Bob receives the message from Alice. *)
let bobFromAliceMsg2 = aliceToBobSendOutput1.output

let bobFromAliceReceiveOutput2 =
  T.recv bobIdentityKey bobSignedPreKey bobSessionWithAlice bobFromAliceMsg2


;;
Format.printf
  "Did Bob receive a message? %b\n"
  bobFromAliceReceiveOutput2.output.valid

;;
Format.printf
  "Bob just received a new message: %s\n"
  (bobFromAliceReceiveOutput2.plaintext |> P.to_bytes |> Bytes.to_string)

(* ------------------------------------------------------------------- *)
(*                             END VERBATIM                            *)
(* ------------------------------------------------------------------- *)

let hexbuffer_equals = Alcotest.testable P.hexdump_pp P.equal

let () =
  let open Alcotest in
  run
    "dirsp_exchange_kbb2017"
    [ ( "Alice sends message to Bob"
      , [ test_case "Did Alice send successfully?" `Quick (fun _ ->
              (check bool) "is true" true aliceToBobSendOutput1.output.valid )
        ; test_case "Did Bob receive a message?" `Quick (fun _ ->
              (check bool)
                "is true"
                true
                bobFromAliceReceiveOutput2.output.valid )
        ; test_case "Bob got the right message" `Quick (fun _ ->
              (check string)
                "equal strings"
                "Hi Bob!"
                ( bobFromAliceReceiveOutput2.plaintext
                |> P.to_bytes
                |> Bytes.to_string ) )
        ] )
    ]
