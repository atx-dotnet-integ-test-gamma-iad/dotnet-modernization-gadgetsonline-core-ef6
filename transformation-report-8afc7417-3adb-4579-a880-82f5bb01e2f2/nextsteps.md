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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate and supported version of .NET, such as `net8.0`. Ensure it is not targeting an end-of-life version like `net5.0` or `net6.0` if long-term support is a concern.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to areas that relied on Windows-specific APIs or legacy ASP.NET features prior to migration.

### 5. Review Replaced or Removed APIs

Check the codebase for any uses of APIs that were commonly replaced during .NET migrations, including:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core
- `Session` and `Application` state management, which require explicit middleware registration in ASP.NET Core
- `Global.asax` logic, which should have been moved to `Program.cs` or `Startup.cs`

### 6. Check Static Files and Configuration

Verify that the following have been correctly migrated:

- `web.config` settings should be represented in `appsettings.json` where applicable
- Static file serving should be enabled via `app.UseStaticFiles()` in the middleware pipeline
- Connection strings should be present and correct in `appsettings.json`

### 7. Run Unit Tests

If the solution contains test projects, execute them to validate that existing logic behaves as expected:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to migration-related changes or pre-existing issues.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all necessary files, including views, static assets, and configuration files, are present.

### 9. Verify on Target Operating System

If the goal of the migration was cross-platform support, run the published output on the intended target operating system (Linux or macOS) to confirm there are no platform-specific runtime issues.