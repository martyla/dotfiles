# Local agent instructions

The rules defined here should take priority over any other rules defined
anywhere else.

## Grep/fd/ripgrep/find/etc

* Prefer usage of faster tools for grepping files, e.g. `rg`.
* Prefer not to use `find` in the root filesystem. We have a lot of files, and
  it's slow.
* Use short timeouts (up to 10 sec) for these search operations. If it times
  out, we want to reduce the search scope by using subdirectories or filters,
  rather than increasing the timeout.

## Git

* Freely use read-only git commands, e.g. `git show`, `git diff`, `git log`,
  `git status`.
* Do not use write commands like `git commit`, `git pull`, `git rebase`, unless
  you have explicitly confirmed with the user that you want to do this. This
  also applies to `gh` write based operations (comments, push, pull, etc.) - 
  do not use them unless the user explicitly has requested to.
* Prefer to use `git` directly over any MCP variants
* Prefer the `gh` tool to interact with github (e.g. listing/fetching PRs) over
  MCP variants. Useful for fetching PR information, etc

## Code & writing style

Follow the surrounding code's conventions first. Beyond that:

* Comments are the exception (~5% of lines). Names carry meaning; don't restate
  them. No Javadoc (or equivilent) on modules, DTOs, converters, tests,
  private fields, constructors, getters, or simple delegations. No comments
  above `@Test` methods.
* Comment the *why*, never the *what*: hidden contracts (null/missing-key
  semantics, idempotency), magic numbers (with a `Ref:` link or quoted source),
  non-obvious skips/fallbacks/retries, hacks, and test scenarios that encode a
  state (e.g. mid-migration, stale routing).
* Comments must stand alone with only the file open. Don't argue against
  alternatives not in the code ("lives here, not on X") or reference the
  conversation; that belongs in the PR description.
* Be brief: one sentence, ~6-10 words; join tightly-coupled clauses with `:`
  ("Patches never create records: a missing record is a 404"). Prefer
  single-line `/** ... */`; expand only for `@throws` or a second sentence.
  `@throws` states the condition; skip `@param`/`@return` when the name says it.
* Voice: full sentences, capitalised, trailing period. Backticks for
  identifiers in `//`, `{@code}` in Javadoc. Use `i.e.`/`e.g.`, `->` for
  mappings, CAPS for emphasis (`ONLY`, `NOT`). `TODO(name): ... once <removal
  condition>`.
* Class Javadoc only when the name doesn't reveal the role or a design
  decision: one sentence what-it-is + one sentence the non-obvious choice.
* Keep code simple over clever: early returns, plain `for` loops when
  accumulating or side-effecting, streams only for straight map/filter/collect.
  One-per-line chained builder calls. Small classes with a single role.
* Small, focused tests: one behaviour each, named
  `test<Method><Condition><Outcome>` (use `_` segments for 3+ clauses). Long
  tests get `// Given/When/Then:` (or `Setup/Execute/Verify`) labels with the
  expected *reason*; short ones get none. Do not add section-divider comments
  (e.g. `// ---- <topic> tests ----`); group related tests by ordering and
  blank lines instead. Assert individual fields (use captors) over whole-object
  equality; avoid `lenient()`.
* Log/exception messages: lowercase-first, terse, include ids as placeholders;
  suffix `, skipping` for deliberate no-ops ("media record does not exist: {},
  skipping").
* Commits/PRs: `<area>: <sub-area>: <imperative summary>`, all lowercase except
  backticked identifiers, compact notation (`25->100`, `` `a` -> `b` ``, `&`,
  `/`). Title max 72 chars. No body; keep changes small enough that the title
  suffices and stack them (protos -> repository -> read flow -> write flow ->
  wiring). Sub area optional only if relevant.

### Examples

Comments:

```java
// BAD: restates the code / the name
/** Repository for Hyperion. */
public class HyperionRepository {
  /** The client. */
  private final HyperionClient client;

  /**
   * Gets a batch.
   * @param keys the keys
   * @return the blobs
   */
  public Map<Key, Blob> getBatch(List<Key> keys) {
    // check if empty
    if (keys.isEmpty()) {
      return Map.of();
    }
    ...
  }
}

// GOOD: only the non-obvious contract and decision
/**
 * Thin wrapper around the Hyperion client for annotation payloads. Payloads are
 * opaque blobs, so the typed client is intentionally not used.
 */
public class HyperionRepository {
  // DynamoDB BatchGetItem has a limit of 100 items per request.
  // Ref: https://docs.aws.amazon.com/.../Constraints.html
  private static final int BATCH_GET_LIMIT = 100;

  private final HyperionClient client;

  /**
   * Fetches blobs keyed by Hyperion key. Every requested key has an entry; its
   * {@code data} is null when the record does not exist.
   *
   * @throws NotFoundException if an expected version is given and the record is missing
   */
  public Map<Key, Blob> getBatch(List<Key> keys) { ... }
}

// Inline: why, not what; one sentence; clauses joined with ; or :
// Must not fall back to update for non-conflict failures; framework will retry.
// Patches never create records: a missing record is a 404.
// TODO(martin): remove once server sends 409 responses.
```

Tests:

```java
// BAD: one test covering many behaviours, narrating comments, whole-object equality
@Test
public void testGetBatch() {
  // create keys
  ...
  // call get batch
  ...
  assertThat(result).isEqualTo(expectedMap);
  assertThatThrownBy(() -> repo.getBatch(tooMany)).isInstanceOf(BadRequestException.class);
}

// GOOD: one behaviour per test, name is the description, no comment needed when short
@Test
public void testGetBatchReturnsEmptyMapForNoKeys() {
  assertThat(repo.getBatch(List.of())).isEmpty();
  verifyNoInteractions(client);
}

@Test
public void testGetBatch_missingKey_returnsNullData() {
  when(client.batchGet(any(), any())).thenReturn(aResponseWithout(KEY));

  var blobs = repo.getBatch(List.of(KEY));

  var captor = ArgumentCaptor.forClass(BatchGetRequest.class);
  verify(client).batchGet(any(), captor.capture());
  assertThat(captor.getValue().namespace).isEqualTo("annotation");
  assertThat(blobs.get(KEY).data()).isNull();
}

// GOOD: long scenario test gets labels carrying the *reason*
@Test
public void testGetStrong_stalePrimary_readsFallback() {
  // Given: a partition mid-migration, where the key was written to the fallback
  // shard before the primary was promoted.
  ...
  // When: reading with STRONG consistency.
  ...
  // Then: fallback record is returned (primary is not yet authoritative).
  ...
}
```

Commits:

```
BAD:  Added batch get support to the Hyperion client and updated the callers
GOOD: hyperion: add `batchGet` to client lib
GOOD: media: swap to hyperion `batchGet` methods
GOOD: hyperion: increase batch get limit from 25->100
GOOD: annotation: protos: rename `partition` -> `brand`
```
