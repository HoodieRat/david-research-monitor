# Test plan

- Run `dotnet test DavidResearchMonitor.sln` for policy, URL, matching, hashing, resource, schema, capture, scheduler XML, and report-encoding tests.
- Run `python scripts/check_secrets.py` on the staged Git contents before each push. Confirm that local databases, reports, account state, and generated packages are ignored.
- Test OpenAI API request construction with a fake HTTP handler and Codex CLI sign-in/structured output with a fake process runner. Live account tests require a user-selected provider and active account access.
- Run `ResearchMonitor.Diagnostics.exe --full` on the target machine.
- From the UI, add a topic, run discovery, verify a standalone report, then test with a locally installed 4B model and confirm owned-model unload.
- Test the LinkedIn block both on and off with a small, explicitly chosen batch before enabling scheduled reads.
- Test pause/resume, Task Scheduler registration, 45-minute timeout, cancellation, abrupt Worker termination, and restart recovery.
- The v1 stability gate requires 30 consecutive scheduled runs and target-laptop responsiveness checks. This cannot be asserted from development-machine unit tests.

## Results on the development computer (2026-09-29)

- Four self-contained win-x64 executables published successfully.
- Fifteen unit and integration tests passed, including full-text chosen capture, policy gating, public-search LinkedIn fallback, report encoding, report-item bookmarking, recovery, schedule XML, and LM Studio lifecycle with a fake CLI/API.
- Temporary Windows Task Scheduler registration succeeded and was removed.
- Full diagnostics passed for SQLite, DokoBot CLI, a real local DokoBot browser-bridge read of `example.com`, LM Studio CLI, disk, RAM, CPU sampling, reports, and browser presence.
- Packaged WPF app remained running through a startup smoke check.
- Packaged Runner generated a standalone report in an isolated data root. A separate LinkedIn discovery-only run produced a report containing 27 LinkedIn URL mentions while page reads were blocked.
- The local GPU resource probe deferred live AI inference; model-backed acceptance on David's target laptop remains unverified.
- With the LinkedIn block off in a separate test database, a bounded scheduled scan discovered two LinkedIn URLs and stored two sequential DokoBot page reads in SQLite. Their normalized text lengths were 11,753 and 145 characters. A separate user-selected two-URL capture batch stored both pages through the same worker path. Both reports linked back to LinkedIn. The shorter page did not meet the AI queue threshold; the longer page remained queued because the selected local model did not pass availability/resource checks on this computer.
- The 30-run endurance gate, abrupt-termination recovery, and model-backed analysis on the target laptop remain unverified.
