# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Check for Runtime Compatibility Issues

Even with a clean build, runtime issues may exist. Pay attention to the following areas:

- **Database connectivity**: Confirm connection strings in `appsettings.json` (or equivalent) are correct and that the data provider (e.g., Entity Framework Core, ADO.NET) is functioning correctly.
- **Authentication and Authorization**: If the project uses ASP.NET Identity or cookie-based auth, verify that middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Static files and views**: If this is an ASP.NET Core MVC or Razor Pages project, verify that views render correctly and static assets are served properly.
- **Configuration**: Ensure any settings previously in `Web.config` have been correctly migrated to `appsettings.json`.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate business logic and integration points:

```bash
dotnet test
```

Review any failing tests and address them individually, as they may surface runtime or logic regressions introduced during the migration.

### 7. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any suppressed warnings or compatibility shims that may be in use:

```bash
dotnet add package Microsoft.Windows.Compatibility
```

Only include this package if Windows-specific APIs are genuinely required. Otherwise, replace those APIs with cross-platform alternatives.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present, including configuration files, static assets, and dependencies.

### 9. Verify on Target Environment

Deploy the published output to the target environment (e.g., a staging server) and run a final round of smoke tests to confirm the application operates correctly outside of the local development machine.