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

(* --------------------------------------------------- *)
(*                 AES-GCM Test Vectors                *)
(* --------------------------------------------------- *)

(* ------------------------------------------------------------- *)
(*               Wycheproof test vectors for AES-GCM             *)
(* ------------------------------------------------------------- *)

(*
From the Apache v2.0 licensed

https://github.com/google/wycheproof/blob/2196000605e45d91097147c9c71f26b72af58003/testvectors/aes_gcm_test.json
*)

type wycheproof_notes =
  { xConstructedIv : string
  ; xSmallIv : string
  ; xZeroLengthIv : string
  }

type wycheproof_test =
  { tcId : int
  ; comment : string
  ; key : string
  ; iv : string
  ; aad : string
  ; msg : string
  ; ct : string
  ; tag : string
  ; result : string
  ; flags : string list
  }

type wycheproof_testGroup =
  { ivSize : int
  ; keySize : int
  ; tagSize : int
  ; xtype : string
  ; tests : wycheproof_test list
  }

type wycheproof_root =
  { algorithm : string
  ; generatorVersion : string
  ; numberOfTests : int
  ; header : string list
  ; notes : wycheproof_notes
  ; schema : string
  ; testGroups : wycheproof_testGroup list
  }

(** wycheproof test vectors for AES-GCM *)
let wycheproof_test_vectors =
  { algorithm = "AES-GCM"
  ; generatorVersion = "0.8r12"
  ; numberOfTests = 256
  ; header =
      [ "Test vectors of type AeadTest test authenticated encryption with"
      ; "additional data. The test vectors are intended for testing both"
      ; "encryption and decryption."
      ]
  ; notes =
      { xConstructedIv =
          "The counter for AES-GCM is reduced modulo 2**32. This test vector \
           was constructed to test for correct wrapping of the counter."
      ; xSmallIv =
          "AES-GCM leaks the authentication key if the same IV is used twice. \
           Hence short IV sizes are typically discouraged. This test vector \
           uses an IV smaller than 12 bytes"
      ; xZeroLengthIv =
          "AES-GCM does not allow an IV of length 0. Encrypting with such an \
           IV leaks the authentication key. Hence using an IV of length 0 is \
           insecure even if the key itself is only used for a single \
           encryption."
      }
  ; schema = "aead_test_schema.json"
  ; testGroups =
      [ { ivSize = 96
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 1
              ; comment = ""
              ; key = "5b9604fe14eadba931b0ccf34843dab9"
              ; iv = "028318abc1824029138141a2"
              ; aad = ""
              ; msg = "001d0c231287c1182784554ca3a21908"
              ; ct = "26073cc1d851beff176384dc9896d5ff"
              ; tag = "0a3ea7a5487cb5f7d70fb6c58d038554"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 2
              ; comment = ""
              ; key = "5b9604fe14eadba931b0ccf34843dab9"
              ; iv = "921d2507fa8007b7bd067d34"
              ; aad = "00112233445566778899aabbccddeeff"
              ; msg = "001d0c231287c1182784554ca3a21908"
              ; ct = "49d8b9783e911913d87094d1f63cc765"
              ; tag = "1e348ba07cca2cf04c618cb4d43a5b92"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 3
              ; comment = ""
              ; key = "aa023d0478dcb2b2312498293d9a9129"
              ; iv = "0432bc49ac34412081288127"
              ; aad = "aac39231129872a2"
              ; msg = "2035af313d1346ab00154fea78322105"
              ; ct = "eea945f3d0f98cc0fbab472a0cf24e87"
              ; tag = "4bb9b4812519dadf9e1232016d068133"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 4
              ; comment = ""
              ; key = "bedcfb5a011ebc84600fcb296c15af0d"
              ; iv = "438a547a94ea88dce46c6c85"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "960247ba5cde02e41a313c4c0136edc3"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 5
              ; comment = ""
              ; key = "384ea416ac3c2f51a76e7d8226346d4e"
              ; iv = "b30c084727ad1c592ac21d12"
              ; aad = ""
              ; msg = "35"
              ; ct = "54"
              ; tag = "7c1e4ae88bb27e5638343cb9fd3f6337"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 6
              ; comment = ""
              ; key = "cae31cd9f55526eb038241fc44cac1e5"
              ; iv = "b5e006ded553110e6dc56529"
              ; aad = ""
              ; msg = "d10989f2c52e94ad"
              ; ct = "a036ead03193903f"
              ; tag = "3b626940e0e9f0cbea8e18c437fd6011"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 7
              ; comment = ""
              ; key = "dd6197cd63c963919cf0c273ef6b28bf"
              ; iv = "ecb0c42f7000ef0e6f95f24d"
              ; aad = ""
              ; msg = "4dcc1485365866e25ac3f2ca6aba97"
              ; ct = "8a9992388e735f80ee18f4a63c10ad"
              ; tag = "1486a91cccf92c9a5b00f7b0e034891c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 8
              ; comment = ""
              ; key = "ffdf4228361ea1f8165852136b3480f7"
              ; iv = "0e1666f2dc652f7708fb8f0d"
              ; aad = ""
              ; msg = "25b12e28ac0ef6ead0226a3b2288c800"
              ; ct = "f7bd379d130477176b8bb3cb23dbbbaa"
              ; tag = "1ee6513ce30c7873f59dd4350a588f42"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 9
              ; comment = ""
              ; key = "c15ed227dd2e237ecd087eaaaad19ea4"
              ; iv = "965ff6643116ac1443a2dec7"
              ; aad = ""
              ; msg = "fee62fde973fe025ad6b322dcdf3c63fc7"
              ; ct = "0de51fe4f7f2d1f0f917569f5c6d1b009c"
              ; tag = "6cd8521422c0177e83ef1b7a845d97db"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 10
              ; comment = ""
              ; key = "a8ee11b26d7ceb7f17eaa1e4b83a2cf6"
              ; iv = "fbbc04fd6e025b7193eb57f6"
              ; aad = ""
              ; msg = "c08f085e6a9e0ef3636280c11ecfadf0c1e72919ffc17eaf"
              ; ct = "7cd9f4e4f365704fff3b9900aa93ba54b672bac554275650"
              ; tag = "f4eb193241226db017b32ec38ca47217"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 11
              ; comment = ""
              ; key = "28ff3def08179311e2734c6d1c4e2871"
              ; iv = "32bcb9b569e3b852d37c766a"
              ; aad = "c3"
              ; msg = "dfc61a20df8505b53e3cd59f25770d5018add3d6"
              ; ct = "f58d453212c2c8a436e9283672f579f119122978"
              ; tag = "5901131d0760c8715901d881fdfd3bc0"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 12
              ; comment = ""
              ; key = "e63a43216c08867210e248859eb5e99c"
              ; iv = "9c3a4263d983456658aad4b1"
              ; aad = "834afdc5c737186b"
              ; msg = "b14da56b0462dc05b871fc815273ff4810f92f4b"
              ; ct = "bf864616c2347509ca9b10446379b9bdbb3b8f64"
              ; tag = "a97d25b490390b53c5db91f6ee2a15b8"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 13
              ; comment = ""
              ; key = "38449890234eb8afab0bbf82e2385454"
              ; iv = "33e90658416e7c1a7c005f11"
              ; aad = "4020855c66ac4595058395f367201c4c"
              ; msg = "f762776bf83163b323ca63a6b3adeac1e1357262"
              ; ct = "a6f2ef3c7ef74a126dd2d5f6673964e27d5b34b6"
              ; tag = "b8bbdc4f5014bc752c8b4e9b87f650a3"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 14
              ; comment = ""
              ; key = "6a68671dfe323d419894381f85eb63fd"
              ; iv = "9f0d85b605711f34cd2a35ba"
              ; aad = "76eb5f147250fa3c12bff0a6e3934a0b16860cf11646773b"
              ; msg = "0fc67899c3f1bbe196d90f1eca3797389230aa37"
              ; ct = "bd64802cfebaeb487d3a8f76ce943a37b3472dd5"
              ; tag = "fce9a5b530c7d7af718be1ec0ae9ed4d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 15
              ; comment = ""
              ; key = "e12260fcd355a51a0d01bb1f6fa538c2"
              ; iv = "5dfc37366f5688275147d3f9"
              ; aad = ""
              ; msg =
                  "d902deeab175c008329a33bfaccd5c0eb3a6a152a1510e7db04fa0aff7ce4288530db6a80fa7fea582aa7d46d7d56e708d2bb0c5edd3d26648d336c3620ea55e"
              ; ct =
                  "d33bf6722fc29384fad75f990248b9528e0959aa67ec66869dc3996c67a2d559e7d77ce5955f8cad2a4df5fdc3acccafa7bc0def53d848111256903e5add0420"
              ; tag = "8bc833de510863b4b432c3cbf45aa7cc"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 16
              ; comment = ""
              ; key = "3c55f88e9faa0d68ab50d02b47161276"
              ; iv = "d767c48d2037b4bd2c231bbd"
              ; aad = ""
              ; msg =
                  "5d6add48e7a5704e54f9c2829a9b4283dce0d3a65b133eba3793c4fbfa1d8e3a2539d0d4f3de381598ce5b2360173fbd149476c31692c5d6e872fce40219378949c2e70b5f1b9f0a1d5f38352ad814b2a035bb3f3f26425d831a2f7a5e65c5dfcd91a315c2b24f53a662605ea40857dd980e9be5cdad000c569f2d204d4bd3b0"
              ; ct =
                  "17d72d90bd23e076d8364a87ecb9ac58acc5de4629bfd590409b8bf1fcd3a2f602731b4614cec15e773ea65a65e7210994256bf5450a25acb527269c065f2e2f2279d1fe8b3eda98dcf87b348f1528377bbdd258355d46e035330483d8097e80c7de9bbb606ddf723f2909217ffdd18e8bdbd7b08062f1dcba960e5c0d290f5f"
              ; tag = "090b8c2ec98e4116186d0e5fbefeb9c2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 17
              ; comment = ""
              ; key = "a294e70fa2ac10a1fb00c588b888b673"
              ; iv = "dfe20d1c4350e6235d987af1"
              ; aad = ""
              ; msg =
                  "6ed1d7d618d158741f52078006f28494ba72a2454f27160ae8722793fcebc538ebc2f67c3ace3e0fe7c47b9e74e081182b47c930144e3fc80d0ad50611c3afcfe2dbc5279edbbba087c0e390355f3daffcd25ad4dea007c284ad92e7fcbecb438fb60623ff89a599dca2aac141b26651386ca55b739b94901ef6db609c344d8acf4544568e31bb09361112754b1c0c6a3c875bd9453b0ee0081412151398a294ecad75add521611db5288b60ac3c0128f6e94366b69e659e6aa66f058a3a3571064edbb0f05c11e5dde938fb46c3935dd5193a4e5664688f0ae67c29b7cc49a7963140f82e311a20c98cd34fbcab7b4b515ae86557e62099e3fc37b9595c85a75c"
              ; ct =
                  "5bc6dbafc401101c7a08c81d6c2791aa147ce093aad172be18379c747384a54a41a747ba955cade8fdfb8967aa808b43fee3d757cc80f11163b800e5e59df932757f76c40b3d9cba449aaf11e4f80e003b1f384eafa4f76e81b13c09ec1ad88e7650c750d442fe46d225a373e8a1b564b4915a5c6c513cfdfa22d929d5741ca5ebefaedcba636c7c3bbef18863fdc126b4b451611049c35d814fc2eb7e4b8f1a8995ecb4a3c86652a068c0b2a3e1c5941d59c210b458d5d5d3b06420ec2053465ccceca7c20f67404985460379e2ee806a46e8409dfab2e0dd67ea3cf46d5ad4eb78756827358c3ef1fdbd07c33834f3d9eca3ff13b744a01059a6c17a315a8fd4"
              ; tag = "c7587e7da41bed682c37377ea4324029"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 18
              ; comment = ""
              ; key = "c4b03435b91fc52e09eff27e4dc3fb42"
              ; iv = "5046e7e08f0747e1efccb09e"
              ; aad =
                  "75fc9078b488e9503dcb568c882c9eec24d80b04f0958c82aac8484f025c90434148db8e9bfe29c7e071b797457cb1695a5e5a6317b83690ba0538fb11e325ca"
              ; msg = "8e887b224e8b89c82e9a641cf579e6879e1111c7"
              ; ct = "b6786812574a254eb43b1cb1d1753564c6b520e9"
              ; tag = "ad8c09610d508f3d0f03cc523c0d5fcc"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 19
              ; comment = ""
              ; key = "7e37d56e6b1d0172d40d64d6111dd424"
              ; iv = "517c55c2ec9bfea90addc2bd"
              ; aad =
                  "8ed8a9be4c3d32a5098434ee5c0c4fc20f78ef5e25ed8b72a840a463e36b67b881e048b5e49f515b2541ad5ce4ebb3a917c16bcdc0dc3cb52bb4ed5a1dffcf1e1866544e8db103b2ad99c6fa6e7de1d8b45bff57ec872f1cfc78b0e4870f6f200ff1291cae033defc3327ba82792ba438e35c4bfbb684fec5ce5e3ae167d01d7"
              ; msg = "6a7dea03c1bba70be8c73da47d5ee06d72a27430"
              ; ct = "cfb631790767d0645d8ec6f23bf7fa8b19ce79ee"
              ; tag = "c5767ddaa747158446231766bd20490c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 20
              ; comment = ""
              ; key = "3076741408f734ce25d48f982e8b844b"
              ; iv = "a2712eac5e06d3cc2864aa8b"
              ; aad =
                  "18526e4efd995a0bf6405d9f906725c290278958d49554974d8fe025e7860daa225c1285b0573916a4b6741f7cc2e29ce4e525e12f436cb7ce0ad47df3d0f5bd80fb27e47635a4985fdaedf0e821f1c8959985cac49c97a4a02438d92b4afd4c855dcc7ef41ecfc36866334fcc05b2bb93ef13f00c5ea9b921e8a519d77f648e0efe9b5a62305a2ecf7d4999663a6ddfca517f1f36f0899b0bdef9f433c4bb2663c0cc1bb616e7d1949e522bec85485d371d1134c90eede75e865dc7be405b54c33f0acbace6cf780c78035b8035b6ea3f562a8d30a156c199fdafd25be06ee895581195ef125cb4e629e4f18e0bee979d31513896db8466e448e6b4600a316757"
              ; msg = "414ec6b149e54735302dada888b98b7fdb4c127c"
              ; ct = "e4d3f4898cb3d9732641d1f8d9d889b2c98af930"
              ; tag = "76d4fbb69d529b64175b328be00b1068"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 21
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "000000000000000000000000"
              ; aad = ""
              ; msg = "ebd4a3e10cf6d41c50aeae007563b072"
              ; ct = "f62d84d649e56bc8cfedc5d74a51e2f7"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 22
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "ffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "d593c4d8224f1b100c35e4f6c4006543"
              ; ct = "431f31e6840931fd95f94bf88296ff69"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 23
              ; comment = "Flipped bit 0 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d9847dbc326a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 24
              ; comment = "Flipped bit 1 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "da847dbc326a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 25
              ; comment = "Flipped bit 7 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "58847dbc326a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 26
              ; comment = "Flipped bit 8 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8857dbc326a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 27
              ; comment = "Flipped bit 31 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847d3c326a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 28
              ; comment = "Flipped bit 32 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc336a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 29
              ; comment = "Flipped bit 33 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc306a06e988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 30
              ; comment = "Flipped bit 63 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a066988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 31
              ; comment = "Flipped bit 64 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e989c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 32
              ; comment = "Flipped bit 71 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e908c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 33
              ; comment = "Flipped bit 77 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988e77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 34
              ; comment = "Flipped bit 80 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77bd3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 35
              ; comment = "Flipped bit 96 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3873e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 36
              ; comment = "Flipped bit 97 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3843e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 37
              ; comment = "Flipped bit 103 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3063e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 38
              ; comment = "Flipped bit 120 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3863e6082"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 39
              ; comment = "Flipped bit 121 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3863e6081"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 40
              ; comment = "Flipped bit 126 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3863e60c3"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 41
              ; comment = "Flipped bit 127 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a06e988c77ad3863e6003"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 42
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d9847dbc326a06e989c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 43
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847d3c326a066988c77ad3863e6083"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 44
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d8847dbc326a066988c77ad3863e6003"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 45
              ; comment = "all bits of tag flipped"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "277b8243cd95f9167738852c79c19f7c"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 46
              ; comment = "Tag changed to all zero"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "00000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 47
              ; comment = "tag changed to all 1"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 48
              ; comment = "msbs changed in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "5804fd3cb2ea86690847fa5306bee003"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 49
              ; comment = "lsbs changed in tag"
              ; key = "000102030405060708090a0b0c0d0e0f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "eb156d081ed6b6b55f4612f021d87b39"
              ; tag = "d9857cbd336b07e889c67bd2873f6182"
              ; result = "invalid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 64
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 50
              ; comment = ""
              ; key = "aa023d0478dcb2b2312498293d9a9129"
              ; iv = "0432bc49ac344120"
              ; aad = "aac39231129872a2"
              ; msg = "2035af313d1346ab00154fea78322105"
              ; ct = "64c36bb3b732034e3a7d04efc5197785"
              ; tag = "b7d0dd70b00d65b97cfd080ff4b819d1"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 51
              ; comment = "small IV sizes"
              ; key = "f3434725c82a7f8bb07df1f8122fb6c9"
              ; iv = "28e9b7851724bae3"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "44aca00f42e4199b829a55e69b073d9e"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 52
              ; comment = "small IV sizes"
              ; key = "deb62233559b57476602b5adac57c77f"
              ; iv = "d084547de55bbc15"
              ; aad = ""
              ; msg = "d8986df0241ed3297582c0c239c724cb"
              ; ct = "03e1a168a7e377a913879b296a1b5f9c"
              ; tag = "3290aa95af505a742f517fabcc9b2094"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 128
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 53
              ; comment = ""
              ; key = "2034a82547276c83dd3212a813572bce"
              ; iv = "3254202d854734812398127a3d134421"
              ; aad = "1a0293d8f90219058902139013908190bc490890d3ff12a3"
              ; msg = "02efd2e5782312827ed5d230189a2a342b277ce048462193"
              ; ct = "64069c2d58690561f27ee199e6b479b6369eec688672bde9"
              ; tag = "9b7abadd6e69c1d9ec925786534f5075"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 54
              ; comment = ""
              ; key = "b67b1a6efdd40d37080fbe8f8047aeb9"
              ; iv = "fa294b129972f7fc5bbd5b96bba837c9"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "a2cf26481517ec25085c5b17d0786183"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 55
              ; comment = ""
              ; key = "209e6dbf2ad26a105445fc0207cd9e9a"
              ; iv = "9477849d6ccdfca112d92e53fae4a7ca"
              ; aad = ""
              ; msg = "01"
              ; ct = "fd"
              ; tag = "032df7bba5d8ea1a14f16f70bd0e14ec"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 56
              ; comment = ""
              ; key = "a549442e35154032d07c8666006aa6a2"
              ; iv = "5171524568e81d97e8c4de4ba56c10a0"
              ; aad = ""
              ; msg = "1182e93596cac5608946400bc73f3a"
              ; ct = "2f333087bdca58219f9bfc273e45cc"
              ; tag = "e06d1ef473132957ad37eaef29733ca0"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 57
              ; comment = ""
              ; key = "cfb4c26f126f6a0acb8e4e220f6c56cd"
              ; iv = "1275115499ae722268515bf0c164b49c"
              ; aad = ""
              ; msg = "09dfd7f080275257cf97e76f966b1ad9"
              ; ct = "a780bd01c80885156c88a973264c8ee5"
              ; tag = "2adeffa682c8d8a81fada7d9fcdd2ee2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 58
              ; comment = ""
              ; key = "0b11ef3a08c02970f74281c860691c75"
              ; iv = "95c1dd8c0f1705ece68937901f7add7b"
              ; aad = ""
              ; msg =
                  "f693d4edd825dbb0618d91113128880dbebb23e25d00ed1f077d870be9cc7536"
              ; ct =
                  "7e47e10fe3c6fbfa381770eaf5d48d1482e71e0c44dff1e30ca6f95d92052084"
              ; tag = "d01444fa5d9c499629d174ff3927a1ac"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 59
              ; comment = "J0:000102030405060708090a0b0c0d0e0f"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "f95fde4a751913202aeeee32a0b55753"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "00078d109d92143fcd5df56721b884fac64ac7762cc09eea2a3c68e92a17bdb575f87bda18be564e"
              ; tag = "152a65045fe674f97627427af5be22da"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 60
              ; comment = "J0:00000000000000000000000000000000"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "7b95b8c356810a84711d68150a1b7750"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "84d4c9c08b4f482861e3a9c6c35bc4d91df927374513bfd49f436bd73f325285daef4ff7e13d46a6"
              ; tag = "213a3cb93855d18e69337eee66aeec07"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 61
              ; comment = "J0:ffffffffffffffffffffffffffffffff"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "1a552e67cdc4dc1a33b824874ebf0bed"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "948ca37a8e6649e88aeffb1c598f3607007702417ea0e0bc3c60ad5a949886de968cf53ea6462aed"
              ; tag = "99b381bfa2af9751c39d1b6e86d1be6a"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 62
              ; comment = "J0:fffffffffffffffffffffffffffffffe"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "dd9d0b4a0c3d681524bffca31d907661"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "64b19314c31af45accdf7e3c4db79f0d948ca37a8e6649e88aeffb1c598f3607007702417ea0e0bc"
              ; tag = "5281efc7f13ac8e14ccf5dca7bfbfdd1"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 63
              ; comment = "J0:fffffffffffffffffffffffffffffffd"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "57c5643c4e37b4041db794cfe8e1f0f4"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "2bb69c3e5d1f91815c6b87a0d5bbea7164b19314c31af45accdf7e3c4db79f0d948ca37a8e6649e8"
              ; tag = "a3ea2c09ee4f8c8a12f45cddf9aeff81"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 64
              ; comment = "J0:000102030405060708090a0bffffffff"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "99821c2dd5daecded07300f577f7aff1"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "127af9b39ecdfc57bb11a2847c7c2d3d8f938f40f877e0c4af37d0fe9af033052bd537c4ae978f60"
              ; tag = "07eb2fe4a958f8434d40684899507c7c"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 65
              ; comment = "J0:000102030405060708090a0bfffffffe"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "5e4a3900142358d1c774d8d124d8d27d"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "0cf6ae47156b14dce03c8a07a2e172b1127af9b39ecdfc57bb11a2847c7c2d3d8f938f40f877e0c4"
              ; tag = "f145c2dcaf339eede427be934357eac0"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 66
              ; comment = "J0:000102030405060708090a0bfffffffd"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "d4125676562984c0fe7cb0bdd1a954e8"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "f0c6ffc18bd46df5569185a9afd169eb0cf6ae47156b14dce03c8a07a2e172b1127af9b39ecdfc57"
              ; tag = "facd0bfe8701b7b4a2ba96d98af52bd9"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 67
              ; comment = "J0:000102030405060708090a0b7fffffff"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "b97ec62a5e5900ccf9e4be332e336091"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "d6928e094c06e0a7c4db42184cf7529e95de88b767edebe9b343000be3dab47ea08b744293eed698"
              ; tag = "a03e729dcfd7a03155655fece8affd7e"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 68
              ; comment = "J0:000102030405060708090a0b7ffffffe"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "7eb6e3079fa0b4c3eee366177d1c1d1d"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "d82ce58771bf6487116bf8e96421877ed6928e094c06e0a7c4db42184cf7529e95de88b767edebe9"
              ; tag = "1e43926828bc9a1614c7b1639096c195"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 69
              ; comment = "J0:000102030405060708090a0bffff7fff"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "0314fcd10fdd675d3c612962c931f635"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "a197a37a5d79697078536bc27fe46cd8d475526d9044aa94f088a054f8e380c64f79414795c61480"
              ; tag = "f08baddf0b5285c91fc06a67fe4708ca"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 70
              ; comment = "J0:000102030405060708090a0bffff7ffe"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "c4dcd9fcce24d3522b66f1469a1e8bb9"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "149fde9abbd3a43c2548575e0db9fb84a197a37a5d79697078536bc27fe46cd8d475526d9044aa94"
              ; tag = "62a4b6875c288345d6a454399eac1afa"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 71
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "00000000000000000000000000000000"
              ; aad = ""
              ; msg = "bec6fa05c1718b9b84c47345bbed7dcb"
              ; ct = "45a3f89d02918bfd0c8161658ccc9795"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 72
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff"
              ; iv = "ffffffffffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "4d82639c39d3f3490ee903dd0be7afcf"
              ; ct = "1cd5a06214235ceb044d4bad7b047312"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 96
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 73
              ; comment = ""
              ; key =
                  "92ace3e348cd821092cd921aa3546374299ab46209691bc28b8752d17f123c20"
              ; iv = "00112233445566778899aabb"
              ; aad = "00000000ffffffff"
              ; msg = "00010203040506070809"
              ; ct = "e27abdd2d2a53d2f136b"
              ; tag = "9a4a2579529301bcfb71c78d4060f52c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 74
              ; comment = ""
              ; key =
                  "29d3a44f8723dc640239100c365423a312934ac80239212ac3df3421a2098123"
              ; iv = "00112233445566778899aabb"
              ; aad = "aabbccddeeff"
              ; msg = ""
              ; ct = ""
              ; tag = "2a7d77fa526b8250cb296078926b5020"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 75
              ; comment = ""
              ; key =
                  "80ba3192c803ce965ea371d5ff073cf0f43b6a2ab576b208426e11409c09b9b0"
              ; iv = "4da5bf8dfd5852c1ea12379d"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "4771a7c404a472966cea8f73c8bfe17a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 76
              ; comment = ""
              ; key =
                  "cc56b680552eb75008f5484b4cb803fa5063ebd6eab91f6ab6aef4916a766273"
              ; iv = "99e23ec48985bccdeeab60f1"
              ; aad = ""
              ; msg = "2a"
              ; ct = "06"
              ; tag = "633c1e9703ef744ffffb40edf9d14355"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 77
              ; comment = ""
              ; key =
                  "51e4bf2bad92b7aff1a4bc05550ba81df4b96fabf41c12c7b00e60e48db7e152"
              ; iv = "4f07afedfdc3b6c2361823d3"
              ; aad = ""
              ; msg = "be3308f72a2c6aed"
              ; ct = "cf332a12fdee800b"
              ; tag = "602e8d7c4799d62c140c9bb834876b09"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 78
              ; comment = ""
              ; key =
                  "67119627bd988eda906219e08c0d0d779a07d208ce8a4fe0709af755eeec6dcb"
              ; iv = "68ab7fdbf61901dad461d23c"
              ; aad = ""
              ; msg = "51f8c1f731ea14acdb210a6d973e07"
              ; ct = "43fc101bff4b32bfadd3daf57a590e"
              ; tag = "ec04aacb7148a8b8be44cb7eaf4efa69"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 79
              ; comment = ""
              ; key =
                  "59d4eafb4de0cfc7d3db99a8f54b15d7b39f0acc8da69763b019c1699f87674a"
              ; iv = "2fcb1b38a99e71b84740ad9b"
              ; aad = ""
              ; msg = "549b365af913f3b081131ccb6b825588"
              ; ct = "f58c16690122d75356907fd96b570fca"
              ; tag = "28752c20153092818faba2a334640d6e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 80
              ; comment = ""
              ; key =
                  "3b2458d8176e1621c0cc24c0c0e24c1e80d72f7ee9149a4b166176629616d011"
              ; iv = "45aaa3e5d16d2d42dc03445d"
              ; aad = ""
              ; msg = "3ff1514b1c503915918f0c0c31094a6e1f"
              ; ct = "73a6b6f45f6ccc5131e07f2caa1f2e2f56"
              ; tag = "2d7379ec1db5952d4e95d30c340b1b1d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 81
              ; comment = ""
              ; key =
                  "0212a8de5007ed87b33f1a7090b6114f9e08cefd9607f2c276bdcfdbc5ce9cd7"
              ; iv = "e6b1adf2fd58a8762c65f31b"
              ; aad = ""
              ; msg = "10f1ecf9c60584665d9ae5efe279e7f7377eea6916d2b111"
              ; ct = "0843fff52d934fc7a071ea62c0bd351ce85678cde3ea2c9e"
              ; tag = "7355fde599006715053813ce696237a8"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 82
              ; comment = ""
              ; key =
                  "b279f57e19c8f53f2f963f5f2519fdb7c1779be2ca2b3ae8e1128b7d6c627fc4"
              ; iv = "98bc2c7438d5cd7665d76f6e"
              ; aad = "c0"
              ; msg = "fcc515b294408c8645c9183e3f4ecee5127846d1"
              ; ct = "eb5500e3825952866d911253f8de860c00831c81"
              ; tag = "ecb660e1fb0541ec41e8d68a64141b3a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 83
              ; comment = ""
              ; key =
                  "cdccfe3f46d782ef47df4e72f0c02d9c7f774def970d23486f11a57f54247f17"
              ; iv = "376187894605a8d45e30de51"
              ; aad = "956846a209e087ed"
              ; msg = "e28e0e9f9d22463ac0e42639b530f42102fded75"
              ; ct = "feca44952447015b5df1f456df8ca4bb4eee2ce2"
              ; tag = "082e91924deeb77880e1b1c84f9b8d30"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 84
              ; comment = ""
              ; key =
                  "f32364b1d339d82e4f132d8f4a0ec1ff7e746517fa07ef1a7f422f4e25a48194"
              ; iv = "5a86a50a0e8a179c734b996d"
              ; aad = "ab2ac7c44c60bdf8228c7884adb20184"
              ; msg = "43891bccb522b1e72a6b53cf31c074e9d6c2df8e"
              ; ct = "43dda832e942e286da314daa99bef5071d9d2c78"
              ; tag = "c3922583476ced575404ddb85dd8cd44"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 85
              ; comment = ""
              ; key =
                  "ff0089ee870a4a39f645b0a5da774f7a5911e9696fc9cad646452c2aa8595a12"
              ; iv = "bc2a7757d0ce2d8b1f14ccd9"
              ; aad = "972ab4e06390caae8f99dd6e2187be6c7ff2c08a24be16ef"
              ; msg = "748b28031621d95ee61812b4b4f47d04c6fc2ff3"
              ; ct = "a929ee7e67c7a2f91bbcec6389a3caf43ab49305"
              ; tag = "ebec6774b955e789591c822dab739e12"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 86
              ; comment = ""
              ; key =
                  "5b1d1035c0b17ee0b0444767f80a25b8c1b741f4b50a4d3052226baa1c6fb701"
              ; iv = "d61040a313ed492823cc065b"
              ; aad = ""
              ; msg =
                  "d096803181beef9e008ff85d5ddc38ddacf0f09ee5f7e07f1e4079cb64d0dc8f5e6711cd4921a7887de76e2678fdc67618f1185586bfea9d4c685d50e4bb9a82"
              ; ct =
                  "c7d191b601f86c28b6a1bdef6a57b4f6ee3ae417bc125c381cdf1c4dac184ed1d84f1196206d62cad112b038845720e02c061179a8836f02b93fa7008379a6bf"
              ; tag = "f15612f6c40f2e0db6dc76fc4822fcfe"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 87
              ; comment = ""
              ; key =
                  "d7addd3889fadf8c893eee14ba2b7ea5bf56b449904869615bd05d5f114cf377"
              ; iv = "8a3ad26b28cd13ba6504e260"
              ; aad = ""
              ; msg =
                  "c877a76bf595560772167c6e3bcc705305db9c6fcbeb90f4fea85116038bc53c3fa5b4b4ea0de5cc534fbe1cf9ae44824c6c2c0a5c885bd8c3cdc906f12675737e434b983e1e231a52a275db5fb1a0cac6a07b3b7dcb19482a5d3b06a9317a54826cea6b36fce452fa9b5475e2aaf25499499d8a8932a19eb987c903bd8502fe"
              ; ct =
                  "53cc8c920a85d1accb88636d08bbe4869bfdd96f437b2ec944512173a9c0fe7a47f8434133989ba77dda561b7e3701b9a83c3ba7660c666ba59fef96598eb621544c63806d509ac47697412f9564eb0a2e1f72f6599f5666af34cffca06573ffb4f47b02f59f21c64363daecb977b4415f19fdda3c9aae5066a57b669ffaa257"
              ; tag = "5e63374b519e6c3608321943d790cf9a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 88
              ; comment = ""
              ; key =
                  "317ba331307f3a3d3d82ee1fdab70f62a155af14daf631307a61b187d413e533"
              ; iv = "a6687cf508356b174625deaa"
              ; aad = ""
              ; msg =
                  "32c1d09107c599d3cce4e782179c966c6ef963689d45351dbe0f6f881db273e54db76fc48fdc5d30f089da838301a5f924bba3c044e19b3ed5aa6be87118554004ca30e0324337d987839412bf8f8bbdd537205d4b0e2120e965373235d6cbd2fb3776ba0a384ec1d9b7c631a0379ff997c3f974a6f7bbf4fd23016211f5fc10acadb5e400d2ff0fdfd193f5c6fc6d4f7271dfd1349ed80fbedaebb155b9b02fb3074495d55f9a2455f59bf6f113191a029c6b0ba75d97cdc0c84f131836337f29f9d96ca448eec0cc46d1ca8b3735661979d83302fec08fffcf5e58f12b1e7050657b1b97c64a4e07e317f554f8310b6ccb49f36d48c57816d24952aada711d4f"
              ; ct =
                  "d7eebc9587aa21136fa38b41cf0e2db03a7ea2ba9eaddf83d33f781093617bf50f49b2bfe2f7173b113912e2e1775f40edfed8b3b0099b9e1c220dd103be6166210b01029feb24ed9e20614eddc3cebe41b0079a9a8c117b596c90288effd3796fbd0c7e8eab00609a64be3ad9597cdbf3a818c260cd938bdf232e4059ae35a2571a838887fc196912179486e046a62227a4caddce38cbbc37587bb9439ec637602b6818c5cbe3c71a7c4143960533dc74174bd315c8db227b69b55bb7fc30ba1d5213a752ec33925043cefbc1a62943ee5f34d5da01799e69094d732aef52f8e036980d0070e22e173c67c4bbcca61cc1eedbd6016516c592144819df13204dee"
              ; tag = "bf0540d34b20f761101bc608b02458f2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 89
              ; comment = ""
              ; key =
                  "2ce6b4c15f85fb2da5cc6c269491eef281980309181249ebf2832bd6d0732d0b"
              ; iv = "c064fae9173b173fd6f11f34"
              ; aad =
                  "498d3075b09fed998280583d61bb36b6ce41f130063b80824d1586e143d349b126b16aa10fe57343ed223d6364ee602257fe313a7fc9bf9088f027795b8dc1d3"
              ; msg = "f8a27a4baf00dc0555d222f2fa4fb42dc666ea3c"
              ; ct = "aed58d8a252f740dba4bf6d36773bd5b41234bba"
              ; tag = "01f93d7456aa184ebb49bea472b6d65d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 90
              ; comment = ""
              ; key =
                  "44c8d0cdb8f7e736cfd997c872a5d9c5ef30afbe44b6566606b90aa5e3e8b797"
              ; iv = "6f39afba021e4c36eb92962e"
              ; aad =
                  "98d1ca1788cbeb300ea5c6b1eec95eb2347177201400913d45225622b6273eec8a74c3f12c8d5248dabee586229786ff192c4df0c79547f7ad6a92d78d9f8952758635783add2a5977d386e0aef76482211d2c3ae98de4baadb3f8b35b510464755dc75ceb2bf25b233317523f399a6c507db214f085fa2818f0d3702b10952b"
              ; msg = "2e6f40f9d3725836ac0c858177938fd67be19432"
              ; ct = "b42428f8094ef7e65c9e8c45ef3e95c28ce07d72"
              ; tag = "32b25dfbb896d0f9d79c823bdd8e5d06"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 91
              ; comment = ""
              ; key =
                  "e40003d6e08ab80b4bfc8400ef112945a901ec64a1b6536ca92665090d608bc4"
              ; iv = "9f095dafe6f6e0fbafbbe02e"
              ; aad =
                  "422d5efcffe364905984533f0a579d80b18bda7b29e6e46498effba53c350112c0bbb8dc4ce03bb0c69e1d0baa19f0637108aa4a16b09a281f232839d87b6d0e42be1baa7c67f1be970ea169d3960b9fe0a61f11cd2eb7398c19e641feb43f778e257a397063db5b3a6707e9db62387054f9f9d44f143583e63edad45a00251e5173d7505f22a8bce232e56c2c276a58033ae30d5dbf4e35a862e42af573be38c6406d9b4c7acbf275fe36c0ecf2c4642898a30e6146fac992a16405f98312126b7a3722f5dfb7dd4e4911c1426b2e01d04e9be6db3771100f7d7d4282e4ea585f3646241e807ca64f06a7fa9b7003d710b801d66f517d2d5ebd740872deba13d0"
              ; msg = "38c3f44bc5765de1f3d1c3684cd09cddefaf298d"
              ; ct = "d4a79f729487935950ec032e690ab8fe25c4158e"
              ; tag = "876d2f334f47968b10c103859d436db8"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 92
              ; comment = "special case"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "000000000000000000000000"
              ; aad = ""
              ; msg = "561008fa07a68f5c61285cd013464eaf"
              ; ct = "23293e9b07ca7d1b0cae7cc489a973b3"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 93
              ; comment = "special case"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "ffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "c6152244cea1978d3e0bc274cf8c0b3b"
              ; ct = "7cb6fc7c6abc009efe9551a99f36a421"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 94
              ; comment = "Flipped bit 0 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9de8fef6d8ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 95
              ; comment = "Flipped bit 1 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ee8fef6d8ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 96
              ; comment = "Flipped bit 7 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "1ce8fef6d8ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 97
              ; comment = "Flipped bit 8 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce9fef6d8ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 98
              ; comment = "Flipped bit 31 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fe76d8ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 99
              ; comment = "Flipped bit 32 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d9ab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 100
              ; comment = "Flipped bit 33 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6daab1bf1bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 101
              ; comment = "Flipped bit 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1b71bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 102
              ; comment = "Flipped bit 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1be887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 103
              ; comment = "Flipped bit 71 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf13f887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 104
              ; comment = "Flipped bit 77 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bfa87232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 105
              ; comment = "Flipped bit 80 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887332eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 106
              ; comment = "Flipped bit 96 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232ebb590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 107
              ; comment = "Flipped bit 97 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232e8b590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 108
              ; comment = "Flipped bit 103 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf8872326ab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 109
              ; comment = "Flipped bit 120 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232eab590dc"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 110
              ; comment = "Flipped bit 121 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232eab590df"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 111
              ; comment = "Flipped bit 126 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232eab5909d"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 112
              ; comment = "Flipped bit 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1bf1bf887232eab5905d"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 113
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9de8fef6d8ab1bf1be887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 114
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fe76d8ab1b71bf887232eab590dd"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 115
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9ce8fef6d8ab1b71bf887232eab5905d"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 116
              ; comment = "all bits of tag flipped"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "631701092754e40e40778dcd154a6f22"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 117
              ; comment = "Tag changed to all zero"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "00000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 118
              ; comment = "tag changed to all 1"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 119
              ; comment = "msbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "1c687e76582b9b713f08f2b26a35105d"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 120
              ; comment = "lsbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "b2061457c0759fc1749f174ee1ccadfa"
              ; tag = "9de9fff7d9aa1af0be897333ebb491dc"
              ; result = "invalid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 128
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 121
              ; comment = "J0:000102030405060708090a0b0c0d0e0f"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "029e0e777db092b12535d043012f09ba"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "f83cee467336e1a09b75f24e9b4385c99c13e6af722256a66129ece961fe803b167bad206f5017fb"
              ; tag = "09338a42f0acc14f97c064f52f5f1688"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 122
              ; comment = "J0:00000000000000000000000000000000"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "f1be3b06b7feac07e7eab629f556047b"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "0b32b648a2c28e9edd7cee08eeeb900034cae7215e5ab1e201bd2eed1032c5a97866ba582a3458a4"
              ; tag = "90be3606de58bd778fa5beff4a4102bd"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 123
              ; comment = "J0:ffffffffffffffffffffffffffffffff"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "de9eb63b1daed321a11b7547cc9e223c"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "575e2ecec2b3c72d4e80830d0d859ad9e42c29c4a68d8d9d8d23434de2cd07733be49d62ac1ae085"
              ; tag = "6e4d6396125a10df5443bd0cbc8566d1"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 124
              ; comment = "J0:fffffffffffffffffffffffffffffffe"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "40bb0abebc483ff6d5671241ff5d66c6"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "2a818888d1f09f32aa7beedd2869b446575e2ecec2b3c72d4e80830d0d859ad9e42c29c4a68d8d9d"
              ; tag = "dc481f172545268eff63ab0490403dc3"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 125
              ; comment = "J0:fffffffffffffffffffffffffffffffd"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "20d5cf305e630a8f49e3bb4bab18abc9"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "96d36b795f8e7edf6a8e0dbcd20d6c072a818888d1f09f32aa7beedd2869b446575e2ecec2b3c72d"
              ; tag = "8a3a22bf2592958b930292aa47f590e8"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 126
              ; comment = "J0:000102030405060708090a0bffffffff"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "255358a71a0e5731f6dd6ce28e158ae6"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "cfce3d920f0e01f0bb49a751955b236d1b887baefd25c47f41303c46d5c7bf9ca4c2c45a8f1e6656"
              ; tag = "2db9dc1b7fd315df1c95432432fcf474"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 127
              ; comment = "J0:000102030405060708090a0bfffffffe"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "bb76e422bbe8bbe682a10be4bdd6ce1c"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "69a24169792e9a07f6e6f4736fa972dccfce3d920f0e01f0bb49a751955b236d1b887baefd25c47f"
              ; tag = "82ad967f7ac19084354f69a751443fb2"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 128
              ; comment = "J0:000102030405060708090a0bfffffffd"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "db1821ac59c38e9f1e25a2eee9930313"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "4e4417a83beac1eb7e24456a05f6ba5569a24169792e9a07f6e6f4736fa972dccfce3d920f0e01f0"
              ; tag = "472d5dd582dc05ef5fc496b612023cb2"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 129
              ; comment = "J0:000102030405060708090a0b7fffffff"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "f7a02ecca03064b2ef3cce9feab79f07"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "6f8e174efca3097299f784efd4caff0bf168c3e5165b9ad3d20062009848044eef8f31f7d2fead05"
              ; tag = "caff723826df150934aee3201ba175e7"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 130
              ; comment = "J0:000102030405060708090a0b7ffffffe"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "6985924901d688659b40a999d974dbfd"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "af193090ce3d43a388a1d294a09616906f8e174efca3097299f784efd4caff0bf168c3e5165b9ad3"
              ; tag = "3b08958be1286c2b4acba02b3674adb2"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 131
              ; comment = "J0:000102030405060708090a0bffff7fff"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "3f1188546c65ed0fc55e75032c68ee44"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "5deccf838b2cf5f869c90d2a611160b1e578ab8121b93735cba4a1930647b8c4c84bf776333ee45a"
              ; tag = "c14d52208f0f51b816a48971eaf8ff7e"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 132
              ; comment = "J0:000102030405060708090a0bffff7ffe"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "a13434d1cd8301d8b12212051fabaabe"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "d2cae1684aa407a13a2e2da5357e29f55deccf838b2cf5f869c90d2a611160b1e578ab8121b93735"
              ; tag = "ea2d018099cd7925c507cef0ceddb0ae"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 133
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "00000000000000000000000000000000"
              ; aad = ""
              ; msg = "5c7d3f81d4b5055ed6f8db53614587a4"
              ; ct = "541b835dc828d541073f7d7d7504ebf5"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 134
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "ffffffffffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "6a347ad1190e72ede611044e7475f0eb"
              ; ct = "a3f36154331c196624564bc395e49c3b"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 135
              ; comment = ""
              ; key = "fae2a14197c7d1140061fe7c3d11d9f77c79562e3593a99b"
              ; iv = "bc28433953772d57bbd933100cd47a56"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1bb94331f26cad24036cfeff34b89aaf"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 136
              ; comment = ""
              ; key = "cee9abbc26b63e169f0ced621fe21d95904e75b881d93e6b"
              ; iv = "1e8259e0a43e571068f701cd2064fc0c"
              ; aad = ""
              ; msg = "46"
              ; ct = "dc"
              ; tag = "af1f5535b125b34fc466902ea40cb3a2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 137
              ; comment = ""
              ; key = "189f0bd390ba40632586a45c39735c2b87113329c800f394"
              ; iv = "c84442d6975f0359737de0fa828f958e"
              ; aad = ""
              ; msg = "b4bcd7b8eeca3050dd17682c6a914e"
              ; ct = "2aab5c87dcb4a4dae4e975ddb65aab"
              ; tag = "6b03b7557c7131e2352e495d54e61aef"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 138
              ; comment = ""
              ; key = "b0724f15df5b792c2f49bc51df0ac5aad69be0030981613c"
              ; iv = "13cd526ec77b58f62d48d03f8b88f2b8"
              ; aad = ""
              ; msg = "8da3ab9c3d195b04df452ad23953da4d"
              ; ct = "d127fd2e67c0887d90eb92b91f357d97"
              ; tag = "eb05bda937faeed27f8833295d4ba559"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 139
              ; comment = ""
              ; key = "998750ba784841e40a7c5b03985732b6397e5459a3843954"
              ; iv = "1d3d62eccd8ac5e896f2654a7f606fc9"
              ; aad = ""
              ; msg =
                  "2f60ca3494a958dc3e6ebeb5d0b4e6dda0d0c4331ab9c957f6422a5100878ebf"
              ; ct =
                  "344c2cea17b06cb3da272e22a22a3a71ee0eaa1959a7facfff464660ddccedd1"
              ; tag = "bab7fbf499ff06aad5f757b1c1a4fcc0"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 96
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 140
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "000000000000000000000000"
              ; aad = ""
              ; msg = "0b4dbbba8982e0f649f8ba85f3aa061b"
              ; ct = "3f875c9bd7d8511448459468e398c3b2"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 141
              ; comment = "special case"
              ; key = "00112233445566778899aabbccddeeff1021324354657687"
              ; iv = "ffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "1ae93688ef7e2650a9342ad4718b2780"
              ; ct = "210dabea4364c6d5b3429e7743322936"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 142
              ; comment = ""
              ; key = "5019eb9fef82e5750b631758f0213e3e5fcca12748b40eb4"
              ; iv = "ff0ddb0a0d7b36d219da12b5"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "7971284e6c9e6aac346fe2b7a0a064c2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 143
              ; comment = ""
              ; key = "21218af790428f8024d3e7e1428c9fcf578c216636d60e73"
              ; iv = "34047bc39b9c608384dff5b8"
              ; aad = ""
              ; msg = "e3"
              ; ct = "fe"
              ; tag = "2e982e24b81cd120d35a70fe6935e665"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 144
              ; comment = ""
              ; key = "3a8bf543c480925632118245bcbf5d01522b987a31a33da3"
              ; iv = "4ebc13cf4636cc7c45e560a7"
              ; aad = ""
              ; msg = "53fc72e71b59eeb3"
              ; ct = "99f2ff1c8a44e5f2"
              ; tag = "6870f104ddc514477b400336fb01860e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 145
              ; comment = ""
              ; key = "92f4d2672fceec43963ccffb17e6ea7578b11418b06a3b82"
              ; iv = "6e7ff7f0797685cfc44b05ff"
              ; aad = ""
              ; msg = "c3ec16adb184affa8ae9738bffb916"
              ; ct = "afe8ef41591bfcc00db3c880ceb186"
              ; tag = "29fff7f285768645c9c8bf7a471c9393"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 146
              ; comment = ""
              ; key = "bcb6bc5ee6743df1396a34639327b25809ec9c81dd6a0c0e"
              ; iv = "be0326d23bdc2c64648d13f4"
              ; aad = ""
              ; msg = "80474a3a3b809560eee2ce7a7a33ea07"
              ; ct = "90339dca02ef717f1603994aee6cf6d2"
              ; tag = "e3d33e01ce64f271783147de226228bc"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 147
              ; comment = ""
              ; key = "5e1d28213e092536525bbae09e214af4c891e202b2b4fa4f"
              ; iv = "b6be6cd0681235d826aa28ea"
              ; aad = ""
              ; msg = "53d59433a7db7f41b31ccb6d4a2d789965"
              ; ct = "b98ed6321679941a3e521834296686ad98"
              ; tag = "9f50c03e055e519712c582ec9db3235b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 148
              ; comment = ""
              ; key = "7f672d85e151aa490bc0eec8f66b5e5bee74af11642be3ff"
              ; iv = "b022067048505b20946216ef"
              ; aad = ""
              ; msg = "ef6412c72b03c643fa02565a0ae2378a9311c11a84065f80"
              ; ct = "addd303651119e52f6170dfc7a915064253d57532987b9ab"
              ; tag = "fa0484f8baa95f5b7a31c56d1b34c58b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 149
              ; comment = ""
              ; key = "969fed5068541d65418c2c1de8fe1f845e036030496e1272"
              ; iv = "817fe51c31f2879141a34335"
              ; aad = "cb"
              ; msg = "3d8233191a2823bf767e99167b1d4af4f4848458"
              ; ct = "0d2c3a3c0cc4b40e70ed45e188e356a0e1533b31"
              ; tag = "92909a80e90540e1878ab59ef300072b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 150
              ; comment = ""
              ; key = "fa5b9b41f93f8b682c04ba816c3fecc24eec095b04dd7497"
              ; iv = "62b9cf1e923bc1138d05d205"
              ; aad = "2ed8487153e21b12"
              ; msg = "18159841813a69fc0f8f4229e1678da7c9016711"
              ; ct = "c7c1cbb85ce2a0a3f32cb9ef01ad45ec1118b66d"
              ; tag = "253317f98bdab87531ece20475cd9ebb"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 151
              ; comment = ""
              ; key = "fbfb395662787e2d25a2e7510f818e825936a35114e237c9"
              ; iv = "3f1a1e02e90a4ba7a1db9df2"
              ; aad = "74318d8876528243f1944b73eb77e96e"
              ; msg = "2952a3d64107d5cbb9602239d05a5c5c222cf72b"
              ; ct = "ecf5e403f19c007c8da7a456caf0a6d75762829b"
              ; tag = "e0877a100f9dd9d6795f0e74c56a9fab"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 152
              ; comment = ""
              ; key = "5d8e9c2222316c9ed5ff94513cc957436ae447a6e1a73a29"
              ; iv = "0802ae86c75a73bf79561521"
              ; aad = "5ca354a4cb8e4fc9798aa209ad4f739dc7c232fdd1f22584"
              ; msg = "42b4439e1d2116f834b91c516a26299df279956b"
              ; ct = "94d844d98b9467daa7e8dde7f4290037354d7fb2"
              ; tag = "62196638590cef429d6b1d1a59839c02"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 153
              ; comment = ""
              ; key = "ccbd0f509825a5f358a14aac044ae2826bb2c9eaaaaa077f"
              ; iv = "9189a71ac359b73c8c08df22"
              ; aad = ""
              ; msg =
                  "a1ed1007b52e36ec0f70109c68da72ee7b675c855e3e4956d2dcf9d12f675d6933f677ddcc58face857699d2e3d90adcb8c6c57c9d88b5dfcf356de4c0b63f0e"
              ; ct =
                  "e9915bc5aea63c8bc014f2ae6a4986b03115ff1f34ad6c0acd74ffca07c453ec3f3ce6902d5ff338c588a34a1c3b30ef753ec7001572cbfeafe690fd00f59b02"
              ; tag = "fbf19b6b90e2d9df7ead0c3bc6e375a2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 154
              ; comment = ""
              ; key = "d045c6eb173f440843faec3e9374602a94ee3f7176312208"
              ; iv = "98e9153daca2522e3162cb15"
              ; aad = ""
              ; msg =
                  "3f0b30dc963a82d182c035b5a823060f07c4123792e6cee6bf91fea3c52fa66bb6a93ea6cce9f4813eb95bf18f816c00ad4fb56932827a39efb2fe56804e604a606774ee92ad46cd8c172a0d2bdea2fc99f67cd82c6024c315cfee6dbb8d27f745c9d0ce9bf5d09724f4bed003cf39478348b3304baa4ecc9974fc4f3ff93f95"
              ; ct =
                  "9663e6f98b2768448e6dd0dd780e145668af5b002257e353213868c9cd9fd3a1e9427530327541775a093123076d34985db3aa248cd55e532609d1a39274c49216ea20fbab719b9c7e310b27877b9a33d1b69ab747afac944d1e97ea789367821c331f00b5d618402bfc57884d18edbd60c4dfe218c08080b8e3479ff84bdfb5"
              ; tag = "fc2ff62a41bdb79afc369842e4eccabf"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 155
              ; comment = ""
              ; key = "e602188abf6a91f3e258838cea6befeffcf6257a509c3e95"
              ; iv = "9e35d3ef1897c5fe3f647204"
              ; aad = ""
              ; msg =
                  "3b9a6edc44848c072341fd4af51ec116ac328f69cc5a3354e49299fb2e5d22fa0084e30b36ecaf54309397b2b498d686087f3457698c3639e73ca18c78c3e021d673986cfc2ceb4d07e66971e976f58f0336f82c7fc0d52d66610f26ca3bfe53c0b01cf7c207306db904c1ad300ab95c56fde820a8edd256f2b9906b312bf7af5ef4a806f618ddfcb67179b03fff80a245c38d8f4cff2875b71a0bf69129caf97121462e0501ec6574ede94706f4a04d2fb301d415c22ea12157d2e919bc7a0169a5ad5c7bb5761a8531abbe77d66a4871b3f27a7170f099044b9fdc50a8cb3b894252a501cc896ac4793bdb478bb1cb99c02341d7238dd8d593cfda02f7d520d7"
              ; ct =
                  "167183661675677625bed2d5f55f728dab80d7f06f629d99e58b45069fe9d7428e8961561b11245c709ac9ebb5c59ac2a89d8375d8a01d849c7733a1b482529927e3f1a1a53f63a4be08a11c941c634cd40373c42ffb2449c641bc9e39eafbcf9c0fba677e36496f73fc70aa0972224901ab04b0a196ab745262021b2313a8464187fecec43adb406258bddcd8c9d04dc2ae29e65d54a89dd0f1752d6d950dbf7da4dea0a7b9465579503fc8ec4451f4b39878ac4754a1aaf7b0b73fee11213cb8e601fc6039393f72e0e079ee97ecc610241757da2db2f51d5ed121481540eff47287744dac43375c4f48a46af70190453a17c3c78d735ba1d1fc76a330e6cbed"
              ; tag = "c72035314f43d256f8d845eb696bd943"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 156
              ; comment = ""
              ; key = "55a4ca526443357ac7c896d9a67cf7d467f6921d69002d3a"
              ; iv = "dba233ccbc7992e64e82cfa3"
              ; aad =
                  "df737cd77d31eb9097a17c31b4c92889ef1f32b7464e2620e9007192ea675b9ad6910527ffecee2452be0248fab75608c7fdca08e86580322aac1d6a11b96ecf"
              ; msg = "4e56d1ea538cf49cad49959e884eb540c846556c"
              ; ct = "3f57ec1b414f74818fead9f35aa1679402c3e750"
              ; tag = "97b89b291419e32cf654ea630a3ad014"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 157
              ; comment = ""
              ; key = "f381d0ffd3373a1aa02edd1d7fa748e91908fe534bef73d2"
              ; iv = "10aaec0de4ad75376be9fd41"
              ; aad =
                  "7739aad7399d9c0f0a3c95b403888f0072d94acb76ff576e05f4a063120b84e722b4d5cd43a58e4abab444cb8ced112f3dbd8993b831c39b4edb76e92eb33ee24c5922b56552685f3b0f4cf22e0e11628f6a3d33eff9def7ec527112dfafcf122814e3d1aaf66c3f970526511088bffef8101d1cef833268ff80387df30557f7"
              ; msg = "653a3f033c2775e08fef73cf80f5e2699fb360cb"
              ; ct = "5565c6d09c4c924d61c0ef808fb0ea144ffb4738"
              ; tag = "12b72ec1d9c32fb22c13c40b33796fa9"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 158
              ; comment = ""
              ; key = "8f27b1c3b3d7023c76ee66c768a3e92d4971e25f729d8788"
              ; iv = "12444040caede67285e490d7"
              ; aad =
                  "58fd02ac23ec7fa5b9460f60bfc85b4bebba70039a8f83261d6cc4f560107c10bc69548a5d6152882fb465fd59fb8164d7c94523c3dd4206d33064f5191bd31f0c48fe03d7460e995c93175b57cb03f58711adc94632031c4305272367b4289c725d9cb7ae9ba996b3a079174508c1eae8162a0bac446c1e53fe0c402b6912dfd6702addccada30a5c010fc22c2c75e43226378ec7f4b3b71ccc71f32ab1adc877cc7b0a180c75d385c0f71a0b291a1cccf4be47e272249d61ffbf059c4f7be74eba07d5e1be3a7438458a611fe58cee4f946e25dee03e6485235566f20ed555be32cd57a94e522d2168eae23c4587371a2d145f418c59e7bbc464a3bd88b8919b"
              ; msg = "0df6e750092b9ac576dde66006a4cab2116eee21"
              ; ct = "c6877b03552e97d9a1e6557f90dc7adde15a2f43"
              ; tag = "2536272bee7446820041854e10b49a03"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 159
              ; comment = "Flipped bit 0 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b5e44c5b2fe90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 160
              ; comment = "Flipped bit 1 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b6e44c5b2fe90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 161
              ; comment = "Flipped bit 7 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "34e44c5b2fe90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 162
              ; comment = "Flipped bit 8 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e54c5b2fe90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 163
              ; comment = "Flipped bit 31 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44cdb2fe90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 164
              ; comment = "Flipped bit 32 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2ee90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 165
              ; comment = "Flipped bit 33 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2de90e4c78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 166
              ; comment = "Flipped bit 63 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90ecc78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 167
              ; comment = "Flipped bit 64 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c79f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 168
              ; comment = "Flipped bit 71 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4cf8f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 169
              ; comment = "Flipped bit 77 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78d358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 170
              ; comment = "Flipped bit 80 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f359da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 171
              ; comment = "Flipped bit 96 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0c99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 172
              ; comment = "Flipped bit 97 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0f99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 173
              ; comment = "Flipped bit 103 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da8d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 174
              ; comment = "Flipped bit 120 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0d99cb65"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 175
              ; comment = "Flipped bit 121 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0d99cb66"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 176
              ; comment = "Flipped bit 126 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0d99cb24"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 177
              ; comment = "Flipped bit 127 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90e4c78f358da0d99cbe4"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 178
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b5e44c5b2fe90e4c79f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 179
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44cdb2fe90ecc78f358da0d99cb64"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 180
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b4e44c5b2fe90ecc78f358da0d99cbe4"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 181
              ; comment = "all bits of tag flipped"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "4b1bb3a4d016f1b3870ca725f266349b"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 182
              ; comment = "Tag changed to all zero"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "00000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 183
              ; comment = "tag changed to all 1"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 184
              ; comment = "msbs changed in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "3464ccdbaf698eccf873d85a8d194be4"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 185
              ; comment = "lsbs changed in tag"
              ; key = "000102030405060708090a0b0c0d0e0f1011121314151617"
              ; iv = "505152535455565758595a5b"
              ; aad = ""
              ; msg = "202122232425262728292a2b2c2d2e2f"
              ; ct = "458256842dfd297f30bd2f8f15c92db0"
              ; tag = "b5e54d5a2ee80f4d79f259db0c98ca65"
              ; result = "invalid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 128
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 186
              ; comment = "J0:000102030405060708090a0b0c0d0e0f"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "5c2ea9b695fcf6e264b96074d6bfa572"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "28e1c5232f4ee8161dbe4c036309e0b3254e9212bef0a93431ce5e5604c8f6a73c18a3183018b770"
              ; tag = "d5808a1bd11a01129bf3c6919aff2339"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 187
              ; comment = "J0:00000000000000000000000000000000"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "57b3a81f2c36b6b06577ca0fbab8fa8e"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "cceebeb4fe4cd90c514e52d2327a2ecd75393661006cf2476d8620149aef3d1cdce491fff3e7a7a3"
              ; tag = "8132e865b69d64ef37db261f80cbbe24"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 188
              ; comment = "J0:ffffffffffffffffffffffffffffffff"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "ce20a7e870696a5e68533c465bad2ba1"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "4f4350565d91d9aa8c5f4048550492ad6d6fdabf66da5d1e2af7bfe1a8aadaa0baa3de38a41d9713"
              ; tag = "155da6441ec071ef2d8e6cffbacc1c7c"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 189
              ; comment = "J0:fffffffffffffffffffffffffffffffe"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "918e3c19dbdfee2db18156c5b93f3d75"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "8316a53167b6de1a7575700693ffef274f4350565d91d9aa8c5f4048550492ad6d6fdabf66da5d1e"
              ; tag = "6c574aa6a2490cc3b2f2f8f0ffbc56c4"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 190
              ; comment = "J0:fffffffffffffffffffffffffffffffd"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "717d900b270462b9dbf7e9419e890609"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "5175927513e751eb309f45bc2ef225f28316a53167b6de1a7575700693ffef274f4350565d91d9aa"
              ; tag = "8082a761e1d755344bf29622144e7d39"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 191
              ; comment = "J0:000102030405060708090a0bffffffff"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "ecd52120af240e9b4bf3b9d1eeb49434"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "36b3fbecd09178d04527fb37544f5579d20d60a41266f685c48098e1a52804ca387d90709d3268dd"
              ; tag = "033e0ef2953ebfd8425737c7d393f89a"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 192
              ; comment = "J0:000102030405060708090a0bfffffffe"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "b37bbad104928ae89221d3520c2682e0"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "16929b773051f12b0adac95f65e21a7f36b3fbecd09178d04527fb37544f5579d20d60a41266f685"
              ; tag = "ca448bb7e52e897eca234ef343d057d0"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 193
              ; comment = "J0:000102030405060708090a0bfffffffd"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "538816c3f849067cf8576cd62b90b99c"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "6d3faefaf691d58163846f8d4b9ffd5916929b773051f12b0adac95f65e21a7f36b3fbecd09178d0"
              ; tag = "84f49740e6757f63dd0df7cb7656d0ef"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 194
              ; comment = "J0:000102030405060708090a0b7fffffff"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "d10e631943cd3bdababab2bbd13951c0"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "d60196c2d14fcf30c0991d2721ddc52d385f407a16691dade82c9023c855fd8e2e8fbb562102f018"
              ; tag = "877e15d9889e69a99fcc6d727465c391"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 195
              ; comment = "J0:000102030405060708090a0b7ffffffe"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "8ea0f8e8e87bbfa96368d83833ab4714"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "948fbceca12a6e4fabb79b6d965e336fd60196c2d14fcf30c0991d2721ddc52d385f407a16691dad"
              ; tag = "cd5757626945976ba9f0264bd6bee894"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 196
              ; comment = "J0:000102030405060708090a0bffff7fff"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "7b2df4fbed1de2727eb24898e5deabb9"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "a1a0120660ff52e6b1700b12c54d2d33b94b00cd7882d8857d84e6e183a1dea6ee85a7da84fbc35d"
              ; tag = "b015d72da62c81cb4d267253b20db9e5"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 197
              ; comment = "J0:000102030405060708090a0bffff7ffe"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "24836f0a46ab6601a760221b074cbd6d"
              ; aad = ""
              ; msg =
                  "00000000000000000000000000000000000000000000000000000000000000000000000000000000"
              ; ct =
                  "5e3434b45edbf0d1f6e02d1144dbf867a1a0120660ff52e6b1700b12c54d2d33b94b00cd7882d885"
              ; tag = "ee74ccb30d649ebf6916d05a7dbe5696"
              ; result = "valid"
              ; flags = [ "ConstructedIv" ]
              }
            ; { tcId = 198
              ; comment = "special case"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "00000000000000000000000000000000"
              ; aad = ""
              ; msg = "8d74f1c97243d362577ff376c393d2dc"
              ; ct = "265c42e2b96ea1de9c24f7182e337390"
              ; tag = "00000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 199
              ; comment = "special case"
              ; key =
                  "00112233445566778899aabbccddeeff102132435465768798a9bacbdcedfe0f"
              ; iv = "ffffffffffffffffffffffffffffffff"
              ; aad = ""
              ; msg = "884df0e76f3ce227bf9595d103825a46"
              ; ct = "988f47668ea650cbaa6714711abe268d"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 200
              ; comment = ""
              ; key =
                  "b4cd11db0b3e0b9b34eafd9fe027746976379155e76116afde1b96d21298e34f"
              ; iv = "00c49f4ebb07393f07ebc3825f7b0830"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "306fe8c9645cc849823e333a685b90b2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 201
              ; comment = ""
              ; key =
                  "b7797eb0c1a6089ad5452d81fdb14828c040ddc4589c32b565aad8cb4de3e4a0"
              ; iv = "0ad570d8863918fe89124e09d125a271"
              ; aad = ""
              ; msg = "ed"
              ; ct = "3f"
              ; tag = "fd8f593b83314e33c5a72efbeb7095e8"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 202
              ; comment = ""
              ; key =
                  "4c010d9561c7234c308c01cea3040c925a9f324dc958ff904ae39b37e60e1e03"
              ; iv = "2a55caa137c5b0b66cf3809eb8f730c4"
              ; aad = ""
              ; msg = "2a093c9ed72b8ff4994201e9f9e010"
              ; ct = "041341078f0439e50b43c991635117"
              ; tag = "5b8a2f2da20ef657c903da88ef5f57bb"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 203
              ; comment = ""
              ; key =
                  "e7f7a48df99edd92b81f508618aa96526b279debd9ddb292d385ddbae80b2259"
              ; iv = "7ee376910f08f497aa6c3aa7113697fd"
              ; aad = ""
              ; msg = "5e51dbbb861b5ec60751c0996e00527f"
              ; ct = "469478d448f7e97d755541aa09ad95b0"
              ; tag = "254ada5cf662d90c5e11b2bd9c4db4c4"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 204
              ; comment = ""
              ; key =
                  "4f84782bfbb64a973c3de3dcfa3430367fd68bc0b4c3b31e5d7c8141ba3e6a67"
              ; iv = "5d1bde6fa0994b33efd8f23f531248a7"
              ; aad = ""
              ; msg =
                  "78cb6650a1908a842101ea85804fed00cc56fbdafafba0ef4d1ca607dcae57b6"
              ; ct =
                  "cb960201fa5ad41d41d1c2c8037c71d52b72e76b16b589d71b976627c9734c9d"
              ; tag = "8dfce16467c3a6ebb3e7242c9a551962"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 120
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 205
              ; comment = "unusual IV size"
              ; key = "34c74e28182948e03af02a01f46eb4f7"
              ; iv = "b0a73119a97d623806b49d45ddf4c7"
              ; aad = ""
              ; msg = "fe82ba66cf2e265741f2c86c"
              ; ct = "2bc3ef8e7402b4631f48e9be"
              ; tag = "4b6f6f5be291a90b9e93a8a82ddbc8d8"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 160
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 206
              ; comment = "unusual IV size"
              ; key = "55cb7cac77efe18a1ea3b30c65f3f346"
              ; iv = "e22b6b144ab26b5781316e7a42a76202ac4b2278"
              ; aad = ""
              ; msg = "2f3d11ea32bf5bc72cbe2b8d"
              ; ct = "4fe13ef29f118f85a63188f8"
              ; tag = "05975b175316df8045889f43e0c857e0"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 120
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 207
              ; comment = "unusual IV size"
              ; key = "66f75acbd8d3acf7af47d13e8384c2809d6b91503a7f294b"
              ; iv = "edf93e16294f15eded83808f09320e"
              ; aad = ""
              ; msg = "a900c86b6b7e0e5563f8f826"
              ; ct = "9af1a022c61c4315aa0e923e"
              ; tag = "20529bff3c59222ec33353af337b1d40"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 160
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 208
              ; comment = "unusual IV size"
              ; key = "ef2e299dd4ecd7e3b9cc62780922cc2c89f78840564d1276"
              ; iv = "130c14c839e35b7d56b3350b194b0da342e6b65d"
              ; aad = ""
              ; msg = "03f59579b14437199583270e"
              ; ct = "073a5291b11df379f31b4f16"
              ; tag = "17205999491bd4c1d6c7ec3e56779c32"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 120
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 209
              ; comment = "unusual IV size"
              ; key =
                  "e98b0669a645eb14cd06df6968fc5f10edc9f54feed264e3d410cdc61b72ef51"
              ; iv = "17ca250fb733877556263223eadde1"
              ; aad = ""
              ; msg = "f384b3ed7b274641f5db60cf"
              ; ct = "fc213602aa423b87d7c2a874"
              ; tag = "36b15bab6923b17218fe1c24048e2391"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 160
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 210
              ; comment = "unusual IV size"
              ; key =
                  "849b3e6b8cdd85bdcfb8eb701aa5522ae2340fbe5214e389622cef76979225c4"
              ; iv = "0f9d6ed7eef362dfa4a7dfa5c0f74c5b27bd4ebf"
              ; aad = ""
              ; msg = "8c5564e53051c0de273199b4"
              ; ct = "c1d76233e8c5042e92bf8d32"
              ; tag = "7cf036d235d3b2dd349a8c804b65144a"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 256
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 211
              ; comment = "long IV size"
              ; key = "5927bae748bb69d81b5a724e0a165652"
              ; iv =
                  "365e0b96932b13306f92e9bb23847165bcbf5d35e45a83d75c86ecca70131f4c"
              ; aad = ""
              ; msg = "316bf99bfafc76f1bfc0b03c"
              ; ct = "5348af57fafe2485b43f2bc4"
              ; tag = "019a96c5373c031626b6c0300d4cf78b"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 512
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 212
              ; comment = "long IV size"
              ; key = "dbd3676f293409273f27b375e03793a3"
              ; iv =
                  "967fa7c990eb2becbd450835e28ea3a9000c7216285cfa7696e8c3dac3ce952a1fe638d7c8c73e1d708dce01b5a20fcc9aa011949d2a835f777423c172fa3aa0"
              ; aad = ""
              ; msg = "625efedb8b7f1aa62238a8f2"
              ; ct = "f559b70fe1149cb34406a2c7"
              ; tag = "94180ddb7bb1995abe0219eab5ce232f"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 1024
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 213
              ; comment = "long IV size"
              ; key = "7e5a39dcda7e066988f19adf4de4d501"
              ; iv =
                  "494356c3459d60e3a83433c9bcf2c0454a763e496e4ec99bfbe4bbb83a4fda76b542213899dcf5521cd9bbbe5d11545bda44a3f4a681ce2843acea730d83d3930ea30991ee1a68ebf6d1a5a40f9b02a1aab091298df8dd689dc7613bcbff94d35f2ca43377d81618562bcf6573411ec9bc97c5a6276b554054c0fa787073d067"
              ; aad = ""
              ; msg = "b04729b4adbaac63c2aaf8d8"
              ; ct = "5291dd4da91ccc2e77306d83"
              ; tag = "a7f7b21a3b7ece509e922647fd905f06"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 2056
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 214
              ; comment = "long IV size"
              ; key = "eac3f28cd937ff29eb6158a3721b5145"
              ; iv =
                  "6fd260bba87339539c37dc68fdc3656f63c83028cb8adcb531085e98bd570c6b735d0cc4b4b924696000a2d893621ae64dcce992b562b89a5285643a08febccbc52243cbfc8d45212e047b00c87c6b6bf175f8bb678ec55c1091315cbecb8b85700f4a4653623fb78e63cfff7d6235e48e9832c9f0716d10992fc5b0ad4e6972bbeeb1ad670cd7ec8fac82e07ea5a64f9761a39714aaa73affd2cb190a7ac2df5e5dcea6812ae2c872c7ac70453c5e7ec4d0b5b18c6ff3bfb9ae15fea44cf392615b80034edae596b8821f97fca58d167fb44a093b0c009a0bd5631355b0cb25d93ba9b79b006301d99db657e801933fc2764a0ce650eaf5a1299efe60cb53b634"
              ; aad = ""
              ; msg = "098912a302773377b9c26ac3"
              ; ct = "e3be947153a26a3a54e3015c"
              ; tag = "fd042bdde22f67c4fd298d5dc0867606"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 256
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 215
              ; comment = "long IV size"
              ; key = "8f9ebc67a9a6430c2b0ceeaf983e1356964bb928635b9ca4"
              ; iv =
                  "36e4b381574d171c7769a788cbc147224fabd8b773f16b8ae84d8f2603aaa440"
              ; aad = ""
              ; msg = "a3a96ee94f94caa81ebcd66d"
              ; ct = "8c2a9823a3b3d413be696387"
              ; tag = "faaf01ceb40a7e145e8fe65aa9af58c0"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 512
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 216
              ; comment = "long IV size"
              ; key = "f4bbdfd06f7fb1434880e4166d38d56e02a3f0df0d5301ce"
              ; iv =
                  "90743bd5d794d52ac848b7e2384545a25846acf143be84c0ead0432fcf3172631cf58d0ca78571c03053c1e1b85ed79cb5303d0e3a98ff4f56c4f0a5eb4f0eac"
              ; aad = ""
              ; msg = "39d2abe6697f17ec27f2a39c"
              ; ct = "a660ea5bf07a78fea0120173"
              ; tag = "7404fc7b7354694428236f203c130244"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 1024
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 217
              ; comment = "long IV size"
              ; key = "1761c77798ef9cdfa40553f34614fe7402212087f0509411"
              ; iv =
                  "fbb3eab379c9b8689dc30b0713690e55d51c956ca36fbcc73eeeee16a46d7c41a7a9626e68e25d685c008c19d3b2b1792bdc99c35441a6fcac35e0d6446dd914f543abd9ecd6b0cb5201c243026c4f13641d67c8d8cd5114b6e11ebbc6b1dee2a18db2150a5a575dcd21648e0337dadbccd3deffd6d979e03e6b9ddfee0abdc2"
              ; aad = ""
              ; msg = "35ca4eb463a2000138210b4d"
              ; ct = "f400132ff38c04ed747dde34"
              ; tag = "ca1534e7dd0336bbb32a79830c71a447"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 2056
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 218
              ; comment = "long IV size"
              ; key = "f795ece7de1881fbc6843eb740f812e41e3fc49ff6c7b940"
              ; iv =
                  "3569fca7c9d06e2a03fed1aac2484fd4416ca07d55ecbb333ec674f0ea5c6e75a10dfb9c738b69dab2eda10ada721a61c7f02b7e7f79e8a9e2dc36b3fdf609e436054c82a774ec617dceec84a577037ff1a3f120d9818d042063acb36c9584e81ec94f11f1ee240f2e45e944694a9c8e535acbb01d93958411cff68e3d32f8931746a4a0cece65e93c51c70b3111034b6867b407e0147f97c576d3ed8cec7e8ec26e95643e46e97ea3595c9c3172b4856f2d2b6dc8564666ddac92c794ffb2d4dc7f461761f0e326650f48d327604e095bd8754072116c96360d09f010ac2f39eb96b227f3d738deb756c8699460d88cf716170ae15267b14f4a89164720f1c602"
              ; aad = ""
              ; msg = "22dbd8037aa05b14cf81dd23"
              ; ct = "13a95a06c1bed4845af9c701"
              ; tag = "03379836b0c82f64a1bccdcd763acbbc"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 256
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 219
              ; comment = "long IV size"
              ; key =
                  "ee4171917d2337496812a2784d6a71300e6b8c1ac3b1ef58cee77c229aeaf2c5"
              ; iv =
                  "e826a79361f9d582b64450e3edc82589487853d5b22feaa0c889875bd0d87cd4"
              ; aad = ""
              ; msg = "94d2f8697facaaa191ba617a"
              ; ct = "a295c2cb27ce23d26874ade1"
              ; tag = "04650a78bbb61db337c9c32aa3e7b6fa"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 512
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 220
              ; comment = "long IV size"
              ; key =
                  "132c59b4bcb8afb31637734a81105bb2c9878f320ace9076d5fd7c5d216c8d12"
              ; iv =
                  "ec51ee18cfb46897d3666c7df35c29ca5d898241c4a34f893eb1db5d5c6b76e24617459d1153868154437a0e95aa3c26e956b494a52dd5ac3b9331116c7c775f"
              ; aad = ""
              ; msg = "12c7be00facda49596e19134"
              ; ct = "9cdcfc3aaa8d466f25588e4b"
              ; tag = "7e80f51e7180f1cd3ba84349888fcd5c"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 1024
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 221
              ; comment = "long IV size"
              ; key =
                  "7b0b12491901d62d097fa26dc71e15cfacafa3226719e47126d99c79d98ec222"
              ; iv =
                  "7d08b226b4a5d03f6f8cb3a3cb8d1ce31b059dc5112385275e38a15c97e0f24022b249a5f7019ea577198cb26ac64e82b2b04681537c4198775a523b0e6494b84febaef3399b35c27b0969fa43572bf5827a763aac1af69526f37e38acb5d354f2b68487f275f4361ed39073f7dd6653ac17c0794118a0cf143293ac0be66229"
              ; aad = ""
              ; msg = "c80312590700c3bbfacd1a40"
              ; ct = "3f3c151e984d059462f9e5a0"
              ; tag = "e559f5f755aa292171cc35fbf911a64f"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 2056
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 222
              ; comment = "long IV size"
              ; key =
                  "3bc3bf39d0d5ffd94cca2b45c678a2d049151ed2babc713be53cb66f54a16337"
              ; iv =
                  "92c2cee7e9138b186da51f146fb21fd5b491f1a19eef61d4ed14ce6b21b04fdb6ff8ebb60fddc55926e7bda2a8f35c610bb795232412739d6c2d74458ef5a1a1cde9bf17e47e3b00db0b0504d56dc8b8d3de23f7c3a5d52e8d0aab1e64405aaa852ec2dd667ed9c1fd8dc1fdbbc8712c7a38f30faeab594f33897b41b1720f3c2f954ed91ca450d82c3dcd35858c608ad42f36832e56b04821a132f72e0da7b62cbd3925250f64fbb3f5c4783495893097adc09a32d776e04bf72558d37830b372341f6536d8ee9df4a82e4074e7774ab6917a04fa8c499eb4b46a92def365da8b5eb1e0b438779507d1f5272a6e8629a3f9c7bd4862c5691ee8b56bfe292deb4e"
              ; aad = ""
              ; msg = "8125ee7637d7d0e03bbacf35"
              ; ct = "5496ae94c3322ebf959ea9a9"
              ; tag = "70717cc00fd1ffa59bb04329226a0c0a"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { ivSize = 0
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 223
              ; comment = "0 size IV is not valid"
              ; key = "8f3f52e3c75c58f5cb261f518f4ad30a"
              ; iv = ""
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "cf71978ffcc778f3c85ac9c31b6fe191"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ; { tcId = 224
              ; comment = "0 size IV is not valid"
              ; key = "2a4bf90e56b70fdd8649d775c089de3b"
              ; iv = ""
              ; aad = ""
              ; msg = "324ced6cd15ecc5b3741541e22c18ad9"
              ; ct = "00a29f0a5e2e7490279d1faf8b881c7b"
              ; tag = "a2c7e8d7a19b884f742dfec3e76c75ee"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ]
        }
      ; { ivSize = 0
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 225
              ; comment = "0 size IV is not valid"
              ; key = "0b18d21337035c7baa08211b702fa780ac7c09be8f9ed11f"
              ; iv = ""
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "ca69a2eb3a096ea36b1015d5dffff532"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ; { tcId = 226
              ; comment = "0 size IV is not valid"
              ; key = "ba76d594a6df915bb7ab7e6d1a8d024b2796336c1b8328a9"
              ; iv = ""
              ; aad = ""
              ; msg = "d62f302742d61d823ea991b93430d589"
              ; ct = "509b0658d09f7a5bb9db43b70c8387f7"
              ; tag = "2c9488d53a0b2b5308c2757dfac7219f"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ]
        }
      ; { ivSize = 0
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 227
              ; comment = "0 size IV is not valid"
              ; key =
                  "3f8ca47b9a940582644e8ecf9c2d44e8138377a8379c5c11aafe7fec19856cf1"
              ; iv = ""
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1726aa695fbaa21a1db88455c670a4b0"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ; { tcId = 228
              ; comment = "0 size IV is not valid"
              ; key =
                  "7660d10966c6503903a552dde2a809ede9da490e5e5cc3e349da999671809883"
              ; iv = ""
              ; aad = ""
              ; msg = "c314235341debfafa1526bb61044a7f1"
              ; ct = "7772ea358901f571d3d35c19497639d9"
              ; tag = "8fe0520ad744a11f0ccfd228454363fa"
              ; result = "invalid"
              ; flags = [ "ZeroLengthIv" ]
              }
            ]
        }
      ; { ivSize = 8
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 229
              ; comment = "small IV sizes"
              ; key = "59a284f50aedd8d3e2a91637d3815579"
              ; iv = "80"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "af498f701d2470695f6e7c8327a2398b"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 230
              ; comment = "small IV sizes"
              ; key = "fec58aa8cf06bfe05de829f27ec77693"
              ; iv = "9d"
              ; aad = ""
              ; msg = "f2d99a9f893378e0757d27c2e3a3101b"
              ; ct = "0a24612a9d1cbe967dbfe804bf8440e5"
              ; tag = "96e6fd2cdc707e3ee0a1c90d34c9c36c"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 16
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 231
              ; comment = "small IV sizes"
              ; key = "88a972cce9eaf5a7813ce8149d0c1d0e"
              ; iv = "0f2f"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "4ccf1efb4da05b4ae4452aea42f5424b"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 232
              ; comment = "small IV sizes"
              ; key = "b43967ee933e4632bd6562ba1201bf83"
              ; iv = "8760"
              ; aad = ""
              ; msg = "5a6ad6db70591d1e520b0122f05021a0"
              ; ct = "ba3e7f8b2999995c7fc4006ca4f475ff"
              ; tag = "98f47a5279cebbcac214515710f6cd8a"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 32
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 233
              ; comment = "small IV sizes"
              ; key = "4e9a97d3ed54c7b54610793ab05052e1"
              ; iv = "cc851957"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "e574b355bda2980e047e584feb1676ca"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 234
              ; comment = "small IV sizes"
              ; key = "d83c1d7a97c43f182409a4aa5609c1b1"
              ; iv = "7b5faeb2"
              ; aad = ""
              ; msg = "c8f07ba1d65554a9bd40390c30c5529c"
              ; ct = "1b84baea9df1e65bee7b49e4a8cda1ec"
              ; tag = "5c0bb79d8240041edce0f94bd4bb384f"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 48
        ; keySize = 128
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 235
              ; comment = "small IV sizes"
              ; key = "c6a705677affb49e276d9511caa46145"
              ; iv = "4ad80c2854fb"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1e2ed72af590cafb8647d185865f5463"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 236
              ; comment = "small IV sizes"
              ; key = "eba7699b56cc0aa2f66a2a5be9944413"
              ; iv = "d1dafc8de3e3"
              ; aad = ""
              ; msg = "d021e53d9098a2df3d6b903cdad0cd9c"
              ; ct = "18291aa8dc7b07448aa8f71bb8e380bf"
              ; tag = "9c0e22e5c41b1039ff5661ffaefa8e0f"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 8
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 237
              ; comment = "small IV sizes"
              ; key = "c70ce38e84e5f53ed41c3f0d2ca493412ad32cb04c6e2efa"
              ; iv = "cb"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "08d96edb5e22874cd10cb2256ca04bc6"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 238
              ; comment = "small IV sizes"
              ; key = "74c816b83dfd287210a3e2c6da8d3053bbfbd9b156d3fdd8"
              ; iv = "0f"
              ; aad = ""
              ; msg = "f2b7b2c9b312cf2af78f003df15c8e19"
              ; ct = "6c5e796ba9a3ddc64f401e68d135101d"
              ; tag = "96a132ed43924e98feb888ff682bdaef"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 16
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 239
              ; comment = "small IV sizes"
              ; key = "cbf45ba488932aea1a10e5862f92e4a7e277bda9f34af6d0"
              ; iv = "75e5"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1f0d23070fcd748e25bf6454f5c9136e"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 240
              ; comment = "small IV sizes"
              ; key = "e1c0446f11ae6aa4fa254f9a846fc6e13e45e537e47f2042"
              ; iv = "8989"
              ; aad = ""
              ; msg = "3a2f5ad0eb216e546e0bcaa377b6cbc7"
              ; ct = "550b48a43e821fd76f49f0f1a897aead"
              ; tag = "f6e0a979481f9957ddad0f21a777a73a"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 32
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 241
              ; comment = "small IV sizes"
              ; key = "567563bf4cf154902275a53bc57cd6dd7b370d27011bdac8"
              ; iv = "68d7fc38"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1475563e3212f3b5e40062569afd71e3"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 242
              ; comment = "small IV sizes"
              ; key = "834d0bb601170865a78139428a1503695a6a291ebd747cd1"
              ; iv = "bb9d2aa3"
              ; aad = ""
              ; msg = "6f79e18b4acd5a03d3a5f7e1a8d0f183"
              ; ct = "309133e76159fe8a41b20843486511ab"
              ; tag = "03ab26993b701910a2e8ecccd2ba9e52"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 48
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 243
              ; comment = "small IV sizes"
              ; key = "99fb18f5ba430bb9ea942968ecb799b43406e1af4b6425a1"
              ; iv = "a984bdcdcae2"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "d7b9a6b58a97982916e83219fbf71b1e"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 244
              ; comment = "small IV sizes"
              ; key = "b77b242aa0d51c92fda013e0cb0ef2437399ace5d3f507e4"
              ; iv = "52aa01e0d0d6"
              ; aad = ""
              ; msg = "4ba541a9914729216153801340ab1779"
              ; ct = "e08261e46eaf90d978ea8f7889bccd4f"
              ; tag = "c052a55df3926a50990a532efe3d80ec"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 64
        ; keySize = 192
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 245
              ; comment = "small IV sizes"
              ; key = "d74599b3d2db81653de43b52fc994c50d0be759fab87c33a"
              ; iv = "d1c61cf8532531b5"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "f94f2049a6560c470b3a7ca7bbc31a3d"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 246
              ; comment = "small IV sizes"
              ; key = "0b177198c8b419bf74acc3bc65b5fb3d09a915ff71add754"
              ; iv = "8f075cbcda9831c3"
              ; aad = ""
              ; msg = "c4b1e05ca3d591f9543e64de3fc682ac"
              ; ct = "3c6ec0ab1b827bf238a5384fb7e212ce"
              ; tag = "7db7402224fd583e312bc0e61cf11366"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 8
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 247
              ; comment = "small IV sizes"
              ; key =
                  "8f9a38c1014966e4d9ae736139c5e79b99345874f42d4c7d2c81aa6797c417c0"
              ; iv = "a9"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "2a268bf3a75fd7b00ba230b904bbb014"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 248
              ; comment = "small IV sizes"
              ; key =
                  "144cd8279229e8bb2de99d24e615306663913fe9177fcd270fafec493d43bca1"
              ; iv = "b3"
              ; aad = ""
              ; msg = "976229f5538f9636476d69f0c328e29d"
              ; ct = "7bea30ecc2f73f8e121263b37966954c"
              ; tag = "8bbad4adc54b37a2b2f0f6e8617548c9"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 16
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 249
              ; comment = "small IV sizes"
              ; key =
                  "7d31861f9d3536e14016a3216b1042e0d2f7d4614314268b6f834ec7f38bbb65"
              ; iv = "c332"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1d978a693120c11f6d51a3ed88cd4ace"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 250
              ; comment = "small IV sizes"
              ; key =
                  "22b35fe9623ee11f8b60b6d22db3765b666ed972fa7ccd92b45f22deee02cab1"
              ; iv = "da6c"
              ; aad = ""
              ; msg = "5341c78e4ce5bf8fbc3e077d1990dd5d"
              ; ct = "9c39f5b110361e9a770cc5e8b0f444bb"
              ; tag = "b63ff43c12073ec5572b1be70f17e231"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 32
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 251
              ; comment = "small IV sizes"
              ; key =
                  "c224e0bba3d7a99165f7996b67a0fce3e12f2c01179b197b69b7e628bca92096"
              ; iv = "6b30145e"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "ae6f7c9a29f0d8204ca50b14a1e0dcf2"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 252
              ; comment = "small IV sizes"
              ; key =
                  "093eb12343537ee8e91c1f715b862603f8daf9d4e1d7d67212a9d68e5aac9358"
              ; iv = "5110604c"
              ; aad = ""
              ; msg = "33efb58c91e8c70271870ec00fe2e202"
              ; ct = "f73f72f976a296ba3ca94bc6eb08cd46"
              ; tag = "b824c33c13f289429659aa017c632f71"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 48
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 253
              ; comment = "small IV sizes"
              ; key =
                  "98e6f8ab673e804e865e32403a6551bf807a959343c60d34559360bc295ecb5b"
              ; iv = "d4d857510888"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "3db16725fafc828d414ab61c16a6c38f"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 254
              ; comment = "small IV sizes"
              ; key =
                  "0bd0e8e7781166e1d876dec8fad34ba95b032a27cac0551595116091005947b7"
              ; iv = "1bdcd44b663e"
              ; aad = ""
              ; msg = "91222263b12cf5616a049cbe29ab9b5b"
              ; ct = "ed463f4f43336af3f4d7e08770201145"
              ; tag = "c8fc39906aca0c64e14a43ff750abd8a"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ; { ivSize = 64
        ; keySize = 256
        ; tagSize = 128
        ; xtype = "AeadTest"
        ; tests =
            [ { tcId = 255
              ; comment = "small IV sizes"
              ; key =
                  "61ba694897925d1b4174d40401469c3ef267cdb9f829edb1a10618c16d666059"
              ; iv = "0d10c5c84b88d688"
              ; aad = ""
              ; msg = ""
              ; ct = ""
              ; tag = "1311f9f830d729c189b74ec4f9080fa1"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ; { tcId = 256
              ; comment = "small IV sizes"
              ; key =
                  "115884f693b155563e9bfb3b07cacb2f7f7caa9bfe51f89e23feb5a9468bfdd0"
              ; iv = "04102199ef21e1df"
              ; aad = ""
              ; msg = "82e3e604d2be8fcab74f638d1e70f24c"
              ; ct = "7e0dd6c72aec49f89cc6a80060c0b170"
              ; tag = "af68a37cfefecc4ab99ba50a5353edca"
              ; result = "acceptable"
              ; flags = [ "SmallIv" ]
              }
            ]
        }
      ]
  }
