# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Review the following areas:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. If any remain, they will need to be replaced with ASP.NET Core equivalents.
- **`HttpContext`, `HttpRequest`, `HttpResponse`**: Ensure these reference `Microsoft.AspNetCore.Http` and not `System.Web`.
- **`ConfigurationManager`**: Replace with `Microsoft.Extensions.Configuration` if still in use.
- **`Global.asax`**: This should have been migrated to `Program.cs` and `Startup.cs` (or the minimal hosting model in .NET 6+).

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and functions as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 7. Review Database Connectivity

If the project uses Entity Framework or direct database access, verify the following:

- Connection strings in `appsettings.json` are correct and accessible from the new runtime environment.
- Entity Framework migrations are up to date. Run the following if needed:

```bash
dotnet ef database update
```

- If migrating from Entity Framework 6 to Entity Framework Core, review any breaking changes in query behavior or model configuration.

### 8. Static Files and wwwroot

Confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is the expected location for static files in ASP.NET Core.

### 9. Verify Application Configuration

Ensure that `appsettings.json` contains all configuration values that were previously in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Any environment-specific overrides using `appsettings.Development.json`

### 10. Test on Target Operating System

Since the goal is cross-platform compatibility, if deployment is intended for Linux or macOS, run and test the application on that operating system to catch any platform-specific issues such as:

- File path casing sensitivity
- Platform-specific native dependencies
- Differences in default encoding or culture settings