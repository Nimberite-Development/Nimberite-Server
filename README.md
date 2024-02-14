# Nimberite
The Nimberite MC server implementation in all its (probably buggy and incomplete) glory!~
Isn't this great? Look at what I've accomplished (with a lot of help)!

## Libraries Created
Here is a small overview of the libraries that I've created for use in Nimberite:

- [Pulse](https://github.com/Nimberite-Development/Pulse-Nim)
  - An event system library created by me, that works in a way I personally deem acceptable!

- [TagForge](https://github.com/Nimberite-Development/TagForge-Nim)
  - A maintained and up-to-date (yet still missing VarInt support) implementation of the
    NBT format! Credits also exist in the repo to see how I've implemented this, also
    thanks to the folk in the 'Nim' and 'Minecraft Protocol' discord servers, as well as
    the [wiki.vg](https://wiki.vg/Main_Page) contributors who documented the format!

- [ModernNet](https://github.com/Nimberite-Development/ModernNet)
  - A library I quickly threw together in 2022, polished a bit in 2023, and now working on
    improving in 2024! It's held together by ducktape and a dream, but it sure is something
    that helped me get rid of a *lot* of boilerplate, so it works for now! Again, the folks
    who contributed to wiki.vg sure *are* something haha!

# To-Do
Organised in order of priority:
- [ ] Clean Up
  - Need to make the code organised in a more reasonable and maintainable way,
    at the moment it is a complete mess and will become a pain to work with.

- [ ] Play Packets
  - Will be expanded as implemented to indicate completion.

- [ ] Test Suite
  - Need to automate tests somehow.

- [ ] Plugin System
  - A WASM plugin system would probably be ideal here.

- [ ] Implementation of Protocols as Plugins
  - Relies on the previous task, obviously. There's a lot of design choices that
    this will force me to think about and work on improving the plugin system for
    sure, right now I just need something *working* before splitting the networking
    code into a plugin(s).