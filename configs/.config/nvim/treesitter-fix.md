# Treesitter no-freeze note

## Why the cursor used to hang on `hjkl`

On this Neovim build, tree-sitter's "async" parse is not actually preemptible:
while parsing, the main thread is hard-blocked until the parse finishes
(a 12k-line C file measured ~800 ms–2.4 s with zero UI updates). Keys typed
during the freeze are queued and replayed afterwards, so the cursor *jumps*
to where it "would have been" once parsing completes.

The old config made it worse by:
- running `install()` + `vim.treesitter.start` on **every loaded buffer** at
  ~1 s after startup (right when you start typing), and
- starting treesitter synchronously inside the `FileType` event with no size
  limit.

## How the new config fixes it

1. **Plugin loads eagerly** (no `event = "VeryLazy"`) — the tiny query/parser
   library is loaded at startup, so the `FileType` autocommand exists **before**
   any file opens. This fixes files opened at launch (`nvim foo.cpp`) never
   getting treesitter: previously only registered after `VeryLazy` fired, i.e. too late for the
   first file's `FileType` event. `mapleader` is also set before `lazy.setup`
   so the eager config's `<leader>` mappings resolve to the real leader.
2. **Parsers build at `:Lazy` update time** (`build = ... :wait()`), never in
   the session — nothing installs while you edit. (`:TSUpdate` alone never
   installs the list; hence the explicit `install` in `build`.)
3. **Size gate** (`vim.g.ts_max_lines`, default 1200) — only buffers **larger
   than** 1200 lines are skipped (they keep regex `syntax` highlighting).
   Small files always get treesitter. The gate exists because parsing
   can't be made non-blocking on this build, so a very large file would freeze
   input for as long as parsing takes.
4. **`vim.defer_fn(..., 0)`** moves the (cheap ~10 ms) `start` out of the
   `FileType` callback stack, so it never delays file opening — and out of the
   `<leader>ts>` keymap, so the keypress returns instantly.
5. **`<leader>ts`** — toggle treesitter on/off per buffer, e.g. to enable it
   deliberately on a large file once it's loaded (still a one-time block, but
   only when you ask for it).
6. **Idle pre-warm** — after startup, each installed parser `.so` is loaded and
   its highlight/injection queries compiled once, spread across ~1.5 s in small
   chunks. The first open of any language then has ~zero overhead instead of a
   ~0.5 s one-time block (parser `dlopen` + query compile). Disable with
   `vim.g.ts_warm = false`.

Note: `vim.g.ts_max_lines` can be overridden in `init.lua` before the plugin
loads.