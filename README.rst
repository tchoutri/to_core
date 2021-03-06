=================
To Core |license|
=================

This program takes a BEAM Bytecode (``.beam``) file as an argument, and outputs on ``stdout`` its `Core Erlang`_ representation

Installation
------------

.. code:: Shell

    $ MIX_ENV=prod mix escript.build
    $ cp to_core ~/.local/bin # OR mix escript.install --force


Usage
-----

.. code:: Shell

    $ to_core "_build/to/ebin/foo.beam"


Thanks again to Bryan Joseph (@bryanjos) :)


.. |license| image:: https://img.shields.io/badge/license-MIT-blue.svg
             :target: https://opensource.org/licenses/MIT
             :alt: MIT License

.. _`Core Erlang` : https://www.it.uu.se/research/group/hipe/cerl/doc/core_erlang-1.0.3.pdf 
