# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the clean state:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `0 Error(s)` and review any warnings that may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves as expected compared to the legacy version.

### 5. Check for Removed or Changed APIs

Even without build errors, certain APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm no runtime references exist.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that migrations are intact.
- **Windows-specific APIs**: Any use of the registry, Windows authentication, or COM interop may fail at runtime on non-Windows platforms.
- **`HttpContext` and session handling**: Behavior differences may exist and should be tested explicitly.

### 6. Execute Unit Tests

If a test project exists in the solution, run all tests to validate logic correctness:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 7. Review Configuration Files

- Confirm that `web.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable.
- Verify that connection strings, application settings, and environment-specific values are correctly represented.
- Ensure that `Program.cs` and `Startup.cs` (or the combined `Program.cs` in minimal hosting model) correctly registers all required services and middleware.

### 8. Test on Target Platform

If the intent is to run on Linux or macOS, test the application explicitly on that platform to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay attention to file path casing, line endings, and any OS-specific behavior.

### 9. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all expected files, static assets, and configuration files are present.