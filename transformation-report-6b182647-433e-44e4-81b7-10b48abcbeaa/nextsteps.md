# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm functional correctness.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Windows-Specific Dependencies

Even when a project builds successfully, runtime failures can occur due to Windows-specific APIs or libraries that were not caught at compile time. Review the codebase for usage of the following:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-cross-platform variants)
- Registry access (`RegistryKey`)
- Windows-specific file path assumptions (e.g., hardcoded backslashes)
- COM interop or P/Invoke calls targeting Windows DLLs

Replace or abstract any such usages with cross-platform alternatives where necessary.

### 7. Verify Static Assets and Configuration Files

Confirm that files such as `appsettings.json`, `web.config` (if applicable), and any static assets are correctly included in the project output. Check the `.csproj` file for appropriate `<Content>` or `<EmbeddedResource>` entries.

### 8. Test on Target Platform

If the goal is Linux or macOS compatibility, run the application on the target operating system to surface any platform-specific runtime issues that would not appear on Windows.

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Transfer and run the published output on the target platform to confirm compatibility.

### 9. Review Deprecated or Removed APIs

Use the .NET Upgrade Analyzer or inspect build warnings to identify any APIs that are marked as obsolete in the target framework version. Address these proactively to avoid issues in future framework upgrades.

```bash
dotnet build --configuration Release /warnaserror
```

This treats warnings as errors and forces resolution of any outstanding compatibility concerns.