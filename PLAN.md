# PLAN.md - DeutchLernen: German Language Learning Application

## Metadata for LLM Agent

```yaml
project_name: DeutchLernen
app_module: DeutchLernen
web_module: DeutchLernenWeb
app_folder: deutch_lernen
language: Elixir
framework: Phoenix, Ash Framework
database: PostgreSQL (pre-configured via AshPostgres)
primary_goal: Build German language learning application with spaced repetition for B1/B2 certification
development_approach: Agile-Kanban, Test-driven, feature branch workflow, MVP-first
methodology: Agile with Sprints, Story Point estimation (Fibonacci), User acceptance testing
tools_required:
  - Elixir Review Agent
  - Tidewave MCP (pre-configured for AI-assisted UI design)
  - Ash AI MCP (pre-configured)
branch_strategy: Feature branches only, PR to main
quality_gate: mix precommit before PR
progress_tracking: Remove completed steps from this file
project_status: Repository initialized, dependencies installed, PostgreSQL configured, Tidewave MCP configured
target_proficiency: B1 and B2 German certification (CEFR)
current_sprint: Sprint 1
sprint_status: Planning
```

## CRITICAL: Agile Development Meta-Instructions for Agent

### Sprint Development Process

**AGENT: Follow this process religiously before implementing ANY feature:**

1. **Sprint Completion Check**
   - Before starting ANY task, verify if current Sprint is marked as COMPLETED
   - If current Sprint is COMPLETED, STOP immediately
   - Output message: "Sprint [N] is completed. Awaiting PROJECT OWNER approval for Sprint [N+1]."
   - DO NOT proceed with next Sprint until PROJECT OWNER explicitly approves

2. **Sprint Planning (Only with PROJECT OWNER approval)**
   - When PROJECT OWNER approves next Sprint, create detailed Sprint backlog
   - Break down each feature into granular tasks with Story Points
   - Identify dependencies and risks
   - Define clear acceptance criteria
   - Create todo list using TodoWrite tool before implementation

3. **User Acceptance Testing**
   - After completing Sprint, remind PROJECT OWNER to test
   - Document what needs testing
   - Wait for feedback before marking Sprint as COMPLETED
   - Do not proceed to next Sprint planning without approval

4. **Story Point Estimation (Fibonacci sequence)**
   - 1 point: Trivial (< 1 hour, no complexity)
   - 2 points: Simple (1-2 hours, minimal risk)
   - 3 points: Moderate (3-4 hours, some complexity)
   - 5 points: Complex (1 day, multiple files/tests)
   - 8 points: Very Complex (1-2 days, significant integration)
   - 13 points: Epic (2-3 days, requires breaking down)
   - 21+ points: TOO LARGE - must be decomposed

5. **Definition of Done**
   - Code written and reviewed (Elixir Review Agent)
   - All tests passing (unit + integration)
   - Documentation updated
   - `mix precommit` passes
   - PR created and merged
   - Feature tested by PROJECT OWNER

### MVP Philosophy

**Focus on Core Learning Loop:**
- Read German text → Click unknown words → Save with context → Review with spaced repetition
- Everything else is secondary to this loop
- Ship fast, iterate based on real user (PROJECT OWNER) feedback

## Important Verification Instructions for Agent

**Before implementing each step, you MUST:**

1. **Verify Ash Framework patterns** by checking all usage_rules loaded in your context with related deps and Elixir as a language. Confirm:
   - Elixir code is canonical and follows best community practices
   - Resource definition syntax matches current Ash conventions
   - Action definitions follow Ash best practices
   - Relationship declarations use correct Ash macros
   - Query patterns align with Ash query composition
   - Code interface generation follows Ash guidelines

2. **Verify Phoenix LiveView patterns** by checking Phoenix documentation:
   - Mount function signatures and return types
   - Handle_event callback patterns
   - Socket assign management
   - Form handling with Ash integration

3. **Verify Tidewave MCP usage** by checking the Tidewave documentation at https://hexdocs.pm/tidewave/mcp.html:
   - Tidewave is an MCP server, Check available tools and use it

4. **Check usage rules** for all libraries before writing code to ensure compatibility with current versions

When in doubt about any implementation detail, explicitly state: "Checking official documentation for [library/pattern]" and verify before proceeding.

---

## 📋 PRODUCT BACKLOG (Prioritized by MVP Value)

Legend:
- 🎯 MVP = Must have for minimum viable product
- 📦 Sprint# = Assigned sprint number
- 🔢 SP = Story Points (Fibonacci)
- ⏸️ FUTURE = Post-MVP, implement after user testing

---

## 🚀 SPRINT 1: Core Foundation & Basic Reading Flow
**Goal:** Enable user to read German text, save words with context, and see them in a simple list
**Story Points:** 49 SP (approximately 3-4 days of focused work)
**Status:** READY TO START (awaiting PROJECT OWNER approval)
**Alignment with REVIEW_ISSUES.md:** Focuses on comprehensible input (reading) first, not jumping to reviews

### Sprint 1 Acceptance Criteria
- [ ] User can add a German book to the system (via seeds)
- [ ] User can add German sentences to books (via seeds)
- [ ] User can view book with clickable words in browser
- [ ] User can click a word and save it with German grammatical info + English translation
- [ ] Saved words are stored in database with context (WordInstance)
- [ ] All tests pass, `mix precommit` succeeds
- [ ] PROJECT OWNER can test the reading flow end-to-end

### Sprint 1 Detailed Task Breakdown
1. **Domain Structure (5 SP)** - Foundation for all resources
2. **Book Resource (5 SP)** - Store reading materials with difficulty levels
3. **Sentence Resource (5 SP)** - Store German text with position tracking
4. **Word Resource (5 SP)** - Store German vocabulary with grammatical metadata (articles, gender, cases)
5. **Translation Resource (3 SP)** - English meanings for words
6. **WordInstance Resource (5 SP)** - Link words to sentences (critical for context-based learning)
7. **User Resource (3 SP)** - Basic user model (no auth yet)
8. **Base Layout (3 SP)** - Minimal responsive UI
9. **Reading View LiveView (13 SP)** - THE CORE FEATURE - clickable words, modal for saving
10. **Simple Seed Data (2 SP)** - Sample book and sentences for testing

**Total: 49 SP**

---

## Domain Structure and Core Foundation

### Step 1: Define Core Domain Structure 🎯 MVP | 📦 Sprint 1 | 🔢 5 SP

Establish the domain organization for the application following Ash best practices. Create separate domains for Content (reading materials), Vocabulary (German words and grammar), and Learning (user progress and spaced repetition).

**Agent: Before implementing, verify current Ash Domain syntax and registration patterns in the official Ash documentation.**

Branch name: `feat/domain-structure`

Create domain modules at `lib/deutch_lernen/content.ex`, `lib/deutch_lernen/vocabulary.ex`, and `lib/deutch_lernen/learning.ex`. Each domain should be an Ash Domain module using the `use Ash.Domain` macro. In Ash 3.0, domains ARE the API - there is no separate API module. Define code interfaces on each domain using the `resource` macro. Create the directory structure for resources under each domain at `lib/deutch_lernen/content/resources/`, `lib/deutch_lernen/vocabulary/resources/`, and `lib/deutch_lernen/learning/resources/`.

The Content domain manages German reading materials and their sentences. The Vocabulary domain handles German words with grammatical metadata specific to German (articles, gender, cases, verb conjugations). The Learning domain implements user progress tracking and the SM-2 spaced repetition algorithm for B1/B2 preparation.

Commit with message: "Create domain structure for Content, Vocabulary, and Learning"

Write tests in `test/deutch_lernen/content_test.exs`, `test/deutch_lernen/vocabulary_test.exs`, and `test/deutch_lernen/learning_test.exs` verifying each domain module loads correctly and follows current Ash patterns. Tests should validate that resources can be added to domains and queried through the domain code interfaces.

Commit with message: "Add tests for domain structure"

Create pull request to main branch after running `mix check`.

## Content Domain Implementation

### Step 2: Create Book Resource 🎯 MVP | 📦 Sprint 1 | 🔢 5 SP

Implement the Book resource for storing German reading materials suitable for B1 and B2 learners. Books represent authentic German texts from which learners will acquire vocabulary and grammar patterns.

**Agent: Verify current Ash resource definition syntax, attribute types, and action definitions in the Ash documentation before implementing.**

Branch name: `feat/book-resource`

Use Ash generators to create the Book resource. **Agent: Check if the correct generator command is `mix ash.gen.resource` or if it has changed.** Create the resource at `lib/deutch_lernen/content/resources/book.ex`. Define the resource using `use Ash.Resource` with the following structure:

Add attributes for `title` as a required string, `author` as an optional string, `difficulty_level` as a string enum with values "a2", "b1", "b2" for filtering content appropriate to learner level, `description` as optional text for book summaries, and `source_url` as an optional string. **Agent: Verify the correct syntax for defining attributes with required/optional status and enums in current Ash.**

Implement actions following Ash conventions. **Agent: Check if actions are defined with `actions do` block or another pattern.** Implement default CRUD actions or explicitly define create, read, update, and destroy actions. Add a custom read action to filter books by difficulty level for B1/B2 learners.

Define a code interface following Ash patterns. **Agent: Verify if code interface is defined using `code_interface do` block and check the correct syntax.**

Create the database migration. **Agent: Check if migrations are generated with `mix ash.codegen` or another command in current Ash.**

Commit with message: "Add Book resource with B1/B2 difficulty levels"

Write comprehensive tests in `test/deutch_lernen/content/resources/book_test.exs` covering creation with valid data, validation failures for missing required fields, querying all books, filtering by difficulty level, update operations, and destroy operations with constraint handling. Use ExMachina to create a book factory in `test/support/factories/content_factory.ex`.

Commit with message: "Add tests for Book resource"

Create pull request to main branch after running `mix check`.

### Step 3: Create Sentence Resource 🎯 MVP | 📦 Sprint 1 | 🔢 5 SP

Implement the Sentence resource for storing German sentences from books. Sentences are the primary unit of learning, providing context for vocabulary acquisition and grammatical pattern recognition essential for B1/B2 certification.

**Agent: Verify Ash relationship syntax, especially belongs_to patterns, in the official documentation.**

Branch name: `feat/sentence-resource`

Create the Sentence resource at `lib/deutch_lernen/content/resources/sentence.ex`. Add attributes for `text` as a required string containing the German sentence, `position` as a required positive integer for ordering within the book, `book_id` as a uuid reference, `translation` as an optional text field for storing English translation if the learner chooses to add it, and `grammar_notes` as optional text for noting specific B1/B2 grammar patterns like subjunctive, passive voice, or relative clauses.

**Agent: Verify the correct syntax for belongs_to relationships in Ash, including how to specify the destination resource and foreign key.**

Define a belongs_to relationship to Book. **Agent: Check if the syntax is `belongs_to :book, Content.Book` or if additional options are needed.** Ensure proper referential integrity.

Implement actions for create, read, update, and destroy. Add a custom read action `by_book_ordered` that accepts a book_id and returns sentences ordered by position. **Agent: Verify how to define custom read actions with arguments in current Ash.**

Add validations ensuring position is positive and text is not empty. **Agent: Check current Ash validation syntax.**

Create the database migration with an index on book_id.

Commit with message: "Add Sentence resource with Book relationship"

Write tests in `test/deutch_lernen/content/resources/sentence_test.exs` covering creation with valid book association, validation failures, custom query action, updating operations, cascade behavior, and handling duplicate positions. Update the factory.

Commit with message: "Add tests for Sentence resource"

Create pull request to main branch after running `mix check`.

## Vocabulary Domain Implementation

### Step 4: Create Word Resource for German 🎯 MVP | 📦 Sprint 1 | 🔢 5 SP

Implement the Word resource storing German words with comprehensive grammatical metadata required for B1/B2 proficiency. German requires tracking gender, case, plural forms, and verb conjugation patterns.

**Agent: Verify Ash attribute syntax, especially for enums and unique constraints.**

Branch name: `feat/word-resource`

Create the Word resource at `lib/deutch_lernen/vocabulary/resources/word.ex`. Add attributes for `lemma` as a required string (base form), `article` as an optional string enum with values "der", "die", "das" for German nouns (required for B1/B2), `word_type` as a required string enum with values "noun", "verb", "adjective", "adverb", "preposition", "conjunction", "pronoun", "separable_verb" (important for German), `gender` as an optional string enum with values "masculine", "feminine", "neuter" (critical for German grammar), `plural_form` as an optional string for noun plurals (essential for B1/B2), `verb_type` as an optional string enum with values "weak", "strong", "mixed", "modal", "irregular" for German verb conjugation patterns, `separable_prefix` as an optional string for German separable verbs (e.g., "an" in "ankommen"), and `level` as a string enum with values "a1", "a2", "b1", "b2" to track vocabulary difficulty.

**Agent: Verify how to define unique constraints in current Ash.** Add a unique constraint on lemma to prevent duplicates.

Implement CRUD actions plus a custom read action for searching by partial lemma match (autocomplete). **Agent: Check how to implement fuzzy search or pattern matching in Ash queries.**

Create the database migration with indexes on lemma and level.

Commit with message: "Add Word resource with German grammatical metadata"

Write tests in `test/deutch_lernen/vocabulary/resources/word_test.exs` covering creation of nouns with articles and gender, verbs with conjugation types, separable verbs, uniqueness constraint, querying by type and level, and search functionality. Create word factories for different types.

Commit with message: "Add tests for Word resource"

Create pull request to main branch after running `mix check`.

### Step 5: Create Translation Resource 🎯 MVP | 📦 Sprint 1 | 🔢 3 SP

Implement the Translation resource for storing German-to-English meanings. Multiple translations per word capture different contexts and nuances important for B1/B2 comprehension.

**Agent: Verify belongs_to relationship syntax and cascade delete behavior in Ash.**

Branch name: `feat/translation-resource`

Create the Translation resource at `lib/deutch_lernen/vocabulary/resources/translation.ex`. Add attributes for `word_id` as uuid reference, `english_text` as required string, `context_hint` as optional text explaining semantic nuance or usage context, and `example_usage` as optional text with German example sentence.

Define belongs_to relationship to Word with cascade delete. **Agent: Verify cascade delete configuration in Ash relationships.**

Implement CRUD actions and a custom read action `for_word` that retrieves all translations for a specific word.

Create the database migration with index on word_id.

Commit with message: "Add Translation resource with Word relationship"

Write tests in `test/deutch_lernen/vocabulary/resources/translation_test.exs` covering creation, querying by word, validation, updates, cascade deletion, and multiple translations per word. Update factories.

Commit with message: "Add tests for Translation resource"

Create pull request to main branch after running `mix check`.

### Step 6: Create WordInstance Resource 🎯 MVP | 📦 Sprint 1 | 🔢 5 SP

Implement the WordInstance resource linking word occurrences to specific sentences. This tracks where each German word appears, providing rich context for learning grammatical patterns at B1/B2 level.

**Agent: Verify compound unique constraint syntax in Ash.**

Branch name: `feat/word-instance-resource`

Create the WordInstance resource at `lib/deutch_lernen/vocabulary/resources/word_instance.ex`. Add attributes for `word_id` as uuid reference, `sentence_id` as uuid reference, `position_in_sentence` as integer for word ordering, `marked_as_new` as boolean defaulting to true, and `grammatical_case` as optional string enum with values "nominative", "accusative", "dative", "genitive" for tracking German case usage (critical for B1/B2).

Define belongs_to relationships to Word and Sentence. **Agent: Verify syntax for multiple belongs_to relationships in a single resource.**

Implement CRUD actions and custom read action `for_sentence_ordered` that retrieves word instances for a sentence ordered by position.

**Agent: Verify how to define compound unique constraints in current Ash.** Add compound unique constraint on word_id, sentence_id, and position_in_sentence.

Create the database migration with indexes on word_id and sentence_id.

Commit with message: "Add WordInstance resource with German case tracking"

Write tests in `test/deutch_lernen/vocabulary/resources/word_instance_test.exs` covering creation, querying, case tracking, uniqueness constraint, cascade behavior, and multiple occurrences. Update factories.

Commit with message: "Add tests for WordInstance resource"

Create pull request to main branch after running `mix check`.

## Learning Domain Implementation

### Step 7: Create User Resource 🎯 MVP | 📦 Sprint 1 | 🔢 3 SP

Implement a User resource for tracking individual learner progress toward B1/B2 certification. Each user has isolated learning data and preferences.

**Agent: Verify Ash attribute validation syntax, especially for email format.**

Branch name: `feat/user-resource`

Create the User resource at `lib/deutch_lernen/learning/resources/user.ex`. Add attributes for `username` as required string with unique constraint, `email` as optional string with email validation, `current_level` as string enum with values "a1", "a2", "b1", "b2" to track progress, and `target_level` as string enum defaulting to "b1" for goal setting.

**Agent: Verify how to add email format validation and unique constraints in Ash.**

Implement CRUD actions.

Create the database migration with unique index on username.

Commit with message: "Add User resource for B1/B2 learner tracking"

Write tests in `test/deutch_lernen/learning/resources/user_test.exs` covering creation, uniqueness, email validation, and queries. Create user factory in `test/support/factories/learning_factory.ex`.

Commit with message: "Add tests for User resource"

Create pull request to main branch after running `mix check`.

### Step 8: Create UserWordProgress Resource with SM-2 ⏸️ FUTURE | 📦 Sprint 2 | 🔢 13 SP

Implement the UserWordProgress resource with SuperMemo 2 algorithm for spaced repetition. This is the core learning engine for B1/B2 vocabulary acquisition.

**Rationale for Sprint 2:** Per REVIEW_ISSUES.md - focus MVP on comprehensible input (reading) first. Spaced repetition comes after user has content to review.

**Agent: Verify Ash custom action syntax, especially actions with calculations and side effects. Check how to implement complex business logic in Ash actions.**

Branch name: `feat/user-word-progress-sm2`

Create the UserWordProgress resource at `lib/deutch_lernen/learning/resources/user_word_progress.ex`. Add attributes for `user_id` as uuid reference, `word_id` as uuid reference, `interval` as integer defaulting to 1 (days until next review), `repetitions` as integer defaulting to 0, `ease_factor` as float defaulting to 2.5, `next_review_date` as date defaulting to today, `status` as string enum with values "new", "learning", "reviewing", "known" defaulting to "new", and `last_reviewed_at` as utc_datetime_usec (nullable).

Define belongs_to relationships to User and Word. Add compound unique constraint on user_id and word_id.

**Agent: This is critical - verify the current Ash pattern for implementing custom actions with business logic. Check if custom actions are defined in an `actions do` block and how to accept arguments and perform calculations.**

Implement a custom update action named `review_word` that accepts `quality` argument (integer 0-5) and implements SM-2 algorithm:

```
Calculate new_ease = ease_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
Clamp new_ease to minimum 1.3

If quality < 3:
  Reset repetitions to 0
  Set interval to 1
  Set status to "learning"
Else:
  Increment repetitions
  If repetitions == 1: interval = 1
  Else if repetitions == 2: interval = 6
  Else: interval = round(interval * new_ease)
  If repetitions > 2: status = "reviewing"

Set ease_factor to new_ease
Set next_review_date to today + interval days
Set last_reviewed_at to now
```

**Agent: Verify how to perform date arithmetic in Ash actions and how to access "today" or "now" in action context.**

Implement custom read action `due_for_review` that accepts `user_id` and returns UserWordProgress records where `next_review_date <= today` and `status != "known"`, ordered by next_review_date.

Implement custom update action `mark_as_known` that sets `status` to "known" and clears `next_review_date`.

Create the database migration with compound index on user_id and next_review_date, plus index on status.

Commit with message: "Add UserWordProgress with SM-2 algorithm"

Write comprehensive tests in `test/deutch_lernen/learning/resources/user_word_progress_test.exs` covering:
- Initial creation with defaults
- SM-2 calculations for quality ratings 0, 2, 3, 5
- Interval progression through multiple reviews
- Ease factor adjustments and clamping
- Status transitions
- Due for review query
- Mark as known action
- Unique constraint enforcement
- Complete review sequence simulation

Create factories for user word progress at different stages.

Commit with message: "Add comprehensive tests for SM-2 algorithm"

Create pull request to main branch after running `mix check`.

### Step 9: Create StudySession Resource ⏸️ FUTURE | 📦 Sprint 3 | 🔢 5 SP

Implement the StudySession resource for tracking learning sessions and B1/B2 exam preparation analytics.

**Rationale for Sprint 3:** Analytics are valuable but not required for MVP learning loop.

**Agent: Verify Ash attribute types for date, integer, and float fields.**

Branch name: `feat/study-session-resource`

Create the StudySession resource at `lib/deutch_lernen/learning/resources/study_session.ex`. Add attributes for `user_id` as uuid reference, `session_date` as date defaulting to today, `session_type` as string enum with values "reading", "review", "grammar_exercise", "writing_practice" for B1/B2 skill tracking, `duration_minutes` as optional integer, `words_reviewed` as integer defaulting to 0, `sentences_read` as integer defaulting to 0, `new_words_learned` as integer defaulting to 0, and `accuracy_percentage` as optional float.

Define belongs_to relationship to User.

Implement CRUD actions plus custom read actions `by_date_range` (accepts user_id, start_date, end_date) and `by_type` (accepts user_id, session_type).

**Agent: Verify how to implement date range filtering in Ash queries.**

Create the database migration with indexes on user_id and session_date.

Commit with message: "Add StudySession resource for B1/B2 tracking"

Write tests in `test/deutch_lernen/learning/resources/study_session_test.exs` covering session creation, date range queries, type filtering, statistics updates, and aggregations. Create factory.

Commit with message: "Add tests for StudySession resource"

Create pull request to main branch after running `mix check`.

## Phoenix LiveView Implementation

### Step 10: Create Base Layout 🎯 MVP | 📦 Sprint 1 | 🔢 3 SP

Set up Phoenix LiveView layout with responsive design. Use Tidewave MCP through the AI protocol to design UI components with Tailwind CSS.

**Agent: READ the Tidewave MCP documentation at https://hexdocs.pm/tidewave/mcp.html CAREFULLY. Tidewave is an MCP server for AI-assisted UI design, NOT a CSS framework. You should use the Tidewave MCP to help design Tailwind CSS classes, but you're actually writing standard Phoenix templates with Tailwind.**

Branch name: `feat/base-layout`

Create root layout at `lib/deutch_lernen_web/components/layouts/root.html.heex` with semantic HTML structure, responsive navigation header, and main content area. Create app layout at `lib/deutch_lernen_web/components/layouts/app.html.heex` with navigation links to Books, Review (Wiederholen), Progress (Fortschritt), Grammar (Grammatik), and Settings (Einstellungen).

**Agent: Use Tidewave MCP through the AI protocol to help design the Tailwind CSS classes for these layouts. Request design assistance for: responsive navigation, mobile-friendly menus, proper spacing and typography for a learning application.**

Use standard Tailwind CSS utility classes in the HTML templates. Implement mobile-first responsive design with appropriate breakpoints.

Commit with message: "Set up base layout with responsive design"

Test manually by starting Phoenix server and verifying rendering at different viewport sizes.

Create pull request to main branch after running `mix check`.

### Step 11: Implement Book List LiveView ⏸️ FUTURE | 📦 Sprint 1 | 🔢 0 SP (SIMPLIFIED IN MVP)

**MVP DECISION:** Skip complex book management UI. For Sprint 1, add books via IEx console or seeds.

**Sprint 2+ Full Implementation:**
Create LiveView for displaying and managing German reading materials filtered by B1/B2 difficulty.

**Agent: Verify current Phoenix LiveView mount and handle_event callback patterns. Check Phoenix.LiveView documentation for correct function signatures.**

Branch name: `feat/book-list-liveview`

Create `lib/deutch_lernen_web/live/book_live/index.ex` as LiveView module.

**Agent: Verify the correct LiveView mount callback signature and return tuple format in Phoenix.LiveView documentation.**

Implement mount to load books using Ash API, potentially filtering by difficulty level. Create template at `lib/deutch_lernen_web/live/book_live/index.html.heex` displaying books in responsive grid with title, author, difficulty level, and description.

Add form for creating new books with fields for title, author, difficulty level (dropdown with A2/B1/B2), description, and source URL.

**Agent: Verify how to integrate Ash with Phoenix forms in LiveView. Check if there's an AshPhoenix.Form helper or similar.**

Implement handle_event for form submission that creates books through Ash API.

**Agent: Use Tidewave MCP to design the book grid layout and form styling with Tailwind CSS.**

Add routing in `lib/deutch_lernen_web/router.ex` under `/books` scope.

Commit with message: "Add Book list LiveView with B1/B2 filtering"

Write LiveView tests in `test/deutch_lernen_web/live/book_live/index_test.exs` covering rendering, filtering, creation, validation errors, and state updates.

**Agent: Verify current Phoenix.LiveViewTest patterns for testing LiveView pages.**

Commit with message: "Add tests for Book list LiveView"

Create pull request to main branch after running `mix check`.

### Step 12: Implement Reading View LiveView 🎯 MVP | 📦 Sprint 1 | 🔢 13 SP

Create the core reading interface for interacting with German text, clicking words, and adding translations. This is the primary B1/B2 vocabulary acquisition interface.

**THIS IS THE CORE MVP FEATURE** - Enables the fundamental learning loop from REVIEW_ISSUES.md.

**Agent: Verify Phoenix LiveView hook patterns for JavaScript interop and modal component patterns.**

Branch name: `feat/reading-view-liveview`

Create `lib/deutch_lernen_web/live/reading_live/show.ex` as LiveView accepting book_id parameter. Implement mount to load book and sentences with efficient preloading.

**Agent: Verify Ash preloading syntax for loading nested relationships efficiently.**

Create template at `lib/deutch_lernen_web/live/reading_live/show.html.heex` displaying book title and sentences with words as clickable spans.

Implement Phoenix LiveView JavaScript hook for word click events that captures word text, position, and sentence context.

**Agent: Verify current Phoenix LiveView JS hook patterns and how to send events from hooks to the server.**

Add handle_event for word clicks that opens modal dialog.

Create word interaction modal component at `lib/deutch_lernen_web/live/reading_live/word_modal.ex` displaying:
- German word prominently
- Form for English translation
- Word type selector (noun, verb, etc.)
- Article selector for nouns (der/die/das)
- Gender selector (masculine/feminine/neuter)
- Verb type for verbs (weak/strong/mixed/modal)
- Separable prefix input for separable verbs
- Plural form input for nouns
- Case selector (nominative/accusative/dative/genitive) for this occurrence
- Buttons for "Mark as New" and "Mark as Known"

Implement handle_event for form submission that:
1. Creates/finds Word record by lemma (upsert)
2. Creates Translation record
3. Creates WordInstance with case information
4. Initializes UserWordProgress

**Agent: Verify how to perform atomic multi-resource operations in Ash. Check if there's a transaction or batch operation pattern.**

For "Mark as Known": creates Word, WordInstance, and UserWordProgress with status "known".

**Agent: Use Tidewave MCP to design the modal styling and form layout with Tailwind CSS.**

Add routing for `/books/:id/read`.

Commit with message: "Add Reading view with German grammar tracking"

Write LiveView tests in `test/deutch_lernen_web/live/reading_live/show_test.exs` covering rendering, word clicks, form submission, word creation, case tracking, and database state verification. Test both new word creation and existing word association.

Commit with message: "Add tests for Reading view"

Create pull request to main branch after running `mix check`.

### Step 13: Implement Review Session LiveView ⏸️ FUTURE | 📦 Sprint 2 | 🔢 8 SP

Create spaced repetition review interface for B1/B2 vocabulary practice using SM-2 algorithm.

**Rationale:** Per REVIEW_ISSUES.md, focus on comprehensible input first. Review comes after user has collected vocabulary.

**Agent: Verify LiveView patterns for sequential state management and handling queue-based workflows.**

Branch name: `feat/review-session-liveview`

Create `lib/deutch_lernen_web/live/review_live/session.ex` as LiveView. Implement mount to query due words using `due_for_review` action, loading Word, Translation, and example sentences via WordInstance relationships.

**Agent: Verify efficient preloading patterns in Ash for nested relationships.**

Store word queue in socket assigns.

Create template at `lib/deutch_lernen_web/live/review_live/session.html.heex` displaying:
- German word lemma prominently
- Word type, article, gender
- "Antwort zeigen" (Show Answer) button
- After reveal: translations, grammatical info, up to 3 example sentences with word highlighted
- Quality rating buttons: "Nochmal" (0), "Schwer" (2), "Gut" (3), "Einfach" (5)

Implement handle_event for "show_answer" that reveals content without progressing.

Implement handle_event for quality ratings that:
1. Calls `review_word` action with quality
2. Updates/creates StudySession with stats
3. Loads next word or shows completion

Track session stats: words reviewed, quality ratings, duration.

**Agent: Use Tidewave MCP to design the review card layout with clear visual hierarchy and mobile-friendly buttons.**

Add routing for `/review`.

Commit with message: "Add Review session with SM-2"

Write LiveView tests in `test/deutch_lernen_web/live/review_live/session_test.exs` covering due word loading, reveal, quality submission, SM-2 verification, progression, completion, and StudySession creation.

Commit with message: "Add tests for Review session"

Create pull request to main branch after running `mix check`.

### Step 14: Implement Progress Dashboard LiveView ⏸️ FUTURE | 📦 Sprint 3 | 🔢 8 SP

Create dashboard for B1/B2 exam preparation tracking with comprehensive statistics.

**Rationale:** Nice to have, but not needed for basic reading loop.

**Agent: Verify if there are Ash aggregation or calculation helpers for efficient statistics queries.**

Branch name: `feat/progress-dashboard-liveview`

Create `lib/deutch_lernen_web/live/progress_live/dashboard.ex` as LiveView. Implement mount to calculate statistics:
- Total words encountered
- Words by status (new/learning/reviewing/known)
- Words by level (A1/A2/B1/B2)
- Words due today
- Study sessions this week by type
- Total sentences read
- Books started
- Study time stats

**Agent: Check Ash documentation for efficient aggregate queries and calculations. Verify if Ash has built-in aggregation features or if you should use custom calculations.**

Create template at `lib/deutch_lernen_web/live/progress_live/dashboard.html.heex` with sections:
- Vocabulary stats (total, mastered, learning, due)
- Level breakdown (A1/A2/B1/B2 word counts)
- Reading stats (sentences, books)
- Study stats (sessions, time, accuracy)
- B1/B2 readiness indicators

**Agent: Use Tidewave MCP to design dashboard grid with responsive cards, clear typography for metrics, and appropriate use of color for different stat types.**

Add routing for `/progress`.

Consider simple SVG visualizations for trends.

Commit with message: "Add Progress dashboard for B1/B2 tracking"

Write LiveView tests in `test/deutch_lernen_web/live/progress_live/dashboard_test.exs` covering statistics calculations, empty state, level filtering, and accurate aggregations.

Commit with message: "Add tests for Progress dashboard"

Create pull request to main branch after running `mix check`.

### Step 14.5: Add Simple Seed Data 🎯 MVP | 📦 Sprint 1 | 🔢 2 SP

Create minimal seed data to test the reading flow.

Branch name: `feat/mvp-seeds`

Create `priv/repo/seeds.exs` with:
1. One sample user (username: "learner", email: "test@example.com")
2. One book: "Café in Berlin" by André Klein (B1 level)
3. 5-10 simple German sentences from the book
4. NO words pre-populated (user will add them via UI)

Make seeds idempotent using upserts.

Commit with message: "Add MVP seed data for testing"

Test by running `mix run priv/repo/seeds.exs` and verifying via IEx.

Create pull request to main branch after running `mix check`.

---

## Terminal CLI Implementation

### Step 15: Create CLI Structure ⏸️ FUTURE | 📦 Sprint 4 | 🔢 8 SP

Implement command-line interface for terminal-based vocabulary interaction.

**Agent: Verify escript configuration in mix.exs and main function requirements.**

Branch name: `feat/cli-structure`

Create `lib/deutch_lernen/cli.ex` as main CLI module. Configure escript in `mix.exs`:

**Agent: Verify current escript configuration syntax in Mix.Project documentation.**

Implement main function with interactive loop using IO.gets. Create command parser recognizing:
- `add word` - create vocabulary entry
- `add sentence` - add reading content
- `review` - start practice session
- `progress` - display statistics
- `help` - show commands
- `exit` - quit

Implement command handlers calling Ash API:
- `add word`: prompt for lemma, article, word type, grammatical info, translation → create Word + Translation
- `add sentence`: prompt for book selection/creation, text → create Sentence
- `review`: delegate to review session (next step)
- `progress`: query and display statistics

Use IO.puts with ANSI color codes for formatted output.

Commit with message: "Add CLI with command parsing"

Write tests in `test/deutch_lernen/cli_test.exs` covering command parsing, execution, error handling, and output using capture_io.

Commit with message: "Add tests for CLI"

Create pull request to main branch after running `mix check`.

### Step 16: Implement Terminal Review Session ⏸️ FUTURE | 📦 Sprint 4 | 🔢 5 SP

Add interactive review session to CLI using SM-2 algorithm.

Branch name: `feat/cli-review-session`

Extend `lib/deutch_lernen/cli.ex` with review_session function accepting user parameter.

Query due UserWordProgress records with preloaded Word, Translation, and example sentences.

For each word:
1. Display German lemma, article, word type, gender
2. Prompt user to recall (press Enter)
3. Reveal translations and 3 example sentences with ANSI highlighting
4. Prompt for quality rating 0-5 with descriptions
5. Call `review_word` action
6. Display feedback: new interval, next review date, status
7. Track session stats

Display session summary: words reviewed, average quality, study time, encouraging message in German.

Create/update StudySession record.

Commit with message: "Add terminal review session"

Write tests in `test/deutch_lernen/cli/review_session_test.exs` covering review flow, rating parsing, SM-2 updates, completion, and StudySession creation using capture_io.

Commit with message: "Add tests for terminal review"

Create pull request to main branch after running `mix check`.

## Anki Integration

### Step 17: Implement Anki Export ⏸️ FUTURE | 📦 Sprint 5 | 🔢 13 SP

Create Anki .apkg export functionality preserving SM-2 state for learners who prefer Anki.

**Agent: Research Anki .apkg format specification and SQLite schema requirements before implementing. Note: Anki uses SQLite for its .apkg files, but we query data from our PostgreSQL database.**

Branch name: `feat/anki-export`

Create `lib/deutch_lernen/anki/exporter.ex` module. Add SQLite library dependency if not present (for generating Anki's SQLite-based .apkg files).

**Agent: Verify available Elixir SQLite libraries for creating the Anki export files (Anki format requires SQLite).**

Implement `export_user_vocabulary/1` accepting user_id:
1. Query UserWordProgress with Word and Translation preloaded from PostgreSQL
2. Create Anki collection SQLite database for export (schema: col, notes, cards, revlog tables)
3. Generate notes: front = German word + article + gender, back = translations + examples + grammatical info
4. Map SM-2 state: interval → Anki interval, ease_factor * 1000 → Anki ease, next_review_date → Anki due
5. Package into .apkg (zip with .apkg extension)

Add LiveView at `lib/deutch_lernen_web/live/export_live/anki.ex` with export UI showing word count, learning status, compatibility notes.

Implement download action using Phoenix send_download.

Add routing for `/export/anki`.

Commit with message: "Add Anki export with SM-2 preservation"

Write tests in `test/deutch_lernen/anki/exporter_test.exs` covering .apkg generation, database structure, note content, scheduling mapping, empty data handling, and format validation.

Commit with message: "Add tests for Anki export"

Create pull request to main branch after running `mix check`.

## Browser Extension API

### Step 18: Create Browser Extension API Endpoint ⏸️ FUTURE | 📦 Sprint 5 | 🔢 8 SP

Implement Phoenix API endpoint for browser extension to capture German sentences from web browsing.

**Agent: Verify Phoenix JSON API controller patterns and CORS configuration with cors_plug.**

Branch name:
name: `feat/browser-extension-api`

Create `lib/deutch_lernen_web/controllers/api/sentence_controller.ex` as JSON API controller.

**Agent: Verify current Phoenix controller patterns, especially for JSON APIs. Check if Phoenix.Controller provides specific helpers for JSON responses.**

Implement create action accepting JSON payload:
- Required: `sentence_text` (German sentence), `language` (should be "de")
- Optional: `source_url`, `book_title`, `page_title`, `selected_word`

Validate payload:
- sentence_text present and non-empty
- language is "de"
- source_url properly formatted if provided

Implement logic:
1. Find or create Book: use book_title or default "Browser Sammlung" (Browser Collection)
2. Create Sentence: link to book with next position
3. Parse sentence: split on whitespace (basic initial implementation)
4. Create WordInstance records for each word
5. If selected_word provided, mark that WordInstance specially

**Agent: Verify how to perform multiple Ash resource creations in a single request efficiently. Check if Ash provides batch or bulk creation patterns.**

Return JSON: `{status: "success", sentence_id: <id>, word_count: <n>, word_instances: [ids]}`

Add API routes under `/api/v1/sentences` with POST endpoint.

Configure CORS using cors_plug:

**Agent: Verify current cors_plug configuration syntax and options for allowing browser extension requests.**

```elixir
plug CORSPlug, origin: ["chrome-extension://*", "moz-extension://*"]
```

Implement API authentication:
- Add `api_token` attribute to User resource
- Add token generation function
- Create authentication plug checking bearer token
- Require authentication for API endpoints

**Agent: Verify Phoenix plug patterns for authentication and how to extract bearer tokens from headers.**

Commit with message: "Add browser extension API with authentication"

Write controller tests in `test/deutch_lernen_web/controllers/api/sentence_controller_test.exs` covering:
- Successful creation with valid payload
- Book creation/reuse logic
- Word instance generation
- Authentication validation (valid token, invalid token, missing token)
- CORS headers presence
- Error handling (missing fields, invalid language, malformed data)
- Edge cases (long sentences, special characters)

**Agent: Verify Phoenix.ConnTest patterns for testing JSON API controllers and authentication.**

Commit with message: "Add tests for browser extension API"

Create pull request to main branch after running `mix check`.

### Step 19: Document Browser Extension ⏸️ FUTURE | 📦 Sprint 5 | 🔢 2 SP

Create comprehensive documentation for building browser extension that integrates with the API.

Branch name: `feat/browser-extension-docs`

Create `docs/browser_extension.md` with specifications:

1. **API Integration**
   - Endpoint URL structure: `POST /api/v1/sentences`
   - Authentication: Bearer token in Authorization header
   - How to obtain tokens (user settings page)

2. **JavaScript Implementation**
   - Capturing selected text with Selection API
   - Extracting surrounding context (paragraph or sentence boundaries)
   - Detecting language (basic heuristics or browser API)
   - JSON payload structure with all fields

3. **Extension Architecture**
   - manifest.json for Chrome/Firefox with required permissions:
     - `activeTab` for page content access
     - `storage` for token persistence
     - Host permissions for API endpoint
   - Content script for text selection
   - Background script for API communication
   - Popup UI for settings and feedback

4. **User Interaction Patterns**
   - Context menu integration (right-click → "Zu DeutchLernen hinzufügen")
   - Keyboard shortcut for quick capture
   - Visual feedback (notification, badge)
   - Error handling (network errors, auth failures)

5. **Example Code**
   ```javascript
   // Example fetch to API
   fetch('https://api.german-lerner.app/api/v1/sentences', {
     method: 'POST',
     headers: {
       'Content-Type': 'application/json',
       'Authorization': `Bearer ${token}`
     },
     body: JSON.stringify({
       sentence_text: selectedText,
       source_url: window.location.href,
       page_title: document.title,
       language: 'de'
     })
   })
   ```

6. **CORS and Security**
   - CORS preflight handling
   - Token storage security (encrypted storage)
   - HTTPS requirements

Commit with message: "Add browser extension documentation"

No tests required (documentation only).

Create pull request to main branch after running `mix check`.

## Additional Features and Polish

### Step 20: Add Development Seeds ⏸️ FUTURE | 📦 Sprint 3 | 🔢 5 SP

Create seed data with realistic German content for B1/B2 learners.

Branch name: `feat/development-seeds`

Create `priv/repo/seeds.exs` with comprehensive German seed data:

1. **Books** (B1/B2 level)
   - "Die Verwandlung" by Franz Kafka (B2)
   - "Der Vorleser" by Bernhard Schlink (B2)
   - "Tschick" by Wolfgang Herrndorf (B1)
   - "Café in Berlin" by André Klein (B1)

2. **Sentences** covering B1/B2 grammar:
   - Perfekt and Präteritum (past tenses)
   - Konjunktiv II (subjunctive)
   - Passiv (passive voice)
   - Relativsätze (relative clauses)
   - Kausalsätze (causal clauses with weil/da/denn)
   - Finalsätze (purpose clauses with damit/um...zu)

3. **Words** with German grammar:
   - Nouns with articles: der Tisch, die Lampe, das Buch
   - Strong verbs: gehen/ging/gegangen, sehen/sah/gesehen
   - Weak verbs: machen/machte/gemacht
   - Modal verbs: können, müssen, dürfen, sollen, wollen, mögen
   - Separable verbs: ankommen, aufstehen, mitnehmen
   - Adjectives with comparison: gut/besser/am besten
   - Common prepositions with cases: für (Akk), mit (Dat), wegen (Gen)

4. **Translations** in English with context hints

5. **Sample Users** for testing

6. **UserWordProgress** at various stages:
   - New words (repetitions=0, interval=1)
   - Learning (repetitions=1-2, interval=1-6)
   - Reviewing (repetitions>2, interval=10-60)
   - Known words

7. **StudySession** records across dates for progress visualization

Use Ash API calls for all data creation. Make seeds idempotent.

**Agent: Verify efficient bulk creation patterns in Ash if available, or use loops with proper error handling.**

Commit with message: "Add German B1/B2 development seed data"

Test manually: run `mix run priv/repo/seeds.exs` and verify data in LiveView interfaces.

Create pull request to main branch after running `mix check`.

### Step 21: Add User Authentication ⏸️ FUTURE | 📦 Sprint 3 | 🔢 13 SP

Implement authentication for multi-user support with isolated progress.

**Agent: Verify Phoenix authentication patterns. Consider if Phoenix 1.7+ has built-in auth generators or if manual implementation is needed.**

Branch name: `feat/user-authentication`

Add `bcrypt_elixir` dependency.

**Agent: Verify current bcrypt_elixir version and API in documentation.**

Extend User resource:
- Add `password_hash` attribute (string, private, never returned in queries)
- Add `api_token` attribute (string, for browser extension auth)

**Agent: Verify how to mark attributes as private/sensitive in Ash to prevent exposure.**

Implement authentication actions on User resource:
- `register` action: accepts username, email, password, validates uniqueness and password strength, hashes password with Bcrypt, generates API token, creates user
- `sign_in` action: accepts username and password, finds user, verifies password, returns user or error

**Agent: Verify Ash action patterns for complex validations and calculations. Check if Ash has built-in password validation or if custom validation is needed.**

Create auth plug at `lib/deutch_lernen_web/plugs/auth.ex`:
- Check session for user_id
- Load user from database
- Store in conn.assigns.current_user
- Provide require_authenticated_user that redirects to login if not authenticated

**Agent: Verify Phoenix plug patterns and session management in current Phoenix version.**

Create LiveView pages:
- `lib/deutch_lernen_web/live/auth_live/login.ex` with login form
- `lib/deutch_lernen_web/live/auth_live/register.ex` with registration form

**Agent: Verify Phoenix.Component patterns for form components and how to handle form submissions in LiveView.**

Forms should include:
- Login: username, password
- Register: username, email, password, password_confirmation, current_level, target_level

Add routes for `/login` and `/register`.

Update router to require authentication for app routes using pipeline with auth plug.

Add logout route and link in navigation.

Update all LiveView mount functions to use current_user from assigns for data filtering.

**Agent: Verify how to access socket.assigns in LiveView mount and ensure queries are scoped by user_id.**

Update CLI to accept username parameter and load user.

Commit with message: "Add user authentication with session management"

Write comprehensive tests:
- `test/deutch_lernen_web/live/auth_live/login_test.exs`: login success/failure, error messages, session establishment
- `test/deutch_lernen_web/live/auth_live/register_test.exs`: registration, password hashing, uniqueness, validation errors
- `test/deutch_lernen_web/plugs/auth_test.exs`: authenticated access, redirects, user loading, logout

**Agent: Verify Phoenix.LiveViewTest patterns for testing authentication flows.**

Update existing LiveView tests to set up authenticated sessions.

Commit with message: "Add authentication tests"

Create pull request to main branch after running `mix check`.

### Step 22: Improve German Word Parsing ⏸️ FUTURE | 📦 Sprint 4 | 🔢 13 SP

Enhance word parsing to handle German linguistic features accurately.

**Agent: Research German morphology and consider if there are Elixir NLP libraries available, or if rule-based parsing is needed.**

Branch name: `feat/german-word-parsing`

Create `lib/deutch_lernen/vocabulary/german_parser.ex` module.

Implement German-specific parsing:

1. **Tokenization**
   - Split on whitespace and punctuation
   - Handle German quotation marks („")
   - Preserve hyphens in compound words (Donaudampfschifffahrtsgesellschaft)
   - Handle abbreviations (z.B., d.h., usw.)

2. **Article Detection**
   - Identify and separate articles: der/die/das, ein/eine, den/dem/des
   - Extract article as grammatical metadata
   - Determine case from article form (der=Nom/Gen, den=Akk, dem=Dat, des=Gen)

3. **Lemmatization** (basic rule-based)
   - **Nouns**: strip common plural endings (-e, -en, -er, -s)
   - **Verbs**: strip conjugation endings
     - Present: -e, -st, -t, -en, -t
     - Past: -te, -test, -ten, -tet
     - Participles: ge-...-t, ge-...-en
   - **Adjectives**: strip comparison (-er, -st, -ste) and declension endings
   - Handle irregular forms with lookup table for common words

4. **Separable Verb Detection**
   - Identify common separable prefixes: ab-, an-, auf-, aus-, bei-, ein-, mit-, nach-, vor-, zu-
   - Check if word starts with prefix + verb
   - Store prefix separately

5. **Word Type Detection**
   - Capitalization → likely noun
   - Verb endings → verb
   - Article + capitalized → definitely noun with gender
   - Position after preposition → likely noun/pronoun
   - -lich, -ig, -sam, -bar endings → adjective

6. **Case Detection**
   - From article form
   - From preposition (für→Akk, mit→Dat, wegen→Gen)

Integrate parser into:
- Reading LiveView: parse sentences on display, suggest word info
- API controller: parse captured sentences
- CLI: parse when adding sentences

Provide confidence scores for automatic parsing.

Store original word form alongside lemma in WordInstance.

Commit with message: "Add German-specific word parsing with lemmatization"

Write comprehensive tests in `test/deutch_lernen/vocabulary/german_parser_test.exs`:
- Tokenization with German punctuation
- Article detection and case determination
- Noun lemmatization (singular from plural forms)
- Verb lemmatization (infinitive from conjugated forms)
- Separable verb detection (ankommen → an + kommen)
- Word type heuristics accuracy
- Compound word handling
- Edge cases (proper nouns, abbreviations, loanwords)

Include test cases with real German sentences at B1/B2 level.

Commit with message: "Add tests for German parser"

Create pull request to main branch after running `mix check`.

### Step 23: Add Example Sentences in Reviews ⏸️ FUTURE | 📦 Sprint 2 | 🔢 5 SP

Enhance review system to show words in context with example sentences.

**Agent: Verify efficient preloading and query patterns in Ash to avoid N+1 issues.**

Branch name: `feat/example-sentences`

Update review session LiveView:
- In mount, when loading due words, also load WordInstance records with associated Sentences
- Select up to 3 diverse example sentences (different books/contexts)
- Preload efficiently to avoid N+1 queries

**Agent: Verify Ash preload syntax for deeply nested relationships: UserWordProgress → Word → WordInstance → Sentence → Book.**

Update review template to display after revealing answer:
- Example sentences with target word highlighted using `<mark>` tag or bold
- Book title with each example for source attribution
- German original sentences (not translations)

Update word modal in Reading view:
- Show other occurrences of selected word
- Display count of total occurrences
- List up to 5 sentences with word, showing book and position
- Add "Zu anderem Beispiel springen" (Jump to other example) links

Implement efficient caching or query strategies:
- Add database indexes on word_id in WordInstance if not present
- Use Ash aggregates if available for counting occurrences

**Agent: Verify if Ash provides aggregate or calculation features for counting related records.**

Commit with message: "Add example sentences in reviews and word modal"

Write tests:
- `test/deutch_lernen_web/live/review_live/session_test.exs`: example loading, highlighting, book attribution, no examples handling
- `test/deutch_lernen_web/live/reading_live/show_test.exs`: occurrence display, navigation, accurate counting

Verify query efficiency (no N+1 issues).

Commit with message: "Add tests for example sentences"

Create pull request to main branch after running `mix check`.

### Step 24: Implement B1/B2 Statistics ⏸️ FUTURE | 📦 Sprint 3 | 🔢 13 SP

Add comprehensive statistics for exam preparation tracking.

**Agent: Verify Ash aggregate query capabilities and efficient calculation patterns.**

Branch name: `feat/b1-b2-statistics`

Create `lib/deutch_lernen/learning/statistics.ex` module.

Implement statistics functions:

1. **`vocabulary_statistics/2`** (user_id, date_range)
   - Total unique words by level (A1/A2/B1/B2)
   - Words by status (new/learning/reviewing/known) for each level
   - Percentage mastered per level
   - Average ease factor per level
   - New words per day/week
   - B1/B2 readiness score (percentage of expected vocab known)

2. **`grammar_statistics/2`**
   - Case usage distribution (Nominativ/Akkusativ/Dativ/Genitiv)
   - Verb type distribution (weak/strong/modal/separable)
   - Sentence complexity (based on length, subordinate clauses)

3. **`reading_statistics/2`**
   - Total sentences read by difficulty level
   - Books completed per level
   - Average sentence length
   - Reading session frequency
   - Total reading time

4. **`review_statistics/2`**
   - Total reviews by level
   - Average quality rating per level
   - Reviews per day (consistency)
   - Retention rate (successful reviews / total)
   - Ease factor distribution
   - Words needing attention (low ease factor)

5. **`study_time_statistics/2`**
   - Total study time
   - Average session length
   - Time by activity type
   - Study streak (consecutive days)
   - Daily/weekly/monthly trends

6. **`b1_b2_readiness/1`** (user_id)
   - B1 vocabulary coverage (% of common B1 words known)
   - B2 vocabulary coverage
   - Grammar patterns encountered (list of B1/B2 structures)
   - Recommended focus areas

**Agent: Verify Ash aggregate functions (count, avg, sum, etc.) and how to use them efficiently. Check if Ash supports grouping and filtering in aggregates.**

Use efficient queries:
- Ash aggregates where possible
- Minimize database roundtrips
- Consider adding calculations to resources if appropriate

Integrate into Progress dashboard:
- Call statistics functions in mount
- Display in organized sections with clear labels
- Add date range selector (week/month/3 months/all time)
- Add level filter (show B1 or B2 focus)
- Simple visualizations using SVG or HTML/CSS

**Agent: Use Tidewave MCP to design statistics dashboard with clear visual hierarchy, color coding for different levels, and progress indicators.**

Consider B1/B2 specific features:
- "Bereit für B1 Prüfung?" indicator (Ready for B1 exam?)
- Estimated weeks to B1/B2 based on current pace
- Skill breakdown: Leseverstehen, Hörverstehen, Schreiben, Sprechen

Commit with message: "Add B1/B2 statistics and exam readiness tracking"

Write extensive tests in `test/deutch_lernen/learning/statistics_test.exs`:
- All statistics calculations with sample data
- Date range filtering accuracy
- Level filtering
- Edge cases (no data, single data point)
- Performance with large datasets
- B1/B2 readiness calculations
- Trend calculations

Use factories to generate varied test data across dates and levels.

Commit with message: "Add tests for B1/B2 statistics"

Create pull request to main branch after running `mix check`.

### Step 25: Add Grammar Notes Feature ⏸️ FUTURE | 📦 Sprint 4 | 🔢 8 SP

Add ability to annotate sentences with B1/B2 grammar explanations.

Branch name: `feat/grammar-notes`

Extend Sentence resource:
- Add `grammar_pattern` attribute (string enum) with values:
  - "perfekt", "praeteritum", "konjunktiv_ii", "passiv"
  - "relativsatz", "kausalsatz", "finalsatz", "konditionalsatz"
  - "nominativ", "akkusativ", "dativ", "genitiv"
  - "modalverb", "trennbares_verb", "reflexiv"
- Add `grammar_explanation` attribute (text) for detailed notes

**Agent: Verify Ash attribute modification patterns - check if you need a migration or if Ash handles schema changes.**

Update Reading view:
- Add "Grammatik hinzufügen" (Add Grammar) button per sentence
- Open modal to select grammar pattern and add explanation
- Display grammar badges on sentences with notes
- Filter/highlight sentences by grammar pattern

Create Grammar practice section:
- New LiveView: `lib/deutch_lernen_web/live/grammar_live/index.ex`
- List all grammar patterns with example count
- Click pattern → show all example sentences
- Practice mode: show sentence, hide grammar explanation, reveal after thinking

Add to StudySession:
- Track grammar patterns studied
- Add `grammar_patterns_practiced` attribute (array or JSON)

**Agent: Verify how to store arrays or JSON in Ash resources with PostgreSQL.**

Commit with message: "Add grammar notes and practice for B1/B2"

Write tests in `test/deutch_lernen_web/live/grammar_live/index_test.exs`:
- Pattern listing
- Example filtering
- Practice mode
- Statistics tracking

Commit with message: "Add tests for grammar features"

Create pull request to main branch after running `mix check`.

### Step 26: Add Deployment Configuration ⏸️ FUTURE | 📦 Sprint 6 | 🔢 5 SP

Prepare for production deployment with secure configuration.

Branch name: `feat/deployment-config`

Update `config/runtime.exs`:
```elixir
if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
    raise "DATABASE_URL not set"

  config :deutch_lernen, DeutchLernen.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    ssl: true

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
    raise "SECRET_KEY_BASE not set"

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :deutch_lernen, DeutchLernenWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base
end
```

**Agent: Verify current Phoenix runtime configuration patterns in Phoenix documentation.**

Update `mix.exs` release configuration:
```elixir
def project do
  [
    # ...
    releases: [
      deutch_lernen: [
        steps: [:assemble, :tar]
      ]
    ]
  ]
end
```

Create `Dockerfile`:
```dockerfile
# Build stage
FROM hexpm/elixir:1.16.0-erlang-26.2.1-alpine-3.18.4 AS build

# Install build dependencies
RUN apk add --no-cache build-base git nodejs npm postgresql-dev

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

# Install dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Copy application code
COPY lib ./lib
COPY priv ./priv
COPY assets ./assets
COPY config ./config

# Compile assets
RUN npm --prefix assets ci --progress=false --no-audit --loglevel=error
RUN npm run --prefix assets deploy
RUN mix phx.digest

# Compile application
RUN mix compile

# Build release
RUN mix release

# Runtime stage
FROM alpine:3.18.4

RUN apk add --no-cache libstdc++ openssl ncurses-libs postgresql-client

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/deutch_lernen ./

ENV HOME=/app

CMD ["bin/deutch_lernen", "start"]
```

**Agent: Verify current Elixir/Erlang versions and Alpine versions for production use.**

Create `fly.toml` for Fly.io:
```toml
app = "deutch-lernen"
primary_region = "fra"

[build]

[http_service]
  internal_port = 4000
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 0

[env]
  PHX_HOST = "deutch-lernen.fly.dev"
```

Note: Fly.io provides managed PostgreSQL. Create a Postgres cluster with:
```bash
fly postgres create --name deutch-lernen-db
fly postgres attach deutch-lernen-db
```

Create `docs/deployment.md`:
1. Environment variables (SECRET_KEY_BASE, DATABASE_URL, etc.)
2. Database migration in production
3. Release building: `MIX_ENV=prod mix release`
4. Fly.io deployment:
   - `fly launch`
   - `fly postgres create --name deutch-lernen-db`
   - `fly postgres attach deutch-lernen-db`
   - `fly secrets set SECRET_KEY_BASE=$(mix phx.gen.secret)`
   - `fly deploy`
5. Railway deployment instructions
6. Backup strategy for PostgreSQL (automated backups, pg_dump)
7. Scaling considerations (PostgreSQL connection pooling, read replicas for high traffic)
8. Monitoring setup

Commit with message: "Add production deployment configuration"

Test: Build production release locally and verify it starts.

Create pull request to main branch after running `mix check`.

## Documentation and Finalization

### Step 27: Create Comprehensive Documentation ⏸️ FUTURE | 📦 Sprint 6 | 🔢 8 SP

Write user and technical documentation.

Branch name: `feat/comprehensive-docs`

Create `README.md`:
- Project overview: German B1/B2 learning application
- Key features: spaced repetition, reading-based learning, grammar tracking, Anki export
- Installation for development
- Running: `mix phx.server`
- Testing: `mix test`
- Contributing guidelines

Create `docs/user_guide.md`:
1. **Getting Started**
   - Registration and login
   - Setting current and target level

2. **Reading German Text**
   - Adding books by difficulty level
   - Adding sentences manually or via browser extension
   - Clicking words to learn
   - Understanding grammatical information (articles, gender, cases)

3. **Learning Vocabulary**
   - SM-2 spaced repetition explained
   - Quality ratings: when to use "Nochmal", "Schwer", "Gut", "Einfach"
   - Daily review best practices
   - Understanding intervals and ease factor

4. **Grammar Study**
   - Annotating sentences with grammar patterns
   - Practicing specific B1/B2 structures
   - Tracking grammar pattern coverage

5. **Progress Tracking**
   - Reading statistics
   - Level-based vocabulary progress
   - B1/B2 readiness indicators
   - Exam preparation timeline

6. **Using the CLI**
   - Terminal commands
   - Quick word addition
   - Terminal review sessions

7. **Anki Export**
   - Exporting vocabulary with SM-2 state
   - Importing into Anki

8. **Browser Extension**
   - Installing and configuring
   - Capturing sentences from German websites
   - Authentication setup

Create `docs/german_grammar_guide.md`:
- B1/B2 grammar patterns covered
- Case system explanation
- Verb conjugation overview
- Sentence structure patterns

Create `docs/architecture.md`:
1. **System Architecture**
   - Ash domain organization
   - Resource relationships (ER diagram)
   - Database schema (PostgreSQL)

2. **SM-2 Algorithm**
   - Implementation details
   - Mathematical formulas
   - State machine diagram
   - Default parameters rationale

3. **German Linguistic Processing**
   - Parsing strategy
   - Lemmatization rules
   - Case detection
   - Separable verb handling

4. **Extension Points**
   - Adding LLM integration (future)
   - Audio integration (future)
   - Collaborative features (future)
   - Database migration to PostgreSQL

5. **Code Examples**
   - Creating words with Ash API
   - Scheduling reviews
   - Querying progress statistics
   - Custom actions

Create `docs/b1_b2_certification.md`:
- Goethe Institut B1/B2 exam structure
- Vocabulary requirements
- Grammar requirements
- Using the app for exam preparation
- Study plan recommendations

Commit with message: "Add comprehensive user and technical documentation"

Manually review all documentation for accuracy and completeness.

Create pull request to main branch after running `mix check`.

### Step 28: Final Quality Review ⏸️ FUTURE | 📦 Sprint 6 | 🔢 13 SP

Conduct comprehensive code quality, performance, and security review.

Branch name: `refactor/final-quality-review`

**Agent: Before making changes, read through the entire codebase to understand current state.**

1. **Code Quality**
   - Run `mix credo --strict`
   - Address all warnings
   - Ensure consistent code style
   - Add missing function documentation
   - Remove unused code

2. **Database Optimization**
   - Review all Ash resources for missing indexes
   - Add indexes on foreign keys: book_id, word_id, sentence_id, user_id
   - Add indexes on query fields: next_review_date, status, level
   - Add compound indexes where needed

**Agent: Verify how to add indexes in Ash migrations.**

3. **Query Optimization**
   - Review all LiveView mount functions
   - Identify N+1 query patterns
   - Add appropriate preloading

**Agent: Enable query logging temporarily and check for repeated queries during common workflows.**

   - Use Ash aggregates where beneficial

4. **Type Safety**
   - Add @spec to all public functions
   - Run Dialyzer if configured
   - Address type warnings

**Agent: Check if Dialyzer is set up in the project and how to run it.**

5. **Security Review**
   - Verify all queries filter by user_id
   - Check XSS protection in templates (Phoenix auto-escapes)
   - Verify API authentication on all endpoints
   - Review CORS configuration (restrictive enough?)
   - Check password hashing (using Bcrypt properly?)
   - Verify no sensitive data logged

6. **Error Handling**
   - Review all LiveView pages for graceful error handling
   - Ensure user-friendly error messages
   - Add error logging for production debugging
   - Consider error tracking service (Sentry/AppSignal)

**Agent: Check if error tracking is desired and add basic configuration if so.**

7. **Test Coverage**
   - Run `mix test --cover`
   - Aim for 80%+ coverage
   - Add tests for uncovered branches
   - Focus on Learning domain (critical business logic)

8. **Performance Benchmarks**
   - Add Benchee dependency if not present
   - Create benchmarks in `bench/`:
     - Review session loading time
     - Statistics calculation performance
     - German parser performance
   - Document baseline performance

**Agent: Verify Benchee usage patterns for creating benchmarks.**

9. **Accessibility**
   - Verify semantic HTML
   - Check color contrast ratios
   - Ensure keyboard navigation works
   - Add ARIA labels where needed

10. **Mobile Responsiveness**
    - Test all pages at mobile viewport
    - Verify touch targets are large enough
    - Check horizontal scrolling issues

Commit with message: "Final code quality improvements and optimizations"

Write tests for any uncovered edge cases found during review.

Commit with message: "Add tests for edge cases from quality review"

Create pull request to main branch after running `mix check`.

### Step 29: Create Future Roadmap ⏸️ FUTURE | 📦 Sprint 6 | 🔢 2 SP

Document future enhancements for continued development.

Branch name: `docs/future-roadmap`

Create `ROADMAP.md`:

## Phase 1: Current Release (Complete)
- ✅ Core vocabulary learning with SM-2
- ✅ Reading-based acquisition
- ✅ B1/B2 grammar tracking
- ✅ Progress dashboard
- ✅ CLI interface
- ✅ Anki export
- ✅ Browser extension API

## Phase 2: LLM Integration (Future)
- **Ollama Integration** for local German models
  - Conversational practice in German
  - Context-aware translation assistance
  - Grammar explanations
  - RAG over sentence corpus for intelligent responses
- **Suggested models**: Llama 3.1 8B, Mistral 7B with German fine-tuning
- **Implementation**: HTTP client to Ollama API, context management

## Phase 3: Bumblebee Integration (Future)
- **German BERT** for advanced text analysis
  - Automatic lemmatization with ML
  - Part-of-speech tagging
  - Named entity recognition
- **Embeddings** for semantic search
  - Find similar sentences
  - Discover related vocabulary
  - Contextual word recommendations
- **Implementation**: Nx/EXLA for model inference, pgvector extension for PostgreSQL vector storage

## Phase 4: Audio Learning (Future)
- **Text-to-Speech** for listening practice
  - Hear sentences pronounced correctly
  - Adjust speed for learning
  - Focus on B1/B2 pronunciation patterns
- **Speech Recognition** for speaking practice
  - Pronunciation feedback
  - Speaking exercises
  - Conversation simulation
- **Integration**: Whisper for speech-to-text, Mozilla TTS for text-to-speech

## Phase 5: Enhanced Learning (Future)
- **Grammar Exercises** with automated feedback
  - Case practice
  - Verb conjugation drills
  - Sentence construction
- **Writing Practice** with correction
  - Composition exercises
  - Essay writing for B2
  - Feedback on style and grammar
- **Listening Comprehension** tests
  - Audio passages
  - Comprehension questions
  - B1/B2 exam-style exercises

## Phase 6: Social Features (Future)
- **Vocabulary Lists** sharing
  - Community-created word lists
  - Thematic collections (business, travel, etc.)
  - Import/export between users
- **Leaderboards** for motivation
  - Study streaks
  - Words learned
  - Review consistency
- **Study Groups**
  - Shared progress tracking
  - Collaborative learning

## Phase 7: Platform Expansion (Future)
- **Native Mobile
Apps**
  - iOS app with SwiftUI
  - Android app with Kotlin
  - Offline learning capabilities
  - Sync with web application
  - Push notifications for reviews
- **Desktop Application**
  - Elixir Desktop for standalone app
  - No browser required
  - Better performance
  - System tray integration
- **Browser Extension Enhancement**
  - Full Chrome/Firefox extension (beyond API)
  - Inline translation overlay on German websites
  - Quick-add button on selection
  - Statistics dashboard in popup

## Technical Improvements
- **Database Optimization**
  - Already using PostgreSQL for scalability
  - Optimize for 100+ concurrent users with connection pooling
  - Implement full-text search capabilities
  - Consider PostGIS for geographic content features
- **Caching Layer**
  - Redis for session data
  - Cachex for application-level caching
  - Reduce database load
- **Real-time Collaboration**
  - Phoenix Channels for live updates
  - Multiplayer learning games
  - Live study sessions
- **Advanced Analytics**
  - Learning curve analysis
  - Personalized recommendations
  - Adaptive difficulty
  - Predictive exam readiness

## Integration Opportunities
- **Anki Sync** (two-way)
  - Not just export, but also import from Anki
  - Keep progress in sync
- **Language Exchange Platforms**
  - Integration with Tandem, HelloTalk
  - Find conversation partners
- **German Media Sources**
  - Deutsche Welle integration
  - News articles at different levels
  - Podcasts with transcripts
- **Official Exam Preparation**
  - Goethe Institut practice tests
  - TestDaF materials
  - Telc B1/B2 resources

## Lessons Learned
1. **Test-Driven Development Critical**
   - Especially for SM-2 algorithm
   - Edge cases are numerous
   - Tests caught many issues early

2. **Ash Framework Benefits**
   - Rapid domain modeling
   - Built-in validations
   - Query composition is powerful
   - Documentation is essential (check official docs!)

3. **PostgreSQL Benefits**
   - Excellent for multi-user applications
   - Strong ACID guarantees
   - Robust backup and replication
   - Scales well with proper indexing and connection pooling

4. **Phoenix LiveView Strengths**
   - Real-time interactivity without JS frameworks
   - Mobile-first responsive works well
   - Authentication integration straightforward
   - Socket assigns pattern is clean

5. **German-Specific Challenges**
   - Case system requires careful tracking
   - Separable verbs need special handling
   - Gender and articles are critical
   - Compound words are complex
   - Rule-based parsing has limits (ML would help)

6. **Language Learning Insights**
   - Context is crucial (example sentences matter)
   - Spaced repetition works but needs tuning
   - Progress visualization drives motivation
   - Multiple interaction modes (web/CLI/mobile) increase usage
   - Grammar awareness accelerates B1/B2 progress

## Recommendations for Similar Projects
1. **Start with Core Learning Loop**
   - Get spaced repetition working first
   - Add features incrementally
   - Don't over-engineer initially

2. **Domain Modeling**
   - Separate concerns clearly (Content/Vocabulary/Learning)
   - Use framework tools (Ash generators)
   - Document relationships thoroughly

3. **Language-Specific Features**
   - Understand target language grammar deeply
   - Design data model to capture linguistic features
   - Consult with language teachers/learners

4. **User Feedback Early**
   - Get real learners testing quickly
   - B1/B2 learners know what they need
   - Iterate based on actual usage patterns

5. **Performance Matters**
   - Profile queries early
   - N+1 queries kill user experience
   - Mobile performance is critical

6. **Open Source Benefits**
   - Community contributions for content
   - Bug reports from diverse usage
   - Localization help
   - Trust from privacy-conscious users

## Contributing Guidelines
- Fork repository and create feature branches
- Follow existing code style (mix format, credo)
- Write tests for all new features
- Update documentation
- Submit PR with clear description
- Run `mix check` before submitting

## Community Requests (Add yours!)
- [ ] More German book recommendations
- [ ] Vocabulary lists by topic
- [ ] Integration with German podcasts
- [ ] Speaking practice features
- [ ] Grammar exercise generator
- [ ] Your idea here!

Commit with message: "Add comprehensive future roadmap"

Review roadmap and prioritize based on user feedback once application is live.

Create pull request to main branch after running `mix check`.

---

## 📊 SPRINT PLANNING SUMMARY

### Sprint Overview

| Sprint | Goal | Story Points | Status | Key Features |
|--------|------|--------------|--------|--------------|
| **Sprint 1** | Core Reading Flow (MVP) | 49 SP | READY | Reading view, clickable words, save with context |
| **Sprint 2** | Spaced Repetition System | 26 SP | BLOCKED | SM-2 algorithm, review session, example sentences |
| **Sprint 3** | Multi-user & Analytics | 36 SP | BLOCKED | Authentication, statistics, enhanced seeds |
| **Sprint 4** | Advanced Parsing & CLI | 34 SP | BLOCKED | German parser, CLI interface, grammar notes |
| **Sprint 5** | Integrations | 23 SP | BLOCKED | Anki export, browser extension API |
| **Sprint 6** | Production Ready | 28 SP | BLOCKED | Deployment, docs, quality review, roadmap |

**Total Backlog:** 196 Story Points

### Sprint 1 Details (CURRENT)

**Status:** READY TO START - Awaiting PROJECT OWNER approval

**Features:**
1. ✅ Domain structure (3 domains: Content, Vocabulary, Learning)
2. ✅ Core resources (Book, Sentence, Word, Translation, WordInstance, User)
3. ✅ Reading view with clickable German words
4. ✅ Word save modal with German grammar (articles, gender, cases)
5. ✅ Context preservation (WordInstance links words to sentences)
6. ✅ Minimal seed data for testing

**What USER Can Do After Sprint 1:**
- View a German book (pre-seeded) in browser
- Click any word in a German sentence
- See word save dialog with grammatical options
- Enter English translation, select article (der/die/das), gender, case
- Save word with full context (which sentence it appeared in)
- Verify word saved to database via IEx

**What USER Cannot Do (Future Sprints):**
- Review saved words with spaced repetition (Sprint 2)
- See statistics/progress dashboard (Sprint 3)
- Multiple books or book management UI (Sprint 3)
- Browser extension capture (Sprint 5)
- Authentication/multi-user (Sprint 3)

### Sprint 2 Details (BLOCKED - Needs Sprint 1 Completion)

**Status:** BLOCKED - Requires PROJECT OWNER approval after Sprint 1 testing

**Story Points:** 26 SP

**Features:**
- UserWordProgress resource with SM-2 algorithm (13 SP)
- Review session LiveView (8 SP)
- Example sentences in reviews (5 SP)

**Acceptance Criteria:**
- User can review saved words using spaced repetition
- SM-2 algorithm calculates next review dates
- Words shown with example sentences from reading context
- Quality ratings (0-5) adjust difficulty

### Sprint 3 and Beyond

**All future sprints are BLOCKED** until PROJECT OWNER:
1. Tests and approves Sprint 1
2. Provides feedback for Sprint 2 planning
3. Explicitly approves Sprint 2 scope

---

## 🎯 LEARNING FROM REVIEW_ISSUES.md

### Key Insights Applied to Sprint 1

1. **Comprehensible Input First** ✅
   - Sprint 1 focuses on READING German text with context
   - No premature spaced repetition - user builds vocabulary naturally
   - Aligns with "80-90% comprehensible" principle

2. **Avoid Word-by-Word Translation Trap** ✅
   - WordInstance preserves sentence context
   - User sees word IN its German sentence, not isolated
   - Supports sentence mining approach from review

3. **Grammar Awareness for B1/B2** ✅
   - Word resource captures German-specific grammar
   - Articles (der/die/das), gender, cases tracked
   - Foundation for B1/B2 grammar pattern recognition

4. **Progressive Difficulty** ✅
   - Book resource has difficulty_level (A2/B1/B2)
   - Foundation for filtering by proficiency
   - Sprint 1 uses B1 seed data (Café in Berlin)

### What We're NOT Doing Yet (Per Review Guidance)

- ❌ Forcing reviews before user has content (Sprint 2)
- ❌ Jumping to B2 difficulty (using B1 seed data)
- ❌ Complex analytics before basic loop works (Sprint 3)
- ❌ Automated parsing (manual selection in Sprint 1, automation in Sprint 4)

---

## 🚦 AGENT DECISION FLOWCHART

```
START
  ↓
Is current Sprint marked as COMPLETED?
  ├─ NO → Proceed with current Sprint tasks
  │        ↓
  │      Use TodoWrite to create task list
  │        ↓
  │      Implement features following Definition of Done
  │        ↓
  │      Mark Sprint as COMPLETED when all tasks done
  │        ↓
  │      Notify PROJECT OWNER to test
  │        ↓
  │      STOP and WAIT
  │
  └─ YES → Check if PROJECT OWNER approved next Sprint?
           ├─ NO → Output: "Sprint [N] completed. Awaiting PROJECT OWNER approval for Sprint [N+1]"
           │        ↓
           │      STOP (do nothing until approval)
           │
           └─ YES → Create detailed Sprint backlog
                    ↓
                  Use TodoWrite with granular tasks
                    ↓
                  Begin implementation
```

---

## ✅ DEFINITION OF DONE (Every Sprint Task)

- [ ] Code implemented following Ash/Phoenix best practices
- [ ] Usage rules consulted for all libraries used
- [ ] Comprehensive tests written (unit + integration)
- [ ] All tests passing (`mix test`)
- [ ] Code review completed (Elixir Review Agent)
- [ ] `mix precommit` passes with no errors
- [ ] Git branch created with `feat/` prefix
- [ ] Commits follow conventional commits format
- [ ] Pull request created to main branch
- [ ] PR merged after review
- [ ] Feature manually tested by developer
- [ ] Feature ready for PROJECT OWNER acceptance testing

---

## 📝 END OF PLAN.md

**AGENT: Before starting ANY work, confirm Sprint 1 approval from PROJECT OWNER.**

**PROJECT OWNER: Review Sprint 1 scope and reply with approval to begin implementation.**
