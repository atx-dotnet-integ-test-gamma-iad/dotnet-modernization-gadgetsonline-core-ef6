# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended modern .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing `net48` or any other legacy .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm runtime behavior matches the pre-migration baseline.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to verify no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and address them individually.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available on cross-platform .NET. If any were referenced, confirm they have been replaced with ASP.NET Core equivalents.
- **Windows-specific APIs**: APIs such as the registry, certain cryptography providers, or Windows ACLs may throw `PlatformNotSupportedException` at runtime on non-Windows systems.
- **Configuration system**: Ensure `web.config` or `app.config` settings have been migrated to `appsettings.json` and are being read via `IConfiguration`.
- **Entity Framework**: If the project uses Entity Framework 6, confirm whether it has been migrated to Entity Framework Core, as EF6 has limited cross-platform support.

### 7. Test on Target Platform

If the goal is to run on Linux or macOS, test the application on that operating system explicitly. Runtime issues that do not appear on Windows may surface there.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 8. Review Warnings

Build warnings can indicate future compatibility issues. Run the build with detailed output and review all warnings:

```bash
dotnet build --configuration Release /warnaserror
```

Address any warnings that are relevant to the application's correctness or long-term maintainability.

### 9. Publish the Application

Once validation is complete, publish the application for the target runtime:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --runtime linux-x64 --self-contained false
```

Adjust the `--runtime` flag to match your deployment target (e.g., `win-x64`, `osx-x64`, `linux-x64`).

Review the published output in the `publish` folder before deploying to the target environment.