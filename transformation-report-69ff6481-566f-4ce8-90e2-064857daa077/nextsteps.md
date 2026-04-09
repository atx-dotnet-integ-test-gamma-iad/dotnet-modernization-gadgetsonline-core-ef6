# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality to check for any runtime errors that would not surface at compile time.

### 5. Check for Runtime Compatibility Issues

Pay particular attention to the following areas that commonly surface issues at runtime after a migration:

- **Database connectivity**: Confirm connection strings are valid and any Entity Framework migrations are up to date. Run `dotnet ef database update` if applicable.
- **Authentication and session handling**: Verify that any authentication middleware is correctly configured in `Program.cs` or `Startup.cs`.
- **Static files and wwwroot**: Confirm that static assets are present in the `wwwroot` folder and are being served correctly.
- **Configuration**: Ensure `appsettings.json` contains all settings that were previously in `Web.config` or `App.config`, including connection strings and application keys.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures to determine whether they are caused by migration-related changes.

### 7. Review Removed or Changed APIs

Check the codebase for any use of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with identifying these areas.

### 8. Validate on Target Operating Systems

If cross-platform support is a goal, run and test the application on each target operating system (e.g., Linux, macOS) to surface any platform-specific issues such as file path casing sensitivity or platform-unavailable APIs.