# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `HttpContext` usage outside of ASP.NET Core's dependency injection model
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Session` and `HttpRuntime` usage
- Any Windows-specific APIs such as the registry or Windows Event Log

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to surface any runtime compatibility issues that do not produce build errors.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows and confirm that pages load correctly, data access functions as expected, and no runtime exceptions are thrown.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate core functionality:

```bash
dotnet test
```

Review the results and address any failing tests before proceeding.

### 7. Verify Configuration Files

Check that `appsettings.json` (or `appsettings.Development.json`) contains all necessary configuration values that were previously held in `Web.config` or `App.config`. Common entries to verify include:

- Database connection strings
- Application-specific settings
- Logging configuration

### 8. Validate Data Access

If the project uses Entity Framework, confirm the version in use is compatible with cross-platform .NET (Entity Framework Core is required; classic Entity Framework 6 has limited cross-platform support). Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 9. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows-only build.