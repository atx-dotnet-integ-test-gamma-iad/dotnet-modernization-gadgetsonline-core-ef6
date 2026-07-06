# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution appears to have transformed successfully. No build errors were detected in any of the projects, including `GadgetsOnline/GadgetsOnline.csproj`. The following steps outline how to validate, test, and deploy the migrated project.

---

## 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, locate them in the `.csproj` file and search [NuGet.org](https://www.nuget.org) for a compatible version.

---

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or platform compatibility.

---

## 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify the appropriate meta-package is referenced, such as `Microsoft.AspNetCore.App`.

---

## 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether the failures are caused by the migration or pre-existing issues.

---

## 5. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:
- Database connectivity and migrations (if using Entity Framework)
- Authentication and authorization flows
- Any file system or path-dependent operations that may behave differently across platforms
- Static file serving and routing (if this is a web project)

---

## 6. Check for Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or patterns that may not function correctly on Linux or macOS:

- `Registry` access (`Microsoft.Win32.Registry`)
- `System.Windows.Forms` or `System.Drawing` references
- Hardcoded Windows-style file paths (e.g., `C:\`)
- COM interop calls

Replace or conditionally compile any such code using platform checks where necessary:

```csharp
if (OperatingSystem.IsWindows())
{
    // Windows-specific logic
}
```

---

## 7. Review Configuration Files

Ensure that `appsettings.json` (and environment-specific variants such as `appsettings.Production.json`) are present and correctly configured. If the project previously used `Web.config` or `App.config`, confirm that the relevant settings have been migrated to the new configuration system.

---

## 8. Publish the Application

Once validation is complete, publish the application to a self-contained or framework-dependent deployment:

**Framework-dependent:**
```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

**Self-contained (example for Linux x64):**
```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --runtime linux-x64 --self-contained true --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.