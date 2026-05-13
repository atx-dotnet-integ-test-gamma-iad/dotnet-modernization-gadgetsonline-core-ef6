# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework as needed.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which have moved to `Microsoft.AspNetCore.Http`
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `System.Drawing` on non-Windows platforms, which may require an alternative package such as `System.Drawing.Common`

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality, routing, and data access behave as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not changed after the migration:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression or a test that requires updating due to API changes.

### 7. Verify Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` (or the equivalent configuration file) are correct and that the application can connect and perform queries as expected.

### 8. Check Static Files and Configuration

For web applications, verify that:

- Static files such as CSS, JavaScript, and images are served correctly
- Configuration values previously stored in `Web.config` have been migrated to `appsettings.json`
- Any `appSettings` or `connectionStrings` sections from `Web.config` are present in the new configuration file