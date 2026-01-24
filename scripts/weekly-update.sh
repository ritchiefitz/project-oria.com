#!/bin/bash
# Daily Oria Update Script (set to daily for testing)
# Run with: ./scripts/weekly-update.sh
# This script triggers Claude Code in headless mode to perform automated updates

set -e

cd "$(dirname "$0")/.."

# The prompt that instructs Claude to perform all tasks
PROMPT=$(cat << 'HEREDOC'
You are authorized to search the web and make changes to this codebase. Please complete the following four tasks in order:

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

## TASK 2: Create an Original 2D Game for the Sandbox

Invent and build an original 2D video game for the Oria Sandbox. Be creative - design something fun and unique that you're confident you can implement in a single shot.

**IMPORTANT: Never create the same type of game twice. Check what games already exist in the sandbox and invent something completely different.**

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

## TASK 3: Weekly Stock Predictions

Update the stock predictions page with new picks and last week's results.

**You have permission to use WebSearch** to research stocks and find current prices.

Steps:
1. Read `public/stocks/predictions.json` to see existing predictions
2. If there's a previous week with `resultsAdded: false`:
   - Use WebSearch to find the current/closing price for each stock from that week
   - Update each pick's `actualPrice` field with the real price
   - Set `resultsAdded: true` for that week
3. Research and select 5 US stocks you expect to rise over the next week:
   - Use WebSearch to analyze market trends, news, earnings, and momentum
   - Focus on stocks with clear catalysts (earnings, news, technical breakouts)
   - Look for a mix of sectors for diversification
4. For each pick, get the current stock price via WebSearch
5. Add a new week entry to the TOP of the `weeks` array in predictions.json:
   ```json
   {
     "weekOf": "January 25, 2026",
     "resultsAdded": false,
     "picks": [
       {
         "ticker": "AAPL",
         "company": "Apple Inc.",
         "startPrice": 185.50,
         "targetPrice": 192.00,
         "reasoning": "Brief 1-sentence reason"
       }
     ]
   }
   ```
6. Target price should be a realistic 3-8% gain expectation
7. Keep reasoning brief but specific (earnings, momentum, news catalyst, etc.)

---

## TASK 4: Commit and Push

After completing tasks 1, 2, and 3:
1. Run `git status` to see all changes
2. Run `git diff` to review changes
3. Stage all new and modified files with specific file paths (not `git add -A`)
4. Create a descriptive commit message summarizing the blog post, game, AND stock picks
5. Push to main branch with `git push origin main`

Example commit message format:
```
Weekly update: [blog topic] + [Game Name] + stock picks

Blog: [1-2 sentence summary of the AI news covered]
Sandbox: Added [Game Name] - [brief description]
Stocks: [X] new picks for the week, updated last week's results

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

---

Please complete all three tasks now. Start by searching the web for recent AI news.
HEREDOC
)

# Run Claude Code in headless mode with the prompt
echo "Starting weekly Oria update..."
echo "================================"
claude -p "$PROMPT" \
  --model opus \
  --dangerously-skip-permissions \
  --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Glob,Grep,Bash(git*)"

echo "================================"
echo "Weekly update complete!"
