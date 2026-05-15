# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are correctly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Even without build errors, the code may still reference Windows-specific APIs that will fail at runtime on non-Windows platforms. Use the .NET Compatibility Analyzer or search the codebase for common problem areas such as:

- `System.Web` references that may have been shimmed
- Registry access (`Microsoft.Win32.Registry`)
- Windows file path assumptions (backslashes, drive letters)
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core

### 7. Review Configuration Files

Confirm that any settings previously stored in `Web.config` or `App.config` have been migrated to `appsettings.json`. Verify that connection strings, application settings, and environment-specific values are correctly represented.

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  },
  "AppSettings": {
    "Key": "Value"
  }
}
```

### 8. Database Connectivity

If the application uses a database, confirm the connection string targets the correct server and database. Run the application and perform operations that exercise database reads and writes to validate connectivity and query behavior.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target server and ensure the correct .NET runtime version is installed on that server. Start the application and perform a final round of smoke testing in the target environment.