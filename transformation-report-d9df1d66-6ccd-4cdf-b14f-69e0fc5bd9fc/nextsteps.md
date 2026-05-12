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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate version and that the correct meta-packages (e.g., `Microsoft.AspNetCore.App`) are referenced.

### 4. Check for Windows-Specific APIs

Since this was a legacy project, scan the codebase for any remaining usage of Windows-specific APIs that may not be available cross-platform. Common areas to check include:

- `System.Web` references (should be replaced with `Microsoft.AspNetCore` equivalents)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows-only file path assumptions (e.g., hardcoded backslashes)
- `HttpContext.Current` usage

Use the .NET Upgrade Assistant compatibility analyzer or the `dotnet-compatibility` tool to assist with this:

```bash
dotnet tool install -g dotnet-compatibility
```

### 5. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality and confirm behavior matches the legacy version.

### 6. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Verify Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` (or equivalent configuration) are correct and that the application can connect and perform queries as expected. Legacy `web.config` connection strings should have been migrated to `appsettings.json`.

### 8. Review Static Files and Configuration

Confirm that any static files, configuration files, and middleware previously handled by `System.Web` or IIS-specific modules are now properly handled by the ASP.NET Core pipeline, including:

- Authentication and authorization middleware
- Custom HTTP handlers or modules (converted to middleware)
- Bundling and minification

### 9. Test on Target Platform

If the goal is to run on Linux or macOS, deploy and run the application on the target operating system to catch any remaining platform-specific issues that may not surface on Windows.