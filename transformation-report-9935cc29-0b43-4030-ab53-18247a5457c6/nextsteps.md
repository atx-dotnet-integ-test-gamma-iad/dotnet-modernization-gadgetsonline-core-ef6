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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a current and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those earlier versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, paying particular attention to any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Execute the Test Suite

If the solution contains test projects, run them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences introduced by the framework migration rather than pre-existing failures.

### 6. Review Removed or Changed APIs

Check the application for usage of any APIs that behave differently in cross-platform .NET compared to .NET Framework. Common areas to review include:

- **Configuration**: Ensure `appsettings.json` is used in place of `Web.config` or `App.config` where applicable.
- **Authentication and Authorization**: Verify middleware is correctly configured in `Program.cs` or `Startup.cs`.
- **Entity Framework**: If using Entity Framework, confirm migrations are compatible with the new runtime and that the database provider package is current.
- **File paths**: Confirm that any hardcoded file paths use `Path.Combine` and are not Windows-specific.
- **HTTP modules and handlers**: These do not exist in cross-platform .NET and must be replaced with middleware.

### 7. Test on Target Platform

If the goal of the migration was to run on a non-Windows operating system, deploy and run the application on that platform (Linux or macOS) to surface any remaining platform-specific issues that may not appear during a Windows build.

### 8. Review Warnings

Even without errors, the build may have produced warnings. Run the following to surface them clearly:

```bash
dotnet build 2>&1 | grep -i warning
```

On Windows:

```powershell
dotnet build 2>&1 | Select-String "warning"
```

Address any warnings related to nullable reference types, obsolete APIs, or package deprecations.