
**Important:** The script looks for these **exact folder names**. Do not rename or move them.

## How to Use

### Recommended: Method 1 (if available)

1. Download and extract the ZIP from the repository
2. Right-click on `Install-AllRuntimes-(RunAdmin!).ps1`
3. Select **Run with PowerShell as administrator**  
   (or **Run as administrator** if you see that option)
4. Wait — the PowerShell window will show progress
5. When finished, you'll see a confirmation message

### Method 2 – When right-click option is missing or doesn't work

1. Extract the ZIP to a folder (e.g. Desktop\Apexs-AIO)
2. Open **File Explorer** and navigate to the Apexs-AIO folder
3. In the address bar at the top, click once → type `cmd` → press Enter  
   → this opens Command Prompt in the correct directory
4. In the black Command Prompt window, paste this **single line** and press Enter:

   ```cmd
   powershell -ExecutionPolicy Bypass -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -File \"Install-AllRuntimes-(RunAdmin!).ps1\"'"
