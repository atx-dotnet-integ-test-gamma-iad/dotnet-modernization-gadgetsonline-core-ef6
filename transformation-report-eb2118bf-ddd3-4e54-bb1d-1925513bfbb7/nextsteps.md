# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages. Address any packages that may have been targeting the old .NET Framework and require updated cross-platform equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Run Unit Tests

If the solution contains test projects, execute all tests to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually exercise the key workflows of the application, such as browsing products, adding items to a cart, and completing a checkout, to confirm that core functionality is intact.

### 5. Review Configuration Files

Check `appsettings.json` (and any environment-specific variants such as `appsettings.Development.json`) to ensure that:

- Connection strings are valid and point to the correct database instances.
- Any settings previously stored in `Web.config` or `App.config` have been correctly migrated.
- Environment-specific values are properly separated and not hardcoded.

### 6. Verify Database Connectivity

If the application uses a database, confirm that:

- The connection string is correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

- The schema matches what the application expects.

### 7. Check for Platform-Specific API Usage

Review the codebase for any remaining usage of Windows-specific APIs that may not behave correctly on Linux or macOS, such as:

- `System.Drawing` (consider replacing with a cross-platform alternative like `SkiaSharp` if image processing is used).
- Windows registry access.
- Windows-specific file path assumptions (e.g., backslashes).

Use `dotnet` platform analyzers to assist with identifying these issues:

```bash
dotnet build /p:EnableNETAnalyzers=true
```

### 8. Review Middleware and HTTP Pipeline

If this is an ASP.NET Core web application, verify that the middleware pipeline configured in `Program.cs` or `Startup.cs` is correct and that all previously used HTTP modules or handlers from the legacy project have been replaced with their ASP.NET Core middleware equivalents.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it operates correctly outside of the development environment:

```bash
dotnet ./publish/GadgetsOnline.dll
```

Navigate to the application in a browser and verify that pages load correctly and core features function as expected.