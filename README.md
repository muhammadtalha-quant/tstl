# Toy Standard Template Library (tstl)

<!--toc:start-->
- [Toy Standard Template Library (tstl)](#toy-standard-template-library-tstl)
  - [Why This Repository Exists](#why-this-repository-exists)
    - [Key Concepts for Effective C++ Comprehension](#key-concepts-for-effective-c-comprehension)
  - [Memory Handling in Containers](#memory-handling-in-containers)
  - [The C++ Subset I Need To Tackle](#the-c-subset-i-need-to-tackle)
    - [1. Core Data Structures](#1-core-data-structures)
    - [2. Core Algorithms](#2-core-algorithms)
    - [3. Standalone Memory Allocation Strategies](#3-standalone-memory-allocation-strategies)
    - [4. Foundational Utilities](#4-foundational-utilities)
  - [Essential C++ Concepts](#essential-c-concepts)
  - [Recommended Study Material](#recommended-study-material)
    - [Why this book is recommended](#why-this-book-is-recommended)
  - [Next Steps: Post-Repository Practice](#next-steps-post-repository-practice)
  - [Project Status & Contributions](#project-status-contributions)
  - [License](#license)
<!--toc:end-->

A focused C++ educational laboratory designed to master the core data
structures, algorithms, and memory concepts required for a future that I have planned for.

> [!NOTE]
> **Personal Study Laboratory:** `tstl` is an individual project built
> strictly for **educational and self-study purposes**. Rather than trying
> to implement every niche corner of standard libraries, it focuses on
> implementing the specific, practical subset of modern C++ required for
> my future career.
---

## Why This Repository Exists

Industrial C++ standard libraries are engineering marvels, but their source
code is packed with decades of backwards-compatibility macros, platform
workarounds, and obscured variable names (`_M_allocate_and_copy`).

### Key Concepts for Effective C++ Comprehension

- How data sits in computer memory (cache lines, contiguous buffers).
- How core algorithmic patterns operate on mathematical objects.
- How to write fast, expressive, modern C++ without hidden performance traps.

`tstl` serves as a personal laboratory to implement this exact subset from
the ground up, reinforcing theoretical knowledge with clean, readable code.

---

## Memory Handling in Containers

> [!IMPORTANT]
> **Standard Memory Handling in Data Structures:** Nearly all containers in
> this repository use standard, idiomatic C++ memory techniques:
>
> - Direct `new` and `delete`
> - Placement `new` and explicit destructor calls
> - Modern standard functions: `std::construct_at(...)` and
>   `std::destroy_at(...)`
>
> The **memory allocation strategies** (such as arena, pool, or stack
> allocators) listed later are **completely separate and unrelated** to the
> containers. They are standalone study modules included strictly to explore
> how low-level memory managers function in high-performance systems.

---

## The C++ Subset I Need To Tackle

### 1. Core Data Structures

In an environment where memory access patterns dominate execution time.
This repository focuses on containers that offer high cache locality:

- **`list:`** *no description*
- **`stack:`** *no description*
- **`queue:`** *no description*
- **`vector`**: The foundational contiguous array. Essential for storing price
  series, returns, feature vectors, order book depth levels, and tick logs.
  Provides instant $O(1)$ random access and cache-friendly sequential scans.
- **`circular_buffer` (Ring Buffer)**: Fixed-capacity rolling window for
  streaming market data. Enables efficient updates for rolling indicators
  with zero dynamic memory allocation during streaming.
- **`flat_map` & `flat_set`**: Sorted contiguous arrays with binary search.
  For shallow limits , `flat_map`
  significantly outperforms node-based trees (`std::map`) because contiguous
  storage fits entirely within L1/L2 CPU caches.
- **`priority_queue` (Heap)**: A binary heap for event-driven simulation
  engines, matching engine order queues, timer events, and tracking top-K alpha
  signals.
- **`unordered_map` (Flat Hash Table / Buckets)**: Provides fast average $O(1)$
  lookups for symbol metadata, instrument mappings, and factor state tables.
- **`array`**: Fixed-size stack storage for fixed-depth order book slices and
  tick coordinate tuples, with zero dynamic overhead.

### 2. Core Algorithms

In `tstl`, algorithms focus on practical data analysis, streaming features,
and cross-sectional modeling:

- **Cross-Sectional Factor Ranking**:
  - `sort`: Ordering full asset universes by signal strength.
  - `nth_element`: Calculating percentiles, deciles, and median alpha signals
    in $O(n)$ time without sorting the entire universe.
  - `partial_sort`: Selecting the top and bottom $K$ assets to build long/short
    trading baskets.
<!-- - **Time Series & Rolling Features**:
  - Online Welford algorithm for computing running mean, variance, and
    volatility in a single pass with numerical stability.
  - Monotonic deque algorithms for rolling minimum and maximum calculations.
  - Exponential moving averages (EMA) and rolling quantiles. -->
- **Fast Searching & Alignment**:
  - `lower_bound`, `upper_bound`, `equal_range`, and `binary_search` for
    matching asynchronous timestamps across market feeds and locating price
    levels.
- **Signal Vectorization & Reductions**:
  - `accumulate` / `reduce`, `transform`, and `inner_product` for factor
    weight combinations, portfolio exposure calculations, and covariance
    matrices.
- **Data Cleansing & Filtering**:
  - `partition`, `unique`, and `remove_if` for cleaning market data spikes,
    filtering outliers, and updating active universe filters.

### 3. Standalone Memory Allocation Strategies

These standalone modules explore how high-performance systems bypass general-
purpose heap overhead:

- **Linear / Arena Allocator**: Fast bump allocator that pre-allocates a memory
  block and resets after each bar or trading session, achieving zero
  fragmentation and instant bulk cleanup.
- **Pool Allocator**: Manages fixed-size memory blocks, ideal for high-churn
  objects like order messages and simulation events.
- **Debug / Leak-Tracking Allocator**: Instruments allocations to measure
  peak memory usage and ensure zero memory leaks during multi-hour trading
  runs.

### 4. Foundational Utilities

- **Iterators & Ranges**: Standard random-access and contiguous iterator
  abstractions connecting containers to algorithms.
- **Object Lifecycle Helpers**: Standard functions (`std::construct_at(...)`,
  `std::destroy_at(...)`) to construct and destroy objects in place.

---

## Essential C++ Concepts

Implementing this repository builds competence in the C++ concepts most prized
in quantitative trading:

1. **Mechanical Sympathy & Cache Hierarchy:** Understanding L1/L2/L3 cache
   lines (64 bytes) and designing data structures that avoid pointer chasing.
2. **Move Semantics & Zero-Copy Passing:** Using `std::move` and rvalue
   references to transfer large market data frames without copying.
3. **Allocation Discipline:** Avoiding unexpected heap allocations in the
   critical signal path through pre-sizing (`reserve`) and fixed capacities.
4. **Compile-Time Polymorphism:** Leveraging templates and type traits to build
   generic data structures without the runtime cost of virtual function tables.

---

## Recommended Study Material

This repository is designed to be paired with foundational textbook reading:

> **Data Structures and Algorithm Analysis in C++**
> *By Mark Allen Weiss (4th Edition)*

### Why this book is recommended

- **Theoretical Rigor:** Provides clear Big-O asymptotic analysis, recurrences,
  and proofs for trees, heaps, hashing, and sorting algorithms.
- **Concrete C++ Implementations:** Uses clear, modern C++ examples rather than
  language-agnostic pseudocode.
- **Direct Parallels:** Reading the theory in Weiss and implementing the
  corresponding data structures and algorithms in `tstl` provides the ideal
  synthesis of theory and practice.

---

## Next Steps: Post-Repository Practice

Completing the implementations in `tstl` establishes a solid foundation in
systems-level C++ and data structure mechanics. The immediate next phase of
preparation involves:

1. **Algorithmic Problem-Solving on LeetCode:**
   - Solving Medium and Hard problems focusing on:
     - Arrays & Two Pointers
     - Sliding Window & Monotonic Queues
     - Binary Search & Sorted Matrix Search
     - Heaps & Top-K Elements
     - Interval Scheduling & Graph Traversals
2. **Competitive Programming & Q Problem Sets:**
   - Practicing timed problem solving (e.g., Codeforces, Project Euler) to
     hone mathematical intuition, speed, and edge-case handling under
     interview conditions.
3. **QR Projects:**
   - Applying these data structures to build a fast, event-driven backtesting
     engine using real historical market data (L2 order book replay, tick-based
     alpha factor computation).

---

## Project Status & Contributions

> [!IMPORTANT]
> **No Contributions Needed:** This repository is an individual, personal
> learning project created solely for study and educational practice.
>
> External pull requests, issues, or feature contributions are **not** needed
> or accepted.

---

## License

This project is open-source and available under the [MIT License](LICENSE).
