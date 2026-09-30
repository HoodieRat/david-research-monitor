# David Research Monitor

A Windows desktop app that discovers research for chosen topics, stores findings in SQLite, analyzes them with a selected AI provider, and produces standalone HTML reports. Scheduled scans, source controls, bookmarks, diagnostics, and a user-driven capture screen are included.

## Download and install on Windows

**Start with the [ready-to-run Windows ZIP](https://github.com/HoodieRat/david-research-monitor/releases/download/v0.1.2-preview/DavidResearchMonitor-v0.1.2-preview-win-x64.zip).** The repository is private, so sign in to a GitHub account with access before downloading. Use this release ZIP rather than GitHub's **Code → Download ZIP**, which contains source files.

1. In File Explorer, right-click the downloaded ZIP and choose **Extract All**.
2. Open the extracted `DavidResearchMonitor` folder, then its `scripts` folder.
3. **Double-click `Setup.bat`** and wait for setup to finish. It installs the app and creates a Start menu shortcut.
4. Open **David Research Monitor** from the Windows Start menu. You only need `Setup.bat` for installation; use the Start menu thereafter.

The release is for Windows 10 or 11 x64 and includes the .NET runtime. No programming tools or .NET SDK are needed. DokoBot is installed separately for browser capture; AI is optional for discovery-only reports. See [AI provider setup](docs/AI_PROVIDERS.md) when you are ready for analysis.

## Watch the demo

[**Watch or download the 3-minute MP4 walkthrough**](https://github.com/HoodieRat/david-research-monitor/releases/download/v0.1.2-preview/David-Research-Monitor-Demo.mp4). GitHub may download the MP4 instead of playing it in the browser; open the downloaded file to watch it. The demo uses fictional data and shows no personal LinkedIn account. The [transcript and captions](demo/README.md) are also available.

## Try a first scan

1. In **Setup → Topics**, click **Add example topics**.
2. Go to **Home** and click **Discover links only**. This tests discovery and report creation without an AI account.
3. When the run finishes, select the newest report and click **Open selected report**. Reports are also saved under `Documents\David Research Monitor\Reports`.
4. For the full workflow, complete **Setup → Browser**, choose and test a provider in **AI Model**, then click **Run Now** on Home. Leave scheduled monitoring off until the manual test succeeds.

Browser capture requires DokoBot and its browser bridge. Its in-app installer requires Node.js LTS. See [architecture](docs/ARCHITECTURE.md) for how runs work.

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

The demo uses fictional sample content. No personal LinkedIn account appears in it.

## Develop and verify

For development from source, install the [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0). `scripts/Build-Release.ps1` builds a self-contained local package; `scripts/Package-Release.ps1` builds the distributable ZIP. These steps are for maintainers, not for installing the downloaded release.

```powershell
dotnet restore DavidResearchMonitor.sln
dotnet build DavidResearchMonitor.sln --no-restore
dotnet test DavidResearchMonitor.sln --no-build
python scripts/check_secrets.py
powershell -ExecutionPolicy Bypass -File scripts/Package-Release.ps1
```

See the [implementation plan](PLAN.md), [production specification](docs/PRODUCTION_SPEC.md), and [test plan](docs/TEST_PLAN.md). Security issues and private disclosure guidance are in [SECURITY.md](SECURITY.md).

No redistribution license has been selected by the project owner.
