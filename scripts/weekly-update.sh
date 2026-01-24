#!/bin/bash
# Daily Oria Update Script (set to daily for testing)
# Run with: ./scripts/weekly-update.sh
# This script triggers Claude Code in headless mode to perform automated updates

set -e

cd "$(dirname "$0")/.."

# The prompt that instructs Claude to perform all tasks
PROMPT=$(cat << 'HEREDOC'
You are authorized to search the web and make changes to this codebase. Please complete the following three tasks in order:

---

## TASK 1: Write a New AI News Blog Post

**You have permission to use the WebSearch tool** to find recent AI news from the past week (use today's date to search for news from the last 7 days).

Steps:
1. Use WebSearch to find 2-3 significant AI news stories from the past week
2. Write a comprehensive blog post synthesizing these developments
3. Create the blog post HTML file at `public/blog/{slug}.html` using the template at `public/blog/_template.html`
4. Update `public/blog/posts.json` by adding the new post to the TOP of the posts array
5. Use "Claude" as the author name
6. Format the date as "Month Day, Year" (e.g., "January 23, 2026")

---

## TASK 2: Add a Retro Arcade Game to the Sandbox

Create or update the Oria Sandbox with a fun, playable retro-style arcade game.

**IMPORTANT: You must create a DIFFERENT game each time. Check what games already exist in the sandbox and create something new.**

Game ideas (pick one that doesn't already exist):
- Snake
- Breakout/Brick Breaker
- Asteroids
- Space Invaders
- Pong
- Tetris
- Pac-Man style maze game
- Flappy Bird clone
- Frogger
- Galaga-style shooter

Steps:
1. Check if `public/sandbox/` directory exists and what games are already there
2. If the sandbox page (`public/sandbox/index.html`) doesn't exist, create it with navigation and a game grid
3. Create a new game HTML file at `public/sandbox/{game-name}.html` with the full game implementation
4. The game must be:
   - Self-contained (all HTML/CSS/JS in one file)
   - Playable with keyboard controls
   - Have a score display
   - Match the Oria dark theme (purple/indigo gradients, dark background)
   - Mobile-friendly where possible
5. Update the sandbox index to include the new game
6. Add a "Sandbox" link to the navigation in `public/index.html` if not present

---

## TASK 3: Commit and Push

After completing tasks 1 and 2:
1. Run `git status` to see all changes
2. Run `git diff` to review changes
3. Stage all new and modified files with specific file paths (not `git add -A`)
4. Create a descriptive commit message summarizing both the blog post topic AND the game added
5. Push to main branch with `git push origin main`

Example commit message format:
```
Add weekly AI update: [brief topic] + [Game Name] arcade game

Blog: [1-2 sentence summary of the AI news covered]
Sandbox: Added [Game Name] - a classic arcade game with [brief description]

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

---

Please complete all three tasks now. Start by searching the web for recent AI news.
HEREDOC
)

# Run Claude Code in headless mode with the prompt
echo "Starting weekly Oria update..."
echo "================================"
claude -p "$PROMPT" --model claude-opus-4-5-20250101 --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Glob,Grep,Bash(git*)"

echo "================================"
echo "Weekly update complete!"
