# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET was completed without introducing any compilation issues.

## Validation Steps

### 1. Review the Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform .NET version (e.g., `net6.0`, `net7.0`, or `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure there are no remaining references to `net48`, `netcoreapp`, or other legacy target frameworks unless intentionally multi-targeted.

### 2. Restore NuGet Packages

Run the following command from the solution root to confirm all dependencies resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 3. Build the Solution

Perform a clean build to confirm there are no warnings that could indicate runtime issues:

```bash
dotnet build --configuration Release
```

Address any warnings related to nullable reference types, obsolete APIs, or platform compatibility.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated for the new platform.

### 6. Check for Runtime Compatibility Issues

Even with a clean build, certain issues only surface at runtime. Pay attention to the following areas:

- **File paths**: Ensure no hardcoded Windows-style paths (e.g., `C:\`) remain in the code. Use `Path.Combine` and `Path.DirectorySeparatorChar` where appropriate.
- **Configuration**: Verify that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Authentication/Authorization**: If the project uses ASP.NET membership or Windows Authentication, confirm the equivalent middleware is configured in `Program.cs` or `Startup.cs`.
- **Entity Framework**: If EF is used, run `dotnet ef database update` to confirm migrations apply correctly against the target database.

### 7. Review Removed or Changed APIs

Check the code for any use of APIs that were available in .NET Framework but have changed or been removed in modern .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these.

### 8. Validate Static Assets and Middleware

If this is a web project, confirm that static files, routing, and middleware are functioning correctly by testing each major route and verifying HTTP responses are as expected.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, then deploy to the target environment.