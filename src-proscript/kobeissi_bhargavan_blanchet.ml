(* Copyright 2021 Diskuv, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License. *)
(* Auto-generated using code from <dirsp-exchange>/proscript-messaging/ps2pv/ast2ocaml.ml *)

include Kobeissi_bhargavan_blanchet_intf

module Make (ProScript : Dirsp_proscript.S) :
  PROTOCOL with type t = ProScript.t = struct
  type t = ProScript.t

  type t_aes_decrypted = ProScript.Crypto.aes_decrypted

  include Kobeissi_bhargavan_blanchet_shims.Make (ProScript)

  module Type_key = struct
    let construct =
      (* <unknown expression> at file sp.js, line 11:18 to 11:22 *)
      shim_Type_key_construct


    let toBitstring a =
      ProScript.concat
        [ ProScript.of_string ""
        ; ProScript.Encoding.b2h (ProScript.elem_at a 0)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 1)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 2)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 3)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 4)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 5)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 6)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 7)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 8)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 9)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 10)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 11)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 12)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 13)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 14)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 15)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 16)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 17)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 18)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 19)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 20)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 21)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 22)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 23)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 24)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 25)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 26)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 27)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 28)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 29)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 30)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 31)
        ]


    let fromBitstring a = ProScript.Encoding.hexStringTo32ByteArray a

    let xassert a =
      ProScript.of_elem_list
        [ ProScript.elem_at a 0
        ; ProScript.elem_at a 1
        ; ProScript.elem_at a 2
        ; ProScript.elem_at a 3
        ; ProScript.elem_at a 4
        ; ProScript.elem_at a 5
        ; ProScript.elem_at a 6
        ; ProScript.elem_at a 7
        ; ProScript.elem_at a 8
        ; ProScript.elem_at a 9
        ; ProScript.elem_at a 10
        ; ProScript.elem_at a 11
        ; ProScript.elem_at a 12
        ; ProScript.elem_at a 13
        ; ProScript.elem_at a 14
        ; ProScript.elem_at a 15
        ; ProScript.elem_at a 16
        ; ProScript.elem_at a 17
        ; ProScript.elem_at a 18
        ; ProScript.elem_at a 19
        ; ProScript.elem_at a 20
        ; ProScript.elem_at a 21
        ; ProScript.elem_at a 22
        ; ProScript.elem_at a 23
        ; ProScript.elem_at a 24
        ; ProScript.elem_at a 25
        ; ProScript.elem_at a 26
        ; ProScript.elem_at a 27
        ; ProScript.elem_at a 28
        ; ProScript.elem_at a 29
        ; ProScript.elem_at a 30
        ; ProScript.elem_at a 31
        ]


    let clone a =
      ProScript.of_elem_list
        [ ProScript.elem_at a 0
        ; ProScript.elem_at a 1
        ; ProScript.elem_at a 2
        ; ProScript.elem_at a 3
        ; ProScript.elem_at a 4
        ; ProScript.elem_at a 5
        ; ProScript.elem_at a 6
        ; ProScript.elem_at a 7
        ; ProScript.elem_at a 8
        ; ProScript.elem_at a 9
        ; ProScript.elem_at a 10
        ; ProScript.elem_at a 11
        ; ProScript.elem_at a 12
        ; ProScript.elem_at a 13
        ; ProScript.elem_at a 14
        ; ProScript.elem_at a 15
        ; ProScript.elem_at a 16
        ; ProScript.elem_at a 17
        ; ProScript.elem_at a 18
        ; ProScript.elem_at a 19
        ; ProScript.elem_at a 20
        ; ProScript.elem_at a 21
        ; ProScript.elem_at a 22
        ; ProScript.elem_at a 23
        ; ProScript.elem_at a 24
        ; ProScript.elem_at a 25
        ; ProScript.elem_at a 26
        ; ProScript.elem_at a 27
        ; ProScript.elem_at a 28
        ; ProScript.elem_at a 29
        ; ProScript.elem_at a 30
        ; ProScript.elem_at a 31
        ]
  end

  module Type_iv = struct
    let construct =
      (* <unknown expression> at file sp.js, line 84:18 to 84:22 *)
      shim_Type_iv_construct


    let toBitstring a =
      ProScript.concat
        [ ProScript.of_string ""
        ; ProScript.Encoding.b2h (ProScript.elem_at a 0)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 1)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 2)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 3)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 4)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 5)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 6)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 7)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 8)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 9)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 10)
        ; ProScript.Encoding.b2h (ProScript.elem_at a 11)
        ]


    let fromBitstring a = ProScript.Encoding.hexStringTo12ByteArray a

    let xassert a =
      ProScript.of_elem_list
        [ ProScript.elem_at a 0
        ; ProScript.elem_at a 1
        ; ProScript.elem_at a 2
        ; ProScript.elem_at a 3
        ; ProScript.elem_at a 4
        ; ProScript.elem_at a 5
        ; ProScript.elem_at a 6
        ; ProScript.elem_at a 7
        ; ProScript.elem_at a 8
        ; ProScript.elem_at a 9
        ; ProScript.elem_at a 10
        ; ProScript.elem_at a 11
        ]
  end

  module Type_msg = struct
    let construct () =
      { valid = false
      ; ephemeralKey = Type_key.construct ()
      ; initEphemeralKey = Type_key.construct ()
      ; ciphertext = ProScript.of_string ""
      ; iv = Type_iv.construct ()
      ; tag = ProScript.of_string ""
      ; preKeyId = 0
      }


    let xassert a =
      let _ = a.valid = true |> ignore in
      let _ = a.ephemeralKey <- Type_key.xassert a.ephemeralKey in
      let _ = a.initEphemeralKey <- Type_key.xassert a.initEphemeralKey in
      let _ = a.ciphertext = ProScript.of_string "" |> ignore in
      let _ = a.iv <- Type_iv.xassert a.iv in
      let _ = a.tag = ProScript.of_string "" |> ignore in
      let _ =
        (*check s+t for overflow and underflow*)
        let s = a.preKeyId in
        let t = 1 in
        if s > 0
        then
          if t <= Int.max_int - s
          then ()
          else
            raise
              (Invalid_argument
                 (Format.sprintf "(a.preKeyId+1)=(%d+%d) will overflow" s t) )
        else if s < 0
        then
          if t >= Int.min_int - s
          then ()
          else
            raise
              (Invalid_argument
                 (Format.sprintf "(a.preKeyId+1)=(%d+%d) will underflow" s t) )
      in
      a
  end

  module Type_keypair = struct
    let construct () =
      { priv = Type_key.construct (); pub = Type_key.construct () }


    let xassert a =
      let _ = a.priv <- Type_key.xassert a.priv in
      let _ = a.pub <- Type_key.xassert a.pub in
      a


    let clone a =
      let b = construct () in
      let _ = b.priv <- Type_key.clone a.priv in
      let _ = b.pub <- Type_key.clone a.pub in
      b
  end

  module Type_them = struct
    let construct () =
      { signedPreKey = Type_key.construct ()
      ; signedPreKeySignature = ProScript.of_string ""
      ; identityKey = Type_key.construct ()
      ; identityDHKey = Type_key.construct ()
      ; myEphemeralKeyP0 = Type_keypair.construct ()
      ; myEphemeralKeyP1 = Type_keypair.construct ()
      ; ephemeralKey = Type_key.construct ()
      ; myPreKey = Type_keypair.construct ()
      ; preKey = Type_key.construct ()
      ; preKeyId = 0
      ; recvKeys = [| Type_key.construct (); Type_key.construct () |]
      ; sendKeys = [| Type_key.construct (); Type_key.construct () |]
      ; shared = Type_key.construct ()
      ; established = false
      }


    let xassert a =
      let _ = a.signedPreKey <- Type_key.xassert a.signedPreKey in
      let _ =
        a.signedPreKeySignature <-
          ProScript.concat [ a.signedPreKeySignature; ProScript.of_string "" ]
      in
      let _ = a.identityKey <- Type_key.xassert a.identityKey in
      let _ = a.identityDHKey <- Type_key.xassert a.identityDHKey in
      let _ = a.myEphemeralKeyP0 <- Type_keypair.xassert a.myEphemeralKeyP0 in
      let _ = a.myEphemeralKeyP1 <- Type_keypair.xassert a.myEphemeralKeyP1 in
      let _ = a.ephemeralKey <- Type_key.xassert a.ephemeralKey in
      let _ = a.myPreKey <- Type_keypair.xassert a.myPreKey in
      let _ = a.preKey <- Type_key.xassert a.preKey in
      let _ =
        (*check s+t for overflow and underflow*)
        let s = a.preKeyId in
        let t = 1 in
        if s > 0
        then
          if t <= Int.max_int - s
          then ()
          else
            raise
              (Invalid_argument
                 (Format.sprintf "(a.preKeyId+1)=(%d+%d) will overflow" s t) )
        else if s < 0
        then
          if t >= Int.min_int - s
          then ()
          else
            raise
              (Invalid_argument
                 (Format.sprintf "(a.preKeyId+1)=(%d+%d) will underflow" s t) )
      in
      let _ = Array.set a.recvKeys 0 (Type_key.xassert a.recvKeys.(0)) in
      let _ = Array.set a.recvKeys 1 (Type_key.xassert a.recvKeys.(1)) in
      let _ = Array.set a.sendKeys 0 (Type_key.xassert a.sendKeys.(0)) in
      let _ = Array.set a.sendKeys 1 (Type_key.xassert a.sendKeys.(1)) in
      let _ = a.shared <- Type_key.xassert a.shared in
      let _ = a.established = true |> ignore in
      a
  end

  module Type_sendoutput = struct
    let construct () =
      { them = Type_them.construct (); output = Type_msg.construct () }


    let xassert (a : t record_sendoutput) =
      let _ = a.them <- Type_them.xassert a.them in
      let _ = a.output <- Type_msg.xassert a.output in
      a
  end

  module Type_recvoutput = struct
    let construct () =
      { them = Type_them.construct ()
      ; output = Type_msg.construct ()
      ; plaintext = ProScript.of_string ""
      }


    let xassert a =
      let _ = a.them <- Type_them.xassert a.them in
      let _ = a.output <- Type_msg.xassert a.output in
      let _ = a.plaintext = ProScript.of_string "" |> ignore in
      a
  end

  module UTIL = struct
    let xHKDF ikm salt info =
      let prk = ProScript.Crypto.xHMACSHA256 salt (Type_key.toBitstring ikm) in
      let k0 =
        ProScript.Crypto.xHMACSHA256
          prk
          (ProScript.concat [ info; ProScript.of_string "01" ])
      in
      let k1 =
        ProScript.Crypto.xHMACSHA256
          prk
          (ProScript.concat
             [ Type_key.toBitstring k0; info; ProScript.of_string "02" ] )
      in
      [| k0; k1 |]


    let xQDHInit
        myIdentityKeyPriv
        myInitEphemeralKeyPriv
        theirIdentityKeyPub
        theirSignedPreKeyPub
        theirPreKeyPub =
      Type_key.fromBitstring
        (ProScript.Crypto.xSHA256
           (ProScript.concat
              [ Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     myIdentityKeyPriv
                     theirSignedPreKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     myInitEphemeralKeyPriv
                     theirIdentityKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     myInitEphemeralKeyPriv
                     theirSignedPreKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     myInitEphemeralKeyPriv
                     theirPreKeyPub )
              ] ) )


    let xQDHResp
        myIdentityKeyPriv
        mySignedPreKeyPriv
        myPreKeyPriv
        theirIdentityKeyPub
        theirEphemeralKeyPub =
      Type_key.fromBitstring
        (ProScript.Crypto.xSHA256
           (ProScript.concat
              [ Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     mySignedPreKeyPriv
                     theirIdentityKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     myIdentityKeyPriv
                     theirEphemeralKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519
                     mySignedPreKeyPriv
                     theirEphemeralKeyPub )
              ; Type_key.toBitstring
                  (ProScript.Crypto.xDH25519 myPreKeyPriv theirEphemeralKeyPub)
              ] ) )


    let newIdentityKey id =
      let identityKeyPriv =
        ProScript.Crypto.random32Bytes
          (ProScript.concat [ ProScript.of_string "aID"; id ])
      in
      Type_keypair.xassert
        { priv = identityKeyPriv
        ; pub = ProScript.Crypto.ED25519.publicKey identityKeyPriv
        }


    let newKeyPair =
      (* <unknown expression> at file sp.js, line 301:42 to 301:46 *)
      shim_UTIL_newKeyPair


    let getDHPublicKey =
      (* <unknown expression> at file sp.js, line 310:42 to 310:46 *)
      shim_UTIL_getDHPublicKey
  end

  module RATCHET = struct
    let deriveSendKeys (them : t record_them) myEphemeralKeyPriv =
      let kShared =
        ProScript.Crypto.xDH25519 myEphemeralKeyPriv them.ephemeralKey
      in
      let sendKeys =
        UTIL.xHKDF
          kShared
          them.recvKeys.(0)
          (ProScript.of_string "WhisperRatchet")
      in
      let kKeys =
        UTIL.xHKDF
          (ProScript.Crypto.xHMACSHA256 sendKeys.(1) (ProScript.of_string "1"))
          (Type_key.construct ())
          (ProScript.of_string "WhisperMessageKeys")
      in
      { sendKeys; kENC = kKeys.(0) }


    let deriveRecvKeys myShare (them : t record_them) theirEphemeralKeyPub =
      let kShared = ProScript.Crypto.xDH25519 myShare theirEphemeralKeyPub in
      let recvKeys =
        UTIL.xHKDF
          kShared
          them.sendKeys.(0)
          (ProScript.of_string "WhisperRatchet")
      in
      let kKeys =
        UTIL.xHKDF
          (ProScript.Crypto.xHMACSHA256 recvKeys.(1) (ProScript.of_string "1"))
          (Type_key.construct ())
          (ProScript.of_string "WhisperMessageKeys")
      in
      { recvKeys; kENC = kKeys.(0) }


    let tryDecrypt
        myIdentityKey myEphemeralKey (them : t record_them) (msg : t record_msg)
        =
      let keys =
        deriveRecvKeys
          myEphemeralKey.priv
          (Type_them.xassert them)
          msg.ephemeralKey
      in
      let hENC =
        Type_key.fromBitstring
          (ProScript.Crypto.xSHA256
             (ProScript.concat
                [ Type_key.toBitstring keys.kENC; Type_iv.toBitstring msg.iv ] ) )
      in
      let aes =
        ProScript.Crypto.xAESGCMDecrypt
          hENC
          msg.iv
          { ciphertext = msg.ciphertext; tag = msg.tag }
          (ProScript.concat
             [ Type_key.toBitstring msg.initEphemeralKey
             ; Type_key.toBitstring msg.ephemeralKey
             ; Type_key.toBitstring myEphemeralKey.pub
             ; Type_key.toBitstring them.identityKey
             ; Type_key.toBitstring myIdentityKey.pub
             ] )
      in
      aes
  end

  module HANDLE = struct
    let xAKENeeded myIdentityKey initEphemeralKey (them : t record_them) =
      let shared =
        UTIL.xQDHInit
          myIdentityKey.priv
          initEphemeralKey.priv
          them.identityDHKey
          them.signedPreKey
          them.preKey
      in
      let recvKeys =
        UTIL.xHKDF
          shared
          (Type_key.construct ())
          (ProScript.of_string "WhisperRatchet")
      in
      let validSig =
        ProScript.Crypto.ED25519.checkValid
          them.signedPreKeySignature
          (Type_key.toBitstring them.signedPreKey)
          them.identityKey
      in
      { signedPreKey = them.signedPreKey
      ; signedPreKeySignature = them.signedPreKeySignature
      ; identityKey = them.identityKey
      ; identityDHKey = them.identityDHKey
      ; myEphemeralKeyP0 = them.myEphemeralKeyP0
      ; myEphemeralKeyP1 = them.myEphemeralKeyP1
      ; ephemeralKey = them.ephemeralKey
      ; myPreKey = them.myPreKey
      ; preKey = them.preKey
      ; preKeyId = them.preKeyId
      ; recvKeys
      ; sendKeys = them.sendKeys
      ; shared
      ; established = validSig
      }


    let xAKEInit
        myIdentityKey mySignedPreKey (them : t record_them) (msg : t record_msg)
        =
      let shared =
        UTIL.xQDHResp
          myIdentityKey.priv
          mySignedPreKey.priv
          them.myPreKey.priv
          them.identityDHKey
          msg.initEphemeralKey
      in
      let sendKeys =
        UTIL.xHKDF
          shared
          (Type_key.construct ())
          (ProScript.of_string "WhisperRatchet")
      in
      { signedPreKey = them.signedPreKey
      ; signedPreKeySignature = them.signedPreKeySignature
      ; identityKey = them.identityKey
      ; identityDHKey = them.identityDHKey
      ; myEphemeralKeyP0 = them.myEphemeralKeyP0
      ; myEphemeralKeyP1 = them.myEphemeralKeyP1
      ; ephemeralKey = them.ephemeralKey
      ; myPreKey = them.myPreKey
      ; preKey = them.preKey
      ; preKeyId = msg.preKeyId
      ; recvKeys = them.recvKeys
      ; sendKeys
      ; shared
      ; established = true
      }


    let sending
        myIdentityKey (them : t record_them) initEphemeralKeyPub plaintext =
      let keys =
        RATCHET.deriveSendKeys
          (Type_them.xassert them)
          them.myEphemeralKeyP1.priv
      in
      let iv =
        Type_iv.xassert
          (ProScript.Crypto.random12Bytes (ProScript.of_string "a1"))
      in
      let hENC =
        Type_key.fromBitstring
          (ProScript.Crypto.xSHA256
             (ProScript.concat
                [ Type_key.toBitstring keys.kENC; Type_iv.toBitstring iv ] ) )
      in
      let enc =
        ProScript.Crypto.xAESGCMEncrypt
          hENC
          iv
          plaintext
          (ProScript.concat
             [ Type_key.toBitstring initEphemeralKeyPub
             ; Type_key.toBitstring them.myEphemeralKeyP1.pub
             ; Type_key.toBitstring them.ephemeralKey
             ; Type_key.toBitstring myIdentityKey.pub
             ; Type_key.toBitstring them.identityKey
             ] )
      in
      { them =
          { signedPreKey = them.signedPreKey
          ; signedPreKeySignature = them.signedPreKeySignature
          ; identityKey = them.identityKey
          ; identityDHKey = them.identityDHKey
          ; myEphemeralKeyP0 = them.myEphemeralKeyP0
          ; myEphemeralKeyP1 = them.myEphemeralKeyP1
          ; ephemeralKey = them.ephemeralKey
          ; myPreKey = them.myPreKey
          ; preKey = them.preKey
          ; preKeyId = them.preKeyId
          ; recvKeys = them.recvKeys
          ; sendKeys = them.sendKeys
          ; shared = them.shared
          ; established = them.established
          }
      ; output =
          { valid = them.established
          ; ephemeralKey = them.myEphemeralKeyP1.pub
          ; initEphemeralKey = initEphemeralKeyPub
          ; ciphertext = enc.ciphertext
          ; iv
          ; tag = enc.tag
          ; preKeyId = them.preKeyId
          }
      }


    let receiving myIdentityKey (them : t record_them) (msg : t record_msg) =
      let them = Type_them.xassert them in
      let dec =
        RATCHET.tryDecrypt myIdentityKey them.myEphemeralKeyP1 them msg
      in
      if dec.valid
      then
        { them =
            { signedPreKey = them.signedPreKey
            ; signedPreKeySignature = them.signedPreKeySignature
            ; identityKey = them.identityKey
            ; identityDHKey = them.identityDHKey
            ; myEphemeralKeyP0 = them.myEphemeralKeyP1
            ; myEphemeralKeyP1 = UTIL.newKeyPair (ProScript.of_string "a4")
            ; ephemeralKey = msg.ephemeralKey
            ; myPreKey = them.myPreKey
            ; preKey = them.preKey
            ; preKeyId = msg.preKeyId
            ; recvKeys = them.recvKeys
            ; sendKeys = them.sendKeys
            ; shared = them.shared
            ; established = them.established
            }
        ; output =
            { valid = dec.valid && them.established
            ; ephemeralKey = Type_key.construct ()
            ; initEphemeralKey = Type_key.construct ()
            ; ciphertext = ProScript.of_string ""
            ; iv = Type_iv.construct ()
            ; tag = ProScript.of_string ""
            ; preKeyId = msg.preKeyId
            }
        ; plaintext = dec.plaintext
        }
      else
        let dec =
          RATCHET.tryDecrypt myIdentityKey them.myEphemeralKeyP0 them msg
        in
        { them =
            { signedPreKey = them.signedPreKey
            ; signedPreKeySignature = them.signedPreKeySignature
            ; identityKey = them.identityKey
            ; identityDHKey = them.identityDHKey
            ; myEphemeralKeyP0 = them.myEphemeralKeyP0
            ; myEphemeralKeyP1 = them.myEphemeralKeyP1
            ; ephemeralKey = msg.ephemeralKey
            ; myPreKey = them.myPreKey
            ; preKey = them.preKey
            ; preKeyId = msg.preKeyId
            ; recvKeys = them.recvKeys
            ; sendKeys = them.sendKeys
            ; shared = them.shared
            ; established = them.established
            }
        ; output =
            { valid = dec.valid && them.established
            ; ephemeralKey = Type_key.construct ()
            ; initEphemeralKey = Type_key.construct ()
            ; ciphertext = ProScript.of_string ""
            ; iv = Type_iv.construct ()
            ; tag = ProScript.of_string ""
            ; preKeyId = msg.preKeyId
            }
        ; plaintext = dec.plaintext
        }
  end

  module TOPLEVEL = struct
    let newSession
        mySignedPreKey
        myPreKey
        theirIdentityKeyPub
        theirIdentityDHKeyPub
        theirSignedPreKeyPub
        theirSignedPreKeySignature
        theirPreKeyPub
        preKeyId =
      { signedPreKey = Type_key.fromBitstring theirSignedPreKeyPub
      ; signedPreKeySignature = theirSignedPreKeySignature
      ; identityKey = Type_key.fromBitstring theirIdentityKeyPub
      ; identityDHKey = Type_key.fromBitstring theirIdentityDHKeyPub
      ; myEphemeralKeyP0 = Type_keypair.xassert mySignedPreKey
      ; myEphemeralKeyP1 = UTIL.newKeyPair (ProScript.of_string "a2")
      ; ephemeralKey = Type_key.fromBitstring theirSignedPreKeyPub
      ; myPreKey = Type_keypair.xassert myPreKey
      ; preKey = Type_key.fromBitstring theirPreKeyPub
      ; preKeyId = preKeyId + 0
      ; recvKeys = [| Type_key.construct (); Type_key.construct () |]
      ; sendKeys = [| Type_key.construct (); Type_key.construct () |]
      ; shared = Type_key.construct ()
      ; established = false
      }


    let send myIdentityKey (them : t record_them) plaintext =
      let myIdentityKey = Type_keypair.xassert myIdentityKey in
      let them = Type_them.xassert them in
      let initEphemeralKey =
        { priv = Type_key.construct (); pub = Type_key.construct () }
      in
      if them.established = false
      then
        let initEphemeralKey = UTIL.newKeyPair (ProScript.of_string "a3") in
        HANDLE.sending
          myIdentityKey
          (HANDLE.xAKENeeded myIdentityKey initEphemeralKey them)
          initEphemeralKey.pub
          plaintext
      else HANDLE.sending myIdentityKey them (Type_key.construct ()) plaintext


    let recv
        myIdentityKey mySignedPreKey (them : t record_them) (msg : t record_msg)
        =
      let myIdentityKey = Type_keypair.xassert myIdentityKey in
      let mySignedPreKey = Type_keypair.xassert mySignedPreKey in
      let them = Type_them.xassert them in
      let msg = Type_msg.xassert msg in
      if them.established = false
      then
        HANDLE.receiving
          myIdentityKey
          (HANDLE.xAKEInit myIdentityKey mySignedPreKey them msg)
          msg
      else HANDLE.receiving myIdentityKey them msg
  end
end
