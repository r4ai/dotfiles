Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
#! ---PROMPT---
Invoke-Expression (&starship init powershell)

#! ---IMPORT MODULES---
Import-Module posh-git # gitのタブ補完
if (Get-Command gh -ErrorAction SilentlyContinue) {
  Invoke-Expression -Command $(gh completion -s powershell | Out-String)
}
if (Get-Command volta -ErrorAction SilentlyContinue) {
  Invoke-Expression -Command $(volta completions powershell | Out-String)
}
Import-Module Terminal-Icons # ls時にアイコンを表示する

#! ---MISE---
mise activate pwsh | Out-String | Invoke-Expression

#! ---ALIAS---
Set-Alias -Name 'which' -Value 'Get-Command'
Set-Alias -Name 'll' -Value 'ls'

#! ---ORIGINAL FUNCTIONS---
function lt() {
  lsd -A --tree
}
function cat() {
  bat
}
function touch($file) {
  If (Test-Path $file) {
      (Get-Item $file).LastWriteTime = Get-Date
  }
  Else {
    Out-File -encoding Default $file
  }
}
function open($path) {
  explorer.exe $path
}
function reload() {
  . $profile
}
function gs() {
  git status
}
