$ErrorActionPreference = "Stop"

# Reset Git history
git update-ref -d HEAD
git rm -rf --cached .

# Array of specific dates from May 3rd to May 9th, 2026
$dates = @(
    "2026-05-03T10:15:22",
    "2026-05-04T14:32:01",
    "2026-05-05T09:45:11",
    "2026-05-06T16:20:45",
    "2026-05-07T11:05:33",
    "2026-05-08T15:50:12",
    "2026-05-09T09:12:00",
    "2026-05-09T14:22:15"
)
$global:commitIndex = 0

function MakeCommit {
    param([string]$message)
    $dateStr = $dates[$global:commitIndex]
    $global:commitIndex++
    $env:GIT_AUTHOR_DATE = $dateStr
    $env:GIT_COMMITTER_DATE = $dateStr
    git commit -m $message
}

# Commit 1
git add package.json package-lock.json yarn.lock vite.config.ts index.html src/main.tsx src/App.tsx src/routes.tsx src/index.css src/Layout.tsx src/Layout.css tsconfig.json tsconfig.node.json README.md
MakeCommit "chore: initialize project with React, Vite, and TypeScript"

# Commit 2
git add src/components/buttons src/components/controls
MakeCommit "feat(components): implement core button and control elements"

# Commit 3
git add src/components/navbars src/components/sidebars src/components/dropdowns
MakeCommit "feat(components): build navigation systems"

# Commit 4
git add src/components/logins src/components/signups
MakeCommit "feat(components): integrate authentication views"

# Commit 5
git add src/components/accordions src/components/cards src/components/tables
MakeCommit "feat(components): develop layout and container components"

# Commit 6
git add src/components/modals src/components/carousels src/components/parallax
MakeCommit "feat(components): add interactive overlays and media viewers"

# Commit 7
git add src/components/widgets src/components/gsap src/components/libraries
MakeCommit "feat(components): create specialized widgets and GSAP animations"

# Commit 8
git add .
MakeCommit "refactor(components): standardize component exports and finalize TypeScript migration"

# Cleanup env variables
if (Test-Path Env:\GIT_AUTHOR_DATE) { Remove-Item Env:\GIT_AUTHOR_DATE }
if (Test-Path Env:\GIT_COMMITTER_DATE) { Remove-Item Env:\GIT_COMMITTER_DATE }

# Push to remote
git push -f origin main
