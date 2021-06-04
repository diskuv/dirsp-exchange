Building ProScript into OCaml
=============================

The [KBB2017]_ "Automated Verification for Secure Messaging Protocols
and Their Implementations: A Symbolic and Computational Approach" paper produced by the Prosecco research group has a
`source code repository called proscript-messaging <https://github.com/Inria-Prosecco/proscript-messaging>`_.
We call the paper's algorithm the "Kobeissi, Bhargavan and Blanchet" (KBB2017) algorithm
to both recognize the paper's authors and to avoid the use of the word "Signal" (which the Signal non-profit who
created the original algorithm has `protected with trademarks <https://github.com/libresignal/libresignal/issues/37#issuecomment-216975737>`_).
The KBB2017 algorithm describes how to integrate security algorithms like authenticated 1-on-1
conversation management with OCaml-based proof verification tools (ProScript and ProVerify) and a
runtime deployment target of Javascript.

**Why build ProScript into OCaml?** You can use OCaml for much more than handling 1-on-1
conversations; for example, KBB2017 does not cover group conversations or multi-device parties. So if you need multiple security
or privacy algorithms, writing those in a mixture of ProScript and/or OCaml and *delaying the conversion into your production languages*
(ex. OCaml can easily be converted into Javascript or integrated with C programs) make it relatively easy to verify proofs and
guarantee type safety between the algorithms. Said another way, why shoot yourself in the foot by not letting OCaml tooling
check all of your security and privacy data models?

There is OCaml documentation that discusses why ``proscript-messaging`` was chosen and how to use the ProScript generated
OCaml KBB2017 libraries. But in this documentation, we describe the *build process* of KBB2017 ProScript into OCaml,
with some general pointers if you are using your own ProScript algorithm.
So **you can** use the structure of this code for integrating ProScript into your own OCaml libraries. Read on.

Files
-----

*Security Engineers and Auditors: Everything that says "Unmodified" is a verbatim copy of the Prosecco source code. The git commit and authenticated timestamps are available in <diskuv-communicator-models>/dirsp-exchange/dirsp_exchange.mli*.

``kobeissi_bhargavan_blanchet.ml``
    **Auto-generated**. This is a ProScript-to-OCaml translation of ``proscript-messaging/ps/sp.js`` (aka KBB2017).
    Generated from the dirsp-ps2ocaml.exe program, with auto-formatting by ocamlformat.

``kobeissi_bhargavan_blanchet_intf.ml``
    **New content**. OCaml interface for ``proscript-messaging/ps/sp.js``, plus a few shims for functions that could
    not be auto-translated.

``proscript-messaging/TRANSLATING_PROSCRIPT_INTO_OCAML.rst``
    **New content**. The documentation you are reading now.

``proscript-messaging/pscl/pscl.js``
    **Unmodified**. Javascript implementation of the ProScript Cryptography Library. This has implementations
    of SHA256 and other core security primitives.

``proscript-messaging/pscl/dirsp_Dirsp_proscript_intf.ml``
    **New content**. OCaml interface for the ProScript runtime. This is an OCaml reimagining of the
    Javascript API implicit in ``pscl.js``.

``proscript-messaging/pscl/dirsp_proscript.mli``
    **New content**. Just includes the ``Dirsp_proscript_intf.ml``. This is an idiomatic way to share the same interfaces
    for external use (you!) and internal library use.

``proscript-messaging/pscl/dirsp_proscript.ml``
    **New content**. A hand-written OCaml implementation of the ProScript runtime. It mimics ``pscl.js``.

``proscript-messaging/ps/sp.js``
    **Unmodified**. ProScript implementation of what the Prosecco team calls the version 3 of the
    "Signal Protocol" (X3DH and Double Ratchet). We call it KBB2017.

``proscript-messaging/ps2pv/LICENSE``
    **Unmodified**. License file from the proscript-messaging team

``proscript-messaging/ps2pv/globals.ml``
    **Unmodified**. Global variables and common utility functions.

``proscript-messaging/ps2pv/lexer.ml``
    **Unmodified**. Lexical instructions for how to create tokens (ex. ``BOOL``, ``FUNCTION``, ``FINALLY``, ``IF``) from the ProScript dialect of JavaScript.

``proscript-messaging/ps2pv/ast.ml``
    **Unmodified**. The abstract syntax tree of ProScript. The tree contains the relevant details of ProScript that are necessary
    for recreating a proof with the author's ProVerif tool; it is **not** a perfect representation of ProScript. So we need
    to replace the lossiness (like losing arrays of hexadecimal constants).

``proscript-messaging/ps2pv/parser.mly``
    **Unmodified**. Instructions for how to produce the AST from the lexer.

``proscript-messaging/ps2pv/pretty.ml``
    **Unmodified**. Pretty-printer of the AST.

``proscript-messaging/ps2pv/_tags``
    **Unmodified**. Build instructions for the legacy ``ocamlbuild`` tool. It allows for building a legacy syntax and parser
    generators for OCaml called ``camlp4``, which is difficult to build with modern OCaml tooling.

``proscript-messaging/ps2pv/lexerror.ml``
    **New content**. Error utility functions to report lexical information (line and column) when there is an error.
    Similar to the Prosecco team's ``error.ml`` file, which is not included in this distribution.

``proscript-messaging/ps2pv/ast2ocaml.ml`` ``proscript-messaging/ps2pv/astpredicates.ml``
    **New content**. Translates the AST into OCaml source code.
    Similar to the Prosecco team's ``pretty.ml`` file; both of which walk the AST.

``proscript-messaging/ps2pv/ast2ocaml_tests.ml``
    **New content**. Tests for ``ast2ocaml.ml`` (ex. overflow/underflow compliance).

``proscript-messaging/ps2pv/dirsp_ps2ocamlcore.ml``
    **New content**. Parses source code into AST and translates via ``ast2ocaml.ml`` into OCaml.

``proscript-messaging/ps2pv/dirsp_ps2ocaml.ml``
    **New content**. A command-line driver. When you run ``dirsp-ps2ocaml.exe`` you are running this.

``proscript-messaging/.gitignore``
    **New content**. Which files are ignored for git

``proscript-messaging/.ocamlformat``, ``proscript-messaging/.ocamlformat-ignore``
    **New content**. Formatting instructions for new content.

``proscript-messaging/debug-parsing.mlt``
    **New content**. Instructions for ``utop`` to quickly begin a debug session.


How You Integrate
-----------------

Assuming you ran ``opam install dirsp-ps2ocaml`` and ``eval $(opam env)``, you can run ``dirsp-ps2ocaml``
from your shell.

Otherwise:

* Build the translator with ``dune build src-proscript/dirsp_ps2ocaml.exe``. That
  will produce a standalone executable at ``<dirsp-exchange>/_build/default/src-proscript/dirsp-ps2ocaml.exe``
  which you can run directly or use the shorthand ``dune exec src-proscript/dirsp_ps2ocaml.exe``.
* In everything that follows, use ``dune exec src-proscript/dirsp_ps2ocaml.exe`` wherever you see
  ``dirsp-ps2ocaml``.

The command line options are:

.. code-block:: text

    dirsp-ps2ocaml <proscript_file>
        [-a]
        [-i <ocaml_interface_module>]
        [-s <ocaml_shims_module>]
        (-p [<module_name>.]<parameter_name>:<parameter_type>)*
        -o <ocaml_output_file>

For KBB2017 this is automatically done by the build scripts, but we can invoke it by hand as follows:

.. code-block:: bash

    dirsp-ps2ocaml -- src-proscript/proscript-messaging/ps/sp.js \
        -p "them:t record_them" \
        -p "msg:t record_msg" \
        -p "Type_sendoutput.a:t record_sendoutput" \
        -o src-proscript/kobeissi_bhargavan_blanchet.ml

Here is what that command is doing:

1. Takes the ProScript file ``src-proscript/proscript-messaging/ps/sp.js`` and translates into an OCaml implementation at
   ``src-proscript/kobeissi_bhargavan_blanchet.ml``.
2. The implementation will rely on an `Interface File`_ (the ``.mli`` file)
3. The implementation will rely on an `Interface module`_ called
   ``Kobeissi_bhargavan_blanchet_intf`` (the naming is automatically derived from your ``-o`` option
   unless you use the ``-t`` option)
4. The implementation will rely on a `Shims module`_ called
   ``Kobeissi_bhargavan_blanchet_shims`` (the naming is automatically derived from your ``-o`` option
   unless you use the ``-s`` option)
5. Any ProScript function parameter with the name ``them`` will be annotated with the ``t record_them`` type
   defined in the OCaml interface module described later.
   Any ``msg`` parameter will be annotated with ``t record_msg``.
   And any ``a`` parameter in a module ``Type_sendoutput`` will be annotated with ``t record_sendoutput``.
   For example, the ProScript function

   .. code-block:: javascript

        tryDecrypt: function(myIdentityKey, myEphemeralKey, them, msg) { /* ... */ }

   becomes

   .. code-block:: ocaml

        let tryDecrypt myIdentityKey myEphemeralKey (them : t record_them) (msg : t record_msg) = begin (* ... *) end

    and

    .. code-block:: javascript

        const Type_sendoutput = {
            /* ... */
            assert: function(a) {
                /* ... */
            }
        };
        const Type_recvoutput = {
            /* ... */
            assert: function(a) {
                /* ... */
            }
        };

    becomes

    .. code-block:: ocaml

        module Type_sendoutput = struct
            (* ... *)
            let xassert (a : t record_sendoutput) = (* ... *)
        end
        module Type_recvoutput = struct
            (* ... *)
            let xassert a = (* ... *)
        end

Interface Module
~~~~~~~~~~~~~~~~

It is your responsibility to write the OCaml interface module. For KBB2017 we wrote
``src-proscript/kobeissi_bhargavan_blanchet_intf.mli``.

The interface module interface (``.mli`` file) has all the record types for any records your ProScript algorithm implicitly uses.

It also has any undefined parameter types that you use as annotations with the [(-p <parameter_name:parameter_type>)*] option.
- For example, with ``ps2ocaml -p "msg:t record_msg"`` you must have a ``type `a record_msg`` defined.
- For example, with ``ps2ocaml -p msg:string`` nothing is needed since ``string`` is built-in.
- For example, with ``ps2ocaml -p msg:Bigarray.int16_unsigned_elt`` nothing is needed since ``int16_unsigned_elt`` was specified with a named module ``Bigarray``.

An example you would include in the interface module that accounts for implicit record used in the following ProScript KBB2017 algorithm code

.. code-block:: javascript

    construct: function() {
        return {
            valid: false,
            ephemeralKey: Type_key.construct(),
            initEphemeralKey: Type_key.construct(),
            ciphertext: '',
            iv: Type_iv.construct(),
            tag: '',
            preKeyId: 0
        };
    }

is:

.. code-block:: ocaml

    type 'a record_msg =
        { valid : bool
        ; mutable ephemeralKey : 'a
        ; mutable initEphemeralKey : 'a
        ; ciphertext : 'a
        ; mutable iv : 'a
        ; tag : 'a
        ; preKeyId : int
        }

In addition you must define a ``PROTOCOL`` type that declares the signatures for any ProScript functions where OCaml can't infer their types, and
a ``PROTOCOLFUNCTOR`` and ``PROTOCOLMODULE`` that can instantiate it as follows:

.. code-block:: ocaml

    module type PROTOCOL = sig
        (** The type that will be used to represent contiguous bytes in the protocol; typically Bytes.t or Cstruct.t *)
        type t

        (** An internal type representing a decrypted AES message *)
        type t_aes_decrypted

        (* Everything else below is optional, unless OCaml can't compile because it needs a signature for a function *)

        module Type_key : sig
            val construct : 'a -> t
        end
    end

    module type PROTOCOLFUNCTOR = functor (ProScript : Dirsp_proscript.S) ->
        PROTOCOL with type t = ProScript.t

    module type PROTOCOLMODULE = sig
        module Make: PROTOCOL
    end

The ``PROTOCOL`` is also a great place to put in documentation!

Tip: You can instantiate your auto-translated module in ``utop`` and then ``#show`` it to generate a complete signature of your ProScript code. Use
that signature as your Protocol, replace any references to ``ProScript.t`` with ``t``, and then document each signature.

Interface File
~~~~~~~~~~~~~~

It is your responsibility to write the interface file. For KBB2017 we wrote
``src-proscript/kobeissi_bhargavan_blanchet.mli``.

Here is an example:

.. code-block:: ocaml

    (* filename: kobeissi_bhargavan_blanchet.mli *)

    (* Use whichever _intf module you defined earlier *)
    (** @inline *)
    include Kobeissi_bhargavan_blanchet_intf.PROTOCOLMODULE

Shims Module
~~~~~~~~~~~~

It is your responsibility to write the shims module. For KBB2017 we wrote
``src-proscript/kobeissi_bhargavan_blanchet_shims.ml``.

The shims module (``.ml`` file) needs to contain a ``Make`` functor that defines all functions in your ProScript algorithm
that can't be auto-translated into OCaml. Even if all functions can be auto-translated, the ``Make`` functor
must still exist.

Here is an example:

.. code-block:: ocaml

    (* filename: kobeissi_bhargavan_blanchet_shims.ml *)

    (* Use whichever _intf module you defined earlier *)
    include kobeissi_bhargavan_blanchet_intf

    module Make (ProScript : Proscript.S) : Protocol = struct
        (**
          In KBB2017, we had the following ProScript algorithm code that did not convert:

          {v
                const UTIL = {
                    newKeyPair: function(id) {
                        const priv = ProScript.Crypto.random32Bytes('aPK' + id);
                        return {
                            priv: priv,
                            pub: ProScript.Crypto.DH25519(priv, [
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09
                            ])
                        };
                    }
                }
           v}

           That Javascript function will be replaced by your hand-written [shim_UTIL_newKeyPair]
           in this module.
         *)

        let shim_UTIL_newKeyPair id =
            let priv = ProScript.Crypto.random32Bytes (ProScript.concat [ ProScript.of_string "aID"; id ]) in
            let byte = ProScript.elem_of_char in
            {
                priv = priv;
                pub = ProScript.crypto.xDH25519 priv (ProScript.of_elem_list [
                    byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00';
                    byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00';
                    byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00';
                    byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x00'; byte '\x09'
                ])
            }

FAQs
----

Question 1. How do I know I got the record types and the mutability right?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compile the code with ``dune build``. You can rely on OCaml's compile-time type safety.

If it doesn't compile, you are missing a record, you are missing a field, you have the wrong field type, or you didn't make the field
mutable.

Question 2. What is ``ProScript.t``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It represents what in ProScript would be the memory structure of a string.
The Ocaml type is hidden in ProScript.t, but may be an OCaml ``char array`` or it may be the more
efficient `bytes <https://ocaml.org/api/Bytes.html>`_ depending on the version of the ProScript
runtime.

*All* strings in your ProScript code replaced with ``ProScript.t`` in generated OCaml code. And *all*
lists of element accesses like:

.. code-block:: javascript

    return [ a[0], a[1], a[2] ];

will be converted to use ``ProScript.t``.

Question 3. What about the runtime safety of 'int' operations?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OCaml ints are machine and compiler specific sizes (ex. 32-bit) and are not normally checked for overflow.
However, the ps2ocaml code generator will generate overflow safety checks if you write a standalone ProScript
statement like:

.. code-block:: ocaml

    a.preKeyId + 1;

The generated code will insert an assertion that makes sure that the "+" operation will not overflow or underflow.
Look in the "assert" functions of ``ps/sp.js`` for ProScript examples, and then look in
``ps/kobeissi_bhargavan_blanchet.ml`` for the corresponding auto-generated overflow checks.

Question 4. How do I insert my own assertions?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Write a standalone ProScript equality statement like:

.. code-block:: ocaml

    a.valid === true;

and then use the ``-a`` option in ``dirsp-ps2ocaml.exe``.

Without the ``-a`` option an equality statement is used to constrain the types:

.. code-block:: ocaml

    (* OCaml will force the type of a.valid to be bool (either true or false) because of this line *)
    let _ = (a.valid = true |> ignore) in (* ... *)

but with ``-a`` enabled the equality statement is used to constrain the type and value:

.. code-block:: ocaml

    (* OCaml will force the type of a.valid to be bool _and_ check that a.valid is true because of this line *)
    let _ = if (a.valid = true) then () else raise (Invalid_argument "not (a.valid = true)") in (* ... *)

Question 5. How do I annotate function parameters with explicit types?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You may be forced to annotate if your ProScript code is
`sharing field names in multiple record types <https://dev.realworldocaml.org/records.html#reusing-field-names>`_.

When you run ``ps2ocaml``, use the ``-p`` option to map function parameter names to field types.

For example, if you have the ProScript code:

.. code-block:: javascript

    deriveSendKeys: function(them, myEphemeralKeyPriv) {
        return {
            sendKeys: sendKeys,
            kENC: myEphemeralKeyPriv[0]
        };
    }

then using

.. code-block:: bash

    dirsp-ps2ocaml.exe -p them:record_them ...

will produce the OCaml code:

.. code-block:: ocaml

    let deriveSendKeys (them : record_them) myEphemeralKeyPriv = begin
        {
            sendKeys = sendKeys;
            kENC = myEphemeralKeyPriv.(0)
        }
    end

The better option is to rename the field names so that the field names are unique across all records.

Debugging
---------

Enabling Stack Traces
~~~~~~~~~~~~~~~~~~~~~

Use ``OCAMLRUNPARAM=b dirsp-ps2ocaml``

IDE Debugging
~~~~~~~~~~~~~

`ocamlearlybird <https://github.com/hackwaly/ocamlearlybird>`_ can sometimes work with Visual Studio Code (it is an early release).
There is already a launch configuration available; just place a breakpoint in within the build directory (ex.
``_build/default/src-proscript/proscript-messaging/ps2pv/_build/ps2ocaml.ml``)

utop
~~~~

In your project directory (which holds the src-proscript/ subdirectory), run ``utop`` within Dune so that all the compiled libraries can be loaded:

.. code-block:: bash

    dune build
    utop

Then within your ``utop`` session you can explore the ProScript AST:

.. code-block:: ocaml

    #use "src-proscript/proscript-messaging/debug-parsing.mlt";;

    let ast = Ps2ocaml.parse "src-proscript/proscript-messaging/ps/sp.js" (Ps2ocaml.init_parsing_options ());;

    let only_Type_iv = List.find_opt (Ps2ocaml.is_Statement_of (Ps2ocaml.is_Const_with_identifier "Type_iv") ) ast;;

    let value_Type_iv = match only_Type_iv with | Some (`Statement (`Const _c, _), _) -> List.assoc "Type_iv" _c;;

    let fromBitstring = match value_Type_iv with | Some (`Object obj_prop_l, _) -> List.find_opt (Ps2ocaml.is_Property_with_identifier "fromBitstring") obj_prop_l;;

    let function_fromBitstring = match fromBitstring with Some (`Property (_id, _func), _) -> _func;;

    (* 1. Run something that may not work to your liking. In our example it is Astpredicates *)
    open Astpredicates;;
    is_ast_writable_with_letin_style (match function_fromBitstring with `Function (_fname, _fargs, _f), _loc -> _f) { skip_nested_functions=true };;

    (* 2. Edit the source code (ex. place the following inside is_ast_writable_with_letin_style in astpredicates.ml: Printf.printf "Hello!\n"; *)

    (* 3. Reload the source code *)
    #use "src-proscript/proscript-messaging/ps2pv/astpredicates.ml";;

    (* 4. Retest it *)
    is_ast_writable_with_letin_style (match function_fromBitstring with `Function (_fname, _fargs, _f), _loc -> _f) { skip_nested_functions=true };;

pscl.js and the ProScript API
=============================

We do _not_ use pscl.js in dirsp-exchange! PSCL is used as an API during ProVerif proof testing, and we use it as an API
(see the OCaml library ``dirsp-proscript``). There is a ``dirsp-proscript-mirage`` that uses the Mirage crypto libraries,
which themselves use a correct-by-construction implementation from `fiat-crypto <https://github.com/mit-plv/fiat-crypto>`_
for its elliptic curve functions.

We decided to abandon pscl.js after trying to compare its output with ours. Some cautionary notes:

1. Comparing dirsp-exchange's output to sp.js + pscl.js is a bit of a fool's errand. After burning two days trying
   to match results, I realized that pscl.js' DH25519 was non-standard. In fact, pscl.js is not used for the security
   proofs (the ProVerif translation will replace references to PSCL functions like DH25519). See comment about DH25519 in
   https://github.com/Inria-Prosecco/proscript-messaging/issues/1 ; I had likewise ran test vectors through pscl.js
   and its DH25519 failed.
2. It was difficult to understand which parameters to pscl.js need to be hex-encoded and which ones don't. And it _really_
   matters in JavaScript. In node.js, the ``new Buffer(some_variable, 'hex')`` construction used frequently in pscl.js
   will silently return an empty buffer if the input is not hex. For example, in crypto.ED25519.signature the Buffer-based
   hex decoding is used; supply values without hex encoding will cause the ``ProScript.crypto.ED25519Hash(sk)`` function
   to return empty. But inconsistently the ProVerif code does not hex encode that ``sk`` parameter. If pscl.js is going
   to be used, it needs to do a length check on the Buffer length (and node.js complains that "Buffer() is deprecated due
   to security and usability issues").
3. Completely as a reaction to hex-encoding ambiguities in pscl.js, nothing is expected to be hex encoded in
   ``dirsp-proscript``. Just raw bytes. The hex encoders ``toBitstring`` and ``fromBitstring`` in the first ProScript
   algorithm (sp.js; aka KBB2017) are still present however.

So there is no need for pscl.js, and you won't get matching results because the kinda critical Diffie-Hellman
implementation in pscl.js is non-standard and perhaps broken.

Final Sidethought: None of this affects the proof, but one suggestion for ProScript is to statically type or annotate
which parameters are hex-encoded. It is _way_ too easy to make a mistake where you pass in a hex encoded input to a
parameter that doesn't need hex encoding, or you hex encode something twice.

Now that the cautionary preamble is out of the way ... here is how you would run sp.js + pscl.js.

You'll need node.js v10+ installed.

Then:

.. code-block:: bash

    npm install --save-dev window hexy
    npm install --save-dev @peculiar/webcrypto # only needed if node.js v14 or earlier
    node --experimental-repl-await # or 'nvm exec 16.0 node --experimental-repl-await' depending on your installation

Within ``node``:

.. code-block:: javascript

    // EITHER: this section is for node.js v10-v14
    const getRandomValues = await require('get-random-values')

    // OR: this section is for node.js v15+ which has built-in (more vetted) webcrypto support
    const { getRandomValues } = await require('crypto').webcrypto

    // THEN continue with the following ...

    // Make an approximation of the browser
    const Window = await require('window')
    const { createHash, createHmac, createCipheriv, createDecipheriv } = await require('crypto');
    const window = new Window()
    window.crypto = { getRandomValues }
    const NodeCrypto = { createHash, createHmac, createCipheriv, createDecipheriv }

    // Load the Javascript files
    const fs = await require("fs")
    const pscl_js = fs.readFileSync('./src-proscript/proscript-messaging/pscl/pscl.js', 'utf8')
    eval(pscl_js)
    const sp_js = fs.readFileSync('./src-proscript/proscript-messaging//ps/sp.js', 'utf8')
    eval(sp_js.replaceAll(/\bconst /g,"var "))

    // Now you have access to the ProScript Cryptographic Library (pscl.js)
    // and the 'Signal Protocol'/KBB2017 (sp.js)
    ProScript.crypto.random16Bytes()
    Type_key.construct()
    const { hexy } = await require('hexy')
    hexy(Type_key.construct())

    // You can also override the random functions so you can do a
    // repeatable comparison between JavaScript and OCaml
    const firstByteMd5 = function(s) { return NodeCrypto.createHash('md5').update(s).digest()[0] }
    ProScript.crypto.random12Bytes = function(id) { const fb = firstByteMd5(id); return Array.from({length: 12}, () => fb) }
    ProScript.crypto.random16Bytes = function(id) { const fb = firstByteMd5(id); return Array.from({length: 16}, () => fb) }
    ProScript.crypto.random32Bytes = function(id) { const fb = firstByteMd5(id); return Array.from({length: 32}, () => fb) }

You can simulate a conversation between Alice and Bob:

.. code-block:: javascript

    const P   = ProScript
    const C   = P.crypto
    const E   = P.crypto.ED25519
    const U   = UTIL
    const T   = TOPLEVEL
    const KEY = Type_key
    const MSG = Type_msg

    let aliceIdentityKey  = U.newIdentityKey ("alice-identity")
    let aliceSignedPreKey = U.newKeyPair     ("alice-signed-prekey")
    let bobIdentityKey    = U.newIdentityKey ("bob-identity")
    let bobSignedPreKey   = U.newKeyPair     ("bob-signed-prekey")

    let aliceIdentityKeyPub        = aliceIdentityKey.pub
    let aliceIdentityDHKeyPub      = U.getDHPublicKey (aliceIdentityKey.priv)
    let aliceSignedPreKeyPub       = aliceSignedPreKey.pub
    let aliceSignedPreKeySignature = E.signature (KEY.toBitstring(aliceSignedPreKeyPub), aliceIdentityKey.priv, aliceIdentityKeyPub)
    let bobIdentityKeyPub          = bobIdentityKey.pub
    let bobIdentityDHKeyPub        = U.getDHPublicKey(bobIdentityKey.priv)
    let bobSignedPreKeyPub         = bobSignedPreKey.pub
    let bobSignedPreKeySignature   = E.signature (KEY.toBitstring(bobSignedPreKeyPub  ), bobIdentityKey.priv,   bobIdentityKeyPub)

    let alicePreKey   = U.newKeyPair     ("alice-prekey")
    let bobPreKey     = U.newKeyPair     ("bob-prekey")

    let alicePreKeyPub = KEY.toBitstring (alicePreKey.pub)
    let alicePreKeyId  = 1 /* the Id of alicePreKey */
    let bobPreKeyPub   = KEY.toBitstring (bobPreKey.pub)
    let bobPreKeyId    = 1 /* the Id of bobPreKey   */

    let aliceSessionWithBob = T.newSession(
        aliceSignedPreKey,
        alicePreKey,
        KEY.toBitstring (bobIdentityKeyPub),
        KEY.toBitstring (bobIdentityDHKeyPub),
        KEY.toBitstring (bobSignedPreKeyPub),
        bobSignedPreKeySignature,
        KEY.toBitstring (bobPreKeyPub),
        bobPreKeyId
        )
    let bobSessionWithAlice = T.newSession(
        bobSignedPreKey,
        bobPreKey,
        KEY.toBitstring (aliceIdentityKeyPub),
        KEY.toBitstring (aliceIdentityDHKeyPub),
        KEY.toBitstring (aliceSignedPreKeyPub),
        aliceSignedPreKeySignature,
        KEY.toBitstring (alicePreKeyPub),
        alicePreKeyId
        )

    let aliceToBobMsg1        = "Hi Bob!"
    let aliceToBobSendOutput1 = T.send(
        aliceIdentityKey,
        aliceSessionWithBob,
        aliceToBobMsg1
    )
    console.log(util.format("Did Alice send successfully? %s\n", aliceToBobSendOutput1.output.valid))

    let bobFromAliceMsg2           = aliceToBobSendOutput1.output
    let bobFromAliceReceiveOutput2 = T.recv(
      bobIdentityKey,
      bobSignedPreKey,
      bobSessionWithAlice,
      bobFromAliceMsg2,
    )
    console.log(util.format("Did Bob receive successfully? %s\n", bobFromAliceReceiveOutput2.output.valid))
    /* this should work, but doesn't */

.. [KBB2017]  Nadim Kobeissi, Karthikeyan Bhargavan, Bruno Blanchet.
    Automated Verification for Secure Messaging Protocols
    and Their Implementations: A Symbolic and Computational Approach.
    2nd IEEE European Symposium on Security and Privacy , Apr 2017, Paris, France.
    pp.435 - 450, 2017, <https://www.ieee-security.org/TC/EuroSP2017/>.
    <10.1109/EuroSP.2017.38>. <hal-01575923>
