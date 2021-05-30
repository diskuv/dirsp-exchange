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
(*                 x25519 Test Vectors                 *)
(* --------------------------------------------------- *)

(* ------------------------------------------------------------- *)
(*               Wycheproof test vectors for x25519              *)
(* ------------------------------------------------------------- *)

(*
From the Apache v2.0 licensed

https://github.com/google/wycheproof/blob/2196000605e45d91097147c9c71f26b72af58003/testvectors/x25519_test.json
*)

type wycheproof_notes =
  { xLowOrderPublic : string
  ; xNonCanonicalPublic : string
  ; xSmallPublicKey : string
  ; xTwist : string
  ; xZeroSharedSecret : string
  }

type wycheproof_test =
  { tcId : int
  ; comment : string
  ; public : string
  ; xprivate : string
  ; shared : string
  ; result : string
  ; flags : string list
  }

type wycheproof_testGroup =
  { curve : string
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

(** wycheproof test vectors for x25519 *)
let wycheproof_test_vectors =
  { algorithm = "XDH"
  ; generatorVersion = "0.8r12"
  ; numberOfTests = 518
  ; header =
      [ "Test vectors of type XdhComp are intended for tests that verify the"
      ; "computation of and Xdh key exchange."
      ]
  ; notes =
      { xLowOrderPublic =
          "The curves and its twists contain some points of low order. This \
           test vector contains a public key with such a point. While many \
           libraries reject such public keys; doing so is not a strict \
           requirement according to RFC 7748."
      ; xNonCanonicalPublic =
          "The public key is in non-canonical form. RFC 7749; section 5 \
           defines the value that this public key represents. Section 7 of the \
           same RFC recommends accepting such keys. If a non-canonical key is \
           accepted then it must follow the RFC."
      ; xSmallPublicKey =
          "The public key is insecure and does not belong to a valid private \
           key. Some libraries reject such keys."
      ; xTwist =
          "Public keys are either points on a given curve or points on its \
           twist. The functions X25519 and X448 are defined for points on a \
           twist with the goal that the output of computations do not leak \
           private keys. Implementations may accept or reject points on a \
           twist. If a point multiplication is performed then it is important \
           that the result is correct; since otherwise attacks with invalid \
           keys are possible."
      ; xZeroSharedSecret =
          "Some libraries include a check that the shared secret is not \
           all-zero. This check is described in Section 6.1 of RFC 7748. "
      }
  ; schema = "xdh_comp_schema.json"
  ; testGroups =
      [ { curve = "curve25519"
        ; xtype = "XdhComp"
        ; tests =
            [ { tcId = 1
              ; comment = "normal case"
              ; public =
                  "504a36999f489cd2fdbc08baff3d88fa00569ba986cba22548ffde80f9806829"
              ; xprivate =
                  "c8a9d5a91091ad851c668b0736c1c9a02936c0d3ad62670858088047ba057475"
              ; shared =
                  "436a2c040cf45fea9b29a0cb81b1f41458f863d0d61b453d0a982720d6d61320"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 2
              ; comment = "public key on twist"
              ; public =
                  "63aa40c6e38346c5caf23a6df0a5e6c80889a08647e551b3563449befcfc9733"
              ; xprivate =
                  "d85d8c061a50804ac488ad774ac716c3f5ba714b2712e048491379a500211958"
              ; shared =
                  "279df67a7c4611db4708a0e8282b195e5ac0ed6f4b2f292c6fbd0acac30d1332"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 3
              ; comment = "public key on twist"
              ; public =
                  "0f83c36fded9d32fadf4efa3ae93a90bb5cfa66893bc412c43fa7287dbb99779"
              ; xprivate =
                  "c8b45bfd32e55325d9fd648cb302848039000b390e44d521e58aab3b29a6964b"
              ; shared =
                  "4bc7e01e7d83d6cf67632bf90033487a5fc29eba5328890ea7b1026d23b9a45f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 4
              ; comment = "public key on twist"
              ; public =
                  "0b8211a2b6049097f6871c6c052d3c5fc1ba17da9e32ae458403b05bb283092a"
              ; xprivate =
                  "f876e34bcbe1f47fbc0fddfd7c1e1aa53d57bfe0f66d243067b424bb6210be51"
              ; shared =
                  "119d37ed4b109cbd6418b1f28dea83c836c844715cdf98a3a8c362191debd514"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 5
              ; comment = "public key on twist"
              ; public =
                  "343ac20a3b9c6a27b1008176509ad30735856ec1c8d8fcae13912d08d152f46c"
              ; xprivate =
                  "006ac1f3a653a4cdb1d37bba94738f8b957a57beb24d646e994dc29a276aad45"
              ; shared =
                  "cc4873aed3fcee4b3aaea7f0d20716b4276359081f634b7bea4b705bfc8a4d3e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 6
              ; comment = "public key on twist"
              ; public =
                  "fa695fc7be8d1be5bf704898f388c452bafdd3b8eae805f8681a8d15c2d4e142"
              ; xprivate =
                  "08da77b26d06dff9d9f7fd4c5b3769f8cdd5b30516a5ab806be324ff3eb69e60"
              ; shared =
                  "b6f8e2fcb1affc79e2ff798319b2701139b95ad6dd07f05cbac78bd83edfd92e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 7
              ; comment = "public key on twist"
              ; public =
                  "0200000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "d03edde9f3e7b799045f9ac3793d4a9277dadeadc41bec0290f81f744f73775f"
              ; shared =
                  "b87a1722cc6c1e2feecb54e97abd5a22acc27616f78f6e315fd2b73d9f221e57"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 8
              ; comment = "public key on twist"
              ; public =
                  "0300000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "e09d57a914e3c29036fd9a442ba526b5cdcdf28216153e636c10677acab6bd6a"
              ; shared =
                  "a29d8dad28d590cd3017aa97a4761f851bf1d3672b042a4256a45881e2ad9035"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 9
              ; comment = "public key on twist"
              ; public =
                  "ff00000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "e0ed78e6ee02f08bec1c15d66fbbe5b83ffc37ea14e1512cc1bd4b2ea6d8066f"
              ; shared =
                  "e703bc8aa94b7d87ba34e2678353d12cdaaa1a97b5ca3e1b8c060c4636087f07"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 10
              ; comment = "public key on twist"
              ; public =
                  "ffff000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "a8a1a2ec9fa9915ae7aace6a37c68591d39e15995c4ef5ebd3561c02f72dda41"
              ; shared =
                  "ff5cf041e924dbe1a64ac9bdba96bdcdfaf7d59d91c7e33e76ed0e4c8c836446"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 11
              ; comment = "public key on twist"
              ; public =
                  "0000010000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "a8c9df5820eb399d471dfa3215d96055b3c7d0f4ea49f8ab028d6a6e3194517b"
              ; shared =
                  "a92a96fa029960f9530e6fe37e2429cd113be4d8f3f4431f8546e6c76351475d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 12
              ; comment = "public key on twist"
              ; public =
                  "ffffff0f00000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "d0d31c491cbd39271859b4a63a316826507b1db8c701709fd0ffe3eb21c4467c"
              ; shared =
                  "9f8954868158ec62b6b586b8cae1d67d1b9f4c03d5b3ca0393cee71accc9ab65"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 13
              ; comment = "public key on twist"
              ; public =
                  "ffffffff00000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "d053e7bf1902619cd61c9c739e09d54c4147f46d190720966f7de1d9cffbbd4e"
              ; shared =
                  "6cbf1dc9af97bc148513a18be4a257de1a3b065584df94e8b43c1ab89720b110"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 14
              ; comment = "public key on twist"
              ; public =
                  "0000000000001000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "a021d75009a4596e5a33f12921c10f3670933bc80dde3bba22881b6120582144"
              ; shared =
                  "38284b7086095a9406028c1f800c071ea106039ad7a1d7f82fe00906fd90594b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 15
              ; comment = "public key on twist"
              ; public =
                  "0000000000000001000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "a89c6687f99bd569a01fd8bd438236160d15ce2c57c1d71ebaa3f2da88233863"
              ; shared =
                  "c721041df0244071794a8db06b9f7eaeec690c257265343666f4416f4166840f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 16
              ; comment = "public key on twist"
              ; public =
                  "ffffffffffffffff000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "68964bca51465bf0f5ba524b1482ceff0e960a1ed9f48dcc30f1608d0e501a50"
              ; shared =
                  "25ff9a6631b143dbdbdc207b38e38f832ae079a52a618c534322e77345fd9049"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 17
              ; comment = "public key on twist"
              ; public =
                  "0000000000000000000000000000000000000000000000000100000000000000"
              ; xprivate =
                  "a8e56bb13a9f2b33b8e6750b4a6e6621dc26ae8c5c624a0992c8f0d5b910f170"
              ; shared =
                  "f294e7922c6cea587aefe72911630d50f2456a2ba7f21207d57f1ecce04f6213"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 18
              ; comment = "public key on twist"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000"
              ; xprivate =
                  "e045f55c159451e97814d747050fd7769bd478434a01876a56e553f66384a74c"
              ; shared =
                  "ff4715bd8cf847b77c244ce2d9b008b19efaa8e845feb85ce4889b5b2c6a4b4d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 19
              ; comment = "public key on twist"
              ; public =
                  "ffffff030000f8ffff1f0000c0ffffff000000feffff070000f0ffff3f000000"
              ; xprivate =
                  "105d621e1ef339c3d99245cfb77cd3a5bd0c4427a0e4d8752c3b51f045889b4f"
              ; shared =
                  "61eace52da5f5ecefafa4f199b077ff64f2e3d2a6ece6f8ec0497826b212ef5f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 20
              ; comment = "public key on twist"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f0000"
              ; xprivate =
                  "d88a441e706f606ae7f630f8b21f3c2554739e3e549f804118c03771f608017b"
              ; shared =
                  "ff1b509a0a1a54726086f1e1c0acf040ab463a2a542e5d54e92c6df8126cf636"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 21
              ; comment = "public key on twist"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000800000"
              ; xprivate =
                  "80bbad168222276200aafd36f7f25fdc025632d8bf9f6354bb762e06fb63e250"
              ; shared =
                  "f134e6267bf93903085117b99932cc0c7ba26f25fca12102a26d7533d9c4272a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 22
              ; comment = "public key on twist"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1f"
              ; xprivate =
                  "68e134092e94e622c8a0cd18aff55be23dabd994ebdee982d90601f6f0f4b369"
              ; shared =
                  "74bfc15e5597e9f5193f941e10a5c008fc89f051392723886a4a8fe5093a7354"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 23
              ; comment = "public key on twist"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000020"
              ; xprivate =
                  "e8e43fc1ebac0bbc9b99c8035ee1ac59b90f19a16c42c0b90f96adfcc5fdee78"
              ; shared =
                  "0d41a5b3af770bf2fcd34ff7972243a0e2cf4d34f2046a144581ae1ec68df03b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 24
              ; comment = "public key on twist"
              ; public =
                  "000000fcffff070000e0ffff3f000000ffffff010000f8ffff0f0000c0ffff7f"
              ; xprivate =
                  "18bffb16f92680a9e267473e43c464476d5372ddd1f664f3d0678efe7c98bc79"
              ; shared =
                  "5894e0963583ae14a0b80420894167f4b759c8d2eb9b69cb675543f66510f646"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 25
              ; comment = "public key on twist"
              ; public =
                  "ffffffffffffff00000000000000ffffffffffffff00000000000000ffffff7f"
              ; xprivate =
                  "300305eb002bf86c71fe9c0b311993727b9dc618d0ce7251d0dfd8552d17905d"
              ; shared =
                  "f8624d6e35e6c548ac47832f2e5d151a8e53b9290363b28d2ab8d84ab7cb6a72"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 26
              ; comment = "public key on twist"
              ; public =
                  "00000000ffffffff00000000ffffffff00000000ffffffff00000000ffffff7f"
              ; xprivate =
                  "80da9f02842247d4ade5ddbac51dbce55ea7dca2844e7f97ab8987ce7fd8bc71"
              ; shared =
                  "bfe183ba3d4157a7b53ef178613db619e27800f85359c0b39a9fd6e32152c208"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 27
              ; comment = "public key on twist"
              ; public =
                  "edfffffffffffffffffffffffffffeffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "806e7f26ca3246de8182946cbed09f52b95da626c823c7b50450001a47b7b252"
              ; shared =
                  "bca4a0724f5c1feb184078448c898c8620e7caf81f64cca746f557dff2498859"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 28
              ; comment = "public key on twist"
              ; public =
                  "edfffffffffffffeffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "58354fd64bc022cba3a71b2ae64281e4ea7bf6d65fdbaead1440eeb18604fe62"
              ; shared =
                  "b3418a52464c15ab0cacbbd43887a1199206d59229ced49202300638d7a40f04"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 29
              ; comment = "public key on twist"
              ; public =
                  "edffffffffffefffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "f0019cf05159794cc8052b00c2e75b7f46fb6693c4b38c02b12a4fe272e8556a"
              ; shared =
                  "fcde6e0a3d5fd5b63f10c2d3aad4efa05196f26bc0cb26fd6d9d3bd015eaa74f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 30
              ; comment = "public key on twist"
              ; public =
                  "edfeffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "d0fca64cc5f3a0c8e75c824e8b09d1615aa79aeba139bb7302e2bb2fcbe54b40"
              ; shared =
                  "7d62f189444c6231a48afab10a0af2eee4a52e431ea05ff781d616af2114672f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 31
              ; comment = "public key on twist"
              ; public =
                  "eaffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "d02456e456911d3c6cd054933199807732dfdc958642ad1aebe900c793bef24a"
              ; shared =
                  "07ba5fcbda21a9a17845c401492b10e6de0a168d5c94b606694c11bac39bea41"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 32
              ; comment = "public key = 0"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "88227494038f2bb811d47805bcdf04a2ac585ada7f2f23389bfd4658f9ddd45e"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"; "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 33
              ; comment = "public key = 1"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "48232e8972b61c7e61930eb9450b5070eae1c670475685541f0476217e48184f"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"; "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 34
              ; comment = "edge case public key"
              ; public =
                  "0400000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "a8386f7f16c50731d64f82e6a170b142a4e34f31fd7768fcb8902925e7d1e25a"
              ; shared =
                  "34b7e4fa53264420d9f943d15513902342b386b172a0b0b7c8b8f2dd3d669f59"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 35
              ; comment = "edge case public key"
              ; public =
                  "0001000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "d05abd08bf5e62538cb9a5ed105dbedd6de38d07940085072b4311c2678ed77d"
              ; shared =
                  "3aa227a30781ed746bd4b3365e5f61461b844d09410c70570abd0d75574dfc77"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 36
              ; comment = "edge case public key"
              ; public =
                  "0000001000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "f0b8b0998c8394364d7dcb25a3885e571374f91615275440db0645ee7c0a6f6b"
              ; shared =
                  "97755e7e775789184e176847ffbc2f8ef98799d46a709c6a1c0ffd29081d7039"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 37
              ; comment = "edge case public key"
              ; public =
                  "0000000001000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "d00c35dc17460f360bfae7b94647bc4e9a7ad9ce82abeadb50a2f1a0736e2175"
              ; shared =
                  "c212bfceb91f8588d46cd94684c2c9ee0734087796dc0a9f3404ff534012123d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 38
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffff0f00000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "385fc8058900a85021dd92425d2fb39a62d4e23aef1d5104c4c2d88712d39e4d"
              ; shared =
                  "388faffb4a85d06702ba3e479c6b216a8f33efce0542979bf129d860f93b9f02"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 39
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffff00000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "e0614b0c408af24d9d24c0a72f9137fbd6b16f02ccc94797ea3971ab16073a7f"
              ; shared =
                  "877fec0669d8c1a5c866641420eea9f6bd1dfd38d36a5d55a8c0ab2bf3105c68"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 40
              ; comment = "edge case public key"
              ; public =
                  "0000000000000000010000000000000000000000000000000000000000000000"
              ; xprivate =
                  "f004b8fd05d9fffd853cdc6d2266389b737e8dfc296ad00b5a69b2a9dcf72956"
              ; shared =
                  "180373ea0f23ea73447e5a90398a97d490b541c69320719d7dd733fb80d5480f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 41
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffffffffffffffffff000000000000000000000000000000000000"
              ; xprivate =
                  "e80bf0e609bf3b035b552f9db7e9ecbc44a04b7910b1493661a524f46c3c2277"
              ; shared =
                  "208142350af938aba52a156dce19d3c27ab1628729683cf4ef2667c3dc60cf38"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 42
              ; comment = "edge case public key"
              ; public =
                  "0000000000000000000000000000010000000000000000000000000000000000"
              ; xprivate =
                  "48890e95d1b03e603bcb51fdf6f296f1f1d10f5df10e00b8a25c9809f9aa1a54"
              ; shared =
                  "1c3263890f7a081cefe50cb92abd496582d90dcc2b9cb858bd286854aa6b0a7e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 43
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffffffffffffffffffffff00000000000000000000000000000000"
              ; xprivate =
                  "a806f1e39b742615a7dde3b29415ed827c68f07d4a47a4d9595c40c7fccb9263"
              ; shared =
                  "56128e78d7c66f48e863e7e6f2caa9c0988fd439deac11d4aac9664083087f7a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 44
              ; comment = "edge case public key"
              ; public =
                  "0000000000000000000000000000000001000000000000000000000000000000"
              ; xprivate =
                  "9899d5e265e1fc7c32345227d6699a6d6b5517cf33b43ab156ee20df4878794e"
              ; shared =
                  "30eca56f1f1c2e8ff780134e0e9382c5927d305d86b53477e9aeca79fc9ced05"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 45
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000"
              ; xprivate =
                  "d842316e5476aeaee838204258a06f15de011ba40b9962705e7f6e889fe71f40"
              ; shared =
                  "cb21b7aa3f992ecfc92954849154b3af6b96a01f17bf21c612da748db38eb364"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 46
              ; comment = "edge case public key"
              ; public =
                  "ffffffff00000000ffffffff00000000ffffffff00000000ffffffff00000000"
              ; xprivate =
                  "a0933ee30512b25ee4e900aaa07f73e507a8ec53b53a44626e0f589af4e0356c"
              ; shared =
                  "c5caf8cabc36f086deaf1ab226434098c222abdf8acd3ce75c75e9debb271524"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 47
              ; comment = "edge case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000001000000"
              ; xprivate =
                  "38d6403e1377734cdce98285e820f256ad6b769d6b5612bcf42cf2b97945c073"
              ; shared =
                  "4d46052c7eabba215df8d91327e0c4610421d2d9129b1486d914c766cf104c27"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 48
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff03"
              ; xprivate =
                  "182191b7052e9cd630ef08007fc6b43bc7652913be6774e2fd271b71b962a641"
              ; shared =
                  "a0e0315175788362d4ebe05e6ac76d52d40187bd687492af05abc7ba7c70197d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 49
              ; comment = "edge case public key"
              ; public =
                  "ffffff0f000000ffffff0f000000ffffff0f000000ffffff0f000000ffffff0f"
              ; xprivate =
                  "106221fe5694a710d6e147696c5d5b93d6887d584f24f228182ebe1b1d2db85d"
              ; shared =
                  "5e64924b91873b499a5402fa64337c65d4b2ed54beeb3fa5d7347809e43aef1c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 50
              ; comment = "edge case public key"
              ; public =
                  "000000fcffff030000e0ffff1f000000ffffff000000f8ffff070000c0ffff3f"
              ; xprivate =
                  "d035de9456080d85a912083b2e3c7ddd7971f786f25a96c5e782cf6f4376e362"
              ; shared =
                  "c052466f9712d9ec4ef40f276bb7e6441c5434a83efd8e41d20ce83f2dbf5952"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 51
              ; comment = "edge case public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "a8f37318a4c760f3cb2d894822918735683cb1edacf3e666e15694154978fd6d"
              ; shared =
                  "d151b97cba9c25d48e6d576338b97d53dd8b25e84f65f7a2091a17016317c553"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 52
              ; comment = "edge case public key"
              ; public =
                  "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5f"
              ; xprivate =
                  "20d4d624cf732f826f09e8088017742f13f2da98f4dcf4b40519adb790cebf64"
              ; shared =
                  "5716296baf2b1a6b9cd15b23ba86829743d60b0396569be1d5b40014c06b477d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 53
              ; comment = "edge case public key"
              ; public =
                  "edffffffffffffffffffffffffffffffffffffffffffffffffffffffff7fff7f"
              ; xprivate =
                  "d806a735d138efb3b404683c9d84485ab4af540d0af253b574323d8913003c66"
              ; shared =
                  "ddbd56d0454b794c1d1d4923f023a51f6f34ef3f4868e3d6659307c683c74126"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 54
              ; comment = "edge case public key"
              ; public =
                  "fffffffffeffff7ffffffffffeffff7ffffffffffeffff7ffffffffffeffff7f"
              ; xprivate =
                  "184198c6228177f3ef41dc9a341258f8181ae365fe9ec98d93639b0bbee1467d"
              ; shared =
                  "8039eebed1a4f3b811ea92102a6267d4da412370f3f0d6b70f1faaa2e8d5236d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 55
              ; comment = "edge case public key"
              ; public =
                  "edfffffffffffffffffffffffffffffffffffffffffffffffffffffffeffff7f"
              ; xprivate =
                  "f0a46a7f4b989fe515edc441109346ba746ec1516896ec5b7e4f4d903064b463"
              ; shared =
                  "b69524e3955da23df6ad1a7cd38540047f50860f1c8fded9b1fdfcc9e812a035"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 56
              ; comment = "edge case public key"
              ; public =
                  "edfffffffffffffffffffffffffffffffffffffffffffffffeffffffffffff7f"
              ; xprivate =
                  "881874fda3a99c0f0216e1172fbd07ab1c7df78602cc6b11264e57aab5f23a49"
              ; shared =
                  "e417bb8854f3b4f70ecea557454c5c4e5f3804ae537960a8097b9f338410d757"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 57
              ; comment = "edge case public key"
              ; public =
                  "edfffffffffffffffffffffffffffffffeffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "b8d0f1ae05a5072831443150e202ac6db00322cdf341f467e9f296588b04db72"
              ; shared =
                  "afca72bb8ef727b60c530c937a2f7d06bb39c39b903a7f4435b3f5d8fc1ca810"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 58
              ; comment = "edge case public key"
              ; public =
                  "edfffffffffffffffeffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "c8619ba988859db7d6f20fbf3ffb8b113418cc278065b4e8bb6d4e5b3e7cb569"
              ; shared =
                  "7e41c2886fed4af04c1641a59af93802f25af0f9cba7a29ae72e2a92f35a1e5a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 59
              ; comment = "edge case public key"
              ; public =
                  "edfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "f8d4ca1f37a30ec9acd6dbe5a6e150e5bc447d22b355d80ba002c5b05c26935d"
              ; shared =
                  "dd3abd4746bf4f2a0d93c02a7d19f76d921c090d07e6ea5abae7f28848355947"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 60
              ; comment = "edge case public key"
              ; public =
                  "edffffefffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "88037ac8e33c72c2c51037c7c8c5288bba9265c82fd8c31796dd7ea5df9aaa4a"
              ; shared =
                  "8c27b3bff8d3c1f6daf2d3b7b3479cf9ad2056e2002be247992a3b29de13a625"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 61
              ; comment = "edge case public key"
              ; public =
                  "edfffeffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "5034ee7bf83a13d9167df86b0640294f3620f4f4d9030e5e293f9190824ae562"
              ; shared =
                  "8e1d2207b47432f881677448b9d426a30de1a1f3fd38cad6f4b23dbdfe8a2901"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 62
              ; comment = "edge case public key"
              ; public =
                  "ebffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "40bd4e1caf39d9def7663823502dad3e7d30eb6eb01e9b89516d4f2f45b7cd7f"
              ; shared =
                  "2cf6974b0c070e3707bf92e721d3ea9de3db6f61ed810e0a23d72d433365f631"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 63
              ; comment = "public key with low order"
              ; public =
                  "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800"
              ; xprivate =
                  "e0f978dfcd3a8f1a5093418de54136a584c20b7b349afdf6c0520886f95b1272"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 64
              ; comment = "public key with low order"
              ; public =
                  "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f1157"
              ; xprivate =
                  "387355d995616090503aafad49da01fb3dc3eda962704eaee6b86f9e20c92579"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 65
              ; comment = "public key with low order"
              ; public =
                  "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "c8fe0df92ae68a03023fc0c9adb9557d31be7feed0d3ab36c558143daf4dbb40"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "Twist"; "ZeroSharedSecret" ]
              }
            ; { tcId = 66
              ; comment = "public key with low order"
              ; public =
                  "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b880"
              ; xprivate =
                  "c8d74acde5934e64b9895d5ff7afbffd7f704f7dfccff7ac28fa62a1e6410347"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "LowOrderPublic"
                  ; "NonCanonicalPublic"
                  ; "Twist"
                  ; "ZeroSharedSecret"
                  ]
              }
            ; { tcId = 67
              ; comment = "public key with low order"
              ; public =
                  "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f11d7"
              ; xprivate =
                  "b85649d5120e01e8ccaf7b2fb8d81b62e8ad6f3d5c0553fdde1906cb9d79c050"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "LowOrderPublic"
                  ; "NonCanonicalPublic"
                  ; "Twist"
                  ; "ZeroSharedSecret"
                  ]
              }
            ; { tcId = 68
              ; comment = "public key with low order"
              ; public =
                  "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "2064b2f4c9dc97ec7cf58932fdfa3265ba6ea4d11f0259b8efc8afb35db88c48"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "LowOrderPublic"; "NonCanonicalPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 69
              ; comment = "public key with low order"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 70
              ; comment = "public key with low order"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 71
              ; comment = "public key with low order"
              ; public =
                  "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 72
              ; comment = "public key with low order"
              ; public =
                  "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f1157"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 73
              ; comment = "public key with low order"
              ; public =
                  "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 74
              ; comment = "public key with low order"
              ; public =
                  "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 75
              ; comment = "public key with low order"
              ; public =
                  "eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 76
              ; comment = "public key with low order"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 77
              ; comment = "public key with low order"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 78
              ; comment = "public key with low order"
              ; public =
                  "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 79
              ; comment = "public key with low order"
              ; public =
                  "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f11d7"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 80
              ; comment = "public key with low order"
              ; public =
                  "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b880"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 81
              ; comment = "public key with low order"
              ; public =
                  "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 82
              ; comment = "public key with low order"
              ; public =
                  "eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "786a33a4f7af297a20e7642925932bf509e7070fa1bc36986af1eb13f4f50b55"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 83
              ; comment =
                  "public key = \
                   57896044618658097711785492504343953926634992332820282019728792003956564819949"
              ; public =
                  "edffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "40ff586e73d61f0960dc2d763ac19e98225f1194f6fe43d5dd97ad55b3d35961"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"; "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 84
              ; comment =
                  "public key = \
                   57896044618658097711785492504343953926634992332820282019728792003956564819950"
              ; public =
                  "eeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "584fceaebae944bfe93b2e0d0a575f706ce5ada1da2b1311c3b421f9186c7a6f"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"
                  ; "LowOrderPublic"
                  ; "NonCanonicalPublic"
                  ; "ZeroSharedSecret"
                  ]
              }
            ; { tcId = 85
              ; comment = "non-canonical public key"
              ; public =
                  "efffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "0016b62af5cabde8c40938ebf2108e05d27fa0533ed85d70015ad4ad39762d54"
              ; shared =
                  "b4d10e832714972f96bd3382e4d082a21a8333a16315b3ffb536061d2482360d"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic"; "Twist" ]
              }
            ; { tcId = 86
              ; comment = "non-canonical public key"
              ; public =
                  "f0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "d83650ba7cec115881916255e3fa5fa0d6b8dcf968731bd2c9d2aec3f561f649"
              ; shared =
                  "515eac8f1ed0b00c70762322c3ef86716cd2c51fe77cec3d31b6388bc6eea336"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic"; "Twist" ]
              }
            ; { tcId = 87
              ; comment = "non-canonical public key"
              ; public =
                  "f1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "88dd14e2711ebd0b0026c651264ca965e7e3da5082789fbab7e24425e7b4377e"
              ; shared =
                  "6919992d6a591e77b3f2bacbd74caf3aea4be4802b18b2bc07eb09ade3ad6662"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 88
              ; comment = "non-canonical public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "98c2b08cbac14e15953154e3b558d42bb1268a365b0ef2f22725129d8ac5cb7f"
              ; shared =
                  "9c034fcd8d3bf69964958c0105161fcb5d1ea5b8f8abb371491e42a7684c2322"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 89
              ; comment = "non-canonical public key"
              ; public =
                  "0200000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "c0697b6f05e0f3433b44ea352f20508eb0623098a7770853af5ca09727340c4e"
              ; shared =
                  "ed18b06da512cab63f22d2d51d77d99facd3c4502e4abf4e97b094c20a9ddf10"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic"; "Twist" ]
              }
            ; { tcId = 90
              ; comment = "non-canonical public key"
              ; public =
                  "0300000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "18422b58a18e0f4519b7a887b8cfb649e0bfe4b34d75963350a9944e5b7f5b7e"
              ; shared =
                  "448ce410fffc7e6149c5abec0ad5f3607dfde8a34e2ac3243c3009176168b432"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic"; "Twist" ]
              }
            ; { tcId = 91
              ; comment = "non-canonical public key"
              ; public =
                  "0400000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "20620d82487707bedf9ee3549e95cb9390d2618f50cf6acba47ffaa103224a6f"
              ; shared =
                  "03a633df01480d0d5048d92f51b20dc1d11f73e9515c699429b90a4f6903122a"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 92
              ; comment = "non-canonical public key"
              ; public =
                  "daffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "285a6a7ceeb7122f2c78d99c53b2a902b490892f7dff326f89d12673c3101b53"
              ; shared =
                  "9b01287717d72f4cfb583ec85f8f936849b17d978dbae7b837db56a62f100a68"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 93
              ; comment = "non-canonical public key"
              ; public =
                  "dbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "c8e0330ae9dceeff887fba761225879a4bd2e0db08799244136e4721b2c88970"
              ; shared =
                  "dfe60831c9f4f96c816e51048804dbdc27795d760eced75ef575cbe3b464054b"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 94
              ; comment = "non-canonical public key"
              ; public =
                  "dcffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "10db6210fc1fb13382472fa1787b004b5d11868ab3a79510e0cee30f4a6df26b"
              ; shared =
                  "50bfa826ca77036dd2bbfd092c3f78e2e4a1f980d7c8e78f2f14dca3cce5cc3c"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic"; "Twist" ]
              }
            ; { tcId = 95
              ; comment = "non-canonical public key"
              ; public =
                  "eaffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "9041c6e044a277df8466275ca8b5ee0da7bc028648054ade5c592add3057474e"
              ; shared =
                  "13da5695a4c206115409b5277a934782fe985fa050bc902cba5616f9156fe277"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 96
              ; comment = "non-canonical public key"
              ; public =
                  "ebffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "b8d499041a6713c0f6f876db7406587fdb44582f9542356ae89cfa958a34d266"
              ; shared =
                  "63483b5d69236c63cddbed33d8e22baecc2b0ccf886598e863c844d2bf256704"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 97
              ; comment = "non-canonical public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; xprivate =
                  "c85f08e60c845f82099141a66dc4583d2b1040462c544d33d0453b20b1a6377e"
              ; shared =
                  "e9db74bc88d0d9bf046ddd13f943bccbe6dbb47d49323f8dfeedc4a694991a3c"
              ; result = "acceptable"
              ; flags = [ "NonCanonicalPublic" ]
              }
            ; { tcId = 98
              ; comment =
                  "public key = \
                   57896044618658097711785492504343953926634992332820282019728792003956564819968"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "7887889bac4c629a101d3724f2ed8b98d936fde79e1a1f77d86779626bf8f263"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"
                  ; "LowOrderPublic"
                  ; "NonCanonicalPublic"
                  ; "ZeroSharedSecret"
                  ]
              }
            ; { tcId = 99
              ; comment =
                  "public key = \
                   57896044618658097711785492504343953926634992332820282019728792003956564819969"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000000000080"
              ; xprivate =
                  "e07971ee820e48b0b266d8be3cdbbb5e900a43f59ee8535c6572418615de4962"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"
                  ; "LowOrderPublic"
                  ; "NonCanonicalPublic"
                  ; "Twist"
                  ; "ZeroSharedSecret"
                  ]
              }
            ; { tcId = 100
              ; comment = "RFC 7748"
              ; public =
                  "e6db6867583030db3594c1a424b15f7c726624ec26b3353b10a903a6d0ab1c4c"
              ; xprivate =
                  "a046e36bf0527c9d3b16154b82465edd62144c0ac1fc5a18506a2244ba449a44"
              ; shared =
                  "c3da55379de9c6908e94ea4df28d084f32eccf03491c71f754b4075577a28552"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 101
              ; comment = "RFC 7748"
              ; public =
                  "e5210f12786811d3f4b7959d0538ae2c31dbe7106fc03c3efc4cd549c715a413"
              ; xprivate =
                  "4866e9d4d1b4673c5ad22691957d6af5c11b6421e0ea01d42ca4169e7918ba4d"
              ; shared =
                  "95cbde9476e8907d7aade45cb4b873f88b595a68799fa152e6f8f7647aac7957"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 102
              ; comment = "RFC 8037; Section A.6"
              ; public =
                  "de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f"
              ; xprivate =
                  "77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a"
              ; shared =
                  "4a5d9d5ba4ce2de1728e3bf480350f25e07e21c947d19e3376f09b3c1e161742"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 103
              ; comment = "edge case for shared secret"
              ; public =
                  "b7b6d39c765cb60c0c8542f4f3952ffb51d3002d4aeb9f8ff988b192043e6d0a"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "0200000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 104
              ; comment = "edge case for shared secret"
              ; public =
                  "3b18df1e50b899ebd588c3161cbd3bf98ebcc2c1f7df53b811bd0e91b4d5153d"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "0900000000000000000000000000000000000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 105
              ; comment = "edge case for shared secret"
              ; public =
                  "cab6f9e7d8ce00dfcea9bbd8f069ef7fb2ac504abf83b87db601b5ae0a7f7615"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "1000000000000000000000000000000000000000000000000000000000000000"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 106
              ; comment = "edge case for shared secret"
              ; public =
                  "4977d0d897e1ba566590f60f2eb0db6f7b24c13d436918ccfd32708dfad7e247"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "feffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 107
              ; comment = "edge case for shared secret"
              ; public =
                  "98730bc03e29e8b057fb1d20ef8c0bffc822485d3db7f45f4e3cc2c3c6d1d14c"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "fcffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 108
              ; comment = "edge case for shared secret"
              ; public =
                  "97b4fff682df7f096cd1756569e252db482d45406a3198a1aff282a5da474c49"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "f9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 109
              ; comment = "edge case for shared secret"
              ; public =
                  "317781b0163bae74accc06c0d44ef9a911a22b0d37faf7726621591f9343ea2f"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "f3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 110
              ; comment = "edge case for shared secret"
              ; public =
                  "7e26f8f24cb590027f9d1bc49b0e1a242c7d8f43624d3e8fab28ee08e02cb45e"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff03"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 111
              ; comment = "edge case for shared secret"
              ; public =
                  "e96d2780e5469a74620ab5aa2f62151d140c473320dbe1b028f1a48f8e76f95f"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "e5ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 112
              ; comment = "edge case for shared secret"
              ; public =
                  "8d612c5831aa64b057300e7e310f3aa332af34066fefcab2b089c9592878f832"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "e3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 113
              ; comment = "edge case for shared secret"
              ; public =
                  "8d44108d05d940d3dfe5647ea7a87be24d0d036c9f0a95a2386b839e7b7bf145"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "ddffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 114
              ; comment = "edge case for shared secret"
              ; public =
                  "21a35d5db1b6237c739b56345a930aeee373cdcfb4701266782a8ac594913b29"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "dbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 115
              ; comment = "edge case for shared secret"
              ; public =
                  "3e5efb63c352ce942762482bc9337a5d35ba55664743ac5e93d11f957336cb10"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000002"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 116
              ; comment = "edge case for shared secret"
              ; public =
                  "8e41f05ea3c76572be104ad8788e970863c6e2ca3daae64d1c2f46decfffa571"
              ; xprivate =
                  "60a3a4f130b98a5be4b1cedb7cb85584a3520e142d474dc9ccb909a073a9767f"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000008000"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 117
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "c8d07c46bbfb827753b92c70e49583ce8bfa44641a7382258ea903d6a832c96b"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"; "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 118
              ; comment = "special case public key"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "90b7ef237a055f348dcb4c4364a59d7d31edc7ab78f2ca254e2c810975c3f543"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags =
                  [ "SmallPublicKey"; "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 119
              ; comment = "special case public key"
              ; public =
                  "0200000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "e0a8be63315c4f0f0a3fee607f44d30a55be63f09561d9af93e0a1c9cf0ed751"
              ; shared =
                  "0c50ac2bfb6815b47d0734c5981379882a24a2de6166853c735329d978baee4d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 120
              ; comment = "special case public key"
              ; public =
                  "1200000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "0840a8af5bc4c48da8850e973d7e14220f45c192cea4020d377eecd25c7c3643"
              ; shared =
                  "77557137a2a2a651c49627a9b239ac1f2bf78b8a3e72168ccecc10a51fc5ae66"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 121
              ; comment = "special case public key"
              ; public =
                  "1400000000000000000000000000000000000000000000000000000000000000"
              ; xprivate =
                  "0092229c753a71284d0853909470ad847ab62f439ea51482fb41d30cc3b44743"
              ; shared =
                  "c88e719ae5c2248b5f90da346a92ae214f44a5d129fd4e9c26cf6a0da1efe077"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 122
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000080000000000000000000000000000000000000"
              ; xprivate =
                  "b8da2bd2d7cf25a3e54e5f87ee15911effb9ff86baec4076d56c8e953670bf5b"
              ; shared =
                  "4bf6789c7ea036f973cde0af02d6fdb9b64a0b957022111439570fad7d7a453f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 123
              ; comment = "special case public key"
              ; public =
                  "ffffffffffffffffffffffffffff000000000000000000000000000000000000"
              ; xprivate =
                  "684cd420af41abb3d10c61e773238cf729c2155f941ac27e15f4c37f49b29576"
              ; shared =
                  "bcac235ae15cc7148372e11f9315e3bc76ceb904b3d2a8246bd9d9be2082bb62"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 124
              ; comment = "special case public key"
              ; public =
                  "0100000000000000000000000000010000000000000000000000000000000000"
              ; xprivate =
                  "38cfacaa4460796b4de434bdd6739f0d043671f97fa829517511e6b47aa93474"
              ; shared =
                  "5dd7d16fff25cc5fdf9e03c3157cb0a235cea17d618f36e6f13461567edeb943"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 125
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000004000000000"
              ; xprivate =
                  "30832e8cb627ac195f77b1105258e4bb18b99a5ed944404bfacb3a039fbdb14b"
              ; shared =
                  "2816fd031d51d6750f9225ede950625cca47441ca97e43092650396991afcb6d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 126
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000008000000000"
              ; xprivate =
                  "d818fd6971e546447f361d33d3dbb3eadcf02fb28f246f1d5107b9073a93cd4f"
              ; shared =
                  "7ed8f2d5424e7ebb3edbdf4abe455447e5a48b658e64abd06c218f33bd151f64"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 127
              ; comment = "special case public key"
              ; public =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000"
              ; xprivate =
                  "1021cd8682bdc3f5da9100adff5b2230b3acd836b3a455db8352a2c27e69d17e"
              ; shared =
                  "e8620ed5ca89c72c5ea5503e6dcd01131cd5e875c30e13d5dc619ce28ec7d559"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 128
              ; comment = "special case public key"
              ; public =
                  "0100000000000000000000000000000000000000000000000000000001000000"
              ; xprivate =
                  "20e4c9247102292655d6765d7d84c6fce5309b8004045daea6d7d7dcad462871"
              ; shared =
                  "ceadb264379dcadd6e3bb8ad24dd653d2a609dd703d41da6caf3ad00f001862c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 129
              ; comment = "special case public key"
              ; public =
                  "a8b9c7372118a53a9de9eaf0868e3b1a3d88e81cb2e407ff7125e9f5c5088715"
              ; xprivate =
                  "90b150d462de512056d5bd55173074969b496f262fb6916b733f6263a8078971"
              ; shared =
                  "f86cc7bf1be49574fc97a074282e9bb5cd238e002bc8e9a7b8552b2d60eccb52"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 130
              ; comment = "special case public key"
              ; public =
                  "aab9c7372118a53a9de9eaf0868e3b1a3d88e81cb2e407ff7125e9f5c5088715"
              ; xprivate =
                  "9887286b3261c8d857a16f6db21277f75d88d4e861b3ebe7596699047e816668"
              ; shared =
                  "ccbb8fd9dee165a398b2dbd7c8396f81736c1b3da36b35fbec8f326f38f92767"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 131
              ; comment = "special case public key"
              ; public =
                  "585007a5930d77623cf29756038ca197d3ebfd9e4c80a69585efe0274092c115"
              ; xprivate =
                  "20ca2c85cc8762e96b7047bf15c71c050ffe0ed1616040a953ae32a1297ad871"
              ; shared =
                  "46add6f48ffff461777d4f89b6fdf1155aa051a96387d45f3e5e371a236b6e52"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 132
              ; comment = "special case public key"
              ; public =
                  "fbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1f"
              ; xprivate =
                  "d027656605b10bf18dea28bc52546f9f1f08cef06cafd200fc84f87dbb4ebe46"
              ; shared =
                  "1adbe32207e21f71e1af53884d2a2276481e298e557f4dacb3720f2458e3082d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 133
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000020"
              ; xprivate =
                  "4867a83ee9d01b7510840867db1af6a6049bdbb056b74443f70c358e162c8867"
              ; shared =
                  "e12cc58fbeb70a5e35c861c33710be6516a6a92e52376060211b2487db542b4f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 134
              ; comment = "special case public key"
              ; public =
                  "afa00e4a271beec478e42fad0618432fa7d7fb3d99004d2b0bdfc14f8024832b"
              ; xprivate =
                  "a015970a8add940fca5b1b5d23875397d547d8d494fcb314f2045a67a2d12c4b"
              ; shared =
                  "421bed1b26da1e9adbeada1f32b91a0fb4ced0f1110e0a4a88e735a19ee4571e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 135
              ; comment = "special case public key"
              ; public =
                  "b1a00e4a271beec478e42fad0618432fa7d7fb3d99004d2b0bdfc14f8024832b"
              ; xprivate =
                  "4058cb6b9aaba02a338aaa392dbc10039e26e9e444117e758e24c5d8b232ea5e"
              ; shared =
                  "d7b47463e2f4ca9a1a7deea098da8e74ac3b4a109083d997259b12992e7e7e06"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 136
              ; comment = "special case public key"
              ; public =
                  "fbffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff2f"
              ; xprivate =
                  "b876b05daff0530b139d9e11250563418077178246c5fa7005ba00e9b6647763"
              ; shared =
                  "686eb910a937211b9147c8a051a1197906818fdc626668eb5f5d394afd86d41b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 137
              ; comment = "special case public key"
              ; public =
                  "22231c64ef73ad62318b8a87bc38e272e1bb8bf1a60d7c00476d0b059d7b3c35"
              ; xprivate =
                  "d87fd6aa5d8deef6dee9619a56846a0829620590f2da40835d8e251597e39078"
              ; shared =
                  "09559733b35bcc6bb8ac574b5abe3a4d8841deff051c294a07487e3eec3c5558"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 138
              ; comment = "special case public key"
              ; public =
                  "f6ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "90036321b63751f7622aa93da34d85e59ce81009ac5b9a068921d83bc4715b57"
              ; shared =
                  "f7d5cbcf39eb722b01ed20c85563ebb81d076511aead4ccc429027866b9fd270"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 139
              ; comment = "special case public key"
              ; public =
                  "f7ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "a06781fd4c4a0874e00e72ba131b9dd87a83b2904e294de176e8a9af1f695d67"
              ; shared =
                  "e995ad6a1ec6c5ab32922cff9d204721704673143c4a11deaa203f3c81989b3f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 140
              ; comment = "special case public key"
              ; public =
                  "feffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "b822d72d8b68bdb4fbf67e56a61d672b2c7747e94479fe5ae4072d0accdd6571"
              ; shared =
                  "32b6dabe01d13867f3b5b0892fefd80dca666f2edc5afb43cd0baf703c3e6926"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 141
              ; comment = "special case public key"
              ; public =
                  "0000000000000000000000000000000000000000000000000000000000000040"
              ; xprivate =
                  "d08ce1237e248d02cdf619d20bea5848ade4f6ffd171b8dee8793fc67c459640"
              ; shared =
                  "a93d83fc9ea0f6cb0cc8b631da600019b76cbb2ec57222f2e42dd540e3da850b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 142
              ; comment = "special case public key"
              ; public =
                  "cbdce39b108c529dce74757843c71d8d1e44740e59f283ffb892f4fa6284c34a"
              ; xprivate =
                  "180ae3c928514cfb9edd06e7dc1d5d066160e967445a5c58e4463b69ed205e6d"
              ; shared =
                  "017cbfa2b38e9ef3297a339ecce1a917bdcf7e910036086a41d1e22d04241870"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 143
              ; comment = "special case public key"
              ; public =
                  "3c5ff1b5d8e4113b871bd052f9e7bcd0582804c266ffb2d4f4203eb07fdb7c54"
              ; xprivate =
                  "e881d806a110560cd8fee899d59c0249f1233a4322c41aa369c7a2a99f5b5962"
              ; shared =
                  "71133905b8a57ea8c38de0ecf213699a75b096c2df21f07f7e9eb03e9fa53f5c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 144
              ; comment = "special case public key"
              ; public =
                  "3e5ff1b5d8e4113b871bd052f9e7bcd0582804c266ffb2d4f4203eb07fdb7c54"
              ; xprivate =
                  "08e410e1d7e8b9411236af4a35d6b62a5d8931478e4c62197cfafb491467b162"
              ; shared =
                  "3dc7b70e110766b2bf525252ebed98a100b2e532dc69544464da1bbab8625f6d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 145
              ; comment = "special case public key"
              ; public =
                  "f2ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5f"
              ; xprivate =
                  "e02fdf7e0ee3d55b4440f01432dd253c949793bc04da44ddece83e54c8c39b40"
              ; shared =
                  "e317e5cc438b5f79ead5533ac7c45519a117b31033cc2140b19edf8572011240"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 146
              ; comment = "special case public key"
              ; public =
                  "f6ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff5f"
              ; xprivate =
                  "f05d18f68ef7a5865c14db3a9c255fdf2dabea2aa36581e94f68b727b582867b"
              ; shared =
                  "d86810516aeddc18061036f599a9eb84d1c6146b0f543652dd4526743ba42c04"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 147
              ; comment = "special case public key"
              ; public =
                  "95aff85a6cf2889dc30d68a9fc735e682c140261b37f596a7a101fd8bf6d3e6a"
              ; xprivate =
                  "00c103578d5c079d7bcc22c1c31e787c1b15c57fcb493fdafefa20371cfc746b"
              ; shared =
                  "dfa988a477003be125b95ccbf2223d97729577d25e1d6e89e3da0afabdd0ae71"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 148
              ; comment = "special case public key"
              ; public =
                  "434638c8dee75ac56216150f7971c4e5c27717e34d1bf8008eda160a3af7786a"
              ; xprivate =
                  "7005bb927485c435642b424a3dde014bcf76345e5be64ae6e9b24db39e1cdb51"
              ; shared =
                  "d450af45b8ed5fe140cc5263ffb7b52e66736899a8b872b6e28552129819b25b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 149
              ; comment = "special case public key"
              ; public =
                  "454638c8dee75ac56216150f7971c4e5c27717e34d1bf8008eda160a3af7786a"
              ; xprivate =
                  "0822039a5dc13c40fcccf346e2a7769b4fd272052d43260ad626468a50d44162"
              ; shared =
                  "58002c89bf8bc32ae6fc205b796acd13ef7f8476f6492ae4b2be47f1095e8a4f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 150
              ; comment = "special case public key"
              ; public =
                  "ecfffffffffffffffffffffffffffeffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "40a6349c03f0dc0a42358f6353ca67632af687b14c9dff626c54e211e8fc355a"
              ; shared =
                  "7773aad6e72eb1735b65ad51f7dad258c11d7bfff53094424cb103cd6bfb4368"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 151
              ; comment = "special case public key"
              ; public =
                  "eefffffffffffffffffffffffffffeffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "50696d4d05209971d6ba0676ea274262ba639aac74fa75e5df4570768ad8ae74"
              ; shared =
                  "c118ddf6462fbea80f14ef1f2972a1ab12cafa511d1323d4d22d0d426d651b5b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 152
              ; comment = "special case public key"
              ; public =
                  "edffffffffffffffffffffffff7fffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "68bb680c853f4e4daa47c586dc886cf4568d7b0383770f6df439a53be4a3236d"
              ; shared =
                  "cc0775bfd970a2706b11c7222a4436a3d17160382c83b76f89b66192c81b4408"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 153
              ; comment = "special case public key"
              ; public =
                  "ebffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "b0f6c28dbdc647068a76d71805ef770f087cf76b82afdc0d26c45b71ace49768"
              ; shared =
                  "f0097fa0ba70d019126277ab15c56ecc170ca88180b2bf9d80fcda3d7d74552a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 154
              ; comment = "special case public key"
              ; public =
                  "ecffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f"
              ; xprivate =
                  "18630f93598637c35da623a74559cf944374a559114c7937811041fc8605564a"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "Twist"; "ZeroSharedSecret" ]
              }
            ; { tcId = 155
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "0000000000000000000008000000000000000000000000000000000000000000"
              ; xprivate =
                  "581ecbda5a4a228044fefd6e03df234558c3c79152c6e2c5e60b142c4f26a851"
              ; shared =
                  "59e7b1e6f47065a48bd34913d910176b6792a1372aad22e73cd7df45fcf91a0e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 156
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "77af0d3897a715dfe25df5d538cf133bc9ab7ad52df6bd922a2fb75621d59901"
              ; xprivate =
                  "b0561a38000795b7cb537b55e975ea452c2118506295d5eb15fd9c83b67f7a50"
              ; shared =
                  "179f6b020748acba349133eaa4518f1bd8bab7bfc4fb05fd4c24e7553da1e960"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 157
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "4e39866127b6a12a54914e106aab86464af55631f3cb61766d5999aa8d2e070e"
              ; xprivate =
                  "b00f7df2d47128441c7270b9a87eee45b6056fc64236a57bdf81dbcccf5f5d42"
              ; shared =
                  "43c5ee1451f213ef7624729e595a0fee7c9af7ee5d27eb03278ee9f94c202352"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 158
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "adc6799ed8495ed5ab6eb1ef955479b9b50aa9ce0c349e8992a6665572d1f811"
              ; xprivate =
                  "c8f7a0c0bfb1e9c72576c534f86854fbe4af521d4fa807f67e2440e100ec8852"
              ; shared =
                  "2f350bcf0b40784d1d756c9ca3e38ec9dd68ba80faf1f9847de50779c0d4902a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 159
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "770f4218ef234f5e185466e32442c302bbec21bbb6cd28c979e783fe5013333f"
              ; xprivate =
                  "58181f581aa37022ff71c56c6e68e6175d967c5c995a249885f66565074ded4d"
              ; shared =
                  "d5d650dc621072eca952e4344efc7320b2b1459aba48f5e2480db881c50cc650"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 160
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "5c6118c4c74cfb842d9a87449f9d8db8b992d46c5a9093ce2fcb7a49b535c451"
              ; xprivate =
                  "301c935cae4357070b0adaf9cd6192830b2c989c153729eed99f589eb45f884b"
              ; shared =
                  "909cc57275d54f20c67b45f9af9484fd67581afb7d887bee1db5461f303ef257"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 161
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "4039866127b6a12a54914e106aab86464af55631f3cb61766d5999aa8d2e076e"
              ; xprivate =
                  "d002292d4359a3d42bc8767f1380009332e7a0df2f3379011ab78f789f6baa54"
              ; shared =
                  "4a7e2c5caf1d8180eb1c4f22692f29a14b4cdc9b193bd1d16e2f27438eef1448"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 162
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "078fa523498fb51cba1112d83b20af448b8009d8eea14368564d01b8f9b6086f"
              ; xprivate =
                  "d0c2c49e644ab738270707ff9917065942687e2f12886d961161db46c05b565f"
              ; shared =
                  "c0ee59d3685fc2c3c803608b5ee39a7f8da30b48e4293ae011f0ea1e5aeb7173"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 163
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "9fc6799ed8495ed5ab6eb1ef955479b9b50aa9ce0c349e8992a6665572d1f871"
              ; xprivate =
                  "f087d38b274c1dad1bce6eaa36b48e2190b90b9bf8ca59669cc5e00464534342"
              ; shared =
                  "b252bc8eabfaa68c56e54d61b99061a35d11e3a7b9bda417d90f69b1119bcf45"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 164
              ; comment = "special case for E in multiplication by 2"
              ; public =
                  "7650f2c76858ea201da2022ac730ecc43654852ad209426dd5d048a9de2a667e"
              ; xprivate =
                  "48dbcc5a695f1514bbbaa6ad00842b69d9ae5216b1963add07fb2947c97b8447"
              ; shared =
                  "fbda33bc930c08df837208e19afdc1cfe3fd0f8f0e3976be34775e58a4a7771f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 165
              ; comment = "D = 0 in multiplication by 2"
              ; public =
                  "e0eb7a7c3b41b8ae1656e3faf19fc46ada098deb9c32b1fd866205165f49b800"
              ; xprivate =
                  "5891c9272cf9a197735b701e5715268d36d7436b7e351a3e997a0862e4807d4d"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 166
              ; comment = "D = 0 in multiplication by 2"
              ; public =
                  "5f9c95bca3508c24b1d0b1559c83ef5b04445cc4581c8e86d8224eddd09f1157"
              ; xprivate =
                  "c0f9c60aea73731d92ab5ed9f4cea122f9a6eb2577bda72f94948fea4d4cc65d"
              ; shared =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "acceptable"
              ; flags = [ "LowOrderPublic"; "ZeroSharedSecret" ]
              }
            ; { tcId = 167
              ; comment = "special case for DA - CB in multiplication by 2"
              ; public =
                  "b0224e7134cf92d40a31515f2f0e89c2a2777e8ac2fe741db0dc39399fdf2702"
              ; xprivate =
                  "0066dd7674fe51f9326c1e239b875f8ac0701aae69a804c25fe43595e8660b45"
              ; shared =
                  "8dacfe7beaaa62b94bf6e50ee5214d99ad7cda5a431ea0c62f2b20a89d73c62e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 168
              ; comment = "special case for DA - CB in multiplication by 2"
              ; public =
                  "601e3febb848ec3e57fce64588aad82afc9c2af99bbcdffcc4cd58d4b3d15c07"
              ; xprivate =
                  "80067f30f40d61318b420c859fce128c9017ab81b47b76028a57bc30d5856846"
              ; shared =
                  "20f1d3fe90e08bc6f152bf5dacc3ed35899785333f1470e6a62c3b8cbe28d260"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 169
              ; comment = "special case for DA - CB in multiplication by 2"
              ; public =
                  "82a3807bbdec2fa9938fb4141e27dc57456606301f78ff7133cf24f3d13ee117"
              ; xprivate =
                  "584577669d21ce0ae3e30b02c9783ffe97709cbfe396889aa31e8ee43352dc52"
              ; shared =
                  "2b28cc5140b816add5ad3a77a81b1c073d67bf51bf95bda2064a14eb12d5f766"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 170
              ; comment = "special case for DA - CB in multiplication by 2"
              ; public =
                  "f329ab2376462e5f3128a2682086253c19222ac1e2bca45692f0c3b528f4c428"
              ; xprivate =
                  "18e597a4e2ccdb5e8052d57c9009938c2d4c43d6d8c9f93c98727b7311035953"
              ; shared =
                  "8392160083b9af9e0ef44fcfce53ba8ff7282ee7a6c71ab66f8843a55d09cd68"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 171
              ; comment = "special case for DA in multiplication by 2"
              ; public =
                  "4fce3bb6c8aaf022dbd100e3cde3941b37d543f00401dba7da9bc143dfc55709"
              ; xprivate =
                  "88281cc51d5512d8814ea5249b879dcbad0323d38512dafbdc7ba85bba8c8d5d"
              ; shared =
                  "42184e22c535530c457bd3b4f1084cbf5e297f502fe136b8d1daecf5334cc96c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 172
              ; comment = "special case for DA in multiplication by 2"
              ; public =
                  "15c68851c1db844b5a1ef3456a659f188854b1a75fbdb2f68f514c9289ce711f"
              ; xprivate =
                  "d0e795450df0a813c6573496ec5793ca02e1bdbad10ed08df83fdaed68b3385f"
              ; shared =
                  "f654d78e5945b24bc63e3e6d790e0ae986e53937764068b1bce920e1d79b756f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 173
              ; comment = "special case for DA in multiplication by 2"
              ; public =
                  "4200a242434337b8914f49345301ed782b13594f9ede089c41fb1e7ea82c9053"
              ; xprivate =
                  "30b69a1cc1eb2d0b83ea213846e90a2c922088bdf294a6995bf6e6e77c646c41"
              ; shared =
                  "cd8a09b04795edcc7061867373981aa748651ebdce5ec218a335b878cefe4872"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 174
              ; comment = "special case for DA in multiplication by 2"
              ; public =
                  "baabf0174aaaea4de48cc83adfb0401461a741903ea6fb130d7d64b7bf03a966"
              ; xprivate =
                  "78b30bb63cd8ade71b7a77d426f4419d05f199ffef349e89faa9d9a5f21f6654"
              ; shared =
                  "c9f8258f237db1c80702c5c4d9048dfba9dfe259da4aeee90dc2945526961275"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 175
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "f12f18bd59c126348f6a7a9f4a5fdd9fcaf581345073a851fba098e5d64b4a0c"
              ; xprivate =
                  "c0b386f4ef0d4698686404977e7b60cb6c1f8b6012a22e29d6224c5947439041"
              ; shared =
                  "6600cbe900616a770a126b8b19156d5e27e1174bd538d0944eb3c0be4899c758"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 176
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "bee386527b772490aeb96fc4d23b9304037cb4430f64b228f3d8b3b498319f22"
              ; xprivate =
                  "9886602e719bacafea092bb75b51ae7258abe1a364c176857f3dc188c03e6759"
              ; shared =
                  "3fe710d6344ff0cb342e52349e1c5b57b7a271f2a133bb5249bbe40dc86e1b40"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 177
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "cf911ac91b0d944049cec66ae5ef0c4549d1e612e107c68e87263a2fbcf8323f"
              ; xprivate =
                  "b83960f5d0613cdaac6dda690351666e9f277bba6bd406b0e27a1886bb2d3e46"
              ; shared =
                  "71373ebe67f39a2c230027c7db4b3b74bab80ed212b232679785ee10f47c304e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 178
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "1e6ee536e4f26bbfb63139951a10f3bab62e19ed1ef8397178d9c5d04307cd40"
              ; xprivate =
                  "d03b75f09ac807dfd2ee352c04a1f25984720f785ffaa0af88bc5db6ff9c3453"
              ; shared =
                  "238eef43c589822e1d3de41c1cc46dcfec7a93febf37c8546b6625e1a123815d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 179
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "2f1c79ad8488db6f5146903b2dc46cfbfc834bbcf09b4dd70c274c4b67ce605d"
              ; xprivate =
                  "d036948c0ec223f0ee577e390dbf87222358ed199f2823345ad154bbc4cbcc47"
              ; shared =
                  "87a79c9c231d3b9526b49bf3d683bf38c3c319af7c7c5d1456487398da535010"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 180
              ; comment = "special case for x_2 in multiplication by 2"
              ; public =
                  "fccfe742a63ed9cb70958560b5a02260350a7ecbaf8c57ae045f671a29b4b573"
              ; xprivate =
                  "d054ded613febf2950ac5c927fcb120c387de0ba61b331cd33024c8b6e737048"
              ; shared =
                  "d683ca6194452d878c12d7da35f22833f99728bba89931a51274f61210336a5f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 181
              ; comment = "special case for AA in multiplication by 2"
              ; public =
                  "cb3d4a90f86b3011da3369d9988597c7fff1499273b4a04f84d0e26ed1683c0d"
              ; xprivate =
                  "e82c480631fb153ba2211fe603032b3e71b162dbd3c11bec03208ffcd510655f"
              ; shared =
                  "dbf6203516635840cf69a02db87cf0d95dae315da7fc1ec7ce2b29e1f2db6666"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 182
              ; comment = "special case for AA in multiplication by 2"
              ; public =
                  "101e13f7bc0570fa2638caa20a67c6e0c21dab132f4b456191590264c493d018"
              ; xprivate =
                  "c0c01d28c1cab01f59700aca5f18d2697658b37fdd54a339ff391c0a1a1b1645"
              ; shared =
                  "1fe314744390d525278b1f5fbf108101b8ded587081375ed4ac4ac690d92414f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 183
              ; comment = "special case for AA in multiplication by 2"
              ; public =
                  "dce1ec0843fa8f05d9c7355df598391f3de254ecd0b4ba9e6ea6fd9b3b6c2f67"
              ; xprivate =
                  "c82bde72df36479688c485a8bf442f4a34412e429c02db97704f03daf4dfd542"
              ; shared =
                  "ad454395ee392be677be7b9cb914038d57d2d87ec56cc98678dd84f19920912b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 184
              ; comment = "special case for AA in multiplication by 2"
              ; public =
                  "21c2b56f0794cfee25cc9626677a6838000eb66d8c4b5fb07b2f1d912e97c372"
              ; xprivate =
                  "503f697617fb02a7b8ef00ba34e7fc8ce93f9ec3e1cbfe4bf2c05bcee0cb9757"
              ; shared =
                  "c6d6499255133398f9dd7f32525db977a538118800bfaf3aad8bcd26f02c3863"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 185
              ; comment = "special case for BB in multiplication by 2"
              ; public =
                  "cc3d4a90f86b3011da3369d9988597c7fff1499273b4a04f84d0e26ed1683c0d"
              ; xprivate =
                  "58cd4ca1e4331188de2b2889419ce20ec5ef88a0e93af092099065551b904e41"
              ; shared =
                  "0d74214da1344b111d59dfad3713eb56effe7c560c59cbbb99ec313962dbba58"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 186
              ; comment = "special case for BB in multiplication by 2"
              ; public =
                  "111e13f7bc0570fa2638caa20a67c6e0c21dab132f4b456191590264c493d018"
              ; xprivate =
                  "004ea3448b84ca509efec5fcc24c63ee984def63b29deb9037894709709c0957"
              ; shared =
                  "7b9dbf8d6c6d65898b518167bf4011d54ddc265d953c0743d7868e22d9909e67"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 187
              ; comment = "special case for BB in multiplication by 2"
              ; public =
                  "dde1ec0843fa8f05d9c7355df598391f3de254ecd0b4ba9e6ea6fd9b3b6c2f67"
              ; xprivate =
                  "c8a6eb00a4d74bbdff239522c3c891ed7ce1904be2a329cd0ae0061a253c9542"
              ; shared =
                  "fb0e0209c5b9d51b401183d7e56a59081d37a62ab1e05753a0667eebd377fd39"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 188
              ; comment = "special case for BB in multiplication by 2"
              ; public =
                  "22c2b56f0794cfee25cc9626677a6838000eb66d8c4b5fb07b2f1d912e97c372"
              ; xprivate =
                  "50322ff0d0dcdd6b14f307c04dfecefe5b7cdeaf92bffb919e9d62ed27079040"
              ; shared =
                  "dbe7a1fe3b337c9720123e6fcc02cf96953a17dc9b395a2206cb1bf91d41756e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 189
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "e58baccede32bcf33b3b6e3d69c02af8284a9631de74b6af3f046a9369df040f"
              ; xprivate =
                  "e0328c7d188d98faf2ac72d728b7d14f2bbbd7a94d0fbd8e8f79abe0b1fe1055"
              ; shared =
                  "97bd42093e0d48f973f059dd7ab9f97d13d5b0d5eedffdf6da3c3c432872c549"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 190
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "c6d5c693fc0a4e2df6b290026860566a166b6d7aebe3c98828d492745c8df936"
              ; xprivate =
                  "5017679a17bd23adf95ad47e310fc6526f4ba9ca3b0839b53bd0d92839eb5b4f"
              ; shared =
                  "99bcbc7b9aa5e25580f92bf589e95dae874b83e420225d8a93e18e96dac00b63"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 191
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "d15f4bf2ef5c7bda4ee95196f3c0df710df5d3d206360fc3174ea75c3aa3a743"
              ; xprivate =
                  "2864aaf61c146df06cc256b065f66b34985cc015da5b1d647a6ed4e2c76bfc43"
              ; shared =
                  "afa2adb52a670aa9c3ec3020d5fda285474ede5c4f4c30e9238b884a77969443"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 192
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "6dffb0a25888bf23cf1ac701bfbdede8a18e323b9d4d3d31e516a05fce7ce872"
              ; xprivate =
                  "184a6cfbabcbd1507a2ea41f52796583dbdb851b88a85781ee8e3c28782c3349"
              ; shared =
                  "e6a2fc8ed93ce3530178fef94bb0056f43118e5be3a6eabee7d2ed384a73800c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 193
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "21f86d123c923a92aaf2563df94b5b5c93874f5b7ab9954aaa53e3d72f0ff67e"
              ; xprivate =
                  "c85f954b85bc102aca799671793452176538d077862ee45e0b253619767dff42"
              ; shared =
                  "7fc28781631410c5a6f25c9cfd91ec0a848adb7a9eb40bc5b495d0f4753f2260"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 194
              ; comment = "special case for D in multiplication by 2"
              ; public =
                  "587c347c8cb249564ab77383de358cc2a19fe7370a8476d43091123598941c7f"
              ; xprivate =
                  "50e3e5a9a19be2ee3548b0964672fb5e3134cb0d2f7adf000e4556d0ffa37643"
              ; shared =
                  "314d8a2b5c76cc7ee1217df2283b7e6724436e273aeb80628dce0600ab478a63"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 195
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "f5c6311a1dd1b9e0f8cfd034ac6d01bf28d9d0f962a1934ae2cb97cb173dd810"
              ; xprivate =
                  "08ece580bb6ddf96559b81d7a97dd4531def6cc78d448a70cebabdd26caab146"
              ; shared =
                  "2bfd8e5308c34498eb2b4daf9ed51cf623da3beaeb0efd3d687f2b8becbf3101"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 196
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "9316c06d27b24abc673ffb5105c5b9a89bdfaa79e81cdbb89556074377c70320"
              ; xprivate =
                  "a886033e9dc2b6a913fffbc2bd402e8c11ec34d49c0dc0fa1429329b694a285f"
              ; shared =
                  "d53c3d6f538c126b9336785d1d4e6935dc8b21f3d7e9c25bc240a03e39023363"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 197
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "8a4179807b07649e04f711bf9473a79993f84293e4a8b9afee44a22ef1000b21"
              ; xprivate =
                  "98b1cc2020a8ec575d5c46c76024cf7c7ad7628eb909730bc4f460aaf0e6da4b"
              ; shared =
                  "4531881ad9cf011693ddf02842fbdab86d71e27680e9b4b3f93b4cf15e737e50"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 198
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "a773277ae1029f854749137b0f3a02b5b3560b9c4ca4dbdeb3125ec896b81841"
              ; xprivate =
                  "c8e193de162aa349a3432c7a0c0521d92cbc5e3bf82615e42955dd67ec12345f"
              ; shared =
                  "7ba4d3de697aa11addf3911e93c94b7e943beff3e3b1b56b7de4461f9e48be6b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 199
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "1eceb2b3763231bc3c99dc62266a09ab5d3661c756524cddc5aabcedee92da61"
              ; xprivate =
                  "88e01237b336014075676082afbde51d595d47e1fa5214b51a351abbf6491442"
              ; shared =
                  "bcf0884052f912a63bbab8c5c674b91c4989ae051fa07fcf30cb5317fb1f2e72"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 200
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "9a2acbb3b5a386a6102e3728be3a97de03981d5c71fd2d954604bee3d3d0ce62"
              ; xprivate =
                  "e82313e451a198dce4ae95c6832a8281d847fc87b28db00fe43757c16cc49c4a"
              ; shared =
                  "e5772a92b103ee696a999705cf07110c460f0545682db3fac5d875d69648bc68"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 201
              ; comment = "special case for DA + CB in multiplication by 2"
              ; public =
                  "27430e1c2d3089708bca56d7a5ad03792828d47685b6131e023dd0808716b863"
              ; xprivate =
                  "2828594d16768e586df39601ecc86d3fad6389d872b53fca3edcaf6fb958f653"
              ; shared =
                  "378c29e3be97a21b9f81afca0d0f5c242fd4f896114f77a77155d06ce5fbfa5e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 202
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "4ef367901aac8ba90a50e0cf86ca4e4a3ff164fb121605be346e2e48d04ac912"
              ; xprivate =
                  "a84f488e193139f986b0e5b249635b137d385e420342aef1f194fcde1fe5e850"
              ; shared =
                  "7eb48a60b14fb9ea5728f6410aef627d1522fad481b934af64e2c483b64d585f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 203
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "d1de303c4ddd05d57c29df92ad172dd8c8f424e63ec93445beaea44f9d124b17"
              ; xprivate =
                  "30fd2a781e095c34a483907b3dd2d8bd2736e279617bfa6b8b4e0e1cf90fbd46"
              ; shared =
                  "b71bdbed78023a06deed1c182e14c98f7cf46bc627a4a2c102ad23c41cf32454"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 204
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "5bccd739fd7517d9344bf6b2b0f19a1e0c38d9349a25ad1f94af4a2cdcf5e837"
              ; xprivate =
                  "28312e17b47dd32d90561168245187963c7469a31c881e4a5c94384262b71959"
              ; shared =
                  "5bb56877caf2cdac98611b60367fbb74265984614e5e73996e8ea1bd6f749f1a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 205
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "8a7a939310df7ea768454df51bcd0dfbd7be4fcbb2ffc98429d913ec6911f337"
              ; xprivate =
                  "a87640cf8237b473c638b3e9df08644e8607e563b5964363ccc42133b2996742"
              ; shared =
                  "b568ed46d04f6291f8c176dca8aff6d221de4c9cce4b404d5401fbe70a324501"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 206
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "fe3590fc382da7a82e28d07fafe40d4afc91183a4536e3e6b550fee84a4b7b4b"
              ; xprivate =
                  "780c5b882720d85e5ddfaf1033e9a1385df9e21689eeda4dcc7444ad28330a50"
              ; shared =
                  "11fb44e810bce8536a957eaa56e02d04dd866700298f13b04ebeb48e20d93647"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 207
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "fad9ab3e803b49fc81b27ee69db6fc9fdb82e35453b59ef8fab2a3beb5e1134c"
              ; xprivate =
                  "209e5e0ae1994bd859ce8992b62ec3a66df2eb50232bcc3a3d27b6614f6b014d"
              ; shared =
                  "85d9db8f182bc68db67de3471f786b45b1619aec0f32b108ace30ee7b2624305"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 208
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "98bed955f1516c7a442751ac590046d7d52ca64f76df82be09d32e5d33b49073"
              ; xprivate =
                  "806d1dee5ff6aea84a848916991a89ef3625583e1bd4ae0b3dd25c2524a4ff46"
              ; shared =
                  "61d4ef71cbe7be3128be829ab26ed3463eb4ab25937c309788e876b23412aa7c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 209
              ; comment = "special case for z_2 in multiplication by 2"
              ; public =
                  "e59be4917b3f05b6fc8748c9b90f1b910273c9c6e17ff96ef415ff3d927d987e"
              ; xprivate =
                  "00f98b02ae0df5274cc899f526eb1b877289e0963440a57dd97e414cdd2f7c51"
              ; shared =
                  "5ba4394ed1a664811b01557944becf7585652a8acbdbf806742911207bd79346"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 210
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "8c9885a26cb334054700a270f7a5f4aac06bad8263b651ebf0712eca1ebb6416"
              ; xprivate =
                  "d86c18f2be396b3bb72f22e6ece22e273af6e1506a1c09ad4d01bdd2f439f843"
              ; shared =
                  "a5952588613eb7a5cd49dd526f1f20a4f0ffe9423e82cea302c2dd90ce559955"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 211
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "f6135fe9741c2c9de7dcf7627ef08832f351cb325dbb3a26f93a2b48620e1727"
              ; xprivate =
                  "f81aadb9053eb698996d0f781d9cda67f82ddefa3987d276ff5a94ffdf5d255f"
              ; shared =
                  "cb6fb623084b6197443ec9ba1050c0923332e5e829ae0194269cfaf920a43601"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 212
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "f6ffffffffffffffffffffffffffffbfffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "305b4db4321b4923fc559bf91df677d0e12c3a31b16ec655cb708b759d7c114d"
              ; shared =
                  "9e526079c2fcf12426ae6c2a54b5ffb70f2ec662e29ea5ce0c8385c3b21cd162"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 213
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "f6ffffffffffffffffffffffffffff3f00000000000000000000000000000040"
              ; xprivate =
                  "900638d1979802db9b52e4dd84fa19579f61cd7bef3c0b62fcccaeaa15fa484d"
              ; shared =
                  "6329c7dc2318ec36153ef4f6f91bc6e7d1e008f5293065d9586ab88abb58f241"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 214
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "f6eba0168be3d3621823089d810f77cd0cae34cda244c5d906c5d4b79df1e858"
              ; xprivate =
                  "38575cf7c8691ecc79cd5f8d7d4703aa48592ff6e7f64731c2d98a19aeae514f"
              ; shared =
                  "603f4fc410081f880944e0e13d56fc542a430eec813fad302b7c5ac380576f1c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 215
              ; comment = "special case for A in multiplication by 2"
              ; public =
                  "60677a5d934ccbfab8ff5d8f085a0b553f94527d9c49ae140f8ed135e1449b69"
              ; xprivate =
                  "e88bd02c7016547a24f428bc2a9dcccad6c6f880c17bffcf66fc68459627af4e"
              ; shared =
                  "834bbad5470e1498c4b0148782dfe630e8bfadff1997de802ac8ce302a1bda28"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 216
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "8d9885a26cb334054700a270f7a5f4aac06bad8263b651ebf0712eca1ebb6416"
              ; xprivate =
                  "9036ed7d68f7448ac440dc51216b49840dcabd3d5e32e3b4ffc32a5fe9e96742"
              ; shared =
                  "ec9070ad3491a5ff50d7d0db6c9c844783dde1c6fbd4fe163e9ade1ce9cd041d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 217
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "f7135fe9741c2c9de7dcf7627ef08832f351cb325dbb3a26f93a2b48620e1727"
              ; xprivate =
                  "90c55e77aa0fe4afb1287109fd010f526364dea18d88e2fd870ac01b66e3fa4e"
              ; shared =
                  "dc6d05b92edcdb5dc334b1fc3dff58fe5b24a5c5f0b2d4311555d0fc945d7759"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 218
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "f7ffffffffffffffffffffffffffffbfffffffffffffffffffffffffffffff3f"
              ; xprivate =
                  "a021ba2fd4e3ad57bcbf204d6f6c3e8018d8978552633b6dff1b7447bf529459"
              ; shared =
                  "1b174b189981d81bc6887932083e8488df8bbbed57f9214c9cfa59d59b572359"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 219
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "f7ffffffffffffffffffffffffffff3f00000000000000000000000000000040"
              ; xprivate =
                  "3035083e984837587f6b7346af871bf3fc9581c50eb55c83aefabeed68cee349"
              ; shared =
                  "15a052148abaad1b0f2e7481a34edb61403589439b5bd5e5646cecebe2a1be2b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 220
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "f7eba0168be3d3621823089d810f77cd0cae34cda244c5d906c5d4b79df1e858"
              ; xprivate =
                  "30435ce187f2723f9a3bdea0eef892207e152e4cee8985fa72d2db4147bd2a53"
              ; shared =
                  "1d048cbe2f8df07c233a8f93706f307d17130c2497fb752eeaa31fe3edfc725a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 221
              ; comment = "special case for B in multiplication by 2"
              ; public =
                  "61677a5d934ccbfab8ff5d8f085a0b553f94527d9c49ae140f8ed135e1449b69"
              ; xprivate =
                  "580f0a9bba7281a30fb033490e0f429f22e3f267852caeacefa3e5291f0e614e"
              ; shared =
                  "cb92a98b6aa99ac9e3c5750cea6f0846b0181faa5992845b798923d419e82756"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 222
              ; comment = "special case for C in multiplication by 2"
              ; public =
                  "c8239b710136fe431fb4d98436157e47c9e78a10f09ff92e98baff159926061c"
              ; xprivate =
                  "709098feb2e25c67b4bfd3be0a01af409adb6da52b3fbe3d970642dd2c983856"
              ; shared =
                  "f1bd12d9d32c6f4c5b2dcb3a5c52d9fd454d52ca704c2c137956ec8ad9aef107"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 223
              ; comment = "special case for C in multiplication by 2"
              ; public =
                  "b7a2f79e0de9b58147691b5546d9ec463da8325e1440e58bb20aa129d1b97327"
              ; xprivate =
                  "185ac62e729f88528950926c0de7c481c924bf9cf26a122f443b861e8b6af640"
              ; shared =
                  "e6f1c494c9e4bd2325c17183e82d31ab0bbee6c847d4b0e4a99c7c6891117c3f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 224
              ; comment = "special case for C in multiplication by 2"
              ; public =
                  "2dc624e1663f42a7b9336350f277541b50b8ddc7ee0d86133ad53273aed4e62e"
              ; xprivate =
                  "f03743eead7c2f7719794324f271072817d1a04cbda42b232f3bee43f397cc40"
              ; shared =
                  "aa2a12edf752d279bdb000fb1405a5df8c5f1d41309b4f2bd41aed7ac1ed0149"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 225
              ; comment = "special case for C in multiplication by 2"
              ; public =
                  "0e5eceee9104a64f82c9093b9bf7b4076ee5bc70815af7ee9f942ef015756176"
              ; xprivate =
                  "a8fbb4f90da45794981405d59ef310621e3c3b6b7760b5e30308c7822c88ae5f"
              ; shared =
                  "74d5606ba0b6ad1d8ba36ae6f264d6315f479b3984de573e9b001e0555247c32"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 226
              ; comment = "special case for CB in multiplication by 2"
              ; public =
                  "737d45477e2beb77a6c38b98e2a19b05c395df7da998cb91f6dfab5819614f27"
              ; xprivate =
                  "c887886fd07107c7221f6d9dd36c305ec779ceca132ac933ff77dab2beac6345"
              ; shared =
                  "8cf4538ae5f445cc6d273df4ad300a45d7bb2f6e373a562440f1b37773904e32"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 227
              ; comment = "special case for CB in multiplication by 2"
              ; public =
                  "873f8b260ea9d9ddac08b7b030727bf0072315ab54075ecc393a37a975882b7e"
              ; xprivate =
                  "58096ee29361978f630ad1fb00c1267c5a901f99c502f9569b933ad0dcce0f50"
              ; shared =
                  "d5766753211d9968de4ac2559998f22ef44e8aa879f3328cbc46aa858dcb433c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 228
              ; comment = "special case for CB in multiplication by 2"
              ; public =
                  "75e1587c5eefc83715d71020aa6be5347bb9ec9d91ce5b28a9bbb74c92ef407e"
              ; xprivate =
                  "0829a49046dce2c07ab28440dbad146453e128960e85dd2e6a69a1512873dd44"
              ; shared =
                  "761d8cecf13f93b379a772e5fac5b9ffe996cad9af06152580afe87ff9651c71"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 229
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "f85a06065ea2527238fc5ec1b75ead9262e6b1aed61feff83b91230aeb4b7d01"
              ; xprivate =
                  "587ac36b9a23594632679adea1a826f2f62d79738220fb487464039f36ca2372"
              ; shared =
                  "f12acd36f6299a4d192c03aa4efeea7df51e2d15d763172e68accf7bc6f5c230"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 230
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "6e0f1d00b1099d2a71f7be86655feb8988bba5577b02f964043a49f00c749613"
              ; xprivate =
                  "a8a442b7c0a99227b4cb5c75fb9e5a72cea25eba8a0bdf07271bb4a93c2b6665"
              ; shared =
                  "b2bbbd173f41d952d329251da973a9500300628177ad0fb79d01e2e263905b38"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 231
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "696757ced3097fa960c8390a09e8bd6d390dbde8d1fa170261f3422edc192929"
              ; xprivate =
                  "d8f7233e9612c00c9dca2c751ec1d3f5f67bad77c2e714a20e71eb3f220a6671"
              ; shared =
                  "45ecfa275f1daa25d3fadf33cdf89a152afea25eae37e68e00b30c367789887a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 232
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "fd84b3f2fbfa16aebf40c27f46e18d77bafa0c7971bedde4909212e771bd3c35"
              ; xprivate =
                  "d80c7c7557c9907e1b11e844bf1369cba669bc38e9b7b253e51f239bda322374"
              ; shared =
                  "595e144e07bbe65b38e0e4163d02ad75a65e422e74067db35c90dfa6e055d456"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 233
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "805485703ccfc4a221ef281267f52b61cebc879f0f13b1e5f521c17352a0784f"
              ; xprivate =
                  "8002a85115ad7b41c50f84f35fac750ee8e19734807102830ff6a306beed4464"
              ; shared =
                  "226e16a279ac81e268437eb3e09e07406324cb72a9d4ee58e4cf009147497201"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 234
              ; comment = "special case for x_2 in multiplication by 3"
              ; public =
                  "80642a3279da6bf5fc13db14a569c7089db014225cfcae7dff5a0d25ecc9235b"
              ; xprivate =
                  "782db0c8e3e68f106fe0c56415e0bd13d812dea0e94cbd18bdf6761295613a6d"
              ; shared =
                  "790d09b1726d210957ce8f65869ca1ec8fa0b2b06b6bcf9483b3eb55e49e9272"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 235
              ; comment = "special case for z_2 in multiplication by 3"
              ; public =
                  "84e827f78cae0cf063e4340198f788c284e07430b3a94a3873df38b1f872ce02"
              ; xprivate =
                  "909fb0bdbf53a69a2fe39c8b2497abd4fa57d2d54e046b5f514595e2c0f33d63"
              ; shared =
                  "684cc83af806bcd9cd251e1858f3c10f0166e0a0cd2be154339a886b13e7c76f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 236
              ; comment = "special case for z_2 in multiplication by 3"
              ; public =
                  "d445e1df0083bb6b8e886e6632251807171d4e88c41816fc684373c09d7e5d6e"
              ; xprivate =
                  "78a67909757248665f79371eb014825ab6bd4af3571f140389c636e004bcf46b"
              ; shared =
                  "e426e4a3c54d3e77f4f157301e0ac7d9e12337a2b58df16780041cf6d6198c5a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 237
              ; comment = "special case for z_2 in multiplication by 3"
              ; public =
                  "f26aa6151a4b22390176f6233e742f40f2ecd5137166fb2e1ec9b2f2454ac277"
              ; xprivate =
                  "286a302d5b076d2aba7c2a4daf9e7cc9d8539b7c0391307db65a2f4220d30f70"
              ; shared =
                  "862df92e25277bd94f9af2e1dda51f905a6e2a3f6068a92fabfc6c53da21ec11"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 238
              ; comment = "special case for DA - CB in multiplication by 3"
              ; public =
                  "2b02db3c82477fe21aa7a94d85df379f571c8449b43cbd0605d0acc53c472f05"
              ; xprivate =
                  "a838b70d17161cb38222f7bc69a3c8576032d580275b3b7d63fba08908cb4879"
              ; shared =
                  "3f438dbf03947995c99fd4cb366ca7e00e8cfbce64c3039c26d9fad00fa49c70"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 239
              ; comment = "special case for DA - CB in multiplication by 3"
              ; public =
                  "d71dd7db122330c9bbaab5da6cf1f6e1c25345ee6a66b17512b1804ace287359"
              ; xprivate =
                  "b0733b4203267ab3c94c506acadb949a76cc600486fcd601478fcdef79c29d6c"
              ; shared =
                  "95f3f1849b0a070184e6077c92ae36ba3324bf1441168b89bb4b9167edd67308"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 240
              ; comment = "special case for BB in multiplication by 3"
              ; public =
                  "737bc07de0729bbcfbee3a08e696f97f3770577e4b01ec108f59caf46406d205"
              ; xprivate =
                  "d844a36b58aefdb08b981796029a2766101884b348f70eed947c2541064caf6a"
              ; shared =
                  "6a969af6d236aba08fa83160f699e9ed76fb6355f0662f03dbc5915a3c23063e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 241
              ; comment = "special case for BB in multiplication by 3"
              ; public =
                  "9758061a7b3e2c02fb5c20875ae6b55b11fb6795990a0f4fdcd1147be5521607"
              ; xprivate =
                  "a0b7d312d9b832e124d1bc8cb21db545440e3cf14e7473ee9ccbe9b682f2156c"
              ; shared =
                  "ab39db4aa29ac4017c7446f1ad0c7daa9a37f1b6b4f2e9d2902ccefb84839d28"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 242
              ; comment = "special case for BB in multiplication by 3"
              ; public =
                  "37cd65d33036205f3449e8655a50d4b0c86fec02100b4f2db7da92dcf5e3aa0a"
              ; xprivate =
                  "787f1ddd78cc6473d3e63949409ad3f35bfe0ce0738f255dee682f2bfbc80f7f"
              ; shared =
                  "13de41659e3e308d6e26c94282fcc3e0364ddf0809ddee6c8e7abb5091b02b00"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 243
              ; comment = "special case for BB in multiplication by 3"
              ; public =
                  "a9b6e8081460383adc587c8f91a02c59a7a35576ca62436ccd1b5fef1b92545d"
              ; xprivate =
                  "4080ae60a85c1fa95aad9beabd98b405e7f28141bf08f2c9a4fdbde1c5680265"
              ; shared =
                  "69ed8a0a27812ae6741474bd5c6a4e683a126649f7245aa0f91a3a384bcde25a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 244
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "fd1a2cd17a93f850deb8c45a2d34539232dfd8a558304209781c6cb58229870e"
              ; xprivate =
                  "08f9f4a4fac4db413315f74a59818b2452fc7b7685592e26556775f9b86d907f"
              ; shared =
                  "010218bd67b1b92fee3e7fa4578c13617d73195de10279747e53ba01a254525a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 245
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "b88119e5ae6d9e6b912d52524739e612ef19ab7e5dd3d946cb9bc003c378f81f"
              ; xprivate =
                  "1888cfae3085867657b09435c42b74cc762457839451a3659db218d4214fdd63"
              ; shared =
                  "e6b298de9cb6358fbbb00f11890f5714a3858e8f05a2a8d1cf39fe78cc55dd4e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 246
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "7b70e29dce0479cde4a36c7f9786582f104bc0788f046b48af495e67bdb88f36"
              ; xprivate =
                  "789ce13ed007818d7a5181e629eed944a20a058cfe39669c9831bfa5215a1269"
              ; shared =
                  "967bbe298494b4a5f95853cfde9dc85970b2a4b5dd2c92782901e853957f5809"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 247
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "2a209e2ace0e3d6973ffbf7403f9857ff97a5fdcd27f2c7098b444fc3c166738"
              ; xprivate =
                  "00022b43775ab2f4b91bc1cb54c97f78026289eaaf02abeed04ca84f736c686c"
              ; shared =
                  "9f66848681d534e52b659946ea2c92d2fabed43fe6e69032c11153db43dca75b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 248
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "f50709aca7f314e8d05b5ff97a427e427bd5e85c4e86712125076a771be21448"
              ; xprivate =
                  "8097a52fc562e8a516682f5363cc5e7c88e9c78e308df0deef40497b35cc127d"
              ; shared =
                  "ea7572e27a9120de1f13b85710ba69a3471b7b3f5d12bc430c12c4bbf8aa3957"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 249
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "0f13955978b93d7b9f9a2e70d96df922850a8ffd8412e236fb074aef99d37d54"
              ; xprivate =
                  "4028802030d8a8221a7160eebbf1846116c1c253abc467d6e43cb850f1459860"
              ; shared =
                  "e23d63a46be67c7443c07b9371ff6a06afcd7a5794bf2537926074b88190307a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 250
              ; comment = "special case for E in multiplication by 3"
              ; public =
                  "18ffe992a729ce70c3b7cdc55bab55f2210d279134b3082a9f682d3a0b131273"
              ; xprivate =
                  "d8515d45c7ab2b9529816543150068b8e4bb614cf2b68a8a99363975af503d74"
              ; shared =
                  "33ccaf24e1e26290ed7e462093e9f77607ef52a0626b2cd2511c41cd24c13849"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 251
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "c3ba28057728d0533965ec34979fe7bd93cf6cb644e8da038baa87997b8dc20e"
              ; xprivate =
                  "d8815bd144518fa526befdd373f5f9cff254d5d3c4660e8a90ef2a22c6876a74"
              ; shared =
                  "74f95b4700f0185f33c5b5528ed5012a3363f8bbd6f6a840aa1f0f3bdb7c9650"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 252
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "4eb095a86d1e781bb182233075ebf1db109d57135bf91d54fdb18eb371427640"
              ; xprivate =
                  "a82d996093eefdaf283f4049bba4f5af6ecc2e64894f325ee1f9ca1e156d0567"
              ; shared =
                  "e9677b854851c41cc489e03981ae78690be6cbf0054ea9834759de3e27bcf03e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 253
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "83f67d7c92b11c8fb072484642a01f43deb022b54d94a4015e39849a2e2e9555"
              ; xprivate =
                  "c02609df3d5436c123dcd7ee11f23f1da321666c09f379d37914203340510861"
              ; shared =
                  "f148716ebe7269a7076f0cf1f22b6978d3c7e3607b0bcc87a8c7a85b9fd20c2f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 254
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "20cc75d376d8453b9d049c84f58eafcf61126c08a03661e735f0a8be228fd466"
              ; xprivate =
                  "a0e3b78c0f3be2a760b2c916f244df219624fdda2e9e31b15328f4a77690296a"
              ; shared =
                  "1d5c123e88e9dc7a3b16ec90b60578dfca7e11eab9b88c6eca7bc33d91fde83b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 255
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "ef31b43d19c0a5434deb56129c16298a394a7032a2e52cb997476bdeca325b73"
              ; xprivate =
                  "701f130a290584cb28c7d6539506a1a054f926a17ef7c568ae43047c05e10f60"
              ; shared =
                  "2fc065ba8f5040a0a659f6f7330554bd1b9d7c893b91e316e0af90c37af4f135"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 256
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "d8c8e2c6f33a98525df3767d1d04430dab0bda41f1f904c95bc61cc122caca74"
              ; xprivate =
                  "d0e67f68183a4c1aed9c56864b36278bb7bb75d57a78321bc7c24ff61636607a"
              ; shared =
                  "ef7612c156078dae3a81e50ef33951cab661fb07731d8f419bc0105c4d6d6050"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 257
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "1833619516b80db0c05b225509e6698df028d83b66ed6bac6f0f6308970d2c7d"
              ; xprivate =
                  "88eb7775dacc32b045ceb35f261b3616315efa98b780e08c79d544edadb5467d"
              ; shared =
                  "a3cf3d81ec56896a68fca0da6335171d0c622568738c0db26fe117033726a049"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 258
              ; comment = "special case for AA in multiplication by 3"
              ; public =
                  "e2e989aad2397fc34b6cbe2db27d5ab69b28048383c91d9e8226d548253fab7e"
              ; xprivate =
                  "7055b1c0576e7ab6c89fcc1ce49e79c8c371bf9fc2b22b8f8396a9b64c5ae26d"
              ; shared =
                  "e7f45823a45b6a46192b37d73e8609b5bda68cd7cfbdccaa49082080993e640f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 259
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "b9bd793624d6a7e808486110058853edb25e136bd4d6a795d6d2ef53b25e3804"
              ; xprivate =
                  "906a9bfcfd71014d18967680d4509eaa41c666424af98bf9ff7ff49eb1baba41"
              ; shared =
                  "7c6148134c9e8b2ba5daeca41e6a1f3a82d8f75d0b292b23c40fe7f5ce0a2b7a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 260
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "e3f444e208da9043f3f74c20e28d7f404bb687a346709abcd555156f88607820"
              ; xprivate =
                  "28392b1b035a8465aa22aabb571061c6effeed40cc2530b628e4fd40395ae04a"
              ; shared =
                  "ea5e772bac4693ce69ea3ac761011fa7674037653a433c7f05456e7291cd3c4e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 261
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "87b43f90f76d12fb3a469fa8687c27e369d4a82f95cf95e8dc3970de8f86d92b"
              ; xprivate =
                  "78cbb35204cc88676c14e0ff18171392e998411b23d905d4c4dceab70511f442"
              ; shared =
                  "81c395aed5cc5f5e2a206a8a4cacecd501df5b81e49433835ad8a3779edffb30"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 262
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "86441ea06c5cd2a34c6b51261e93a2f30ea7db0f74e14c42f0fc443c6735973c"
              ; xprivate =
                  "a8225b49ef7b7330e3de787cbc40479644db7ab126370295c94189673430d745"
              ; shared =
                  "513eba5870dc5187e2552fe3ba8292b516d2af9ecb9a9bdc51eac2ce2de40112"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 263
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "4624aa4ae9d12725bf92b85f93e3e8cea16b7bd83fda0eb18fab2dbe0e8bf742"
              ; xprivate =
                  "0841e1a5c7420b94b6cc6991316ebdd608626339c09d0f67b24088588b9d0d49"
              ; shared =
                  "983b7e236ffaddb4b759b7353fe87846f59fb6f28a3ed65c256176b6609b7c6e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 264
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "a625a5b7a04cea462d123b485c39ea44a8079aa223c59e9ca97abcd30b500e4b"
              ; xprivate =
                  "08ecf76e31a23039ea8a15ee474b6251a9d725bff1a5751eb5ecde9d7d4e2f49"
              ; shared =
                  "c941369b085c7465d50d23ceaf6717ab06e24638f217a7b8055ce8ebd3ca1225"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 265
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "8a5f2063f259f3317ae3e0b459f82c4677666e49a2eb9bf0369aee663631265b"
              ; xprivate =
                  "6038fb0a830d1001ca8ea74a613ea98f6ab8512644e55e8d45a29071bd4bef45"
              ; shared =
                  "a3f7e169db44d0d179c242e66347364ab92744dc6ad80e4775aef7f4ff9d5f34"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 266
              ; comment = "special case for D in multiplication by 4"
              ; public =
                  "54cfb6ad0d03e3115acafee12606397f2bb46a8c5f326a255c494118aead3b62"
              ; xprivate =
                  "c04cf129f0b33332e2654f8e45225c042d7fa6cbc793c88bd4c731985289b045"
              ; shared =
                  "401aabfbb73fe6694c446ecfffb43006427a9d4756e049a1ffc79578d62f1660"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 267
              ; comment = "special case for E in multiplication by 4"
              ; public =
                  "0ee3bee8cb3a0afcec22fa2233706e8ec29ccf1af212c0a674745ebba34f9d08"
              ; xprivate =
                  "3806b036c92d7bc0771998d24dbda2945b601d42449bd3ec4bbf3757d01b894d"
              ; shared =
                  "20322dd024fb5a40f327cf7c00da203734c2a279b9666a9ff7d8527c927b675e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 268
              ; comment = "special case for E in multiplication by 4"
              ; public =
                  "797ec7512afbf0ad918d0e4947903be95234f3abf36750a8f854888d117b774e"
              ; xprivate =
                  "380d9056b5a2f4b3dffb30e6ceb722ac4684245f1befafb5661bc8c7a9ad4c43"
              ; shared =
                  "46152d59c2d2f3ecf03ce652d2b6978d401d5ede4570a6c911771bdcfb37cd41"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 269
              ; comment = "special case for E in multiplication by 4"
              ; public =
                  "d570c7810f69e502b355253afa7c667bfa5060d90dc86e358ab445f6381e415d"
              ; xprivate =
                  "384929a42c8d8df146db9508e2f21a4e8cd4d99c1b1338df17a457e88afb0043"
              ; shared =
                  "37567f7ec0449c7b823cf7b0e219e9dd880e56a1464d0417a9e67eff42332866"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 270
              ; comment = "special case for E in multiplication by 4"
              ; public =
                  "2c611cb94448f1c7822425a4cf5356236b90a555b1ed4747820ba7f739c8f57d"
              ; xprivate =
                  "48a986825b2680e2f2547ba75a9599b04ed57f8ed18d98e7099c544efbdf284b"
              ; shared =
                  "fbf6587ec181116cf1ace7dcd548029d69c130e50fcf6ad5dfcd25c23ee9f939"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 271
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "e559c417da7fd5851352f508b90031d49b5d2d0aac88a9c8b5fb6e80165ac10b"
              ; xprivate =
                  "98452ad7df4e26bc4b3d403f9ebf72bb2d7b6b7d5860dbf6fb9a4f78dc02704a"
              ; shared =
                  "c7c6f6d7ce1e4f54c727e5900686c34e6a6953254bd470bbbf0c7c18bbddad73"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 272
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "746d97e7774292a3d703f604e79d8764c99a6a2fe280eaa9811115f5e038f21a"
              ; xprivate =
                  "a8dbc9be5034ed7fe7f469264f2135e9c67cd30f525570d2d841e4bdeac52349"
              ; shared =
                  "cf7d2a66ea4dfed94469b2d343533ff302a576f8402ed2187904437038e54665"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 273
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "1f354aa8ffc4eae2b40dad2ebf830db3feb07e2a1a2da39e55df87c8c613de1d"
              ; xprivate =
                  "f8d26878dff25ced02d3b27ce74002695bb879b3c4328930934315ecae842b47"
              ; shared =
                  "b204d3bbcbdc624f9f1a743fa3daa8f4c8785ed088d37d08cd13c601170a461b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 274
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "9c3f0023e1a4832586af2483bbec64ce9f06f3ea806d4019a5e4abb1b5627029"
              ; xprivate =
                  "d0f5e9c43c95b1ffc36f832b943601d5e17647f7d78e2e7710ace63ff274d447"
              ; shared =
                  "b9f21465615f39dddcc37520ce9b956f7de9883ac93a870d74e388b8e1775463"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 275
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "d05656aa014d476022dfc55e8d3b4884ed0bdf85209be8b55351394d52be684b"
              ; xprivate =
                  "700679e8c24df828f2e5212a3263d5e93ea61679988298bab3b480f46f961a48"
              ; shared =
                  "20f1fc613874495f20562c10b7a8be47bfc12c168d829d6321aa2de17060e40d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 276
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "c4a19b8686e18c29359aa548427f06a368d55a8737483d4893523adac6795a4c"
              ; xprivate =
                  "d0d077c9461f747e5660be85cc620428b4cefe805de0fd254adaa465ea5e784f"
              ; shared =
                  "652b18ffd41cfb7d1f0b6dc79baa3b2a392ef1617f5cf6259b5b4ff065916a16"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 277
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "4989de79853ff35be8c9f92fc94674feef38a0e65788471c521f8e259adf015d"
              ; xprivate =
                  "00711ac08ef88c3d43a3cbda67b6fe5f34f54723dbe6d725c8a3569070ab9a4e"
              ; shared =
                  "679825c259392d86f8edb15328d4faf52300779d979a503a76e27be3d7a85e03"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 278
              ; comment = "special case for B in multiplication by 4"
              ; public =
                  "a981483cb0ea4385ffbb552826c3dd110d4ae89ff52ed0cd6018f99d3387987b"
              ; xprivate =
                  "989a75b40451139ec36ca6aa043765c61a18be323a5987fcb025c2dad8d4bd40"
              ; shared =
                  "9cadc14ac153fa383ef66d1833f589100dff90523272e32b06e2c6f1f4424040"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 279
              ; comment = "special case for BB in multiplication by 4"
              ; public =
                  "1df3dfdab74ff38177dac294b2da2f49a348bc3b3bc6ce9312bea5ef3ecdd30b"
              ; xprivate =
                  "90c3cfedd919a2ccd51fb455649e3ad2da1ef0ff619b59a7f9c55a68a8219645"
              ; shared =
                  "bcc95fb4890ed311f3fb4f44c2b60866cdddec97db820a7f79f475337e16284a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 280
              ; comment = "special case for BB in multiplication by 4"
              ; public =
                  "fc6b718ba8b47d24b1cfd6b5d0dd8b20fd920960fabc302dbe4f93bd2a06e933"
              ; xprivate =
                  "e8fef5c9b60f84984e8836d535acb372096ba8159824a0b49a17eccda843bd41"
              ; shared =
                  "06f1b495b04a0010845c9d39b13bf2784ade860d9632c8847618c0b34297c249"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 281
              ; comment = "special case for BB in multiplication by 4"
              ; public =
                  "b279b6c065f95c7040f148bcb4a3d310e34bdb005931a879be469573deedd041"
              ; xprivate =
                  "c0e05bde7727db4e352b5e7f035327b4d86a42d513ca116e22d64a4ede56434a"
              ; shared =
                  "cce7bb644df94501421db49d15e821c7b0aaabecdf8837ab989b1f23bac08f35"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 282
              ; comment = "special case for BB in multiplication by 4"
              ; public =
                  "98e2cd4c10554e41b0a3e41082c8b6b61b55447d26c0aa97f9a06baeeb54b55b"
              ; xprivate =
                  "d87308bf753573f596ac8330b204014b2152dbdfc9881a0d9975058582bdf646"
              ; shared =
                  "71fdd3405c30805701ae4dfad98c493aecfcf2e3b563e7068373c1b19137c268"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 283
              ; comment = "special case for BB in multiplication by 4"
              ; public =
                  "872897f1bd1885da08b9d03e46811044fbb04186ba30c806f38b94ebdc27186a"
              ; xprivate =
                  "d80059a8a387e16f6ded6e7e980e806d1f78b470bb61103d0ca70623ccee8b4f"
              ; shared =
                  "bf280aeecb74ab34e1310aa6fe8dc972f94dc40c7f88b72137ccfe34ed343c13"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 284
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "c08f72760d9cb4a542aad6e2af777920c44563bd90356168c3608c6b9af2ef0f"
              ; xprivate =
                  "b0a4fe63515169bd82639b515ff7e5c4ac85bba0a53bbaca80477eb3b4250d44"
              ; shared =
                  "72566a91ccd2bcf38cf639e4a5fcb296f0b67de192c6091242a62fae467fb635"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 285
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "4f03849c24d584534d74302220cfdc90e1bc360bb5e297c0fd0fd5f8d799e416"
              ; xprivate =
                  "984256b12ef154ff6c2e1d030826164cba3614e3df7688d82b59e16201c9114d"
              ; shared =
                  "24acb4afa63919621df795206c3929b599ec9d253693895d51a0555072e89a34"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 286
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "4959771a931e242d5713d5cb76f33310c6a283df16645604289553809cda6518"
              ; xprivate =
                  "6847141d5d4377af96a2a647c642ee81600fe48d3467e3a70f3ee312bb621742"
              ; shared =
                  "5ba2112a41b5bb381f202446fa9f23c54d2de149f9ad233753417263840ea432"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 287
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "f6fe690cf547049635bb3a7785537b4379c9ee06b46120493b8bdb152e09c81d"
              ; xprivate =
                  "e85f1164e2ab6faf62667c74b03ce529b49a0e2041b1ac0fa242e522d2b7694c"
              ; shared =
                  "a87c9fdf40c409b9edab481b2cc69687ee1ab92e340c3db0107d40b5de6e7a20"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 288
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "b468681a1275850c11d37ec736af939a75a7098514e04cfc1c6ca78239a88426"
              ; xprivate =
                  "281e1bbfa711de69921a64c5d2183c338db5504606ce2b6b4ce1cdd54b41e14a"
              ; shared =
                  "3be98798f01e71639f3cb8fd4a17bf273e10c67f8974dd9802eed59d847d4020"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 289
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "2d71e8457099e3f445f9e2a14f18b0f5914bb35f482f9c069b64bf63710d4228"
              ; xprivate =
                  "20aacf1902b3cd609d7ee15cc96453cc22e2899d7d17852680f2a728bac6dc4a"
              ; shared =
                  "338c9917dbf11a0cabe8ad4a65959229bc00f99c211e752b20b8b49b87756d0b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 290
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "fa8f24e944de5d003746d4630350c0f4f6175a3269c19184824105398fbdd329"
              ; xprivate =
                  "009e8e9fa993804dce94cecb96b1de2568245a97059e4d7ae116ecdb1badd141"
              ; shared =
                  "56e2bfc7f6ab7da8fc734afc515e57d0794d002434f9bc8e18bd0b72c0df3c4a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 291
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "ae4e37ef53c79e25e8275a60f2fc1dfc277ebc5d3b88428c6432c3f98494212c"
              ; xprivate =
                  "f01574643f231ffac055bd235ee74dd416b94c8e55a2ab2b4d13a8b788d90148"
              ; shared =
                  "17fa1276d9fd5025172736449a1c0ae33512e5037014a18db5903e47bb3bc950"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 292
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "95e56a830792478f7c42504043a9cab8e2eebff5fd90983709e29e03c0a41b64"
              ; xprivate =
                  "3800a42659954281ca266d7cf1ea9db6d79891a406a70f9e84c3570a6a12d24e"
              ; shared =
                  "167a3b2fdce9413c89ee892daf9f839a2eea80ea8044924035db1724a5b0217c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 293
              ; comment = "special case for x_2 in multiplication by 4"
              ; public =
                  "5f16aa7ccabf4da6b686bd28c7460e106bb1b97a823792527765c29a9ad8fc71"
              ; xprivate =
                  "70a826b186962218dbafca113319daefb5ddf3cf14e15fe3faadc4c0a2e46648"
              ; shared =
                  "30a4ba793f2dffe1700c61428b4d84b5fcd0aa99a23b903f84a48eca5cc9fb0a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 294
              ; comment = "special case for DA + CB in multiplication by 4"
              ; public =
                  "47fb78111805a11982a3d6c5d83e8e189e7fcc462c9abf805d3625be7a6eac11"
              ; xprivate =
                  "a85a5eda0a269500b3ab0b58495fc254c2691028ac533494b5f86d44e9dc654c"
              ; shared =
                  "2bf9ab750bd58ff6f877b783eda45a71a65cc9b7c037fcfef4cb5f4c8842f529"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 295
              ; comment = "special case for DA + CB in multiplication by 4"
              ; public =
                  "03b8ca5efd1777d6d625a945db52b81f11214daf015d09fdc9df7d47b9850e31"
              ; xprivate =
                  "183f28ec867624ef5eca4827ed0714a5525ef21d5e35038b24d307a3391a2846"
              ; shared =
                  "35e9289234bd5e531da65d161a065a14f785076088d741c9a2d886efd7d17921"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 296
              ; comment = "special case for DA + CB in multiplication by 4"
              ; public =
                  "4eca5f8731b0fa0c106acf578b83a350fa8173a290f1eba803956de34eeb7671"
              ; xprivate =
                  "888c6444ff5eb482b2b10bd4e8a01bdccb65f32934d8026106f16a91349f484c"
              ; shared =
                  "833afb867054b8b9ac70d6013c163e8b7676fd45ae49a1325f3acb75975d8c13"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 297
              ; comment = "special case for A in multiplication by 4"
              ; public =
                  "a5562b4ba86b464dff4c2cfae85b384be211771efe8a9697e51d84de47f1eb14"
              ; xprivate =
                  "c8a85d140ba150f5c6a8d3cb363bcbcb75365e51c61640e974a0725b5e9d5940"
              ; shared =
                  "8a914760129575c8ab3270d04b0465fc2f327acaf1676463113803bbb2ec8021"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 298
              ; comment = "special case for A in multiplication by 4"
              ; public =
                  "88ae1631cd08ab54c24a31e1fec860391fe29bc50db23eb66709362ec4264929"
              ; xprivate =
                  "90a3aeb1417c3d61c1efef1ac052218fb55d3a59c4fe930b5a33cc5183b48547"
              ; shared =
                  "c1988b6e1f020151ec913b4fb2695bae2c21cc553d0f91cf0c668623a3e5a43d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 299
              ; comment = "special case for A in multiplication by 4"
              ; public =
                  "cbc4d55d5bfddd0bc5c5edbe3a04836b2c701d25195b26221cbea19311e55a3d"
              ; xprivate =
                  "b858d7414bd9ab9a3ebea79064ab87bc050e74407f4d4748f62fa4d9d203b640"
              ; shared =
                  "bb24817bd9fff423dc0972908e2c03fddf4dbe100016b459f28fe9594adb3714"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 300
              ; comment = "special case for A in multiplication by 4"
              ; public =
                  "d66a2f9f7577e2df4a56cb51962b3056ff5cc0494c60f39511782e79923edd41"
              ; xprivate =
                  "f825edf1f79eddd715a72b3ac267d6b2e97e18bb13bcafdac5940370b85ba64b"
              ; shared =
                  "b3b4513f8a3102e1ae782fbc69888177f2c24c569303a5d01ab1c3c5e285524a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 301
              ; comment = "special case for DA - CB in multiplication by 4"
              ; public =
                  "de0fed2fab6e01492675bc75cbe45d7b45b0306cec8dc67611699811c9aaef16"
              ; xprivate =
                  "b0a710b470e324bb56a7d8ff8788d05eb327616129b84972482425ea4ad4f34b"
              ; shared =
                  "471ba91a99634f9acf34fd7fd58f72682be97ee1c821486d62ba4e448cbc0417"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 302
              ; comment = "special case for DA - CB in multiplication by 4"
              ; public =
                  "6418d49fe440a755c9ff1a3582d35dc9b44c818498f15782c95284fe868a914c"
              ; xprivate =
                  "b898f0329794747d33269a3989b67e43a7ab5a55fa1210b0e5dba193f4fa094e"
              ; shared =
                  "cdb3ca02d5fdb536dbc7395bab12bdcfd55b1ae771a4176dedb55eb4d755c752"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 303
              ; comment = "special case for DA - CB in multiplication by 4"
              ; public =
                  "a89bcfa236bbccf07c434b59f8655fb085b6cbe5ed6376281df813afba22b752"
              ; xprivate =
                  "a0528ed9a8ec22ebe9cc2e32fafc3f467500a9a22f5377382df6604edcdf4f44"
              ; shared =
                  "cd3245403fd9edfcf91c9581ebb2eb7c77ad6837fca372479e78de9faf60a34a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 304
              ; comment = "special case for DA - CB in multiplication by 4"
              ; public =
                  "cdb1f95f6eacc24b6d029c6ed976666dc51794db8e4aa966ba850fd7f5048965"
              ; xprivate =
                  "f06888bde75d689d056874f6436000497d22d8ad9b95a1c67de1dda4ada3164d"
              ; shared =
                  "ab7c47ecb0c0167156f44f66a527264b958fc992c21ce98cef3ae214d66bd82d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 305
              ; comment = "special case for DA - CB in multiplication by 4"
              ; public =
                  "9491a82744f1cb6105b76b0442e54e605ac67f47a1b2b3b552d486f75bd98e6a"
              ; xprivate =
                  "e034fcaa3ae40603f9b22af159fd67ef009380946de92cb1d83cc489e8b35041"
              ; shared =
                  "1bfa264a7c7229147a20dd021211891e61f5d8c76cd83f0be24bc70e466a815b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 306
              ; comment = "special case for C in multiplication by 4"
              ; public =
                  "4d19e156e084fe582a0eb79b2f12b61d0b03f3f229227e798a933eea5a1b6129"
              ; xprivate =
                  "702a7448c0ed58e1f4e0e332d096a36360beca2f6955c815bc120b3a691d7742"
              ; shared =
                  "c46057fcf63088b3a80e0be5ce24c8026dfadd341b5d8215b8afcb2a5a02bb2b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 307
              ; comment = "special case for C in multiplication by 4"
              ; public =
                  "cc4729c4eae292e431ec3a5cf5020e19f9bea50ef3218d9a790034526c3ee14a"
              ; xprivate =
                  "50025cb508ad4faa06fafd0f4a33b747ccf1b3573885d3426500d51b56300144"
              ; shared =
                  "d4361e26127adfbe37c2ed8f42cce4ebab8ab74ed9e74f14c3435d612c1a992a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 308
              ; comment = "special case for C in multiplication by 4"
              ; public =
                  "4a474249af8f771f0cfb1116f24fda4c42f4136d2afb766d1b291c73c6668d5a"
              ; xprivate =
                  "7082fc53299a4d30e5d0c383c035935b1eeebd9408fe4d04b93eec24be52eb47"
              ; shared =
                  "80dfae7a28bb13d9e51ff199267cec2a19dfc8b6f4974e3446b2f62fe9b62470"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 309
              ; comment = "special case for C in multiplication by 4"
              ; public =
                  "0f2a5cbbe503139531ac0529183da8e624d25286f6e35d1407ab1f4d76ebc260"
              ; xprivate =
                  "98ff7e711d65cc7fd9d0ac12dfe8b894e0a93602ca9e75bf0eabbf0bfe670148"
              ; shared =
                  "7a5c373065e339b26ee537cff1cf4597cfcb4bf2dc7c4bcfec9884443281c273"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 310
              ; comment = "special case for z_2 in multiplication by 4"
              ; public =
                  "2fe11d723dba63559e1b96147893cb7ec862711806316daa86cd4da769d4b22d"
              ; xprivate =
                  "b080f4ac1e758bbfbfa888a78cb8d624d97b8688002b2017e35f52f3d7c79649"
              ; shared =
                  "c5edcc5d447071c08dfa8281414ae6a02de753e2f7bb80af5f6253e56db43422"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 311
              ; comment = "special case for z_2 in multiplication by 4"
              ; public =
                  "98e1211dcf6651fa9f2d00eb083ae5855869a2a53e835f2e03b30c0a19ba8051"
              ; xprivate =
                  "e815bf9a967e1208af8e74ce9af6d113dab17c01c90f1ae2bc25e3e2f9e3a44a"
              ; shared =
                  "263a38fe538b50e8e988bf07ae86f33d49886b14c7143efd1d2025c840e36a25"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 312
              ; comment = "special case for z_2 in multiplication by 4"
              ; public =
                  "2f1b938b81a4c90e1251135ad7fabe835f6a8bc5e22d4b2ab119f6f677877677"
              ; xprivate =
                  "4051b01cdf90af38f0a96ffb83f8d4133abe4fb035b6fe6f65276447caa7314f"
              ; shared =
                  "340acf2801de71c18f4c79cfea372bc354e4c8a5eb5c2cce8b45d885df162f45"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 313
              ; comment = "special case for CB in multiplication by 4"
              ; public =
                  "340b9f613550d14e3c6256caf029b31cad3fe6db588294e2d3af37605a68d837"
              ; xprivate =
                  "98c092363184e58ad6ce510bd32b309c9d5a46f8d9ee6f64a69d8180bbc6cb45"
              ; shared =
                  "9efe5cd71102d899a333a45ea6d2c089604b926db8c2645ce5ff21492f27a314"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 314
              ; comment = "special case for CB in multiplication by 4"
              ; public =
                  "edfbd6f09aa32435440b0ca8ba436308319613f8f2d501133c526c3ff55c7b3d"
              ; xprivate =
                  "686e51c00116d1c191aa9d5823b96e5956102e8fe75f5cf2376d99989f6f4342"
              ; shared =
                  "196182095bcd2ef46b18f64c63607e0ab162a0869e6265ac8ae35e358c3d8a63"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 315
              ; comment = "special case for CB in multiplication by 4"
              ; public =
                  "9b0538cd618b0a4de09e45420f84d54d74514fbb1a31c1a4aa1e93306f20723f"
              ; xprivate =
                  "208af2c9442b36b521fc3a1ecefe342aac308bd6e6296ee091c196dc02e7ae40"
              ; shared =
                  "a3c6b75168211e8e0a49ca815bfe3f469f29864dc8166152b456e7074afa9b5b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 316
              ; comment = "special case for CB in multiplication by 4"
              ; public =
                  "ae8cf2fcdde710c2c1184524bc32430874dfa08c125f61d6919daf8e66db415a"
              ; xprivate =
                  "c0d861a6d5ff91f91e3bd05934161ff0ab0f3ce7e4a2b5b4fcb31ae34b46664f"
              ; shared =
                  "deaae6c9952844a3a1d01688e7105b0bbeadc160763c2002b6d0bcf35c22d123"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 317
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "2a59f478402d2829cd3b62e9f7cc01445e8e73a42cb11af00b6b9a9f0e44cb3b"
              ; xprivate =
                  "70785cad160972b711318659b47b574f6941ef6da1ea06508b2650f57ec9e54a"
              ; shared =
                  "c204bd15f01a11a2efdabe2e902b7cd0aa079316f60e911b3ee5d46262e98631"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 318
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "836c8e45dd890e658c33e69b6f578a5a774c48b435bc3b91ac693df94a055857"
              ; xprivate =
                  "60afc8eb1f87df4b55287f3c4698c5f8b997b28a73c573fc273e9c467fb7e44c"
              ; shared =
                  "c5457487e90932f57b94af2e8750403e09c9ac727e2bd213590462b6937b0753"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 319
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "59519ead7995a6df89bb54c840d61a8481881098b8a4f83c6a2f6ba800338257"
              ; xprivate =
                  "a83c11b2834136b9aaf0152d90e76e3c27177693a2834e8beda0a3571bce6947"
              ; shared =
                  "4ed6f8d62932541c6bea16e03835f1f758a5c41722b5c9989c9c7cc08e34e37b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 320
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "32f34da84ab4bfca369c4b884691becf54be7fbed16449dc86969da7ea9abf62"
              ; xprivate =
                  "b80d8795735806579e71759894939d758853592127efe84fc82eb7cdee45014f"
              ; shared =
                  "521a5b8149a132d155e6b4ed113900506cfc2f76d2a3e14196d69eb85db3c952"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 321
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "82ae48dcf59bc5e469f9a11b18a32d4753ac818692dfae27d675411a2272b363"
              ; xprivate =
                  "e08ffa45efbe1f96584c76254554adb9177b58ed09609a6ce499e5bd22d35c45"
              ; shared =
                  "e831d6cee95ca1b4c96bb89457562fff36cb4d08b81da89b810b425ecdbafd78"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 322
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "b33bd3ad14b66896f971cbdf27785fc3aa3cfb39adc6c29257d22ea4df8cbf63"
              ; xprivate =
                  "688e1bbb5114f34e8531c278b2d9714ba07c32a7aea6e627135bd1fc65238045"
              ; shared =
                  "350e3ab9d0dbff78f3f2157428beba189333be274827c10d59673f21c0c48a24"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 323
              ; comment = "special case for AA in multiplication by 4"
              ; public =
                  "18e58df6bfbe184b0e3c7c4bf2a051ed055b793501c0d4fc47bc8a95c4deec7c"
              ; xprivate =
                  "8036a4e2e93e9ed82d99d71a522aac9289bd9905fe41d01d08a499376a258442"
              ; shared =
                  "ade71d6460287fe808e947560e67a9d6ff2f96eaa1355d2e9fbbe549e883381b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 324
              ; comment = "special case for DA in multiplication by 4"
              ; public =
                  "772e31e776e8d4f23b7af2037af28a37e68f61e740b3904f4ec4c90157be1478"
              ; xprivate =
                  "901b20f0cda74076c3d4bf4e02653cd406ed480c355159e22ca44b984f10764f"
              ; shared =
                  "91a9bec28cf18c7094e2d80d2764df59ada0cb1946be422864bd7ad0e533b663"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 325
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "a8d55d5c1137e9bb626557f9d6eea8d3120e9364f8bcd9b67934260b1a091801"
              ; xprivate =
                  "d83eb7affd1bcc1ec0b4823cee5cf0b15b5f57085aa2708ed437a2925329b550"
              ; shared =
                  "6c1b8e240edfa5db2abb3dc12bcf9e8ac9ca10dd3507083746f6f36dc035d755"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 326
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "33c94be58b0f0e6cf363e1b12a2ebfb93040715be91518f21df2953eeab5fb01"
              ; xprivate =
                  "989eee317b9c254dc023f9e35eff0224bc2e0bc871996b946a96970e7506a85e"
              ; shared =
                  "d4c3b3467714f2d105904a84cc7e81d7f291304e908041682d8906a683c12125"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 327
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "a218ae9624b07ce05178b9d0cc1b71dee21f27852a2ceb18610b4052b244f00f"
              ; xprivate =
                  "b8355455d358f2dd7c5707b2c6973c9c27b99e7d8ac1650c791e5fdbcbea4957"
              ; shared =
                  "1ebe6ca711a649ae487b332747e3dc0306340560cab6bc6029e44f6a7e0ee41c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 328
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "d7067faeafd3e966e57525f930b3317c9e8b9c9a9ae946e76c1e4602a59a7e33"
              ; xprivate =
                  "8065567ef082b16c20853487f54893012ba4762224e5c59f250dfbf82581e85a"
              ; shared =
                  "03e7a777e648bdc612189f3cd42d34e35736d3e52e6edc8ac873a58e244a6073"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 329
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "8df9682cbe8802478a8531377e752cdde54738d528d639bea9eaf47702f8bf3b"
              ; xprivate =
                  "00b51448139a61fe6c5fbf9395877d53d820ef59da3be856458b5eb90985ba53"
              ; shared =
                  "308ef99dae1064a444fa90775b5dd5b1952d7224a0e5ae031df432640f416208"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 330
              ; comment = "special case for z_2 in multiplication by 5"
              ; public =
                  "7d92706868aa09538638d633c255f333b9da03bc74b49b35941c57820cd3fd47"
              ; xprivate =
                  "e8eb9f6f62f93dbc325b833aa763a90f13f0acb2c2c4b8b33decd471ce70c45f"
              ; shared =
                  "f33e2e86443a2c68823b72a2b59d6a028e0a8e283cfe29fea4f7aa22bd1afe72"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 331
              ; comment = "special case for E in multiplication by 5"
              ; public =
                  "dfb1ffc176aff84db30182d2378f83728f83dd1b33d79856f3da5459cf9df907"
              ; xprivate =
                  "68a1a7ccc50bab4b01e55e18cbd464aff43131fb0741e68d53cdebfc54f33051"
              ; shared =
                  "7b535fc31c6c2a3803d8bd45410a1781bd90a09205da28c9df120df23a9fa32d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 332
              ; comment = "special case for E in multiplication by 5"
              ; public =
                  "12e81e838b21eac96dc130432571216d7a9b4a817f1938721d2267dd150ebf20"
              ; xprivate =
                  "e075bcfc165a471b2f76c3003fb0172c82f707137de2fa7082e43a87a255935c"
              ; shared =
                  "ca23a781da0911e4115a29a9f56447157c23bee187b0c17369c4f7730d781718"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 333
              ; comment = "special case for E in multiplication by 5"
              ; public =
                  "832a46aec02240d716fe22dea94ad566a3fafbeedcce35c83e41e58076c99749"
              ; xprivate =
                  "c0e19634dbf6460e1486930c46e8556b3c16d6de959904600549bb3e08603455"
              ; shared =
                  "cd0686b32ea4cddb8e13ff20a78d380749a5d4f6a3dc55d72f4813d949a0ea57"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 334
              ; comment = "special case for E in multiplication by 5"
              ; public =
                  "8c8033432bcc12d479f67d6d876b1c8e89f16a234b9b093322effa9dee94554d"
              ; xprivate =
                  "b84caa18acc3db37225d32cab4f60e6fba4acab1277e20425d30f94cab2e2c55"
              ; shared =
                  "a950aa57bb2beb9ed5d3228c7ef448dab69552f3d3b1e466accf41bfb6d5b874"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 335
              ; comment = "special case for E in multiplication by 5"
              ; public =
                  "6df799bba6cdf5f46a57ab227f93fba491dad296a2fdb7e491921d610cce8f5e"
              ; xprivate =
                  "2896818cddf572521943e9f0c5e845f530b740427588a0f6de2504bd5bf40c53"
              ; shared =
                  "54f5ae57e676d08c8f8a3cf891e36ddaab751093f92f409060c57e745941700e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 336
              ; comment = "special case for AA in multiplication by 5"
              ; public =
                  "0c8090e1cfe7f761cfdf08d944d4aeb7a509a07a6101645b9a4c7c9e9c3d4609"
              ; xprivate =
                  "a01f0cad98cf2905b812d3530531bb3ac899391abd1eaf4a3ebed96ac6126f58"
              ; shared =
                  "2d49b09f81f3f6fab2c67e32f1bcead2ad09ac9e0d642b0873becfb64de2ab23"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 337
              ; comment = "special case for AA in multiplication by 5"
              ; public =
                  "08352936c8afd8543ac95f24bce9a07e3e3235763ea512a584298967b83c070a"
              ; xprivate =
                  "106b36344cc4a5a389d8168137786806ff03cd4a00f8636bb7e758d456151d59"
              ; shared =
                  "a199368e683c3036a48f4c5f32b32a547dd39f3d1007ca0a0bebcad0a8ac6f5c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 338
              ; comment = "special case for AA in multiplication by 5"
              ; public =
                  "73bdeef8cc044f5ad8d6a241273e1995e0007dc9e6579046df86aa6cd97f5d2a"
              ; xprivate =
                  "88f9a0d2354adfcbab2d12a0e09b3c7719c944384edfbaa27fe0731cb9c6fc5a"
              ; shared =
                  "5aa750de4207869ec7fddab34c639559b1eb27ef244aaf2a702c84963b6d6e7c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 339
              ; comment = "special case for AA in multiplication by 5"
              ; public =
                  "7fdd399b6ef4a3f5cade62e74113b29c27db15203f9b8e398d2c6f230051cd2b"
              ; xprivate =
                  "0811f2e560a205e96e28bc312bcad45fe8befefb7f6da5faa035311eed80b251"
              ; shared =
                  "a6947ee089ff28ce3644ea4c6eb33dbb20c7974fb8d853f4e146e2466177502d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 340
              ; comment = "special case for DA - CB in multiplication by 5"
              ; public =
                  "f0173a96273c646fb63d13b0c686b89e37676fcc7178faf4a6f4601f3068150d"
              ; xprivate =
                  "40ad984066a69080fb4a315878e736096cc577dae4c42c40d893d8c2173b785a"
              ; shared =
                  "230b6aa1f24df90a60839179ba5e9de673cff11cab59e8020b20626c22090b0a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 341
              ; comment = "special case for DA - CB in multiplication by 5"
              ; public =
                  "255bbe7230cd2bee90d283f418a474ab30146ce5e801a0f5ed60ee8def3e6558"
              ; xprivate =
                  "48b10cd45639bbbf83a0b28f0dd3ad0b7b00caf48d05534480556a8278116d59"
              ; shared =
                  "2299e384958bedd2c3d367759155136d1ff76e4434dc1d9e8212cdca52ea8421"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 342
              ; comment = "special case for DA - CB in multiplication by 5"
              ; public =
                  "21accf97b7fee173001ccfcab21637c175ef5186ff0002502b3d52fa8c51e766"
              ; xprivate =
                  "e8fad77946e0de4cf4236798490b838948b82cfb29f8e7686001b11e8d961657"
              ; shared =
                  "97fca065acd3b943c654997c0f125767f9abc4b7c9d8b7246942f12be65d9231"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 343
              ; comment = "special case for BB in multiplication by 5"
              ; public =
                  "5b40777e80ff6efe378b5e81959ccdcbb4ca04b9d77edc6b3006deb99926fa22"
              ; xprivate =
                  "d07babed90b27c4eacafdc871703bd036b720a82b5c094dceb4749eeaeb81052"
              ; shared =
                  "f482531e523d058d6e3fe3a427fc40dbce6dd6f18defbc097bfd7d0cdd2f710d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 344
              ; comment = "special case for BB in multiplication by 5"
              ; public =
                  "48d952a2924ff167f037707469ec715da72bb65f49aaf4dce7ec5a17039ddb42"
              ; xprivate =
                  "68a3049aef8c069b906cf743286d3952a888bf2b9b93bc8775fb5adde06e9f53"
              ; shared =
                  "de88af905d37417d8331105345dabaab9fd2d3cb1ee902911c1c8eae2991d911"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 345
              ; comment = "special case for BB in multiplication by 5"
              ; public =
                  "a5ef265ccbc5c54021d34f82364a4624030f5b9d5ff7e63d7a379e533de5e742"
              ; xprivate =
                  "18d8c3d2a4e366185a85c38698d937e13bbbafdbdab1a0a83dbbe89badf70756"
              ; shared =
                  "075d18ccc984761b70752279e7f6a757208f6c11e29480c32b40aba128a4d52b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 346
              ; comment = "special case for x_2 in multiplication by 5"
              ; public =
                  "9051e55a4050ef4dce0b0c40811f16371e8b16932541da37f069406d848ea424"
              ; xprivate =
                  "18efcd5fe345be4985316695391d2c952eee13b0e1ee7584721fbe8b19d4fc5f"
              ; shared =
                  "212dbf9bc89b6873a60dfc8731a10be11ab2dca4b172142e6c9f06614cd72852"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 347
              ; comment = "special case for x_2 in multiplication by 5"
              ; public =
                  "419adb8b1f2f87de016b0c78d1029a210492eb8cadd164b12cd65b1d57bf3634"
              ; xprivate =
                  "28ec7c693e222c72ac0815f1fd36661357e0a8da7bc996daeeeafcd21c013451"
              ; shared =
                  "379f9221abebf3582681a0e857f3da578a1b0121982b96f14b94de5dc8b24528"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 348
              ; comment = "special case for x_2 in multiplication by 5"
              ; public =
                  "13e00dae3b1ccc97ccd649088c4a7f32ca9976214d645667bd082039bbd9ab7a"
              ; xprivate =
                  "78b35e7ae549308b6414bb610196c04f2af79d4266c86e8a9ce0c02bbdb88d59"
              ; shared =
                  "cff2596b7afe36f4cab9c70133d7aa0f9914f9abc6c3b9895472e2a5894a8037"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 349
              ; comment = "special case for C in multiplication by 6"
              ; public =
                  "441c487a48f0a4989d931cd77a6142a0a13d1aabad82623ba8d94b5c374f4f08"
              ; xprivate =
                  "f0de9c5f8a9372f30c41ca47a55743ce697d46e32e7a9ae26d32503fd5222767"
              ; shared =
                  "d47c46b4329bedcbc1986b3c6d2aa9bcd027d6b68925175d35bbb536b3440801"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 350
              ; comment = "special case for C in multiplication by 6"
              ; public =
                  "0e67ee5c6b65aa802259810b2605f8d7accf9b49bf14cb4a536928e883172915"
              ; xprivate =
                  "686be5a12b310420f9bfb209381fd459a5ccd55c752b88337ebe89e1921ae765"
              ; shared =
                  "1d730158da880533dbf1e6c64a8e99f9169611660969b0a84fb42dd8dc2efa3d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 351
              ; comment = "special case for C in multiplication by 6"
              ; public =
                  "dc9d7ef1cb49c191e258663a94e731b9c066c11a17d8b5fdea1987f5d9a00568"
              ; xprivate =
                  "a0c0337c5bec5ca24dea2f1d701498ae2bad87b8269ac23be113929fe4eb1963"
              ; shared =
                  "07732529a628badeb8d74946775ba457c700bf8390f46bc523fb64e471c86a7e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 352
              ; comment = "special case for C in multiplication by 6"
              ; public =
                  "556b3ee7cd0d37979056ecc1f56a5677a4935be6e49ce28e394f8bfb73d13b6a"
              ; xprivate =
                  "b8824cfce5550b5e17b12f74e28459cab34eb49895cc36bf645a0cf00e3d2d67"
              ; shared =
                  "9e3aae35fa1cc80a359878e212180294ff6608dcb4929e91901abbf976f39c16"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 353
              ; comment = "special case for C in multiplication by 6"
              ; public =
                  "1211be5809605b54f5727d233c783a2a199a3db24ed4499d7b48c7603e4ad371"
              ; xprivate =
                  "e02dba7335af8fb9168de2fcd310c2e2df4a3e25263e0ab9ada87bfb8258a66b"
              ; shared =
                  "880f6dc73220307a597670f3282fc366aa66f04a0a9ca30d895fdde337afe825"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 354
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "505e7851e2352e311ca9536a1fe6c0d95d648197374ce08e4b8a0fbddf62910b"
              ; xprivate =
                  "30ce71f856ceb874fe580039ca67e896e6d08207a73cd55db7059127c1342b67"
              ; shared =
                  "ea62b0eda2d7b249a42417675a2b82b1e6c0d69a4e7cef336448844d2f432251"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 355
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "ddf4e90503dd82610c3a034b925a880b72dbde30c626009202b358c6eb00f418"
              ; xprivate =
                  "e881f46d4141ea69a671649b93b63e97dc67c12521d445862f087b2626fa2b6f"
              ; shared =
                  "302c4f83b5c5bf30c1e3afd9f643f65bfe56ca1628ee042b1ab7393bafe36c06"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 356
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "0e9c4431999ef1ce177e900d37ec6ae665e387e2d4fa27cba8e7baebc65c6520"
              ; xprivate =
                  "e879752683cd73a834251c65749135e06eb9064d3ae35095d88cde14a02ba366"
              ; shared =
                  "8ff2ac65c85ee2fe9452fce460f8c87f9570d769cadddc87fe93ef8b7657c726"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 357
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "5761d6c08624104d4117ff17c75e9211a591c9ca9aecca3a665a7ed844195225"
              ; xprivate =
                  "20576ab456da26c18da5fbf06ec4d16564e111bfae2a92b9f6e1927c15770a62"
              ; shared =
                  "97c91a23c3e4f3ff727d188a352b67ad490b62381566fb3e111cb67aa9e3435c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 358
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "e92d45b3ec56531266303c5113c46310c41650001065b4d87b02b382fc82662e"
              ; xprivate =
                  "a8467418b924c2c003c56e1610a35469356360c29d52aa557a2bb30fb8a9a464"
              ; shared =
                  "24346bb133dd9ae3ff02d2f50510b3a92d9030834d60e5af08b0eebbf1d4dd6f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 359
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "f38b63459d05e422ad024c2dcea5029a0a7a6b6c4c1d2093ce556aab331e2540"
              ; xprivate =
                  "f0f5e162923d7c299388bed781199417ade097475515162d9590976a196fb16f"
              ; shared =
                  "b3453c9c82a2d1d956156de2399cb70dd4e1ec53aea967e035753c1cdae13c39"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 360
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "a7ded0eea45a400b8f5637154d42974aa98c92962314d822ef88b01383a9da4d"
              ; xprivate =
                  "608fcf787fe789644a09bcab958f0737aa81a9e29d505f51035c78e374b9e46b"
              ; shared =
                  "ebeb0c7b7a4165cd02a278f3a222c236eed83266b806d13494c1c3f98a2f3425"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 361
              ; comment = "special case for CB in multiplication by 6"
              ; public =
                  "7b0ecb4c72ee147789d74813ced3ebe40f45c3da526ed1272952e453e43b796d"
              ; xprivate =
                  "58a3396d291eb23571b52d98a31549e514e501e8d0958ad9f25fe5a76c503e69"
              ; shared =
                  "9213a53f22ff0cb5eca87b27b193c773bfdf4c01a193a11f37c157474e15cb07"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 362
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "a244413ddc3a205d038d64266833eea1efba51ba62c9c6cdcdbe943be52bb00c"
              ; xprivate =
                  "d805a7014755dd656f98d2b331f2d2d4912725ef3d03752f26f74dc1ad61666a"
              ; shared =
                  "66484a4120e0eb0c7e0505e1d2c5d15de9b52b72e094c9bac88634200c557267"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 363
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "ec3c8b0c10b1fa65dbbd17cf1ba5f86381284765709b07c5f0428e3d5bcd3920"
              ; xprivate =
                  "40cb1fe06b08f068f7080ba07c695eda91a2bebeadd4db95c97dd7c91af2566d"
              ; shared =
                  "384f2221618e71d456b1551651efdb708a161d7f89f5604b27eb872d4aa93276"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 364
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "6330d3e28a8b6126ace165a9dfccc6e4bd40dbc9768cfb16330cb7f27f906230"
              ; xprivate =
                  "8021464c64c9d6d3c0c852f6972d11969b04c9e066562fa7f0d5fa0d98ebad62"
              ; shared =
                  "8daf5f4b84730144ea8a53ce39cc907e39a89ed09f0202e7be0d3bda38da663b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 365
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "8678aa29cbc06e78b218d22a3e66c38ec0da8fdb0f2570c585c62517c9704f37"
              ; xprivate =
                  "707a2d710b32f55c6eba34898020a2fb981d61b1e822fca84c47d9321e279268"
              ; shared =
                  "da8b7eba6f72c3f3ef33d8982093492e06be39bb0db29c465d95a8e52ef64341"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 366
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "303289c2b1079ea59412faccfeba8c113d2299b9dcfedeabc42697b0829c4658"
              ; xprivate =
                  "204a43dea79d779577581b8c2a51be66e1effce96425b7422b9ca65bdf1a4867"
              ; shared =
                  "0419a71a08d3fdd574cbc932e8f1605933ddcdd9774f5614269b7ed850c8650e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 367
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "3e6e16e02d44ebd94680832e065aeddcbb74af64fbb7c6d8367e7605be13ff5b"
              ; xprivate =
                  "58e4741735d2589322151947a1ce2f5829908626886941cb1631d25a8a684169"
              ; shared =
                  "9f2fcd0c756288c1716ecd1f2a74864b93a7717bfaf5248858dcb6fdbea12864"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 368
              ; comment = "special case for x_2 in multiplication by 6"
              ; public =
                  "a7c1716a41ed23a8870438714ff9745fb0e46f7a5baeb37c9a2d83fe477d146c"
              ; xprivate =
                  "d0af3428ea5205f6bf8d4f1b4e4903cd76f04236a1c0b3ecfdcaf28b21348e63"
              ; shared =
                  "261ab6267c35a9755359e957473870522b7f923fe839f2b155408649cc5e8004"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 369
              ; comment = "special case for DA - CB in multiplication by 6"
              ; public =
                  "dad981552c57541c57ef395ed770ce5edc48f8015461b2ba7aa831ec593ceb15"
              ; xprivate =
                  "c0ea97e442e5dc1c8142bfab7089ecb9bb9c5ae372f9907c2825e678defae567"
              ; shared =
                  "9093bfa3ed3491d0891f02ae466e5e13c980df229db7404c5b9d34e4ed21c653"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 370
              ; comment = "special case for DA - CB in multiplication by 6"
              ; public =
                  "c588dfe6e733d90581cbe112079749d8eb30ab8631134ec29abfb98b32e76522"
              ; xprivate =
                  "b0333f09ac1eaacd3cd617eb8832e9de488b458b735cb4b5345f517130c25d6b"
              ; shared =
                  "6e88bb6bf75596bbe5f1fbe91e365a527a156f4f1b57c13ac1e3e6db93191239"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 371
              ; comment = "special case for DA - CB in multiplication by 6"
              ; public =
                  "0670116a435e8d9b7a12ffc4322fd6b149d0b1dc799b5c0957d9d6e42546e824"
              ; xprivate =
                  "10719099dc63bcc282ef525845c108897ac9fae9590b593e0d505d1cf167c061"
              ; shared =
                  "e6de74d2c5cea54094d7a70af03c768afe05d52a038bb72d56dcacf0ba502d74"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 372
              ; comment = "special case for DA - CB in multiplication by 6"
              ; public =
                  "8b200dd226c5c0f7e116e5388ba162438caf1dddf4edc3b6ba838c21b5929737"
              ; xprivate =
                  "10e20e4fda57084ca90f7ad572a78aa8e6575c659cd01f30c43c58040c20e860"
              ; shared =
                  "78c9c3aff9416a538ce3ea8fa553244528d1fbecbcf91695a33ca464ef76b85a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 373
              ; comment = "special case for DA - CB in multiplication by 6"
              ; public =
                  "419a076b179f79720096eaabaf03477e8f89d61f885c8d7f58f6eaa4fa77df5f"
              ; xprivate =
                  "a8312df473adfec7171e1635f5bad44f0753a88a6b3174ec5ae762703ae25e60"
              ; shared =
                  "c1a96ccba08bdd82d0fc12e8cde4cc1f25cfd5276dce7f18e407ed0e4a898466"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 374
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "aa34d772e9ace43c4d92f4f85596ab9ccd8c36c4f4cbddc819afe2a33cb8b216"
              ; xprivate =
                  "109697f400210f9a92de80a8bed264097199bc240e22767b54d8bb22050b7a61"
              ; shared =
                  "2533b845bb83e3d48cffa8dbd1edd5d601778662d5da03759152a5e0a84b357d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 375
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "1f06cfe464ccc0e27a5ec5f9edd9bc7bc822ad2ff5068ca5c963d20edd1a2d22"
              ; xprivate =
                  "d036308a53c11bebcb02e83688ad74fec43f8462ef4d806272676637d99b3765"
              ; shared =
                  "eb40a3974b1b0310b1597d1f1f4101c08dca727455a9d8224cd061a7aa3cb628"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 376
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "9d4b2ed7817132af5830e899627ea97dc39bd3772e82f2d05769a918273dc02e"
              ; xprivate =
                  "786e5a5ff37405c769d0d3788c3c1b05a62a8442c385570e4438bc5f2eaacd67"
              ; shared =
                  "9509757e289553cfa2cc71313473c3ff1eebce484ee237eae554fda3d3d22f0e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 377
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "4e056b317a31dd96f8ec14b48474af587d195efcc2a70f01f052ef882d7b3a45"
              ; xprivate =
                  "c01f66cb094289d728421dd46c6f9718412e1c546dad70e586851be4da58bf67"
              ; shared =
                  "bad9f7b27dac64b0fc980a41f1cefa50c5ca40c714296c0c4042095c2db60e11"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 378
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "72c60535e9c423f302d6a10796d954d778032cd4dbd40ca0f359e204d67b6f4c"
              ; xprivate =
                  "3877d9ce25cededeb572604f2d123df685690c26e181f777ed33302b82082966"
              ; shared =
                  "51c359768ab0219003af193e2bdb8e5cc9f8e176b8db49e597afca3e7125e370"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 379
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "5856358ed420047cd084f17ae696bad79a4d26c6d5bb79bfb82bbc6332442d51"
              ; xprivate =
                  "50b84618d073c4618f9aa69a3b8518da76dbb2127286214fb43a2b44503b9969"
              ; shared =
                  "fa9fb0df4cfbacd0fbf3262d3a1bf8d7aacb45f73bf94671775e509c8043df7d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 380
              ; comment = "special case for DA + CB in multiplication by 6"
              ; public =
                  "c31e37b04332abca8315f317171566aef38111f622d8bffa29c23c0151cdad6e"
              ; xprivate =
                  "109acfa638e112f6bbec21e352a74e8fc9b7ffe5d9dc28634eeb516e59830a63"
              ; shared =
                  "91ac72b0ed8d7fc4c8846b8a2530d9fb8f0532064880c00dab100c977697db28"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 381
              ; comment = "special case for z_2 in multiplication by 6"
              ; public =
                  "b775e016b32a97f49971121906763f3a0b41689092b9583b6710cf7dee03a61c"
              ; xprivate =
                  "685c0784aa6d194c1b859bda44c4e27cd1dfdf34776e498dd03d09f87ae68a65"
              ; shared =
                  "11393bb548813e04fb54133edbe0626458e80981885e1fe5f3377e8ebe9afa52"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 382
              ; comment = "special case for z_2 in multiplication by 6"
              ; public =
                  "f8bd0e7cf6ec6186f205ab03ab72c8f6b3cde8f6ad9b166916a04d43d1d6d546"
              ; xprivate =
                  "18e9a05a20436cf0dbc3d5b92dac8d996e62ea11fbb3445f29195fc75a8beb69"
              ; shared =
                  "0a83a224fbfcbc5d0f07f6dd8ebb2e9bbee8134f0fab268002ce837f5495d833"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 383
              ; comment = "special case for z_2 in multiplication by 6"
              ; public =
                  "8dfee48ad8b367488ea4dafcf7086e305356a80901f87c720149a5f522337453"
              ; xprivate =
                  "00e099eb23125dab5ec35a419d455d0ba8c01da160f9354e9fb21e6a55d55c64"
              ; shared =
                  "45dc39831f3471d7466bbe29c8142b1a6d6b00c47fea021be2ffc452d9046806"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 384
              ; comment = "special case for z_2 in multiplication by 6"
              ; public =
                  "8f68bfc57d792c322ebb27f44a37c1c93e7eb15c5d5fcedffc1de850487b3372"
              ; xprivate =
                  "b0ca251e0dbae7324a6ca0c2c8d6a888edd12d1447d400a47bcba004b648716e"
              ; shared =
                  "a29005c6b9dbf1707dc2adce4506b55831e8675b7d2d54b0c1037741e3bc611b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 385
              ; comment = "special case for D in multiplication by 6"
              ; public =
                  "ff0f15adeab334afeda3916785ddd38d252dce9876c2357b643b5dc2c06a3b1d"
              ; xprivate =
                  "a8b64b8ed397773b8290425ca5c2f7c3e50fac7a4781bd4a54c133781c9a1360"
              ; shared =
                  "9f04e42c1b2f311d87e1470a4708bba25ac6ffd3f7b486f9b6b502ecbb2c004e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 386
              ; comment = "special case for D in multiplication by 6"
              ; public =
                  "1076fdc827f2550ee95ff9a15d044aedfac65b5e9ba809f62438ccea54637a29"
              ; xprivate =
                  "d0cd0db51ff232afa0919d3106fcb3a8ae581ef12d09c877aa6f31ef74eed068"
              ; shared =
                  "688000bd60af375b4eeac4a7d0e0782c0e6188eabdc608b732f49b4d6ccab44f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 387
              ; comment = "special case for D in multiplication by 6"
              ; public =
                  "ed1c82082b74cc2aaebf3dc772ba09557c0fc14139a8814fc5f9370bb8e98858"
              ; xprivate =
                  "204a3b5652854ff48e25cd385cabe6360f64ce44fea5621db1fa2f6e219f3063"
              ; shared =
                  "e0a82f313046024b3cea93b98e2f8ecf228cbfab8ae10b10292c32feccff1603"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 388
              ; comment = "special case for D in multiplication by 6"
              ; public =
                  "12e1589a34094af5f121c9bd3c1119f2b1f05264c573f667a748683c5633a47e"
              ; xprivate =
                  "88109b1d0e7bace44d41a15d5bcbcd36968c5b8b47c0a2c606b57c4a68cc5f66"
              ; shared =
                  "1fcc50333eb90706935f25b02f437bfd22b6b16cc375afff8a1aa7432fb86251"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 389
              ; comment = "special case for DA in multiplication by 6"
              ; public =
                  "151f54a8a899711757b3b118fc5501779d621d25227af53d0af00b7583ba8824"
              ; xprivate =
                  "5082e497c42979cdbfdd1b3b0653cfea6f2ceb7d07639ebf3541866bb60edb62"
              ; shared =
                  "fac30a74f4ca99f6cf233065e9acd826690cab364bf69320b58095783ed76e11"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 390
              ; comment = "special case for DA in multiplication by 6"
              ; public =
                  "a819c667ed466bd9a69ea0b38642ee8e53f40a50377b051eb590142dd27e3431"
              ; xprivate =
                  "f85a8db44f9e56b11729f51682a9769fc504f93597cbe39444616b224532106e"
              ; shared =
                  "17f6543c4727e7f129ee82477655577635c125a20c3dc8ba206ca3cc4854ca6c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 391
              ; comment = "special case for DA in multiplication by 6"
              ; public =
                  "40b053d056668982a1f550be95e16348e303945f53a3ac64491a9a56d4095b71"
              ; xprivate =
                  "505a076641fac398fc7d8c629937f42db559db5e12052ad366d46d7b20e95769"
              ; shared =
                  "889a8d611e0a7da71475e7c93a2d7f6f7228c787a00ee5cf55474adc376ff762"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 392
              ; comment = "special case for DA in multiplication by 6"
              ; public =
                  "e7dd0549a765bbef34be2e8da18a1bc1b989a8b0614d358ebf38c12a9ca64079"
              ; xprivate =
                  "e8db2bf1af5b8907420789c56e71414706aef0d9f6ffaed0c249c3b7ab14bf65"
              ; shared =
                  "37232fb397af27f5fb5ca493284ff1c5d25786b0d716c73b33aca8d42265f318"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 393
              ; comment = "special case for z_2 in multiplication by 7"
              ; public =
                  "1ee1b9a74604ac31c3db83280170e3811504fcc78c7626b5b2c07a99d80daa0a"
              ; xprivate =
                  "c006ab1762720882017d106b9a4675fdd47005657155c90ca61d4cbf7cc4f973"
              ; shared =
                  "a1b30418436ba1908804ffcce1be2cdcf50c61a8e3938d95c790abdb786b8022"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 394
              ; comment = "special case for z_2 in multiplication by 7"
              ; public =
                  "f226c2d6bd7831eda1b51ee5aec29443a507ef9f7a04e2340f349dbf14933844"
              ; xprivate =
                  "d071807d607953da432d8574d5f3f420676dafdbc6a285a36e1d737624d77c75"
              ; shared =
                  "a5976fda89954a81e442107f9e416a2b4b481bbd4654ebc0c7b57a78b45b4979"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 395
              ; comment = "special case for z_2 in multiplication by 7"
              ; public =
                  "c5197312de3a7a3ee11b29873bae3fc8c85109c66784804f89435db210fcc24b"
              ; xprivate =
                  "304b526f6fe994731980c0975529bca4d061017fbec56f6070d42678d3e11177"
              ; shared =
                  "55b5b5eb38b127617ffe00056d84d35a5071d18783e3a82b5f4e131b1538b150"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 396
              ; comment = "special case for z_2 in multiplication by 7"
              ; public =
                  "590ed0b879319c38a19962a5d216ff2bfaf33555518877969c20c054cbe43e56"
              ; xprivate =
                  "982ddf2c035789379b8a58917d5c3c6c061b503b19a0028e01894c2eb371d079"
              ; shared =
                  "0080e5b9985a960a832133812a7ab9951c6b2c75894deb3e35509190a6bdf457"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 397
              ; comment = "special case for z_2 in multiplication by 7"
              ; public =
                  "7c5f0143a6682f60ccad16f21150c7bb5bc6f807254d08b353fc96ce07bceb6f"
              ; xprivate =
                  "78cc3ec0687e3e53d9cec56b79d11bf049d173f127f5b40fae122a6d0016cd76"
              ; shared =
                  "5241222226638c4bbbc98792cdbd74882ca2e08aa2edf313070425031009e925"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 398
              ; comment = "special case for BB in multiplication by 7"
              ; public =
                  "010850a0974d3e89c029d252b46f739548294c0f9a23183863f9455b9559c211"
              ; xprivate =
                  "c86fc76650cf3b58837aa0f0633560415241c6c4f8f293ba0222b7d6a3875773"
              ; shared =
                  "63788190b10d7451f5fc2b82c421151db4f3e22782e392da6d8d3aba2c344306"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 399
              ; comment = "special case for BB in multiplication by 7"
              ; public =
                  "ad1dd82c23d6a0d5fe0f2a4561d1c16733a3e1e6afa6d902dd077dc43a961628"
              ; xprivate =
                  "888d51c0a2230369e5b65a814b3213dde2e62f2eb95d0971486b733e4f90c174"
              ; shared =
                  "e4b40974a166ac49ed831715c071c751752744b891465e6c45001855aacdc362"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 400
              ; comment = "special case for BB in multiplication by 7"
              ; public =
                  "d0c0d6393c41f4d7e0d5e850b7716f401eda1e028a4ed4a05bea8bf81acfd930"
              ; xprivate =
                  "68bed425d534315584d80f79da6eab9b7e6036b51fe62e1ad933e266640b4673"
              ; shared =
                  "514a4cd0676f1c3101c8c45c17ad416bd33e20a405544fc1a60449abb22fa104"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 401
              ; comment = "special case for E in multiplication by 7"
              ; public =
                  "0f460100d88a1d316dff02d1b22ffb2e42d99d0b92474fc3ec7d62567d0cf112"
              ; xprivate =
                  "98ff2856ef44b4fa14d86782ea793828bdf6f1ef9b669cac1aae338a7bb69376"
              ; shared =
                  "ed83e810ce5ff0868f8589623bb13478dec1c22326c92765ae5e48c84bbabb24"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 402
              ; comment = "special case for E in multiplication by 7"
              ; public =
                  "13756a411ff3ae0c39222dde0810f08c432463162d81ef061071249a48439e15"
              ; xprivate =
                  "b0cdbfdd98bd988d7c6a530455c51c57dd33fd2c7aee3961971bd3a31388fc71"
              ; shared =
                  "ff94862117d3c6edc9dd5f4852fa8a589452b924ca8a75cb23b3d68dfed88c4b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 403
              ; comment = "special case for E in multiplication by 7"
              ; public =
                  "8fc1fae969a6185404db22749ef6d225de86773a4d1bf3857eb8fbbd829a1b47"
              ; xprivate =
                  "e0677644ed4935f01e052e9967302d0fb78ff22bb92fbae0605f3ee54e2f6878"
              ; shared =
                  "1c94868bc8acb3137498209b2812feb53501389f5aa37fecbfd5cb54e1358e0e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 404
              ; comment = "special case for E in multiplication by 7"
              ; public =
                  "7bab0891ecb9e72a15771f0a4fff90547024206339c340b1a2fdb53bcfb86b59"
              ; xprivate =
                  "887b61553843ca99ad1ca92253a6fe082b82494752513fd53ff6530f54c40572"
              ; shared =
                  "adbf3b439b16dbc653578f53374ed3a86f9c0bf1f736573349773bc3b8d60734"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 405
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "102e95eadca7c3c28e5d52336c857bad99ea246f299b06334f401276f49ca814"
              ; xprivate =
                  "00615e4697014fc12484ef53a1440206410a8df78caa0bfff82161db83fea574"
              ; shared =
                  "3952efb93573ae9ce2162d10e4b8c46435859f3f2778db89f72bc579e695cb51"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 406
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "3548c16bf31afdcd445ad9bef0e60d7bd6195aa591ca8c82813cd7d446226720"
              ; xprivate =
                  "58175113550faad56458fb375a6cb3f05df2f6ff3c4ee09d4a6ba643e022d17a"
              ; shared =
                  "96128f929fc03c1269d429f609a1a8acac7a758e3446a125ecf4a359a0e37b73"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 407
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "ba74e766d44855ec93bd441aa41058a4c4ad2be63c639a3f9a87bde51eeaba20"
              ; xprivate =
                  "009738e1e6efef9e2cad8b416fe90a098eb5cb0199f2df5218166c7b181ea079"
              ; shared =
                  "fec3e94cb5f316625b090c2c820828ce0f3ee431e8d6e12abccc7ef2bd0be81a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 408
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "9a5a1d37e5010c356aa80afb347c3d613542ddfa0be7abb8e8cdcd6674411449"
              ; xprivate =
                  "c82019159be792747a39f388ea48a8c568594e3383273e51100721b376e8ba73"
              ; shared =
                  "96903bac9dc60b6178d734890c25db4bed9ea4dbcf6fcbcdc90e6f5694c8b21c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 409
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "630847e28274dbae5491210303c85a359074ee742957b0fc3c9ff55d9e019a50"
              ; xprivate =
                  "10ac9f8383262ef280faac1e4da15a7de4f2cb74af33b50e0d82dcb85d8bcb70"
              ; shared =
                  "50050d0ab1ddd2dd90c460ab8f09e1f80e37cae57d4231adae10c10a4a2b003e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 410
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "11749b00a45067af2c7e7d50f8d178d5a9fedb8f1b69b239763885bc611b136c"
              ; xprivate =
                  "b84c098382f6e37d510cc33e62ddc664e02c8bb6ed9ed0e5fa78cc099a26fe73"
              ; shared =
                  "9170c4c628d5fcfd0ec719cf6e1796dab0a69e46d6379fffa247d444a0056041"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 411
              ; comment = "special case for AA in multiplication by 7"
              ; public =
                  "df1021d8f95950afde77c86ba5ee2f5876ef778376a7fdc7efb8dff0e4836e7b"
              ; xprivate =
                  "78cde8930a1d81aef6601f71409728854987578b0f8349588c04adbe2c1f6e74"
              ; shared =
                  "d7d2a82953f680cee0c81c4d00fe628ac530ce682eb7fb3b0af24f804a58ef5c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 412
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "2743ba408d5f68c65324a485086a004b6bbf784cc9e8b1a7dbeb8c4b9414b018"
              ; xprivate =
                  "b0fe7b06b9950600b3a7ce1d7bb2a1d984194cc9d6c8964504c364dd5c875b74"
              ; shared =
                  "a6b97da989dccf730f122d455152328051c8ed9abc1815c19eec6501d6cfc77c"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 413
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "cc275a2cdd9125e52f20ce2abad41f920afa5a643fb7f276ef416f761d689f1e"
              ; xprivate =
                  "f0c9c3984854d5bd599d3819738a023eb795e93586dc0e5e29b1c870c612d178"
              ; shared =
                  "b210e368729501d9f9b6ebefbebae38f195f91eaf2a5a3a49288bb615ff2216c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 414
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "4929543101ee7ae239059cd134c35d400e50d0821441351d0fa6c3d54efb342e"
              ; xprivate =
                  "906c2f12be89702db26fa7ee905ce36525d2dee4e96a879ca07da097a6aa5075"
              ; shared =
                  "b9e3796c58701ded4237c52994501cee14e18f2fb02b781a8400923484bd4a6c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 415
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "1324e0368597b3181555bb5b2cc7b7ebba46931aeabb6f05ababd4240f0fb933"
              ; xprivate =
                  "f026031ea373e1d16e6e7e0357bc96bc093f4b6bb76a738cbb54fe6cfd2ea271"
              ; shared =
                  "6dcdf8e86903b0caded124d8a7da18e623430ca869aaf267d31029d93de99e66"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 416
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "c7f3842297d6941cac63d6f1bdaea0709437c82dbc9161fc1bae6c79d668eb44"
              ; xprivate =
                  "703f4ac8667d77f9536045cf748f18d42345e39ccab10c18dde0f5170d307f73"
              ; shared =
                  "385ddbf2505ebf537bf5e976b61a4b69d190ae965b7e4a81ae4e1c16b7148748"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 417
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "1e4660ba865fb8085afd4692885d74237fa3bca5af4b84ba3de400f16a5ac45c"
              ; xprivate =
                  "c8a96ae4e77271a0680dd24fcb09f9c5d3ee8316536eec7cc2276597e50fe37f"
              ; shared =
                  "0fbaea73f9518795e026c1fc1079c3738aeb9ee9c8dc9761d65bbf8f94e30154"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 418
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "2488bb6fadb79d46585ff01c160c5b4172799d92bd168edceb65cededc492762"
              ; xprivate =
                  "d0dde8eda38c3783442864c0cb46a0e9832dcf784c21268a21bed2cace87cd70"
              ; shared =
                  "510c64151e5d0737fc324bd15fb5d3966908751cd1a06954b556196655ee5540"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 419
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "a0c1087811af1491171bc51691b8ca84716af36c4baa764ec536280cc1983d6d"
              ; xprivate =
                  "c09cd47e1ce53604f14e4e13426c8f08962f556bcd81f8d75375b1507c6fda78"
              ; shared =
                  "23ef825e1c8e6e64428001a7463e32a9701c81cf78203e6ae753740c91570e6b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 420
              ; comment = "special case for x_2 in multiplication by 7"
              ; public =
                  "cc5c97934607d8b981bce1d6a232bb3aecc3001f698ae1ae84938fbf2861077b"
              ; xprivate =
                  "e09a5f74f318f02303857aa0208d76913d9e240a80549d12013118bad620597f"
              ; shared =
                  "0e55a7ec1a2ddbea1ac5981200812232f7f4c3a60ee3c9ab09f2163bd13da329"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 421
              ; comment = "special case for DA - CB in multiplication by 7"
              ; public =
                  "238de7fcc8a3f194c3554c328efb1215d0640ac674b61a98ef934ec004cfd73b"
              ; xprivate =
                  "706cee5f9b357c03b2f1913294f6e4f0ca5a190a87d30268327d0cb6bdd5bc79"
              ; shared =
                  "0681036a0d27583ba6f2be7630613171a33fb8a6c8991c53b379999f0f15923b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 422
              ; comment = "special case for DA - CB in multiplication by 7"
              ; public =
                  "ac9fd80a45da109fa2329390e5a951cfc03065d7bb4a7855826ccb22c3bfeb3d"
              ; xprivate =
                  "40e300cb1ff260574f85b3f04aac478464a86e6203b3d4656418f4305157877b"
              ; shared =
                  "67b88774f19bd1081d6f23656a135803e34ae1cdcae10818124a78569c299f42"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 423
              ; comment = "special case for DA - CB in multiplication by 7"
              ; public =
                  "a45ab1dc2fa2c50718fb4985d9791401e8d2d34ffe3cd93cffb4e870cce5e855"
              ; xprivate =
                  "882f78b4558b7faa835904c9235e32f300fc8b5ef0a718406a5c8520ca54d071"
              ; shared =
                  "a512e864bd898a5ba6551adcebd836c6a78e7871728e1b8ee528d483af276104"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 424
              ; comment = "special case for DA - CB in multiplication by 7"
              ; public =
                  "1761d3d50ba46b446655aa6a8d9b8b75aa5bb24a7953208d5b69fcc38f18ec7a"
              ; xprivate =
                  "d8649b735590a17d0fc4c378fbf4c2f7d6600569b2e84cbe0ff7bcdbac0b5f71"
              ; shared =
                  "518b778cf5e976c60235abcf6211a18bad2a8e693ab261074c7fab43dbb5da27"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 425
              ; comment = "special case for D in multiplication by 8"
              ; public =
                  "dc99ad0031463e4537c01e16629966d1b962c0b4e4872f067ca3c26ccc957001"
              ; xprivate =
                  "a8edec59ae6ba23813ec54d66df152e0626762b97d4b0c20e0dd8a5695d86e47"
              ; shared =
                  "6cfa935f24b031ff261a7cd3526660fd6b396c5c30e299575f6a322281191e03"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 426
              ; comment = "special case for D in multiplication by 8"
              ; public =
                  "b32750fd80d2d7c62c6b8e39670654baea5719a3e072e99507fd5bcb23898264"
              ; xprivate =
                  "1098723ffe567ea6dcc8d04ecc01efafeea0aee44e1c733be8b1e5d97c8b8041"
              ; shared =
                  "c623e2d2083f18110a525f2b66d89ed82d313b6a2dd082f6b7a6e733134f5a06"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 427
              ; comment = "special case for D in multiplication by 8"
              ; public =
                  "e7b3205777b375f1b1515a50a16a6067953ff221e12b4f416d74fb28c1c85865"
              ; xprivate =
                  "a0f20df98b49218ac832f26fa8c218a0d6872eb7aea07c1d43c9ff699b465b47"
              ; shared =
                  "388ea421650a8d837bad8904018195e99ef494c2d170b93ee721a67d2c108729"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 428
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "21cc338d7869e5863349cc739c8a6946cfc797cb82fbf62dcd2154844b106003"
              ; xprivate =
                  "30473a77a98374f67d5bd43df231ce142916aea0d271e72333fa47dc441a0247"
              ; shared =
                  "b9e5728b37435b1d339988f93267d59f3bd1c517851c5a258e74cb64aea73d2d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 429
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "c34217c02072d7e2bca0454525030780cfb60215d7ca82dbec8f4a59034c5f43"
              ; xprivate =
                  "d8657be3a30fc85fb2f3a68e92ace1b31b26e76e6bdb6727aea507cb7c10dc45"
              ; shared =
                  "20b67b205e22ce87fd44a8e8fd10a6d8890b9270b60e1c6a68b4aa78e6e37961"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 430
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "8abb8cfd60c6f8a4d84d0750d3b40a4f846b30edf2052fef7df84142cd0d9e47"
              ; xprivate =
                  "882f5578ae4a13d8f5af473bdde1709bf2e059df809ee05b505f34de857c3447"
              ; shared =
                  "5faba645fc21f9421ebd35c69bdb1d85b46f95e3746ff7f4886bc280a9ab2522"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 431
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "9fd7b49a08f206688d72db737df8e517aa7b764f5de7c9a2b1c3fcbaa985f64c"
              ; xprivate =
                  "98294db7cbf4958bfb3ed21d5d5c91e13cc8dc27b3c716c86f7167a4819f8741"
              ; shared =
                  "9cb8a0f4ad86a27b96ca61242eab198db2767d3862dd323e41368fcdcc5fab68"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 432
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "c4fefac7acd448e8fd4d6ac4f5dd1bc21f2c67d638444060918fb344aa77e757"
              ; xprivate =
                  "789bc4047ad81b9b6656eef298b766e8763a2f8ea64e374a603dc1fdf2eee146"
              ; shared =
                  "4b42fcf84b51b2b82f1f70b3cf49bd9dc6ab2672920a8de37e81ba7e99acf734"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 433
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "a8341deecc0be6db11401ef7f884ac3ade35650cc21f14b5cdb0a5cf0ee6b15a"
              ; xprivate =
                  "801ffe4e0f6eeb8a50c8fe79663ff585f9d6aebcfbf4b7edc676c693900cb141"
              ; shared =
                  "e55fc931669bd02d1c64689eda62648212b1078c43b5caf97cf9763ff87a3455"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 434
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "55a0e6631a52f29fb90a1777ccbc69ff94547459d541f72e8316e4d616535a67"
              ; xprivate =
                  "e04e412383a63b338b70e1be5fd75995350321dee428aa4f3ba62a50a3b0de44"
              ; shared =
                  "87f7976a17f3e03a7f1eb74e6db950b8c0994f40b7903495599d227725809e01"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 435
              ; comment = "special case for DA + CB in multiplication by 8"
              ; public =
                  "7976d520f1a2512d564af41c68313f5351b0156d5118be4817f192798ae9777d"
              ; xprivate =
                  "382dbe9f10158bfbb7d1d79a35a7809214899a6b8572b35b55875d79bd2f1640"
              ; shared =
                  "3bb3e30105a71901b115065e39bdb3e053d387b39027b12c92cdf4c638adf00d"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 436
              ; comment = "special case for AA in multiplication by 8"
              ; public =
                  "a26a722f7ba71ccfc96ed8e108d7c9f842d17f92051ee7d429ea7fa7908ab907"
              ; xprivate =
                  "60c9af7f4d03136a6034ae52deadfd9d4f274ad8122812eb92a53169c8354141"
              ; shared =
                  "f5cb3a1b76185a29a6360b2142feebb11f3d08f4fd8d73df3a5228624a521c02"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 437
              ; comment = "special case for AA in multiplication by 8"
              ; public =
                  "ca3a2d96f5dda482b002324cbbdcf1dacc9815eab797c7151c3a88c75cded621"
              ; xprivate =
                  "283fae8bd8b294de2848056449751965abb5c7fa86ba4c2c5cdc3bb524dad140"
              ; shared =
                  "b0b47868e70465ee2dd737f1ba5a6399e09cd813d72da7585ab45c946cc28d4d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 438
              ; comment = "special case for AA in multiplication by 8"
              ; public =
                  "eebd858850b56febb707f27a7aad5ff5ab4b0e0c73b9c86ec4ca0f42e7f38e75"
              ; xprivate =
                  "401539703ca4980db4ba42c59fc29e83b4189f2ddea53ba54ca966c06898a640"
              ; shared =
                  "581e4b12b0f39a7cc42dee4513ecfdd20b595f905f17ad8c1fbf1b5cb2068b31"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 439
              ; comment = "special case for z_2 in multiplication by 8"
              ; public =
                  "c800bf799783275eb93312b43dc032ccdfb00a4b77c8b3772cd2fec8db7e4a09"
              ; xprivate =
                  "c8eb056286e098e6b2c79e42f007ebc6ab3705346cdbdace949b5de1e8c36743"
              ; shared =
                  "6bf264532fc70a6a7e459f4579eca6b84f8f76ab85c3264b20bca725a6eb6c40"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 440
              ; comment = "special case for z_2 in multiplication by 8"
              ; public =
                  "7bbc504e04d134eedc13f06dfdfc69c518257a3f374040a49a8d21dac109110c"
              ; xprivate =
                  "487882956c49c69fd0e2d7277a24fb1dbe4b0365b36a13f63440248bca2fbb42"
              ; shared =
                  "690305c9e192cd8a513f705b3f101ecdf3db1ea15a09c4a1bce3a8cdc3a1a93f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 441
              ; comment = "special case for z_2 in multiplication by 8"
              ; public =
                  "132533db62aff4fa06e96314383bf58ebdec5183a19f2e4cb17552ae19a3366e"
              ; xprivate =
                  "9876010f4d64c77ffc4d7dccd72b9ac82078deb883609650b8cff8a686719d46"
              ; shared =
                  "c58591b33e490e4766ff7addff570ce4e89a98338015a55df3d2f232aea3fc4f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 442
              ; comment = "special case for B in multiplication by 8"
              ; public =
                  "ceb90c56508cf330c7f25bab42b05b5612a8310690107ac63a404c0ade788009"
              ; xprivate =
                  "a8a5d4f7894a519537babfac736de36054f508dae434b4fe63cd5633846a2647"
              ; shared =
                  "3d145851b6ff2b92b5807ed1df21eb50c9f24c4474d4721db3abb7356df7b764"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 443
              ; comment = "special case for B in multiplication by 8"
              ; public =
                  "66a09767a0d83bb18d404e1200375a745d1f1f749d5dc6f84a205efa6a11bc65"
              ; xprivate =
                  "f83e4647e82c560aa082c59641e13bf366be8f24dc01d14801e67841160bed47"
              ; shared =
                  "1401829aac4e64bcfa297a7effc60477090d3627a64a35b872ae055d2091785f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 444
              ; comment = "special case for B in multiplication by 8"
              ; public =
                  "39d431316307c85747bd2bcf4f9e0f8892ee45df15f7806ce65147d97f503478"
              ; xprivate =
                  "58c6b94bce9b15f64946c2aa6a4e383b0b2d4365b7997eb2310ac4eef1803145"
              ; shared =
                  "a0ebe6908c5472f937769b9aeb313224437fc5d73f4f866fe7ef41f30e359e09"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 445
              ; comment = "special case for C in multiplication by 8"
              ; public =
                  "84c92d8ecf3d0cb22dde7d721f04140c2d9c179cc813ce6cf8db2dce6168880d"
              ; xprivate =
                  "786a97207adbd4b0d6bfc9f49b18660ad3606c12e325044b8690b4fa07874641"
              ; shared =
                  "07538f1b6583041c4949fafae3349d62f9dd302d3d86857af0dedc0d5ad6741f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 446
              ; comment = "special case for C in multiplication by 8"
              ; public =
                  "a9cedb9e942a47221e4296953220d10007db327d2acb68da6ef3a4f877b8ef1e"
              ; xprivate =
                  "282310210e575a59393cf19bbe6e24752dc247706f1e0031e5d39b2de4fff745"
              ; shared =
                  "1223505fbb534c1bc6108e6b98b4f0af29e11158c02d333d6559beecd6d3e558"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 447
              ; comment = "special case for C in multiplication by 8"
              ; public =
                  "64e1c0c5f59405bbc6c7db41a3485cc9f91c183b0f2b7e1894a7abd8fbbeeb23"
              ; xprivate =
                  "c8bf2fd4c40d00f1465aada682b12fa92dec10343484ab62b8871337de1d3345"
              ; shared =
                  "ee031868165f456f75907bf39742b820e0f8e6df9f9768d757d408e1cc92ff7b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 448
              ; comment = "special case for C in multiplication by 8"
              ; public =
                  "a68d2f55e60eac7983926310f4fae13f95b2bbf140be5ea91751884d900ab44d"
              ; xprivate =
                  "c06a4a4b70f613136f18c0f88e2245086c3d1a52717210a21ac9d63682f2e740"
              ; shared =
                  "c954fa7b042c32943e03191e367d54be0085fa8950ef2bec99620df79ecbea4b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 449
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "6d3cd623f26a7453fa05a01ae758ba84d3c58d93d60ce32735a15e0d053d5b12"
              ; xprivate =
                  "20596e1dc56596823d37698dfa699c79874aaefde797f863ef92135980fb2043"
              ; shared =
                  "7c3219b3c1fae1f95590ac843efd2084a1f4bd3efa2f592f022032db64ebcd77"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 450
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "8f195547346b3d53b7ea4f742b22f1ef7b3cc01a7d3dcd19aa7c5b03f31bd214"
              ; xprivate =
                  "38141518e8e5efa1d031c6c4d95480239f6c30b8ccd8c751a9e04bd3aec17342"
              ; shared =
                  "a31f6b249d64a87c4aed329c6c05c3f2240b3ca938ccdc920ba8016c1aeaeb45"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 451
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "ffc4fe2c2127a309c739565651e9812f834a86dbadbb78776977f786ecdb0217"
              ; xprivate =
                  "207147f2b68fef1efc10a04f988f0eb18b273b0b5ed17aa7af32c90480e19b43"
              ; shared =
                  "4cff9f53ce82064882329a18ea4e4d0bc6d80a631c87c9e6fdc918f9c1bda34a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 452
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "8475babeeab9980d426abd5323dfb335b219e129bddae4d6cebcda50754a6825"
              ; xprivate =
                  "488084537b840f9c93ca57b3ee80491418d44221113e03f56355302604d03547"
              ; shared =
                  "248d3d1a49b7d173eb080ab716ac8fde6bd1c3ed8e7fd5b448af21bcdc2c1616"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 453
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "81f90a2f6633d30c2b72a25795d2a49463a80b6b0edc5aa68bae4bf738185539"
              ; xprivate =
                  "28cfc1d03f5c7428ff3e20b137268b33ccc74db03582d2127c566df4ac99f441"
              ; shared =
                  "66c6e70cf630be90a2c88fcde7f58cff3868660fa96406e8df4ac677dbd85f50"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 454
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "41626e33b3c8f48bd19e49ded307f2b63bde705c4f3cdf9d4f92bf37c48cba42"
              ; xprivate =
                  "c8e37d10f3d03db3f43e467bddf98f595cb529ad253c20d491282d1400b9e740"
              ; shared =
                  "06283fcf69dc83e99d92e5336f499a1d8fa75ed2c819b5ae6ea8094454324b27"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 455
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "ebb32f781c0e89b252e611f9d8f79f8567874c966598314b2f16aa44cfc07843"
              ; xprivate =
                  "00237e91406a7b4db61e780c5976fbb926cdace2fbdfdbcfce65e6dbe7782a42"
              ; shared =
                  "7d2affb43355f5db1294daff55f59b1f17e7d25bca20746f12484d78e5015517"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 456
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "fa75e6f08ca815b4e42af24a8e057c9e00e828e33d12c0e94d1012a758336744"
              ; xprivate =
                  "489c4184a23a8f5eec68a31b41aa2c0392cd6fb123f10acdb4de75292b4b9a43"
              ; shared =
                  "ef8e78cab091d667888489fd3a2ec93fb633427d02eb77b328d556f2b2b0e266"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 457
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "4d96320cdb0ca52655e91118c33f93afe4ae69e9e513ff4506750b8ea784ce46"
              ; xprivate =
                  "c05957fbc3a0e2c22a2aef627651ca1e99307b82a0c6170f7950a334f3004941"
              ; shared =
                  "c8d85bfa74b4b26461297b350c975183fea9d33ba29c3a4934509c2ecda58a79"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 458
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "c0ef1b7c20237db370501f24274e4eba91998ae4545f937007e1c4a2eab63365"
              ; xprivate =
                  "60111c6629f73635985be964b845f87a88ae5652d45bb1451ce8cfd2ea45fe41"
              ; shared =
                  "22557e0d8741ed2a63afd5e313aa1579fc0c88c7772e23a676c94b60c89df577"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 459
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "d534d8ff4d56a73ef7615e94523b17e35edb3d0fb87e98c68536f63f114a8d6c"
              ; xprivate =
                  "58785889a216d15456582d4e1e3de9e9ca4a432954416d81caf52b2b434c1746"
              ; shared =
                  "54d7fc17bad00296ba50b0f3d5bf8fb83f82d571952a5fdb5a494120cc61446b"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 460
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "733a711ba01b6e9b64a0be4cdca8c7cf3c66df2435d5248fb4413fec6ee03f70"
              ; xprivate =
                  "60bef38a3890ec1ed05c299fceb77db5ead4b88d9e931b0f21d664f77df9b544"
              ; shared =
                  "db6851b12585bc11be9362c96a545c6f2ba55f04009792463b96a38cb9b3f07c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 461
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "35738dd539d60f69cd1a1cffc8a42b6af68fe7de45392d02831e2a77500ea278"
              ; xprivate =
                  "5854ee566878ef8b7ebaf5a058306f250edf0c84fd52af2d74b7ce3c1edda746"
              ; shared =
                  "f6d1a664257fa5de3d4d57f04eda2976bf1e35cc3ac513e1ee84d57d2135ed13"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 462
              ; comment = "special case for x_2 in multiplication by 8"
              ; public =
                  "ce932b5af4be4721f96f7b79ba1c43b20687d4af49c37b58dc894279e04bb578"
              ; xprivate =
                  "985b551261fce38ddc8ff3add32f5c26811d271b9a1794e249dd76a38df28446"
              ; shared =
                  "f8f7625ac5bde63f753a9bb4aefbfb9c4647207708af9d774ef08ff1b1e5a354"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 463
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "e3655448339e4850806eb58abba0c89185511ea72c37c49e9583ee6dd235d213"
              ; xprivate =
                  "8815052344dcad97efd1341e9072a808cf999e46e52cf04e0cfbcd9901e18d43"
              ; shared =
                  "5e10dfbff4443efcae2ccc78c289a41460d5a82f79df726b8824ccbef7146d40"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 464
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "4d16965b1637e9d7ae8feb499ed0553962a9aa0022d1620c928072f6501bc41b"
              ; xprivate =
                  "b8e032e9e5ffbaa004390f3a0b900bc7cf5d11238b7ec964afc4bda2aa6c3444"
              ; shared =
                  "19d7b44c1847c44e8f37a22ab69c180fd9d787f204123013e1b16800b9cd0f57"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 465
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "c6b9e6288737ad40452cec1022871d90af1642d10bd0a97792b1a9c8998e2220"
              ; xprivate =
                  "7012852211f6536fca79937e7e316c9149b0e20ea03f951e1bb072895ca0e044"
              ; shared =
                  "db990d979f4f22f766e7826d93554e771b361de461274d6c37baadeb8ef7be4e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 466
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "d566fab505ac4c7a3dc3b9403ef121392cbbe21216e5bcb8eab2dc9408986e34"
              ; xprivate =
                  "d039c1b9ec4763e0ad8a0ef2b0870297d0f8b487e660595a484105d180e14a47"
              ; shared =
                  "6d7fc5d4a8f534b1bc0fa5e078104234675c02664736957abdb27df6faf07c00"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 467
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "468d35ecfb6d9b7272523276cc5e13760519667f0e1e3888da4c56955fe91151"
              ; xprivate =
                  "58efcbc8777c1b54f09c61a216efd427292eb12312dbb3b32bd45254a6683e47"
              ; shared =
                  "539c8d629ab51c2f3ea7278fd5f1c31b6c150a82fe3f786b93ffa159fd6d9316"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 468
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "1929538743977dfea20bf4927ddabb2f3bb15cac2461054508849718854b5568"
              ; xprivate =
                  "c8d73446026cd0ea795773c2eb7b16348cd5f228e352dbc77328c2d8b9cde240"
              ; shared =
                  "dee3fd19c8f296415448b21af44385ec46727bbe67d4839b93efe2f680e76d34"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 469
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "2d7ab4c6f59865355ee8e9de57db19aadf7708b7c1d1a818487c340623badc6d"
              ; xprivate =
                  "98b559523bc778b0418af53c0c32f6ff5cf771ff5df8ae7cbf7c3b72aedb5b43"
              ; shared =
                  "2a0340aaafa05d00529c09057ed0145f34d2de66a3e149cf084ea97168914f39"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 470
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "43839f4a6aa206c82c5a73f49d8c9e573826b3ba7235d312987c17aebee62776"
              ; xprivate =
                  "589815027caf82714e96c9f91bace66ec4ba3e92df3fa14b9b8fe503556e4543"
              ; shared =
                  "00313717d33e3b41a0865986157582e053502a172b88d01bb7b10831a9fc4e6c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 471
              ; comment = "special case for E in multiplication by 8"
              ; public =
                  "3c321e7f0b9e555bc264a2cea617e6b2b562ebab21fe0c226c3e487b7df9a27d"
              ; xprivate =
                  "80715f67270c99789855ceaea99b9957ccda33326f76bb4474ab52ab1ec37041"
              ; shared =
                  "9b6be9e6f2fdb5d3321842225d3e91d14828cc53ba6654dabe190b0c3edeb309"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 472
              ; comment = "special case for DA - CB in multiplication by 8"
              ; public =
                  "42e5a6b8e9654bb4ad624af3f491877977513cc8775c8fb312ad19dbf3903a28"
              ; xprivate =
                  "101b990bd83d684126ff047d930c27d086a588dd19683d2629f0e34f4374ab41"
              ; shared =
                  "223f1eb552308373026d11c954684ce6db870b638b190b9443e50aae219f4e3e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 473
              ; comment = "special case for DA - CB in multiplication by 8"
              ; public =
                  "0a51dd90ab985f6deaf72f16c45014da26df848697f6582d75688f5223342b51"
              ; xprivate =
                  "200089b712d9a2050597779d463712fcd223e3d67879c0fb7606f8f5f0efee40"
              ; shared =
                  "fb95ce4a3c1f325638b7d47f4216d39a7c6c5da9a01caa297c37b62816555b2a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 474
              ; comment = "special case for DA - CB in multiplication by 8"
              ; public =
                  "8842317357bde825ef438a1c53906fb8b04ea360f7ef338c78e668586047936a"
              ; xprivate =
                  "f04f87f4e623af4c31ceca0bb87fac2d5b12517b5a7284902ad75838e65f1e41"
              ; shared =
                  "488b8341c9cb1bbf124510b9f8dae4faf2e0dca9b84e00e952a63b5aa328a860"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 475
              ; comment = "special case for DA - CB in multiplication by 8"
              ; public =
                  "c71d92d3c92dbfaed755fb32797b667cc86b0e79362498e2aca38c689713b16e"
              ; xprivate =
                  "383cbd5a3dd0901d09a3cac3d3a77a979cecf15e206a553e4ca3f24b90783945"
              ; shared =
                  "1129eae97bf75f7314f2e1b403b18737ad830c80429e2ba0d4866b362399855f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 476
              ; comment = "special case for DA - CB in multiplication by 8"
              ; public =
                  "3a21d1cf7b3744d1ad26197335844982c2a0c6a5aa835492bd03c401a4fe6778"
              ; xprivate =
                  "701df09e57b98aec375745df147b72949a6b2bb2ca3a34881512ee31e790ad42"
              ; shared =
                  "072f51d94727f392d59dc7caff1f4460452352ec39c32a1c9f071e388833da56"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 477
              ; comment = "special case for CB in multiplication by 8"
              ; public =
                  "d128ea3e13325ed6ebd6533a9fd3045a55f25ad8b67def30912843504c1aab29"
              ; xprivate =
                  "b0ffa5f4922bb117ad75ff43acac62331efaa45536fe88306e4a4cb58db73a47"
              ; shared =
                  "30512142d3e3a4cad6726d9d35f2e043fca9dfb750884ae22b2547c840f3587b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 478
              ; comment = "special case for CB in multiplication by 8"
              ; public =
                  "e079c8f8423165c7e0a2c48b4abe90aece4e6d903d7a5a1625fad0410cd55b32"
              ; xprivate =
                  "685e3271d2015741756612a930e858b930acf2018145f382c83d8cced2e22044"
              ; shared =
                  "5b81b3761a66d199e8ef99d2494bd57a0229d4564a7f6d6055f22aa48681bd3a"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 479
              ; comment = "special case for BB in multiplication by 8"
              ; public =
                  "65922a06e9be4e8a5e8aceb1a4e08fe90f01e10ef2dd27315427cedfcf95ec32"
              ; xprivate =
                  "f8e161d69297e017d7c51b1b1ff3ba703d4c4cf8fc2b8ff47f74c3ff8c7d3541"
              ; shared =
                  "038de7fdb9cc0030f5c11dda00589f0a95f65658815b06ed013553a02b6c5017"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 480
              ; comment = "special case for BB in multiplication by 8"
              ; public =
                  "d36a240e972dc16e9b97a997ada337f02760d05c46d7f8d7b4e9ea9a635c7c64"
              ; xprivate =
                  "105d7589f8abef0acf0940da84a69e8f2f306fa73c9afd27342287c1dba80044"
              ; shared =
                  "22b0dea3b3b7ca55eceeaae6443426548c7c15cc7ddf31780318d1c23879c16a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 481
              ; comment = "special case for BB in multiplication by 8"
              ; public =
                  "4f5b8b9892b8a46df08d76a4745b1c58d4e7a394905435875688ca11f1e9d86a"
              ; xprivate =
                  "1893d4388b0e90f0b50208aa8f0cc24f576d03641baf1c3eddb2a3efa69c9d40"
              ; shared =
                  "a25e1306684ad7870a31f0404566e8d28f2d83d4b9497822c57f8781b18fec20"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 482
              ; comment = "special case for BB in multiplication by 8"
              ; public =
                  "aa2f02628269139a7a8a16fde95c9bad7da7ffbd5439c396a7d77b6c3213e67f"
              ; xprivate =
                  "0065171301bf6b90fb16efa35509161f1bd6b3b93130d490af9fe224dd155f45"
              ; shared =
                  "bb4431bea7a5871c1be27a2674094627eaaa4425c99cd3fa41bd7e13cbd7bf7e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 483
              ; comment = "special case for A in multiplication by 8"
              ; public =
                  "d995cb287e9a9c5791f3cae3d494a5b516a1e26cbc930f43e73c8b70b69d783b"
              ; xprivate =
                  "10c81a4e78d82145b266e1d74b3869bf1c27427803ebb11c92ff8073d1e4cc46"
              ; shared =
                  "330f5d0b5bccc90f7694dfdd9c6449a62d93af8840eaf571e3e0610e0198b03f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 484
              ; comment = "special case for A in multiplication by 8"
              ; public =
                  "479afb1e73dc77c3743e51e9ec0bcc61ce66ed084dc10bfa2794b4c3e4953769"
              ; xprivate =
                  "48b98b4a99eadd73012c07fe5c4a0b9590ac55e821353b41d5f665e17188bc41"
              ; shared =
                  "bdef00caa514b2f8ab1fb2241e83787a02601ecdff6cf166c4210f8c1ade4211"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 485
              ; comment = "special case for DA in multiplication by 8"
              ; public =
                  "378eda41470b0f238a200f80809ad562ca41e62411a61feb7f7e9b752b554642"
              ; xprivate =
                  "1897678e38222a61fe105dc6643c1eb5940e8dbc73ed6c00f25a34328f43a641"
              ; shared =
                  "bfd5b5acd2d89f213a26caf54062f9a24e6f6fd8ddd0cd2e5e47b7fea4a9c537"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 486
              ; comment = "special case for DA in multiplication by 8"
              ; public =
                  "0cad7545ade2fd93fcae007c97648348f26d85829bdb7223a63eccb84e56d475"
              ; xprivate =
                  "a898af8138e11ae45bbcefa737182a571885f92d515c32056c7cb0d7deac4741"
              ; shared =
                  "c8085877800c175e949cdd88e196eb9c4841da2ac446dfed9085bda5bbec265d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 487
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "60f27ed0a27804ced237cf3c1cc776650fb320bae6d5acb564e97b56cba25210"
              ; xprivate =
                  "b0bfef6ec095b5a1f93917d32f16a21d0462c1fde17446f5a590232d9c895f4a"
              ; shared =
                  "4c300895827382a9d1079028bd6f694a7a12ddac9c76abac6fdf5d29457a3310"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 488
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "f93a73270ac19194b8e4ffd02be4b1438525f84a76224688ea89a9dd6a1bd623"
              ; xprivate =
                  "60497d4464ed8823c50fbc6b68620826c4f629c1d9193058df6bf857c6aecc4b"
              ; shared =
                  "7285fbb3f76340a979ab6e288727a2113332cf933809b018b8739a796a09d00b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 489
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "cf80c30fcbfd535666ca1da499e2e99cc537063e2de19458fcf92f5ee34acf47"
              ; xprivate =
                  "08c6cbe03792a3829f06e8ad54c55db113236ac0dcc9ab6a9a6b10eed1041b48"
              ; shared =
                  "dabc3bd49f19cf7071802e43c863ed0b1d93a841588098b98a0c581bf4fe0a11"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 490
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "698effe0ad42e15ee1f46fde6fc5074ffda183bcf1b2db8647f561ddd191dd60"
              ; xprivate =
                  "50044da3315dd082e9dfb6a1994aabb331f53e0d1c12633383b2a3c8678cfe4c"
              ; shared =
                  "a61a3b150b4770532373676298c9a5da28adcc4365b06fe07c959ca80e477a57"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 491
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "bd1565b4a3f8515dff577be6dcb414511d3d4ec2de15e0bd45b28e9cc4caef60"
              ; xprivate =
                  "285640da7a48252e35ddce60c14addb73097fbc9ac2f87c8d2772ce89aa6be4d"
              ; shared =
                  "916ab4f3bfc8321e1087d9c5444f8f7a43e9ca6d29e7ba98a19dc05fff34ed4c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 492
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "b8649e13843f80cf5702398e4a9a8c378f29da96dfd6579f1eb4f7ea34df6765"
              ; xprivate =
                  "783271c21199ba2e94ead92cd9dd79f70aab378b59497455d327a5907dafcb4a"
              ; shared =
                  "844a5dd5139554ca7b41cbe6a4796193912e7aa4e201cc68944ce2a55774a10f"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 493
              ; comment = "special case for AA in multiplication by 9"
              ; public =
                  "c396938737abdf791e09a97eba577c437d9b67c2dae94e13eab7296ec0fc737e"
              ; xprivate =
                  "d0676a0b9a046c62d5b2e740d9cc43fa37965dea93c23254f7bf569f2bebaa4a"
              ; shared =
                  "10780333b2a6170136265bb5ebc6c818817f2e48ae372528c8f34433fdd6215a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 494
              ; comment = "special case for DA - CB in multiplication by 9"
              ; public =
                  "557b825012d98f065bb95a2ab9b2d2d8b83fd2037912508c263f86d7e36c4f24"
              ; xprivate =
                  "608c84d2b76fccda579e974db3d3b2ce39a6bc0dad440599db22411b60467849"
              ; shared =
                  "5ce84842dbae8b795b3d545343558045508f271383bfb3dd3943f4101398c864"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 495
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "ae98296d4a2fbcbb40b472f4063231608bb1465c226c8a4a2dff29afd915882a"
              ; xprivate =
                  "80f233936a8821936d39114c84d929e79760b27680779e5009e1709410dd8e4f"
              ; shared =
                  "4f11aa0c313195f96f25cadcbf49f06a932d8b051879ea537d1c6dfee7f36d35"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 496
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "8b9d249829fbe81333d85050da88998f63fac665679e27dbbe21b745dd14e145"
              ; xprivate =
                  "c8d80b1a34f21194f047a6f0328bb947e2e7aff6a043553aa07f2abf99aaf048"
              ; shared =
                  "1d619070bf5626064be10025e74e336c81ef3166b743f99c751fb90587c31d7e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 497
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "61896093e2697c78230afdda12639cbe4342827b8d2b093281f148eb60b9034b"
              ; xprivate =
                  "9021477b452361580059364c6f94f4981ee94ea3f9b7d37439bc82ae45816f4d"
              ; shared =
                  "532e797861db56b9d5db8825fb72f8629c2422f8abea721ad2d7b9e77a95b576"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 498
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "ccc1dc186229dba9a9360a0f7ff00247a3732625acaacd18ea13a9a8b40fac4f"
              ; xprivate =
                  "6079dae04c40a59ea4e0c8c17092e4c85ea9133d143307363487836df4e30349"
              ; shared =
                  "4f678b64fd1f85cbbd5f7e7f3c8ac95ec7500e102e9006d6d42f48fb2473ab02"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 499
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "69e368c0b7e78eb9f3a53bf458f6e79dc4883bf9458f04a8c12c4ddd94d62151"
              ; xprivate =
                  "281db6a5ac9a47d4a7b2b91a87f6536ce62d4e5129b8d647b97f9c504014894c"
              ; shared =
                  "e069fd06702f10f33adb8cf0766880634865b510e2da409241fb5f178050514a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 500
              ; comment = "special case for z_2 in multiplication by 9"
              ; public =
                  "f21f9badd98dd8a103cc2ab5484fac6c2bfdd2671ee6e674134a86b89cee9160"
              ; xprivate =
                  "d830f3c4785829a0f945857e0e85e0ae723702b57783b933cd2a2ad05484fe49"
              ; shared =
                  "fee218eb1f92864486e83c1731f04bb8c7e6d7143e3915bcbf80fe03ff69dc77"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 501
              ; comment = "special case for E in multiplication by 9"
              ; public =
                  "e853062b2d6f38d021d645163ea208d0e193a479f11f99971b98e21188fd0b2c"
              ; xprivate =
                  "10230bd0721f4c8c4b921881dd88c603af501ee80e2102f8acc30cf8b2acd349"
              ; shared =
                  "64bdfa0207a174ca17eeba8df74d79b25f54510e6174923034a4d6ee0c167e7b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 502
              ; comment = "special case for E in multiplication by 9"
              ; public =
                  "362eb92dab9fb29f7ed0e03843dcc15797928c2b4e51ec260204179c1c12945f"
              ; xprivate =
                  "f0a34d6d76896e17cb8f66feda23115ffb96f246b823bb63dec08335787de74c"
              ; shared =
                  "d7f4583ee4fe86af3a3f1dfcb295ba3a3e37bced7b9c6f000a95336530318902"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 503
              ; comment = "special case for E in multiplication by 9"
              ; public =
                  "ff543f1e81996e88631f030ceba7e603b13033efd205e68bd36b28468134aa73"
              ; xprivate =
                  "9073c1d0a173c7ff02dc966a165993d9c4c9357514f7a6bb7aaa4b0827718948"
              ; shared =
                  "c1b5e5f4401c98fa14eba8aafae30a641bfd8fb132be03413f3bf29290d49e0b"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 504
              ; comment = "special case for x_2 in multiplication by 9"
              ; public =
                  "90ef70844ead1613f69df7d78c057813f866c0d95e6d22caee4a012b9c1c4b33"
              ; xprivate =
                  "b0c1822566e016c12ae35ec035edd09af3cb7a48f55c9028e05e1178a8c3824e"
              ; shared =
                  "9369ebb3d2b744341cba77302719a4b2d63aff612872f86d9877a76bc919ca1c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 505
              ; comment = "special case for x_2 in multiplication by 9"
              ; public =
                  "88c1ae575ad073dda66c6eacb7b7f436e1f8ad72a0db5c04e5660b7b719e4c4b"
              ; xprivate =
                  "e06fe64e2117796f997bbcd3bcad3067cf1291640a3a643fb359809a4016834d"
              ; shared =
                  "335394be9c154901c0b4063300001804b1cd01b27fa562e44f3302168837166e"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 506
              ; comment = "special case for x_2 in multiplication by 9"
              ; public =
                  "dcffc4c1e1fba5fda9d5c98421d99c257afa90921bc212a046d90f6683e8a467"
              ; xprivate =
                  "707ee81f113a244c9d87608b12158c50f9ac1f2c8948d170ad16ab0ad866d74b"
              ; shared =
                  "7ecdd54c5e15f7b4061be2c30b5a4884a0256581f87df60d579a3345653eb641"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 507
              ; comment = "special case for BB in multiplication by 9"
              ; public =
                  "6c0044cd10578c5aff1ff4917b041b76c9a9ae23664eb8cf978bd7aa192cf249"
              ; xprivate =
                  "7089654baacbb65bd00cd8cb9de4680e748075e8842ca69d448fb50fea85e74e"
              ; shared =
                  "0d8c21fa800ee63ce5e473d4c2975495062d8afa655091122cb41799d374594f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 508
              ; comment = "special case for BB in multiplication by 9"
              ; public =
                  "d9089de902e143dcd9107e5a3393a3f7fe05d926c357b47e307a236cb590fd64"
              ; xprivate =
                  "8089784c52cd67e4536e568218c7b7033b28413f942fca24ed69e43496efa14b"
              ; shared =
                  "db6fec44bf118316a6bdfbae9af447baede4d82daa16bed596ea6f05d4a51400"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 509
              ; comment = "special case for BB in multiplication by 9"
              ; public =
                  "8c4a26aa319c2cc4a4158c2bc69a0d5b340b60628a14cf31bb0ae5ddc38ae866"
              ; xprivate =
                  "00e73e4e013148b9f05273bad626bb126a40ec4558f5425096b48947e0a9de4a"
              ; shared =
                  "ecc1204bc753c4cec4c9059fd7b504944ebf995ab1b1d49f0b3b325353be3a15"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 510
              ; comment = "special case for BB in multiplication by 9"
              ; public =
                  "ce7295d1227c9062aab9cf02fc5671fb81632e725367f131d4122824a6132d68"
              ; xprivate =
                  "78ed4c9bf9f44db8d93388985191ecf59226b9c1205fe7e762c327581c75884e"
              ; shared =
                  "3740de297ff0122067951e8985247123440e0f27171da99e263d5b4450f59f3d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 511
              ; comment = "private key == -1 (mod order)"
              ; public =
                  "6c05871352a451dbe182ed5e6ba554f2034456ffe041a054ff9cc56b8e946376"
              ; xprivate =
                  "a023cdd083ef5bb82f10d62e59e15a6800000000000000000000000000000050"
              ; shared =
                  "6c05871352a451dbe182ed5e6ba554f2034456ffe041a054ff9cc56b8e946376"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 512
              ; comment = "private key == 1 (mod order) on twist"
              ; public =
                  "2eae5ec3dd494e9f2d37d258f873a8e6e9d0dbd1e383ef64d98bb91b3e0be035"
              ; xprivate =
                  "58083dd261ad91eff952322ec824c682ffffffffffffffffffffffffffffff5f"
              ; shared =
                  "2eae5ec3dd494e9f2d37d258f873a8e6e9d0dbd1e383ef64d98bb91b3e0be035"
              ; result = "acceptable"
              ; flags = [ "Twist" ]
              }
            ; { tcId = 513
              ; comment = "special case private key"
              ; public =
                  "3e3e7708ef72a6dd78d858025089765b1c30a19715ac19e8d917067d208e0666"
              ; xprivate =
                  "4855555555555555555555555555555555555555555555555555555555555555"
              ; shared =
                  "63ef7d1c586476ec78bb7f747e321e01102166bf967a9ea9ba9741f49d439510"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 514
              ; comment = "special case private key"
              ; public =
                  "9f40bb30f68ab67b1c4b8b664982fdab04ff385cd850deac732f7fb705e6013a"
              ; xprivate =
                  "4855555555555555555555555555555555555555555555555555555555555555"
              ; shared =
                  "8b98ef4d6bf30df7f88e58d51505d37ed6845a969fe598747c033dcd08014065"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 515
              ; comment = "special case private key"
              ; public =
                  "be3b3edeffaf83c54ae526379b23dd79f1cb41446e3687fef347eb9b5f0dc308"
              ; xprivate =
                  "4855555555555555555555555555555555555555555555555555555555555555"
              ; shared =
                  "cfa83e098829fe82fd4c14355f70829015219942c01e2b85bdd9ac4889ec2921"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 516
              ; comment = "special case private key"
              ; public =
                  "3e3e7708ef72a6dd78d858025089765b1c30a19715ac19e8d917067d208e0666"
              ; xprivate =
                  "b8aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa6a"
              ; shared =
                  "4782036d6b136ca44a2fd7674d8afb0169943230ac8eab5160a212376c06d778"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 517
              ; comment = "special case private key"
              ; public =
                  "9f40bb30f68ab67b1c4b8b664982fdab04ff385cd850deac732f7fb705e6013a"
              ; xprivate =
                  "b8aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa6a"
              ; shared =
                  "65fc1e7453a3f8c7ebcd577ade4b8efe1035efc181ab3bdb2fcc7484cbcf1e4e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 518
              ; comment = "special case private key"
              ; public =
                  "be3b3edeffaf83c54ae526379b23dd79f1cb41446e3687fef347eb9b5f0dc308"
              ; xprivate =
                  "b8aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa6a"
              ; shared =
                  "e3c649beae7cc4a0698d519a0a61932ee5493cbb590dbe14db0274cc8611f914"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ]
  }
