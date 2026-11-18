# Global instructions for Claude Code

## Git commits

- **Atomic commits.** Each commit is one self-contained logical change: one concern per commit,
  never bundle unrelated changes. Split work into several commits before pushing (e.g. a module,
  its tests, the code that uses it, and docs about separate findings are separate commits when
  they are separate concerns). Each commit should leave the repo in a working state.
- **Conventional Commits** (Angular style, https://github.com/qoomon/git-conventional-commits):
  `type(scope)?: description`, imperative mood, lowercase description, no trailing period.
  Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`.
  Use `!` after the type for breaking changes. Use the body to explain *why* when it isn't obvious.
- A repo's own CLAUDE.md or commit hooks take precedence over these defaults.
