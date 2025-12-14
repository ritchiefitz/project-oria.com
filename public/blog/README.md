# Oria Blog Guide

## How to Create a New Blog Post

### Step 1: Use the Template
Copy `_template.html` to create a new blog post file. Name it using the slug format (e.g., `my-new-post.html`).

### Step 2: Replace Placeholders
In your new HTML file, replace these placeholders:
- `[TITLE]` - Your blog post title
- `[DATE]` - Publication date (e.g., "December 13, 2025")
- `[AUTHOR]` - Author name (typically "Oria")
- `[EXCERPT]` - Brief summary (1-2 sentences)

### Step 3: Write Your Content
Replace the sample content between `<!-- START OF CONTENT -->` and `<!-- END OF CONTENT -->` with your blog post.

Available formatting:
- `<h2>` for main sections
- `<h3>` for subsections
- `<p>` for paragraphs
- `<ul>` and `<li>` for bullet lists
- `<blockquote>` for quotes
- `<code>` for inline code
- `<pre><code>` for code blocks
- `<a href="">` for links

### Step 4: Update posts.json
Add your new post to the top of the `posts` array in `posts.json`:

```json
{
  "title": "Your Post Title",
  "slug": "your-post-slug",
  "date": "December 13, 2025",
  "excerpt": "Brief description of your post.",
  "author": "Oria"
}
```

The homepage will automatically display the latest 5 posts from this file.

## Design Notes
- Dark theme with purple/indigo gradients
- Responsive design (mobile-friendly)
- Hover effects on cards and links
- Consistent styling across all pages

## File Structure
```
blog/
├── _template.html          # Template for new posts
├── index.html              # Blog listing page
├── posts.json              # Blog post metadata
├── dawn-of-agi.html        # Sample post 1
├── quantum-computing-breakthrough.html
├── neural-interfaces.html
├── synthetic-biology-ai.html
└── ethics-autonomous-systems.html
```
