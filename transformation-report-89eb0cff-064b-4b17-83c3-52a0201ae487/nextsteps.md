# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the root of the solution to ensure all dependencies are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with your deployment environment.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the original legacy project.

### 5. Check for Runtime Compatibility Issues

Even with a clean build, certain areas may surface issues at runtime that were not present at compile time. Pay particular attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` (or equivalent) are correctly configured for the new runtime environment.
- **Authentication and session handling**: Verify that any authentication middleware has been correctly migrated and is functioning as expected.
- **Static files and wwwroot**: Ensure static assets are being served correctly under the new project structure.
- **Third-party libraries**: Any libraries that were previously referenced via the legacy `packages.config` or `web.config` should be confirmed as compatible with the target .NET version.

### 6. Review `web.config` / `appsettings.json`

If the original project used `web.config` for configuration, confirm that all relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration provider. Pay attention to:

- Connection strings
- Application settings keys
- Custom HTTP handlers or modules, which need to be replaced with ASP.NET Core middleware

### 7. Run Existing Tests

If the solution contains a test project, execute the test suite to validate business logic:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 8. Validate Deployment on Target Environment

Once local validation is complete, deploy the application to the target environment (e.g., IIS, Linux server) and confirm:

- The correct .NET runtime version is installed on the host machine.
- For IIS hosting, the ASP.NET Core Hosting Bundle is installed and the application pool is set to **No Managed Code**.
- Environment-specific configuration (e.g., production connection strings) is correctly applied via environment variables or environment-specific `appsettings.{Environment}.json` files.