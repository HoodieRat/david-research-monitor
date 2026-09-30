# David Research Monitor

A Windows desktop app that discovers research for chosen topics, stores findings in SQLite, analyzes them with a selected AI provider, and produces standalone HTML reports. Scheduled scans, source controls, bookmarks, diagnostics, and a user-driven capture screen are included.

## Start here

1. On Windows 10 or 11, install the [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0).
2. Build a self-contained package with `powershell -ExecutionPolicy Bypass -File scripts/Build-Release.ps1`.
3. Keep `packaging/release` and `scripts` together, then run `scripts/Setup.bat`.
4. Open Research Monitor and complete Setup: browser connection, AI provider, topics, and schedule.
5. Run a small test scan and open its HTML report from Home or Reports.

For a ready-to-run preview, download the Windows ZIP from this private repository's [Releases](https://github.com/HoodieRat/david-research-monitor/releases), extract it, and run `DavidResearchMonitor/scripts/Setup.bat`. The included `packaging/release` folder contains self-contained executables. DokoBot and the chosen AI provider still need their own setup.

DokoBot is installed separately for browser capture. An AI provider is optional for discovery-only reports. See [AI provider setup](docs/AI_PROVIDERS.md) for the three analysis choices and [architecture](docs/ARCHITECTURE.md) for how runs work.

## AI choices

| Provider | Account setup | Where analysis runs |
| --- | --- | --- |
| LM Studio | Install a local model | On this computer |
| OpenAI API | Supply `OPENAI_API_KEY` at runtime | OpenAI API, billed to the API project |
| Codex with ChatGPT | Install Codex CLI and sign in with ChatGPT | Codex using the signed-in account's available usage |

Research Monitor does not write API keys or Codex login tokens to SQLite, reports, logs, or this repository. Cloud options send the selected source text to OpenAI for analysis. Availability and usage limits depend on the account and provider. The local option remains the default.

## LinkedIn controls

The **Block LinkedIn DokoBot reads** switch defaults on. Scheduled scans can still discover public indexed LinkedIn links. Turning the switch off enables sequential DokoBot reads of discovered LinkedIn pages and user-selected URL batches. The Capture screen can also import text the user copied from a page. This setting affects Research Monitor; DokoBot itself is unchanged. Review [LinkedIn design and policy](docs/LINKEDIN_DESIGN.md) before changing the switch.

## Data and privacy

By default, the database, content, and logs live under `%LOCALAPPDATA%\DavidResearchMonitor`; HTML reports live under `%USERPROFILE%\Documents\David Research Monitor`. These paths are outside the source checkout. `RESEARCHMONITOR_DATA_ROOT` and `RESEARCHMONITOR_REPORTS_ROOT` can override them for isolated testing. Runtime data, credentials, generated release files, and local validation files are excluded from Git.

The [narrated demo](demo/README.md) uses fictional sample content. No personal LinkedIn account appears in it.

## Develop and verify

```powershell
dotnet restore DavidResearchMonitor.sln
dotnet build DavidResearchMonitor.sln --no-restore
dotnet test DavidResearchMonitor.sln --no-build
python scripts/check_secrets.py
powershell -ExecutionPolicy Bypass -File scripts/Package-Release.ps1
```

See the [implementation plan](PLAN.md), [production specification](docs/PRODUCTION_SPEC.md), and [test plan](docs/TEST_PLAN.md). Security issues and private disclosure guidance are in [SECURITY.md](SECURITY.md).

No redistribution license has been selected by the project owner.
