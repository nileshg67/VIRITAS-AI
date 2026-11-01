param(
    [int]$Port = 5000,
    [string]$Root = ""
)

if ([string]::IsNullOrWhiteSpace($Root)) {
    if ([string]::IsNullOrWhiteSpace($PSScriptRoot)) {
        $Root = (Get-Location).Path
    } else {
        $Root = $PSScriptRoot
    }
}


$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:$Port/"

try {
    $listener.Prefixes.Add($prefix)
    $listener.Start()
} catch {
    # If default port is occupied, try fallback ports
    foreach ($p in @(5001, 8080, 3000, 8000, 8888, 9000)) {
        try {
            $Port = $p
            $prefix = "http://localhost:$Port/"
            $listener = New-Object System.Net.HttpListener
            $listener.Prefixes.Add($prefix)
            $listener.Start()
            break
        } catch { }
    }
}

if (-not $listener.IsListening) {
    Write-Host "Could not bind HTTP server. Opening app.html directly..." -ForegroundColor Yellow
    Start-Process (Join-Path $Root "app.html")
    exit 0
}

$url = "http://localhost:$Port/"
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  VERITAS - AI Plagiarism & Originality Checker" -ForegroundColor Green
Write-Host "  Running locally without npm / Node.js" -ForegroundColor White
Write-Host "  Server URL: $url" -ForegroundColor Yellow
Write-Host "  Press Ctrl+C in this window to stop the server." -ForegroundColor Gray
Write-Host "============================================================" -ForegroundColor Cyan

Start-Process $url

$mimeMap = @{
    ".html" = "text/html; charset=utf-8"
    ".htm"  = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".mjs"  = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
    ".ttf"  = "font/ttf"
    ".pdf"  = "application/pdf"
}

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $path = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($path)) {
            if (Test-Path (Join-Path $Root "dist\index.html")) {
                $path = "dist\index.html"
            } elseif (Test-Path (Join-Path $Root "app.html")) {
                $path = "app.html"
            } else {
                $path = "index.html"
            }
        }

        # Normalize slashes
        $path = $path.Replace('/', [System.IO.Path]::DirectorySeparatorChar)
        $filePath = Join-Path $Root $path

        if (Test-Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = if ($mimeMap.ContainsKey($ext)) { $mimeMap[$ext] } else { "application/octet-stream" }
            
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentType = $mime
            $response.ContentLength64 = $bytes.Length
            $response.AddHeader("Access-Control-Allow-Origin", "*")
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $msg = [System.Text.Encoding]::UTF8.GetBytes("File Not Found: $path")
            $response.OutputStream.Write($msg, 0, $msg.Length)
        }
        $response.Close()
    } catch {
        # Silent ignore on client abort
    }
}
