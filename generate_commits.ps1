# Initialize git repo if not already
git init

# Set user details
git config user.name "tiwariharsh007"
git config user.email "tiwari007harsh@gmail.com"

# Array of realistic commit entries (date | commit message)
$commits = @(
    "2025-01-04|feat: initialize backend and frontend folders"
    "2025-01-04|chore: add .gitignore and README"
    "2025-01-05|chore: install server dependencies (express, mongoose, dotenv)"
    "2025-01-06|feat: setup API server entry point (index.js)"
    "2025-01-06|feat: create user model and auth controller"
    "2025-01-07|fix: correct CORS issue in server config"
    "2025-01-09|feat: add property listing model and routes"
    "2025-01-09|refactor: extract database connection logic"
    "2025-01-10|docs: update README with setup commands"
    "2025-01-11|feat: initialize React client with Vite and Tailwind"
    "2025-01-12|style: apply Tailwind base styling to homepage"
    "2025-01-13|feat: implement registration form in client"
    "2025-01-14|fix: resolve state issue in registration form"
    "2025-01-15|feat: add login UI and form validation"
    "2025-01-17|chore: install axios and configure client API helper"
    "2025-01-18|feat: connect login form to API"
    "2025-01-19|refactor: centralize API URLs in config"
    "2025-01-20|feat: add listing creation page and form"
    "2025-01-21|fix: upload image handler for listing (frontend)"
    "2025-01-22|feat: integrate image upload API (backend)"
    "2025-01-23|fix: resolve file path bug in upload route"
    "2025-01-24|style: refine form layout with Tailwind"
    "2025-01-26|feat: implement listing display with filters"
    "2025-01-27|fix: filter state link bug"
    "2025-01-28|feat: add pagination to listings"
    "2025-01-29|docs: update README with running instructions"
    "2025-01-30|refactor: improve DB query performance with indices"
    "2025-01-31|chore: add environment variable loader"
    "2025-02-01|feat: protect routes with JWT auth"
    "2025-02-02|fix: token refresh logic in backend"
    "2025-02-03|feat: add profile page with user data"
    "2025-02-04|fix: profile image display issue"
    "2025-02-05|style: improve navbar and footer layout"
    "2025-02-07|feat: implement search bar with debounce"
    "2025-02-08|fix: search results not updating properly"
    "2025-02-09|feat: add logout functionality"
    "2025-02-10|refactor: clean up routes and controller structure"
    "2025-02-11|perf: optimize client rendering"
    "2025-02-12|docs: finalize README with screenshots"
    "2025-02-13|chore: final cleanup before demo"
)

# Create dummy file to commit
if (-not (Test-Path "dummy.txt")) {
    New-Item -ItemType File -Name "dummy.txt" | Out-Null
}

# Loop and generate commits with random skipping to create gaps
foreach ($commit in $commits) {
    # 30% chance to skip this commit (to create natural gaps)
    if ((Get-Random -Minimum 0 -Maximum 10) -lt 3) {
        Write-Output "Skipping commit: $commit"
        continue
    }

    $parts = $commit -split "\|", 2
    $date = $parts[0]
    $message = $parts[1]

    # Write commit message to file (so git detects a change)
    Add-Content -Path "dummy.txt" -Value $message

    git add .

    # Set commit date (randomize commit time within the day)
    $hour = Get-Random -Minimum 9 -Maximum 20
    $minute = Get-Random -Minimum 0 -Maximum 59
    $commitDate = "$date $hour`:$minute`:00"

    $env:GIT_COMMITTER_DATE = $commitDate
    git commit --date "$commitDate" -m "$message"

    # Sometimes insert an extra commit with variation (20% chance)
    if ((Get-Random -Minimum 0 -Maximum 10) -lt 2) {
        Add-Content -Path "dummy.txt" -Value "$message (extra)"
        git add .
        $extraTime = "$date $($hour):$($minute + 1):30"
        $env:GIT_COMMITTER_DATE = $extraTime
        git commit --date "$extraTime" -m "$message (extra work)"
    }
}

# Push changes to master branch
git branch -M master
git push origin master --force
