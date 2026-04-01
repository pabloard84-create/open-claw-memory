# Checkpoint Protocol

Create a checkpoint when any of these happen:
- The task exceeds 10-15 messages.
- The goal changes midstream.
- There are multiple failed attempts.
- There is confusion about why something is being done.

Checkpoint format:
- Goal
- Why it matters
- What was tried
- Current state
- Next step
- Decision if any
