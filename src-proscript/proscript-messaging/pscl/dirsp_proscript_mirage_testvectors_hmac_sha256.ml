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
(*                 HMACSHA256 Test Vectors             *)
(* --------------------------------------------------- *)

(* ------------------------------------------------------------- *)
(*             Wycheproof test vectors for hmac_sha256           *)
(* ------------------------------------------------------------- *)

(*
From the Apache v2.0 licensed

https://github.com/google/wycheproof/blob/2196000605e45d91097147c9c71f26b72af58003/testvectors/hmac_sha256_test.json
*)

type wycheproof_test =
  { tcId : int
  ; comment : string
  ; key : string
  ; msg : string
  ; tag : string
  ; result : string
  ; flags : string list
  }

type wycheproof_testGroup =
  { keySize : int
  ; tagSize : int
  ; xtype : string
  ; tests : wycheproof_test list
  }

type wycheproof_root =
  { algorithm : string
  ; generatorVersion : string
  ; numberOfTests : int
  ; header : string list
  ; schema : string
  ; testGroups : wycheproof_testGroup list
  }

(** wycheproof test vectors for HMACSHA256 *)
let wycheproof_test_vectors =
  { algorithm = "HMACSHA256"
  ; generatorVersion = "0.8rc21"
  ; numberOfTests = 174
  ; header =
      [ "Test vectors of xtype MacTest are intended for testing the"
      ; "generation and verification of MACs."
      ]
  ; (* notes = {
       }; *)
    schema = "mac_test_schema.json"
  ; testGroups =
      [ { keySize = 256
        ; tagSize = 256
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 1
              ; comment = "empty message"
              ; key =
                  "1e225cafb90339bba1b24076d4206c3e79c355805d851682bc818baa4f5a7779"
              ; msg = ""
              ; tag =
                  "b175b57d89ea6cb606fb3363f2538abd73a4c00b4a1386905bac809004cf1933"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 2
              ; comment = "short message"
              ; key =
                  "8159fd15133cd964c9a6964c94f0ea269a806fd9f43f0da58b6cd1b33d189b2a"
              ; msg = "77"
              ; tag =
                  "dfc5105d5eecf7ae7b8b8de3930e7659e84c4172f2555142f1e568fc1872ad93"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 3
              ; comment = "short message"
              ; key =
                  "85a7cbaae825bb82c9b6f6c5c2af5ac03d1f6daa63d2a93c189948ec41b9ded9"
              ; msg = "a59b"
              ; tag =
                  "0fe2f13bba2198f6dda1a084be928e304e9cb16a56bc0b7b939a073280244373"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 4
              ; comment = "short message"
              ; key =
                  "48f3029334e55cfbd574ccc765fb2c3685aab1f4837d23370874a3e634c3a76d"
              ; msg = "c7b8b2"
              ; tag =
                  "6c13f79bb2d5b6f9a315fe8fd6cbb5cb817a660687009deccd88c377429e596d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 5
              ; comment = "short message"
              ; key =
                  "de8b5b5b2f09645be47ecb6407a4e1d9c6b33ae3c2d22517d3357da0357a3139"
              ; msg = "cc021d65"
              ; tag =
                  "e87538eb167e62d7cb236690ff3f034a9c12d417aa8dfa694d7405f9e1f85fe8"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 6
              ; comment = "short message"
              ; key =
                  "b7938910f518f13205ca1492c669001a14ff913c8ab4a0dc3564e7418e91297c"
              ; msg = "a4a6ef6ebd"
              ; tag =
                  "01a93f4ed216d0b280896301e366aa67b25e6b6a5a6e84f291a13391c6e496c5"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 7
              ; comment = "short message"
              ; key =
                  "1bb997ff4de8a5a391de5c08a33bc2c7c2891e47ad5b9c63110192f78b98fe78"
              ; msg = "667e015df7fc"
              ; tag =
                  "06b5d8c5392323a802bc5cdd0b3c527454a873d9651c368836eaa4ad982ba546"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 8
              ; comment = "short message"
              ; key =
                  "32fdeda39f98b4f4426c2d2ac00ab5dd4bfabb68f311447256ed6d3d3a51b154"
              ; msg = "4163a9f77e41f5"
              ; tag =
                  "1b0103729f48c2772bb132aef9ebd6dd6aafc9145df6d5c514b233ee92ef4a00"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 9
              ; comment = "short message"
              ; key =
                  "233e4fdee70bcc20235b6977ddfc05b0df66f5635d827c66e5a63cdb16a24938"
              ; msg = "fdb2ee4b6d1a0ac2"
              ; tag =
                  "120b26ee1355c134c262513c7922deb6c4fd90303de4cd61b9f9cd08f22d6e18"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 10
              ; comment = "short message"
              ; key =
                  "b984c6734e0bd12b1737b2fc7a1b3803b4dfec402140a57b9eccc35414ae661b"
              ; msg = "dea584d0e2a14ad5fd"
              ; tag =
                  "88bc2282e5fce47ec6d9895395cd47fff91a0cdc589a8fd56d8d344616533a3d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 11
              ; comment = "short message"
              ; key =
                  "d0caf1456ac5e255fa6afd61a79dc8c716f5358a298a508271363fe1ff983561"
              ; msg = "18261dc806913c534666"
              ; tag =
                  "f678f081d83cf126ad6bd52c2dffd786214f519c47452b85a97458d0c10c3ee5"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 12
              ; comment = "short message"
              ; key =
                  "835bc8241ed817735ec9d3d0e2df4c173ee4dded4a8ef0c04a96c48f11820463"
              ; msg = "26f8083e944bacf04e9a4d"
              ; tag =
                  "e0e46cd7d1a75b3d102893da64def46e455308761f1d908786628ca7ee22a0eb"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 13
              ; comment = "short message"
              ; key =
                  "055f95c9461b0809575eccdfa5cdd06275f25d30915c4eb8db40e1acd3ab7591"
              ; msg = "bfb7d6a08dbaa5225f320887"
              ; tag =
                  "e76d5c8c070a6b3c4824e9f342dc3056e63819509e1def98b585aeba0d638a00"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 14
              ; comment = "short message"
              ; key =
                  "e40f7a3eb88ddec4c6347ea4d67610756c82c8ebcc237629bf873ccabc32984a"
              ; msg = "7fe43febc78474649e45bf99b2"
              ; tag =
                  "aa57d020aa24ad823472c2b80ff2d0cf475f7de0068f9a59e8112fede53a3581"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 15
              ; comment = "short message"
              ; key =
                  "b020ad1de1c141f7ec615ee5701521773f9b232e4d06376c382894ce51a61f48"
              ; msg = "81c7581a194b5e71b41146a582c1"
              ; tag =
                  "f45c72603cc160c0762f703407844a7781dfe0f1ddf0aaf4ccd8205e94469aed"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 16
              ; comment = "short message"
              ; key =
                  "9f3fd61a105202648ecff6074c95e502c1c51acd32ec538a5cce89ef841f7989"
              ; msg = "2a76f2acdace42e3b779724946912c"
              ; tag =
                  "0226ee13cc05e2340135b3f4b27a9da1a160f6170fe805dadd98a3711ec9c421"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 17
              ; comment = ""
              ; key =
                  "6fa353868c82e5deeedac7f09471a61bf749ab5498239e947e012eee3c82d7c4"
              ; msg = "aeed3e4d4cb9bbb60d482e98c126c0f5"
              ; tag =
                  "9ed7f0e73812a27a87a3808ee0c89a6456499e835974ba57c5aab2a0d8c69e93"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 18
              ; comment = ""
              ; key =
                  "5300489494ca86221c91d6d953952ae1a5e097139dc9cf1179c2f56433753824"
              ; msg = "90fea6cf2bd811b449f333ee9233e57697"
              ; tag =
                  "5b692cba13b54fffc3adcbb0e015cc011fbfd61235303ff0ad2a49775083bf22"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 19
              ; comment = ""
              ; key =
                  "383e7c5c13476a62268423ef0500479f9e86e236c5a081c6449189e6afdf2af5"
              ; msg = "3202705af89f9555c540b0e1276911d01971abb2c35c78b2"
              ; tag =
                  "4e4901592ba46476408d758435c7d1b489d2689afd84ceaaee78bfb91fd9391d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 20
              ; comment = ""
              ; key =
                  "186e248ad824e1eb93329a7fdcd565b6cb4eaf3f85b90b910777128d8c538d27"
              ; msg =
                  "92ef9ff52f46eccc7e38b9ee19fd2de3b37726c8e6ce9e1b96db5dda4c317902"
              ; tag =
                  "3fc1d73dd4a8858c1fc3d8c4a3f33ed5ad0c70210038394a5902cb26fe287348"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 21
              ; comment = "long message"
              ; key =
                  "28855c7efc8532d92567300933cc1ca2d0586f55dcc9f054fcca2f05254fbf7f"
              ; msg =
                  "9c09207ff0e6e582cb3747dca954c94d45c05e93f1e6f21179cf0e25b4cede74b5479d32f5166935c86f0441905865"
              ; tag =
                  "788c0589000fb7f0b5d51f1596472bc9ec413421a43df96ee32b02b5d275ffe3"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 22
              ; comment = "long message"
              ; key =
                  "8e540cb30c94836ae2a5950f355d482a7002e255207e94fda3f7ef1a099013a0"
              ; msg =
                  "d6500f95e11262e308bf3df4df4b855f33e857563d4543f195639a0a17b442eb9fdcc1367d2eee75c8f805730b89290f"
              ; tag =
                  "39697e70ce741feb33dedc069f00b5627fd9b837d10cbdd5b6d19cfbd511dd2c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 23
              ; comment = "long message"
              ; key =
                  "69c50d5274358188cff4c0fae742243d4e8a5e5ba55d94ff40edd90f6a43dd10"
              ; msg =
                  "1ac5255aff052828d8ea21b376f1ebdd4bb879949913900405aebce83e48feb6813b5e9c89f94501a8ade41b26b815c521"
              ; tag =
                  "4b0b4d0416fa2e11586fbfa7fb11261e69991dfa34019b9893d69a2be8c1fc80"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 24
              ; comment = "long message"
              ; key =
                  "23209b7c5aadcbd13f7279af1a86d3c7ae8f179d1bcaaad0dff9a15302e78dbf"
              ; msg =
                  "84bdac37e1af35d9356404e2787d47ece58348dea76a4a46e8aade3463d4db8c94a051be3733b38d756984865d56c60e8025f15e3f968f093e7fb7ebc7e31189c5692d15ed4256737b9b1894e5809503aaa1c9983fb096aa21916361eeb6ef455b129723a1a1ddf9deddea208529a648"
              ; tag =
                  "4a85c479d1650dbd73bc5248074a55ff50218bddaa8d1fddaaf44946dc19aefb"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 25
              ; comment = "long message"
              ; key =
                  "7c9cc667cae175f448faa96647319633b2d48531373ae7d316c44ddd8b9f69cf"
              ; msg =
                  "9233c1d73b498c5106ff88951e07b9652cb0ddae740737ec205c9876d094978bfc947f7dc937119fd6a93915b19b625958a7a22363aa2ac33fb869ed16b303336ab740a0498a2df66a6599da710094481a7b544bd955b6f97135ba4673401db2db144a6e287041e47a51ed9b6ba956c13508c1c0c25310105239ab73629e30"
              ; tag =
                  "ca1b80441d333909c2bb30769650055051ed20f17de8ee953cb9070af56c704f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 26
              ; comment = "long message"
              ; key =
                  "82314540564ea3ce30591e97f68b2602de40fa29f773c2508327471b8348e8c4"
              ; msg =
                  "6a6d2f45cebf2757ae16ea33c68617671d77f8fdf80bed8fc5cdc5c8b7086bd28e7eb3eecc7163491104e5309455e67f836579b82a1da3bf5991a8e2b2f189a49e05700e46c409ed5de77780a5f389e3f13dad406c9d55675329c5c921f07034180937c0f6ef34a2308b6ff3e1a0e9dc1ea65f5632730e8744d1db2c40a6595b"
              ; tag =
                  "0900b3e6535d34f90e2c335775e86bf38ee7e3d26fb60cd9cdf639eb3496b94c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 27
              ; comment = "long message"
              ; key =
                  "d115acc9a636915241795f48852052e07b51273ae2448251ec1d0d0f9807f3db"
              ; msg =
                  "696d2456de853fa028f486fef437b6b6d1b530a8475e299db3a9005ae9cef8401985b7d31e172e8f439ccd1ad1ec44c9b86b78f3f243c1305b53bc21abad7a8fc5256311bfd34c98e37dfdc649e7ae4bda08cf2994b063c0c7106ed0b02a1f48af9191cbfb0d6a953b7e04327dfe8c93779cb574ba9cba575d01674e83621aa0c5f400d6e6cd24b301e33c9f3303e73bf357408c1be86c2489c09de998ff2ef32df554f1247d9313ce1a7160115d06f4c18d6556ff7986ef8a55e2adcfa27e4c69c71cc2ff01639e9d49bd9ed0687f530ffeb0890132457df2088081bc4a2f7f0a9f4dcea2c80d991db7f3747a1803d7619aaf3dd382c69536a0bcdb931cbe"
              ; tag =
                  "82f92977f0b605eaada510ffceb53ad75fde16a8029f1b75b406a84270dbb8b7"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 28
              ; comment = "Flipped bit 0 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d28b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 29
              ; comment = "Flipped bit 0 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d9b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 30
              ; comment = "Flipped bit 1 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d18b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 31
              ; comment = "Flipped bit 1 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "dab99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 32
              ; comment = "Flipped bit 7 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "538b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 33
              ; comment = "Flipped bit 7 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "58b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 34
              ; comment = "Flipped bit 8 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38a42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 35
              ; comment = "Flipped bit 8 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b89f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 36
              ; comment = "Flipped bit 31 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42896d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 37
              ; comment = "Flipped bit 31 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99fa709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 38
              ; comment = "Flipped bit 32 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096c80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 39
              ; comment = "Flipped bit 32 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2708a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 40
              ; comment = "Flipped bit 33 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096f80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 41
              ; comment = "Flipped bit 33 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f270ba3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 42
              ; comment = "Flipped bit 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f4df826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 43
              ; comment = "Flipped bit 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3caf4172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 44
              ; comment = "Flipped bit 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f836b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 45
              ; comment = "Flipped bit 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74162cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 46
              ; comment = "Flipped bit 71 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f026b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 47
              ; comment = "Flipped bit 71 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74972cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 48
              ; comment = "Flipped bit 77 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f824b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 49
              ; comment = "Flipped bit 77 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74170cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 50
              ; comment = "Flipped bit 80 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b45a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 51
              ; comment = "Flipped bit 80 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbf93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 52
              ; comment = "Flipped bit 96 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d4607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 53
              ; comment = "Flipped bit 96 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93834c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 54
              ; comment = "Flipped bit 97 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d7607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 55
              ; comment = "Flipped bit 97 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93804c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 56
              ; comment = "Flipped bit 103 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a955607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 57
              ; comment = "Flipped bit 103 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93024c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 58
              ; comment = "Flipped bit 248 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1ca"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 59
              ; comment = "Flipped bit 248 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14f"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 60
              ; comment = "Flipped bit 249 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1c9"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 61
              ; comment = "Flipped bit 249 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14c"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 62
              ; comment = "Flipped bit 254 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc18b"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 63
              ; comment = "Flipped bit 254 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef10e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 64
              ; comment = "Flipped bit 255 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f45f826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc14b"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 65
              ; comment = "Flipped bit 255 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3ca74172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef1ce"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 66
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d28b42096d80f45f836b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 67
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d9b99f2709a3ca74162cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 68
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42896d80f4df826b44a9d5607de72496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 69
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99fa709a3caf4172cbe93824c1f29b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 70
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d38b42096d80f4df826b44a9d5607d672496a415d3f4a1a8c88e3bb9da8dc1cb"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 71
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d8b99f2709a3caf4172cbe93824c1fa9b23a0c1e9c21bd851ff2d2c39dbef14e"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 72
              ; comment = "all bits of tag flipped"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "2c74bdf6927f0ba07d94bb562a9f8218db695bea2c0b5e573771c44625723e34"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 73
              ; comment = "all bits of tag flipped"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "274660d8f65c358be8d3416c7db3e0d64dc5f3e163de427ae00d2d3c62410eb1"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 74
              ; comment = "Tag changed to all zero"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 75
              ; comment = "Tag changed to all zero"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "0000000000000000000000000000000000000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 76
              ; comment = "tag changed to all 1"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 77
              ; comment = "tag changed to all 1"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 78
              ; comment = "msbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "530bc289ed0074df02ebc42955e0fd67a416249553742128480ebb395a0d414b"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 79
              ; comment = "msbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "58391fa789234af497ac3e1302cc9fa932ba8c9e1ca13d059f7252431d3e71ce"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 80
              ; comment = "lsbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag =
                  "d28a43086c81f55e836a45a8d4617ce62597a514d2f5a0a9c98f3ab8db8cc0ca"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 81
              ; comment = "lsbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag =
                  "d9b89e2608a2cb75162dbf92834d1e28b33b0d1f9d20bc841ef3d3c29cbff04f"
              ; result = "invalid"
              ; flags = []
              }
            ]
        }
      ; { keySize = 256
        ; tagSize = 128
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 82
              ; comment = "empty message"
              ; key =
                  "7bf9e536b66a215c22233fe2daaa743a898b9acb9f7802de70b40e3d6e43ef97"
              ; msg = ""
              ; tag = "f4605585949747de26f3ee98a738b172"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 83
              ; comment = "short message"
              ; key =
                  "e754076ceab3fdaf4f9bcab7d4f0df0cbbafbc87731b8f9b7cd2166472e8eebc"
              ; msg = "40"
              ; tag = "0dc00d7217bbafe8d78bf961189b8fd2"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 84
              ; comment = "short message"
              ; key =
                  "ea3b016bdd387dd64d837c71683808f335dbdc53598a4ea8c5f952473fafaf5f"
              ; msg = "6601"
              ; tag = "ff296b368d3bf059cc48682f6949ccaa"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 85
              ; comment = "short message"
              ; key =
                  "73d4709637857dafab6ad8b2b0a51b06524717fedf100296644f7cfdaae1805b"
              ; msg = "f1d300"
              ; tag = "2d02bd1c25b1fe52b1ead07374d6e883"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 86
              ; comment = "short message"
              ; key =
                  "d5c81b399d4c0d1583a13da56de6d2dc45a66e7b47c24ab1192e246dc961dd77"
              ; msg = "2ae63cbf"
              ; tag = "4d9e8bddf9b7a1218309d5988aa1b0d9"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 87
              ; comment = "short message"
              ; key =
                  "2521203fa0dddf59d837b2830f87b1aa61f958155df3ca4d1df2457cb4284dc8"
              ; msg = "af3a015ea1"
              ; tag = "cb8a4b413350b42f4ac3533cc7f47864"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 88
              ; comment = "short message"
              ; key =
                  "665a02bc265a66d01775091da56726b6668bfd903cb7af66fb1b78a8a062e43c"
              ; msg = "3f56935def3f"
              ; tag = "1cfce745db1ca7de9a1d4420e612ca55"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 89
              ; comment = "short message"
              ; key =
                  "facd75b22221380047305bc981f570e2a1af38928ea7e2059e3af5fc6b82b493"
              ; msg = "57bb86beed156f"
              ; tag = "0bde0d0c756df09d4f6da81b299a3adf"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 90
              ; comment = "short message"
              ; key =
                  "505aa98819809ef63b9a368a1e8bc2e922da45b03ce02d9a7966b15006dba2d5"
              ; msg = "2e4e7ef728fe11af"
              ; tag = "406a5c2bd3e6a9595f9b7dff608d59a7"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 91
              ; comment = "short message"
              ; key =
                  "f942093842808ba47f64e427f7351dde6b9546e66de4e7d60aa6f328182712cf"
              ; msg = "852a21d92848e627c7"
              ; tag = "0b1bf9e98d0a794fa55c09b63e25799f"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 92
              ; comment = "short message"
              ; key =
                  "64be162b39c6e5f1fed9c32d9f674d9a8cde6eaa2443214d86bd4a1fb53b81b4"
              ; msg = "195a3b292f93baff0a2c"
              ; tag = "71f33f6021d90858cadb1353d7fbe8d7"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 93
              ; comment = "short message"
              ; key =
                  "b259a555d44b8a20c5489e2f38392ddaa6be9e35b9833b67e1b5fdf6cb3e4c6c"
              ; msg = "afd73117330c6e8528a6e4"
              ; tag = "4b8d76372ebe5e5caa56ca4e5c59cdd3"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 94
              ; comment = "short message"
              ; key =
                  "2c6fc62daa77ba8c6881b3dd6989898fef646663cc7b0a3db8228a707b85f2dc"
              ; msg = "0ff54d6b6759120c2e8a51e3"
              ; tag = "c580c542846a96e84ea77701778455bf"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 95
              ; comment = "short message"
              ; key =
                  "abab815d51df29f740e4e2079fb798e0152836e6ab57d1536ae8929e52c06eb8"
              ; msg = "f0058d412a104e53d820b95a7f"
              ; tag = "13cdb005059338f0f28e2d8ce1af5d0a"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 96
              ; comment = "short message"
              ; key =
                  "3d5da1af83f7287458bff7a7651ea5d8db72259401333f6b82096996dd7eaf19"
              ; msg = "aacc36972f183057919ff57b49e1"
              ; tag = "bd993e4428cbc0e275e4d80b6f520363"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 97
              ; comment = "short message"
              ; key =
                  "c19bdf314c6cf64381425467f42aefa17c1cc9358be16ce31b1d214859ce86aa"
              ; msg = "5d066a92c300e9b6ddd63a7c13ae33"
              ; tag = "86c9f4dde0b257a7053a7b03c7504409"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 98
              ; comment = ""
              ; key =
                  "612e837843ceae7f61d49625faa7e7494f9253e20cb3adcea686512b043936cd"
              ; msg = "cc37fae15f745a2f40e2c8b192f2b38d"
              ; tag = "b96bcacafac30094f18ac5039e7b3656"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 99
              ; comment = ""
              ; key =
                  "73216fafd0022d0d6ee27198b2272578fa8f04dd9f44467fbb6437aa45641bf7"
              ; msg = "d5247b8f6c3edcbfb1d591d13ece23d2f5"
              ; tag = "6e597c4c3861a380c06854b446fc2a87"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 100
              ; comment = ""
              ; key =
                  "0427a70e257528f3ab70640bba1a5de12cf3885dd4c8e284fbbb55feb35294a5"
              ; msg = "13937f8544f44270d01175a011f7670e93fa6ba7ef02336e"
              ; tag = "f731aaf2f04023d621f10495344679a0"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 101
              ; comment = ""
              ; key =
                  "96e1e4896fb2cd05f133a6a100bc5609a7ac3ca6d81721e922dadd69ad07a892"
              ; msg =
                  "91a17e4dfcc3166a1add26ff0e7c12056e8a654f28a6de24f4ba739ceb5b5b18"
              ; tag = "95243eb1a9d448174ae4fccf4a53ebfe"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 102
              ; comment = "long message"
              ; key =
                  "41201567be4e6ea06de2295fd0e6e8a7d862bb57311894f525d8adeabba4a3e4"
              ; msg =
                  "58c8c73bdd3f350c97477816eae4d0789c9369c0e99c248902c700bc29ed986425985eb3fa55709b73bf620cd9b1cb"
              ; tag = "343367207f71425d8f81f3110b0405f6"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 103
              ; comment = "long message"
              ; key =
                  "649e373e681ef52e3c10ac265484750932a9918f28fb824f7cb50adab39781fe"
              ; msg =
                  "39b447bd3a01983c1cb761b456d69000948ceb870562a536126a0d18a8e7e49b16de8fe672f13d0808d8b7d957899917"
              ; tag = "151618eec4f503f3b63b539de0a58966"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 104
              ; comment = "long message"
              ; key =
                  "7b0d237f7b536e2c6950990e61b361b384333dda690045c591321a4e3f79747f"
              ; msg =
                  "3d6283d11c0219b525620e9bf5b9fd887d3f0f707acb1fbdffab0d97a5c6d07fc547762e0e7dd7c43ad35fab1c790f8047"
              ; tag = "ce201c0dcfdc3f2bef360609a31fb19e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 105
              ; comment = "long message"
              ; key =
                  "17c92663741f012e5bb6714e614c2d155948617f10936269d954c58aba2ae62d"
              ; msg =
                  "7fdd6a15c861d0313f6635d77dc55e115ff18c8ab063b5d03eab472eeca87a378188f25813515cf90b6cffa94a8ff36b29d65603eab3fbd2aa9500b261e184049893dc6ca2010becac163053f211070bdda621b8bd8af77e450268603b52db34c90be836dfebddef42303f724e63bf0f"
              ; tag = "76e8dfd94db4af9d79d9718eec46cb2d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 106
              ; comment = "long message"
              ; key =
                  "424c6b22606fcc094ae82fc5d3cbe484174c2211b3ec778091cac34a8e38a152"
              ; msg =
                  "d96ff062e2490e8e0c54c5a8b89e85b25a66d93d7c2b93bdfef846b70d38672746a4b988d08f15a5c527ca4f2c80e53f7c6ac0521bc57ebe38209180cbf934e0bbeb58cfb63d75da64af41d09ce174af1896f42522910fced35ea000402e95fd3ac7aa6d5e0a6b533b0879bc466019b3a5e6b16e4bd1ea6cdfc9ccc1d6f0f0"
              ; tag = "eda709c7009714c372d0d6a63dfde469"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 107
              ; comment = "long message"
              ; key =
                  "15d553c8da433d53cdc7f15087a70349caab57b379a4078928ce9b99302e31a6"
              ; msg =
                  "d6c0c53b73f74fb426adfdc143d70db7f7a8f8ed32a2faef263cf9ab117537b6b9d1728bd1000c1f28906c6ce6ad21862bfa4d689c1a8ebe3868b992098b7f981b2af5189a6adedff53a6c70c83693f5c8d6385a9a8a4dca017c5716ac4d5b9765c5ca2ab5f9867e02795198c0b9527e07d08af52dbcb91ceb3d8b412a2b2402"
              ; tag = "8ca1402bf8fc23442ac2067be925b828"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 108
              ; comment = "long message"
              ; key =
                  "ffe559468a1031dfb3ced2e381e74b5821a36d9abf5f2e59895a7fdca0fa56a0"
              ; msg =
                  "238899a84a3cf15202a1fbef4741e133fb24c009a0cd83854c6d1d7c9266d4c3eafe6d1dfc18f13845ccdad7fe277627b5fd5ff2555ce6dfde1ee078540a0a3590c6d9bf2fb63ba9afbe9380e797be7cd017645c5a3613eef38ef89e3b7461e6e700ff2b4deef5636c9d2198b143f797ca1820a3dcc5d462ebf4a8c4c09eb202a23592eb9524082c79adda8fcd56d256041a26bf8f523962ba911ce5a5786570d65be3c4df722ed8830302065febdf944715298a1fbb7d10b68d7da2bf889324314ce51e815c7fbf03aa0a8358aff3a86eb7a33f9a4923660db3047e793bebb0c6918f4395d400381723fdae2832c36efc8e368a68f30f6351c3bc942cd560"
              ; tag = "a830b313f4936dea56a3aefd6a3ebe7d"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 109
              ; comment = "Flipped bit 0 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d28b42096d80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 110
              ; comment = "Flipped bit 0 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d9b99f2709a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 111
              ; comment = "Flipped bit 1 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d18b42096d80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 112
              ; comment = "Flipped bit 1 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "dab99f2709a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 113
              ; comment = "Flipped bit 7 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "538b42096d80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 114
              ; comment = "Flipped bit 7 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "58b99f2709a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 115
              ; comment = "Flipped bit 8 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38a42096d80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 116
              ; comment = "Flipped bit 8 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b89f2709a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 117
              ; comment = "Flipped bit 31 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42896d80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 118
              ; comment = "Flipped bit 31 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99fa709a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 119
              ; comment = "Flipped bit 32 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096c80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 120
              ; comment = "Flipped bit 32 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2708a3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 121
              ; comment = "Flipped bit 33 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096f80f45f826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 122
              ; comment = "Flipped bit 33 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f270ba3ca74172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 123
              ; comment = "Flipped bit 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f4df826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 124
              ; comment = "Flipped bit 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3caf4172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 125
              ; comment = "Flipped bit 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f836b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 126
              ; comment = "Flipped bit 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74162cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 127
              ; comment = "Flipped bit 71 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f026b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 128
              ; comment = "Flipped bit 71 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74972cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 129
              ; comment = "Flipped bit 77 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f824b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 130
              ; comment = "Flipped bit 77 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74170cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 131
              ; comment = "Flipped bit 80 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b45a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 132
              ; comment = "Flipped bit 80 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbf93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 133
              ; comment = "Flipped bit 96 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d4607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 134
              ; comment = "Flipped bit 96 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93834c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 135
              ; comment = "Flipped bit 97 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d7607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 136
              ; comment = "Flipped bit 97 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93804c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 137
              ; comment = "Flipped bit 103 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a955607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 138
              ; comment = "Flipped bit 103 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93024c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 139
              ; comment = "Flipped bit 120 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d5607de6"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 140
              ; comment = "Flipped bit 120 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93824c1f28"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 141
              ; comment = "Flipped bit 121 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d5607de5"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 142
              ; comment = "Flipped bit 121 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93824c1f2b"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 143
              ; comment = "Flipped bit 126 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d5607da7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 144
              ; comment = "Flipped bit 126 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93824c1f69"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 145
              ; comment = "Flipped bit 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f45f826b44a9d5607d67"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 146
              ; comment = "Flipped bit 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3ca74172cbe93824c1fa9"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 147
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d28b42096d80f45f836b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 148
              ; comment = "Flipped bits 0 and 64 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d9b99f2709a3ca74162cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 149
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42896d80f4df826b44a9d5607de7"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 150
              ; comment = "Flipped bits 31 and 63 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99fa709a3caf4172cbe93824c1f29"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 151
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d38b42096d80f4df826b44a9d5607d67"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 152
              ; comment = "Flipped bits 63 and 127 in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d8b99f2709a3caf4172cbe93824c1fa9"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 153
              ; comment = "all bits of tag flipped"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "2c74bdf6927f0ba07d94bb562a9f8218"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 154
              ; comment = "all bits of tag flipped"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "274660d8f65c358be8d3416c7db3e0d6"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 155
              ; comment = "Tag changed to all zero"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "00000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 156
              ; comment = "Tag changed to all zero"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "00000000000000000000000000000000"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 157
              ; comment = "tag changed to all 1"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 158
              ; comment = "tag changed to all 1"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "ffffffffffffffffffffffffffffffff"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 159
              ; comment = "msbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "530bc289ed0074df02ebc42955e0fd67"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 160
              ; comment = "msbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "58391fa789234af497ac3e1302cc9fa9"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 161
              ; comment = "lsbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = ""
              ; tag = "d28a43086c81f55e836a45a8d4617ce6"
              ; result = "invalid"
              ; flags = []
              }
            ; { tcId = 162
              ; comment = "lsbs changed in tag"
              ; key =
                  "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f"
              ; msg = "000102030405060708090a0b0c0d0e0f"
              ; tag = "d9b89e2608a2cb75162dbf92834d1e28"
              ; result = "invalid"
              ; flags = []
              }
            ]
        }
      ; { keySize = 128
        ; tagSize = 256
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 163
              ; comment = "short key"
              ; key = "a349ac0a9f9f74e48e099cc3dbf9a9c9"
              ; msg = ""
              ; tag =
                  "3a8437b877b75cc08a4d8d7559a8fc6869a58c713da63d1d4b350d59b597e30c"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 164
              ; comment = "short key"
              ; key = "ac686ba0f1a51b4ec4f0b30492b7f556"
              ; msg = "2fa43a14ae500507deb95ab5bd32b0fe"
              ; tag =
                  "008532a53d0c0ab22027ae249023375374e2239b959609e8339b05a15742a675"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 165
              ; comment = "short key"
              ; key = "73ef9ef1a4225e51e3c1db3ace1fa24f"
              ; msg =
                  "ffad380d9aabb0acede5c1bf112925cdfc3d379fc2376a4fe2644490d0430ac3"
              ; tag =
                  "9c7cb9f7c207ec46d1e3c55764731c4ab5ddbae4e1401e52a895df0cff4787c9"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { keySize = 128
        ; tagSize = 128
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 166
              ; comment = "short key"
              ; key = "e34f15c7bd819930fe9d66e0c166e61c"
              ; msg = ""
              ; tag = "1d765ab9e29892f7bfec2975ad4bc2dc"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 167
              ; comment = "short key"
              ; key = "e09eaa5a3f5e56d279d5e7a03373f6ea"
              ; msg = "ef4eab37181f98423e53e947e7050fd0"
              ; tag = "cfc19ec07902ec8be489606d8f40d172"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 168
              ; comment = "short key"
              ; key = "9bd3902ed0996c869b572272e76f3889"
              ; msg =
                  "a7ba19d49ee1ea02f098aa8e30c740d893a4456ccc294040484ed8a00a55f93e"
              ; tag = "ac50adad9785a89c7282d8ab881dc615"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { keySize = 520
        ; tagSize = 256
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 169
              ; comment = "long key"
              ; key =
                  "8a0c46eb8a2959e39865330079763341e7439dab149694ee57e0d61ec73d947e1d5301cd974e18a5e0d1cf0d2c37e8aadd9fd589d57ef32e47024a99bc3f70c077"
              ; msg = ""
              ; tag =
                  "f5bfb940561fb4db73ebba49bf2e4893bb0cca618a71b7ecf6aca38231e167ea"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 170
              ; comment = "long key"
              ; key =
                  "2877ebb81f80334fd00516337446c5cf5ad4a3a2e197269e5b0ad1889dfe2b4b0aaa676fac55b36ce3affc7f1092ab89c53273a837bd5bc94d1a9d9e5b02e9856f"
              ; msg = "ba448db88f154f775028fdecf9e6752d"
              ; tag =
                  "1690ed4180642899e0deb9ec2270374e8b0a484217f5a682c524316eca219b64"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 171
              ; comment = "long key"
              ; key =
                  "21178e26bc28ffc27c06f762ba190a627075856d7ca6feab79ac63149b17126e34fd9e5590e0e90aac801df09505d8af2dd0a2703b352c573ac9d2cb063927f2af"
              ; msg =
                  "7d5f1d6b993452b1b53a4375760d10a20d46a0ab9ec3943fc4b07a2ce735e731"
              ; tag =
                  "e542ac8ac8f364bae4b7da8b7a0777df350f001de4e8cfa2d9ef0b15019496ec"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ; { keySize = 520
        ; tagSize = 128
        ; xtype = "MacTest"
        ; tests =
            [ { tcId = 172
              ; comment = "long key"
              ; key =
                  "813e0c078c221375e80590ace6774eafd2d2c242350988d02efa550e05aecbe100c1b8bf154c932cf9e57177015c816c42bc7fbc71ceaa5328c7316b7f0f30330f"
              ; msg = ""
              ; tag = "bb6ab66f51e53fa086c9c61a26ca27e0"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 173
              ; comment = "long key"
              ; key =
                  "5713343096b0aaf0562a6b92c1a15535924160475a4e4233589159728c562e3b2ad96f740c6a4da2bc3f768ce98c9bd66bac28d1646ff592028c940d455f35eeb4"
              ; msg = "71712de2fac1fb855673bff72af64257"
              ; tag = "c18165b8b97db1ca5e2486a32b39731e"
              ; result = "valid"
              ; flags = []
              }
            ; { tcId = 174
              ; comment = "long key"
              ; key =
                  "7208afbecf5f1f34828f98b719414e280716de64f5edd1ae1c774153cd2022337bb20fade1b7856f1dbfd40e2b4307f1293ceff1692ee90d8c90b5fdf953ab01a5"
              ; msg =
                  "43b53302b604d613e62db002044a4782d572ac8fbd3cd0ece91b43bc52e18e98"
              ; tag = "2fecfe45d79339c57dddba68ab34f5f1"
              ; result = "valid"
              ; flags = []
              }
            ]
        }
      ]
  }
