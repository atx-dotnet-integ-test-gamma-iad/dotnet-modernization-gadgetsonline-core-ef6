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

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in modern .NET. Common areas to check include:

- `System.Web` references, which are not available in modern .NET
- `HttpContext` and related ASP.NET types if this is a web project
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package
- Any use of `BinaryFormatter`, which is disabled by default in modern .NET

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary functionality to identify any runtime exceptions that would not surface at compile time.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality is preserved:

```bash
dotnet test
```

Review the test results and address any failures before proceeding.

### 7. Review Configuration Files

Check that `appsettings.json` (or `appsettings.Development.json`) contains the necessary configuration values that were previously held in `web.config` or `app.config`. Ensure connection strings, application settings, and environment-specific values have been migrated correctly.

### 8. Verify Database Connectivity

If the application uses a database, confirm that the connection string is correct and that the application can connect to the database successfully during local execution. If Entity Framework is used, verify that migrations are up to date:

```bash
dotnet ef database update
```

### 9. Check Static Files and wwwroot

If this is a web project, confirm that static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly when the application runs.

### 10. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present, then deploy the published output to the target environment.