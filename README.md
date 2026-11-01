# Veritas AI - Plagiarism & Originality Checker

A modern, responsive, and easy-to-use Plagiarism and Originality Detection web application with multimodal OCR image upload support, powered by React, Vite, and an in-browser NLP Detection Engine.

## ✨ Highlights & Features
- **🚀 100% Free & Zero API Key Setup**: Open the website and scan instantly. No Google Gemini API key or signup required.
- **🔍 Multi-Layer Plagiarism Engine**:
  - N-gram shingle fingerprinting and winnowing algorithm to detect exact phrase copying.
  - Real-time Wikipedia and Open Web knowledge cross-referencing.
  - Pre-indexed academic papers, literature, speeches, and scientific definitions corpus.
  - Paraphrasing and synonym-substitution detection via Jaccard and Levenshtein metrics.
  - AI Stylometry & Perplexity/Burstiness detector (Type-Token ratio, sentence length variance, AI marker words).
- **📸 In-Browser Multimodal OCR**: Drag and drop photos or screenshots of documents/assignments (JPEG, PNG, WebP) with client-side OCR extraction.
- **⚖️ Side-by-Side Comparator**: Directly compare two documents or submissions to find overlapping phrases and calculate similarity percentages.
- **📄 PDF Report Generator**: Export professional Originality Certificates and diagnostic reports with one click.
- **🔎 Sentence-by-Sentence Breakdown**: Interactive color-coded breakdown with clickable diagnosis, citations, and suggested rewrite fixes.
- **🕒 Local Scan History**: Stores scan reports in a browser IndexedDB database, with up to 100 recent reports retained across reloads. Existing localStorage history is migrated automatically.

## 🚀 How to Run (Without npm / Node.js)

You can run Veritas immediately **without installing Node.js or using npm**:

### Option 1: 1-Click Batch Launcher (Recommended)
- Simply double-click **`RUN_APP.bat`** in this folder.
- It will start a lightweight local server and automatically launch Veritas in your default browser.
- To use the latest source changes, run `npm run build` first; the launcher will serve the built app from `dist/index.html` when available.

### Option 2: Direct File Opening
- Double-click **`OPEN_IN_BROWSER.bat`** or directly double-click **`app.html`** in this folder.
- It will open the self-contained single-file web application in your browser instantly.

---

## 🛠️ Developer Mode (With npm / Node.js)

If you have Node.js and want to run or edit the source code:

### 1. Installation
```bash
npm install
```

### 2. Development Server
```bash
npm run dev
```
The application will run at `http://localhost:3000`.

### 3. Build Single-File Standalone App
```bash
npm run build
```
This builds the self-contained `dist/index.html` file.

## 🗄️ Scan History Database

Scan history is persisted locally in the browser using IndexedDB. Reports stay on the device and browser profile where they were created; they are not uploaded to a remote database. Clearing browser site data removes these saved reports. Build the app with `npm run build` before launching it if you want to use this database-backed version from the standalone launcher.

