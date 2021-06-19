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
(** For securing a conversation between two or more parties.

    {1 Summary}

    Dirsp is a short form for Diskuv Implementations of Research Security Protocols.
    The [dirsp-exchange] library has implementations of protocols published in the research
    field of the authenticated exchange of messages. It uses a [dirsp-proscript] library
    like [dirsp-proscript-mirage] to provide a runtime library of cryptographic primitives.

    At the moment this library is a no-op. The [dirsp-exchange-kbb2017] library is the first
    implementation of a secure two party protocol.
*)
