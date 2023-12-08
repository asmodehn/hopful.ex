# Hopful

Hopful is a library aiming to help you implement your own bimonadic data collections

As a background, you can get accustomed to directed containers and their uses, via the research of https://danel.ahman.ee/#publications

In day-to-day programming, the aspect that seems most important to me is their bimonadic structure, to cleanly read and write data from/to a collection, 
without adding extra unwanted semantics (empty container, etc.).
This in effect is making the structure somewhat "implicit" for the user in the end, given a proper interface is provided.

Bi-monadic here means 'with a monadic and a comonadic structure'. This is more accurately called a Hopf monad, since they are related to hopf algebras.
Hence, we will use this perspective as an attempt to structure the API of such kinds of collections.

This library is an attempt at studying these loosely defined, yet related, topics. Hopefully, some useful piece of code will come out of it.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hopful` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hopful, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/hopful>.

