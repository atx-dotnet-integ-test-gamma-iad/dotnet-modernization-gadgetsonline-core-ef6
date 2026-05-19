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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings, as some warnings may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your intended deployment environment.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows to confirm that runtime behavior matches the legacy version.

### 5. Check for Runtime Configuration

Review the following files to ensure they are correctly configured for the new .NET runtime:

- `appsettings.json` and `appsettings.{Environment}.json` — Verify connection strings, logging settings, and any environment-specific values.
- `Program.cs` — Confirm the application startup and middleware configuration is correct for cross-platform .NET (i.e., no legacy `Global.asax` or `Startup.cs` patterns that may not have been fully migrated).

### 6. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` is valid for the target environment. Run any pending migrations if Entity Framework Core is in use:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 7. Run Existing Tests

If a test project exists in the solution, execute the test suite to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they represent regressions introduced during the migration or pre-existing issues.

### 8. Review Static Assets and Bundling

If the project uses static assets (CSS, JavaScript, images), confirm that the asset pipeline (e.g., `libman.json`, npm scripts, or bundling configuration) is functioning correctly and that assets are served as expected when the application runs.

### 9. Verify Platform-Specific Code

Search the codebase for any remaining Windows-specific APIs or libraries (e.g., `System.Web`, `Microsoft.Web`, COM interop, or Windows registry access) that may compile successfully but fail at runtime on non-Windows platforms:

```bash
grep -r "System.Web" GadgetsOnline/
```

Replace or abstract any such usages with cross-platform equivalents where necessary.

### 10. Test on Target Platform

If the intended deployment target is Linux or macOS, run and validate the application on that platform to surface any remaining platform-specific runtime issues before deployment.