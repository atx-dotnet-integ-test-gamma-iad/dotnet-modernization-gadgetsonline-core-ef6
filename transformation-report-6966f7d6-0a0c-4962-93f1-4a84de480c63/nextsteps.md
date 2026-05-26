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

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality, particularly any areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Check for Replaced or Removed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in .NET Core/.NET 5+)
- `HttpContext` and related types (ensure they are sourced from `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `AppDomain` members that are no longer supported
- Any P/Invoke calls or Windows Registry access that would break on non-Windows platforms

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests carefully, as failures may indicate behavioral differences between .NET Framework and modern .NET rather than outright bugs.

### 7. Verify Static Assets and Configuration Files

For a web project such as `GadgetsOnline`, confirm the following:

- `appsettings.json` is present and contains the configuration previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Connection strings and application settings have been correctly migrated to `appsettings.json`

### 8. Test on Target Platforms

If cross-platform support is a goal, run and test the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues that do not appear during a Windows-only build.

### 9. Review Event Log and Diagnostics Output

Run the application and monitor the console output and any configured logging sinks for exceptions or warnings that only appear at runtime, as these will not surface during a build.