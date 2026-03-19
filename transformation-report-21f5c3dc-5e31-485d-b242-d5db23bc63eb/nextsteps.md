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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas of the code that may behave differently under cross-platform .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's supported .NET version.

### 4. Check for Windows-Specific Dependencies

Since this is a cross-platform migration, review the project for any remaining dependencies or API calls that are Windows-specific, such as:

- `System.Drawing.Common` (has platform restrictions on non-Windows)
- Registry access via `Microsoft.Win32`
- Windows-specific file path assumptions (e.g., backslashes)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package where needed.

### 5. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows, particularly any areas that interact with the database, file system, or external services.

### 6. Execute Existing Tests

If a test project exists in the solution, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains the correct configuration values, including:

- Connection strings
- Application URLs
- Logging configuration

If the legacy project used `Web.config` or `App.config`, verify that all relevant settings have been migrated to the new configuration system.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string is correct and accessible from the new runtime environment
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.