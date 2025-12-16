# Day 0: Emacs Basics (Before You Start!)
## Understanding Frames, Windows, Buffers, and Scratch

**READ THIS FIRST** before starting the curriculum!

**Time:** 15 minutes to understand
**Goal:** Know what you're looking at when Emacs opens

---

## 🪟 What Am I Looking At?

When you open Emacs, you see several things. Let's break it down:

```
┌─────────────────────────────────────────┐
│  Frame (the whole application window)  │  ← THIS IS THE FRAME
│  ┌───────────────────────────────────┐ │
│  │                                   │ │
│  │     Window (displays a buffer)    │  ← THIS IS A WINDOW
│  │                                   │ │
│  │  *scratch*                        │  ← THIS IS THE BUFFER NAME
│  │  ;; This buffer is for text...   │  ← BUFFER CONTENTS
│  │                                   │ │
│  └───────────────────────────────────┘ │
│  Mode line                            │  ← STATUS BAR
│  Minibuffer                           │  ← COMMAND AREA
└─────────────────────────────────────────┘
```

---

## 1️⃣ Frame

**What it is:** The whole Emacs application window (what you see on screen)

**Think of it as:** The picture frame around everything

**Examples:**
- When you click the Emacs icon, you open a **frame**
- You can have multiple frames (like multiple windows of Chrome)
- `⌘-N` creates a new frame (don't do this yet!)

**Real-world analogy:**
```
Frame = Your house
Windows = Rooms in your house
Buffers = Furniture in the rooms
```

---

## 2️⃣ Window

**What it is:** A view into a buffer (you can split into multiple windows)

**Think of it as:** A pane showing content

**Examples:**

### Single Window (default):
```
┌─────────────────────┐
│                     │
│   One window        │
│   showing           │
│   myfile.R          │
│                     │
└─────────────────────┘
```

### Split Vertically (side-by-side):
```
┌──────────┬──────────┐
│          │          │
│ Window 1 │ Window 2 │
│ myfile.R │ tests.R  │
│          │          │
└──────────┴──────────┘
```

### Split Horizontally (top/bottom):
```
┌─────────────────────┐
│   Window 1          │
│   myfile.R          │
├─────────────────────┤
│   Window 2          │
│   R Console         │
└─────────────────────┘
```

**Key Point:** You can have many windows showing different buffers!

---

## 3️⃣ Buffer

**What it is:** The actual content (file, R console, help page, etc.)

**Think of it as:** A tab (but invisible until shown in a window)

**Examples of buffers:**

1. **File buffer:** `myfile.R` (your R script)
2. **R console buffer:** `*R*` (running R session)
3. **Scratch buffer:** `*scratch*` (temporary notes)
4. **Help buffer:** `*Help*` (documentation)
5. **Magit buffer:** `magit: myproject` (git status)

**Key Concepts:**

- **Buffers exist even when not visible**
- You might have 20 open buffers but only see 2 windows
- Switching buffers = showing different content in current window

**Real-world analogy:**
```
Buffer = A document
Window = A desk where you read the document
Frame = The room containing desks

You can have many documents (buffers),
but only see the ones on your desks (windows),
all inside your room (frame).
```

---

## 4️⃣ Scratch Buffer

**What it is:** A special buffer for quick notes and testing Lisp code

**Think of it as:** A notepad that appears by default

**What you see when opening Emacs:**

```
;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with 'C-x C-f' and enter text in its buffer.

```

**Why it exists:**
- Temporary scratchpad for notes
- Test Emacs Lisp code
- Paste temporary text
- Quick calculations

**Important:**
- `*scratch*` is NOT saved automatically
- It's meant for temporary stuff
- Most people just ignore it and open real files

---

## 📝 Visual Examples

### Example 1: Fresh Emacs Start

```
You open Emacs:
┌─────────────────────────────────────┐
│ Frame (the app window)              │
│  ┌───────────────────────────────┐  │
│  │ Window #1 (full screen)       │  │
│  │                               │  │
│  │ Buffer: *scratch*             │  │
│  │ ;; This buffer is for text... │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│  [*scratch*] (mode line)            │
└─────────────────────────────────────┘

Count: 1 frame, 1 window, 1 visible buffer (but many hidden buffers exist)
```

---

### Example 2: Working on R Package

```
After opening files and splitting:
┌──────────────────────────────────────────┐
│ Frame                                    │
│  ┌─────────────────┬──────────────────┐  │
│  │ Window 1        │ Window 2         │  │
│  │                 │                  │  │
│  │ Buffer: utils.R │ Buffer: *R*      │  │
│  │ my_func <- ...  │ R Console        │  │
│  │                 │ > mean(1:10)     │  │
│  │                 │ [1] 5.5          │  │
│  └─────────────────┴──────────────────┘  │
│  [utils.R]            [*R*]              │
└──────────────────────────────────────────┘

Count: 1 frame, 2 windows, 2 visible buffers
Hidden buffers: test-utils.R, DESCRIPTION, *scratch*, *Messages*, etc.
```

---

### Example 3: Complex Workflow

```
Maximum productivity setup:
┌──────────────────────────────────────────┐
│ Frame                                    │
│  ┌─────────────────┬──────────────────┐  │
│  │ Win 1: utils.R  │ Win 2: test.R    │  │
│  ├─────────────────┴──────────────────┤  │
│  │ Win 3: *R* (R console)             │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘

Count: 1 frame, 3 windows, 3 visible buffers
You can: Edit code (top left), write tests (top right), run R (bottom)
```

---

## 🎯 Common Confusion Cleared Up

### "I closed my file but it's still open?"

**What happened:**
- You closed the **window** showing the buffer
- The **buffer** (file content) is still in memory
- It's just not visible anymore

**How to see hidden buffers:**
- Vanilla Emacs: `C-x C-b` (list buffers)
- Spacemacs: `SPC b b` (switch buffer)

---

### "I have 10 tabs open?"

**Correction:**
- Emacs doesn't have "tabs" (by default)
- You have **10 open buffers**
- They're hidden until you display them in a window

---

### "How do I see all my open files?"

**Answer:**
- Your "open files" are **buffers**
- List them: `SPC b b` (Spacemacs) or `C-x C-b` (vanilla)
- Each file = 1 buffer

---

## 🧪 Interactive Demonstration

**Try this RIGHT NOW to understand:**

### Step 1: Open Emacs

```bash
emacs
```

You see: 1 frame, 1 window, 1 buffer (*scratch*)

---

### Step 2: Open a file

In Emacs:
1. Press `SPC f f` (Spacemacs) or `C-x C-f` (vanilla)
2. Type path to any R file
3. Press Enter

Now you see: 1 frame, 1 window, **different buffer** (your R file)

**Question:** Where did *scratch* go?
**Answer:** Still exists! Just hidden. The window now shows your R file buffer.

---

### Step 3: Switch back to scratch

1. Press `SPC b b` (Spacemacs) or `C-x b` (vanilla)
2. Type `*scratch*`
3. Press Enter

Now you see: 1 frame, 1 window, *scratch* buffer again

**Question:** Where did your R file go?
**Answer:** Still open! Just not visible. It's a hidden buffer.

---

### Step 4: Split the window

1. Press `SPC w /` (Spacemacs) or `C-x 3` (vanilla)

Now you see: 1 frame, **2 windows**, same buffer in both

---

### Step 5: Show different buffers in each window

1. In right window, press `SPC b b` (Spacemacs) or `C-x b` (vanilla)
2. Switch to your R file

Now you see: 1 frame, 2 windows, 2 different buffers!

---

## 📖 Terminology Reference Card

| Term | What It Is | Real-World Analogy |
|------|------------|-------------------|
| **Frame** | The app window | Your house |
| **Window** | A pane showing content | A room |
| **Buffer** | The actual content/file | Furniture |
| **Scratch** | Temporary notepad buffer | Sticky note pad |
| **Mode Line** | Status bar below window | Room label |
| **Minibuffer** | Command area at bottom | Your voice (for commands) |

---

## 🎨 Cheat Sheet: Frame vs Window vs Buffer

### Frame Operations

| Action | Vanilla | Spacemacs | Result |
|--------|---------|-----------|--------|
| New frame | `C-x 5 2` | Don't need | Opens new window |
| Close frame | `C-x 5 0` | `SPC q q` | Closes window |

**Note:** You rarely need multiple frames. Ignore these for now.

---

### Window Operations

| Action | Vanilla | Spacemacs | Result |
|--------|---------|-----------|--------|
| Split vertical | `C-x 3` | `SPC w /` | Side-by-side |
| Split horizontal | `C-x 2` | `SPC w -` | Top/bottom |
| Close window | `C-x 0` | `SPC w d` | Removes pane |
| Close others | `C-x 1` | `SPC w m` | Only current remains |
| Switch window | `C-x o` | `SPC w w` | Move between panes |

---

### Buffer Operations

| Action | Vanilla | Spacemacs | Result |
|--------|---------|-----------|--------|
| List buffers | `C-x C-b` | `SPC b b` | Shows all open |
| Switch buffer | `C-x b` | `SPC b b` | Change current view |
| Kill buffer | `C-x k` | `SPC b k` | Close file |
| Scratch | `C-x b *scratch*` | `SPC b b` → *scratch* | Open notepad |

---

## ✅ Self-Check: Do You Understand?

Answer these before moving to Week 1:

1. **You open Emacs and see *scratch*. What are you looking at?**
   <details><summary>Answer</summary>
   You're looking at:<br>
   - 1 Frame (the app window)<br>
   - 1 Window (the viewing pane)<br>
   - 1 Buffer (*scratch* - temporary notepad)
   </details>

2. **You split the screen. How many frames do you have?**
   <details><summary>Answer</summary>
   Still 1 frame!<br>
   You created a new WINDOW, not a new frame.
   </details>

3. **You open file.R, then test.R. How many buffers?**
   <details><summary>Answer</summary>
   At least 3 buffers:<br>
   - *scratch* (always exists)<br>
   - file.R<br>
   - test.R<br>
   Plus hidden system buffers (*Messages*, etc.)
   </details>

4. **Can a buffer exist without being visible?**
   <details><summary>Answer</summary>
   YES! Most buffers are hidden most of the time.<br>
   Only buffers shown in windows are visible.
   </details>

5. **If you close all windows, what happens to buffers?**
   <details><summary>Answer</summary>
   Buffers still exist in memory!<br>
   You can switch to them again.<br>
   To truly close a buffer, use "kill buffer" (`SPC b k`).
   </details>

---

## 🚀 Now You're Ready!

**You understand:**
- ✅ Frame = The app window
- ✅ Window = A viewing pane (can have multiple)
- ✅ Buffer = The actual content (files, consoles, etc.)
- ✅ Scratch = Default temporary notepad
- ✅ Buffers can be hidden but still open

**Next steps:**

1. **Practice the demonstration** above (5 minutes)
2. **Read** `00-QUICK-START.md` (installation guide)
3. **Start** `02-LEARNING-CURRICULUM.md` Week 1, Day 1
4. **Keep this file** open for reference

---

## 💡 Pro Tips

1. **Scratch buffer is your friend** - use it for:
   - Quick calculations
   - Temporary clipboard
   - Testing code snippets
   - Scratchpad during calls

2. **Don't fear hidden buffers** - they're not "lost," just not visible

3. **Windows ≠ tabs** - stop thinking in tabs, think in panes

4. **One frame is enough** - you almost never need multiple frames

---

**You're ready to start the curriculum! Head to Week 1, Day 1** 🎯

---

## Quick Reference While Learning

Keep this visible:

```
FRAME: The app window (ignore for now)
  └─ WINDOW: A viewing pane (can split)
      └─ BUFFER: The actual content (file, console, etc.)

*scratch* = Temporary notepad buffer (always available)

To switch between buffers: SPC b b (Spacemacs) or C-x b (vanilla)
To split window: SPC w / (vertical) or SPC w - (horizontal)
To close window: SPC w d
```

**Now go learn Vim! 💪**
