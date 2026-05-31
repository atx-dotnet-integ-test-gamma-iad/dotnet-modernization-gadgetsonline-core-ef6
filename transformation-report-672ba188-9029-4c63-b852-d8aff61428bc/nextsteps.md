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

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently on cross-platform .NET compared to .NET Framework.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it is targeting `net8.0` or `net6.0` and not a legacy moniker like `net48`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, including any database connections, authentication flows, and key business logic.

### 5. Check for Removed or Changed APIs

Review the code for usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related types, which have changed in ASP.NET Core
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `System.Drawing` on non-Windows platforms, which requires the `System.Drawing.Common` package and may have platform restrictions

### 6. Verify Configuration Files

Ensure that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. Connection strings, app settings, and environment-specific values should be present and correctly formatted.

### 7. Test Data Access

If the project uses Entity Framework or another ORM, run any existing migrations and verify that the database schema is applied correctly:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

Confirm that queries return expected results and that no data access exceptions occur at runtime.

### 8. Execute Existing Tests

If a test project exists in the solution, run the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a genuine regression or a test that requires updating due to the migration.

### 9. Review Platform-Specific Behavior

If the application will be deployed to Linux or macOS, pay attention to:

- **File path separators**: Use `Path.Combine` rather than hardcoded backslashes
- **Case sensitivity**: File and directory names are case-sensitive on Linux
- **Registry access**: `Microsoft.Win32.Registry` is not available on non-Windows platforms

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm that all required assets, static files, and configuration files are present before deploying to the target environment.