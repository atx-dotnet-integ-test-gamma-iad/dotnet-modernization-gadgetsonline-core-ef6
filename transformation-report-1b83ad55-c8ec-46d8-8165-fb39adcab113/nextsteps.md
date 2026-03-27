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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that could cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure the chosen framework version is still within its support lifecycle.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm that core functionality behaves correctly.

### 5. Review Removed or Changed APIs

Cross-platform .NET does not support certain Windows-specific or legacy .NET Framework APIs. Manually review the codebase for usage of the following, which may compile but fail at runtime:

- `System.Web` types that may have been shimmed
- `ConfigurationManager` if not explicitly added as a NuGet package
- Any P/Invoke calls or Windows Registry access
- `HttpContext` usage patterns specific to ASP.NET (non-Core)

### 6. Check Static Files and Configuration

If this is a web project, verify the following:

- `wwwroot` contains the expected static assets
- `appsettings.json` is present and contains the necessary configuration that was previously in `Web.config` or `App.config`
- Connection strings and application settings have been correctly migrated to `appsettings.json`

### 7. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review any failing tests to determine whether failures are due to the migration or pre-existing issues.

### 8. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once the above steps are validated, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all expected files are present before deploying to the target environment.